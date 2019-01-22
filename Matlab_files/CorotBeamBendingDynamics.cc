// -*- C++ -*-

#include "../../core/Definitions.h"
#include "../../core/Utilities.h"
#include "../../elements/ExternalForce.h"
#include "../../core/Assemblers.h"
#include "../../elements/TwoNodeCorotationalBeam.h"
#include "../../core/ImplicitDynamics.h"
#include "../../core/SolverNewtonRaphson.h"
#include "../materialModels/LinearElastic.h"

const unsigned int NumberOfQuadraturePoints = 1;

typedef typename MaterialModels::LinearElastic1D       MaterialModel;
typedef typename Elements::TwoNodeCorotationalBeam::Linear2D<MaterialModel,NumberOfQuadraturePoints>      	BeamElement;	
typedef typename Elements::TwoNodeCorotationalBeam::Properties                    	BeamElementProperties;

const unsigned int SpatialDimension = BeamElement::SpatialDimension;
const unsigned int DegreesOfFreedom = BeamElement::DegreesOfFreedom;
const unsigned int NumberOfNodes = BeamElement::NumberOfNodes;

typedef typename Elements::ExternalForce::SingleNodeConstantForce<SpatialDimension,DegreesOfFreedom>   	ExternalForceElement;
typedef typename ExternalForceElement::Vector                        	  	ExternalForceVector;
typedef typename BeamElement::Vector                                     	  Vector;
typedef typename BeamElement::Node                                       	  Node;
typedef typename Assemblers::Assembler<BeamElement>         	Assembler;
typedef typename Dynamics::State            State;

int main(int arc, char *argv[]) {
	
    ignoreUnusedVariables(arc);
    
    // 16.7 mm -> 34.5 deg, 17.5 mm -> 32.3 deg, 18 mm -> 26.3 deg, and 18.6 mm -> 22.2 deg.
    
	int numberOfNodes = atof(argv[1]);
	double youngsModulus = 0.6;
    double pi = 3.1416;
    double theta0 = pi/2-atof(argv[3])*pi/180;
    double length = 7.;
    double width = 5.;
    double thickness = 7./13.;
    double areaMoment = width*thickness*thickness*thickness/12;
    double area = width*thickness;
	BeamElementProperties beamProperty(youngsModulus,areaMoment,area);
    MaterialModel materialModel(youngsModulus);
    double timestep = 0.1;
	double alpha = 0.000;
	double beta = 0.000;
	double newmarkBeta = 0.25;
	double newmarkGamma = 0.5; 

    Assembler problem(numberOfNodes);
	
    for(unsigned int i=0; i<numberOfNodes-1; i++){
        Node node1;
	    node1._id = i;	
        Matrix<double, SpatialDimension, 1> coordinates1;
        coordinates1(0) = length*double(i)*cos(theta0)/numberOfNodes;
        coordinates1(1) = -length*double(i)*sin(theta0)/numberOfNodes;
	    node1._position = coordinates1;
    
        Node node2;
        node2._id = i+1;	
        Matrix<double, SpatialDimension, 1> coordinates2;
        coordinates2(0) = length*double(i+1.)*cos(theta0)/numberOfNodes;
        coordinates2(1) = -length*double(i+1.)*sin(theta0)/numberOfNodes;
	    node2._position = coordinates2;
    
        array<Node, NumberOfNodes> nodes;
        nodes[0] = node1;
        nodes[1] = node2;
        BeamElement beamElement(nodes, beamProperty, &materialModel);

	    problem.addElement(beamElement);
    }
    
    cout << "first checkpoint cleared." << endl;
    
	vector<EssentialBoundaryCondition> essentialBCs;
	essentialBCs.push_back(EssentialBoundaryCondition(0,0,0));
    essentialBCs.push_back(EssentialBoundaryCondition(0,1,0));
    essentialBCs.push_back(EssentialBoundaryCondition(0,2,0));
    essentialBCs.push_back(EssentialBoundaryCondition(numberOfNodes-1,1,0));
    essentialBCs.push_back(EssentialBoundaryCondition(numberOfNodes-1,2,0));
    
    cout << "second checkpoint cleared." << endl;
    
    State currentState(numberOfNodes);
    VectorXd currentU(numberOfNodes);
    currentU.fill(0.);
    VectorXd currentV(numberOfNodes);
    currentV.fill(0.);
    currentV(numberOfNodes-1) = 10;
    VectorXd currentA(numberOfNodes);
    currentA.fill(0.);
    
    const int iterations = 1000;
	double tolerance = 1e-8;
	Dynamics::Newmark<Assembler> newmark(problem,timestep,alpha,beta,newmarkBeta,newmarkGamma,currentV,iterations,tolerance);    
    vector<double> displacements;
        
    for (unsigned int iter = 0; iter < iterations; iter++){   
        newmark.computeNewmarkUpdat(essentialBCs,iter);
        State newState = newmark.getState();
        displacements.push_back(newState._displacements[numberOfNodes*DegreesOfFreedom-3]);
    }
    
    cout << "third checkpoint cleared." << endl;
    
    std::ofstream displacementFile;
    string address = "../../../../Dropbox/Research_Neel/Harvard Katia collaboration/Matlab_files/DissipationParameterTesting/";
    string parameter = argv[3]; 
    string text = ".txt";
    string disp = "CorotBeamDynamicDisplacementFullSimulation";
    
    string dispFolder;
    allDispFolder.append(address);
    allDispFolder.append(disp);       
    allDispFolder.append(parameter);
    allDispFolder.append(text);
    
    displacementFile.open(dispFolder);
    
    displacementFile << displacements << endl;
    
    cout << "variables stored in folder: " << address << endl;
    
    return 0;
}