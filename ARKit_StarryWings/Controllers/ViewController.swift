//
//  ViewController.swift
//  ARKit_StarryWings
//
//  Created by Ivan Nikitin on 24/03/2019.
//  Copyright © 2019 Ivan Nikitin. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView.autoenablesDefaultLighting = true
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        sceneView.debugOptions = [.showWorldOrigin, .showFeaturePoints  ]
        
        sceneView.scene.rootNode.addChildNode(loadArea())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    //MARK: - ... Customs Methods
    
    func loadArea() -> SCNNode {
        let node = SCNNode()
        node.position = SCNVector3(0, -0.3, -2.5)
        
        node.addChildNode(loadMainBilding())
        node.addChildNode(loadCar(x: 0, y: -0.5, z: 0.7, angel: 0))
        node.addChildNode(loadCar(x: -0.15, y: -0.5, z: 0.7, angel: .pi))
        node.addChildNode(loadCar(x: 0.15, y: -0.5, z: 0.7, angel: .pi))
        
        node.addChildNode(loadCar(x: -0.3, y: -0.5, z: 1, angel: .pi/2))
        node.addChildNode(loadCar(x: -0.3, y: -0.5, z: 1.15, angel: .pi/2))
        
        node.addChildNode(loadTree(x: -1.2, y: -0.5, z: 1.2))
        node.addChildNode(loadTree(x: 1.2, y: -0.5, z: 1.2))
        node.addChildNode(loadTree(x: 1.2, y: -0.5, z: -1.2))
        node.addChildNode(loadTree(x: -1.2, y: -0.5, z: -1.2))
        
        node.addChildNode(loadGrass())
        node.addChildNode(loadRoad())
        
        return node
    }
    
    func loadMainBilding() -> SCNNode {
        let node = SCNNode()
        //Part One of building
        let nodeOne = SCNNode()
        nodeOne.position = SCNVector3(0, 0, 0)
        
        let boxOne = SCNBox(width: 1, height: 1, length: 0.5, chamferRadius: 0)
        nodeOne.geometry = boxOne
        nodeOne.geometry?.firstMaterial?.diffuse.contents = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        
        // Part Two of building
        
        let nodeTwo = SCNNode()
        let boxTwo = SCNBox(width: 0.5, height: 1, length: 1.5, chamferRadius: 0)
        nodeTwo.geometry = boxTwo
        
        nodeTwo.position = SCNVector3(x: -0.75, y: 0, z: 0.5)
        nodeTwo.geometry?.firstMaterial?.diffuse.contents = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        
        node.addChildNode(nodeOne)
        node.addChildNode(nodeTwo)
        
        return node
    }
    
    func loadGrass() -> SCNNode {
        let node = SCNNode(geometry: SCNPlane(width: 3, height: 3))
        
        node.eulerAngles.x = -.pi / 2
        node.position = SCNVector3(0, -0.51, 0)
        node.geometry?.firstMaterial?.diffuse.contents = UIColor.green
        
        return node
    }
    
    func loadRoad() -> SCNNode {
        let node = SCNNode()
        let roadNode = SCNNode(geometry: SCNPlane(width: 2, height: 0.27))
        
        roadNode.eulerAngles.x = -.pi / 2
        roadNode.position = SCNVector3(-0.5, -0.5, 1.38)
        roadNode.geometry?.firstMaterial?.diffuse.contents = UIColor.gray
        
        let parkingNode = SCNNode(geometry: SCNPlane(width: 1, height: 1.2))
        parkingNode.eulerAngles.x = -.pi / 2
        parkingNode.position = SCNVector3(0 , -0.5, 0.7)
        parkingNode.geometry?.firstMaterial?.diffuse.contents = UIColor.gray
        
        node.addChildNode(parkingNode)
        node.addChildNode(roadNode)
        
        return node
    }
    
    func loadTree(x: Float = 0, y: Float = 0, z: Float = 0) -> SCNNode {
        
        let node = SCNNode()
        node.position = SCNVector3(x, y, z)
        node.scale = SCNVector3(0.3, 0.3, 0.3)

        let stall = SCNNode(geometry: SCNCylinder(radius: 0.05, height: 1))
        stall.position.y = 0.5
        stall.geometry?.firstMaterial?.diffuse.contents = UIColor.brown
        node.addChildNode(stall)
        
        let crown = SCNNode(geometry: SCNSphere(radius: 0.3))
        crown.position.y = 1
        crown.geometry?.firstMaterial?.diffuse.contents = UIColor.green
        node.addChildNode(crown)
        
        
        return node
    }
    //MARK: - ...Car Load
    func loadCar(x: Float = 0, y: Float = 0, z: Float = 0, angel: Float = 0) -> SCNNode {
        
        let carScene = SCNScene(named: "art.scnassets/Muscle_Coupe.scn")!
        
        guard let carNode = carScene.rootNode.childNode(withName: "car", recursively: true) else { return SCNNode() }
        carNode.position = SCNVector3(x, y, z)
        carNode.eulerAngles.y = angel
        return carNode
    }
}
