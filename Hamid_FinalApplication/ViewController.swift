//
//  ViewController.swift
//  Hamid_FinalApplication
//
//  Created by hm13aaac on 16/04/2018.
//  Copyright © 2018 CSStestuser. All rights reserved.
//

import UIKit
import AVFoundation

protocol subviewDelegate1 {
    func changeSomething()
}
class ViewController: UIViewController, subviewDelegate {
    
    var dynamicAnimator: UIDynamicAnimator!
    var dynamicItemBehaviour: UIDynamicItemBehavior!
    var collisionBehavior: UICollisionBehavior!
    

    //@IBOutlet weak var FallinCar: UIImageView!
    
    

    @IBOutlet weak var MoveRoadImages: UIImageView!
    
    @IBOutlet weak var DraggingCar: UIImageView!
    
    //@IBOutlet weak var DraggingGodzilla: UIImageView!
    
    //@IBOutlet weak var DragCar: DragCar!
    
    @IBOutlet weak var cars: DragCar!
    
    //@IBOutlet weak var DraggedCar: DragCar!
     var carsfallingArray = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
   
    func random(_ range:Range<Int>) -> Int
    {
        return range.lowerBound + Int(arc4random_uniform(UInt32(range.upperBound - range.lowerBound)))
    }
    
    func carsfalling(){
        for count in 0...19
        {
            //let score =
            let waiting = Double(self.carsfallingArray[count])
            let time = DispatchTime.now() + waiting
            
            
            DispatchQueue.main.asyncAfter(deadline: time){

                let rand = Int(arc4random_uniform(5))
                let carsfalling = UIImageView(image:nil)
                
                switch rand{
                case 1: carsfalling.image = UIImage(named: "car1.png")
                case 2: carsfalling.image = UIImage(named: "car2.png")
                case 3: carsfalling.image = UIImage(named: "car3.png")
                case 4: carsfalling.image = UIImage(named: "car4.png")
                case 5: carsfalling.image = UIImage(named: "car5.png")
                case 6: carsfalling.image = UIImage(named: "car6.png")
                default: carsfalling.image = UIImage(named: "car1.png")

                }
                
                //carsfalling.image = rand[count]
                carsfalling.frame = CGRect(x: self.random(40..<200), y: 0, width: 40 , height: 60)
                self.view.addSubview(carsfalling)
                self.view.bringSubview(toFront: carsfalling)
                
                
                self.dynamicItemBehaviour.addItem(carsfalling)
                self.dynamicItemBehaviour.addLinearVelocity(CGPoint(x: 0, y: 500), for: carsfalling)
                
                self.collisionBehavior.addItem(carsfalling)
                //self.collisionBehavior.translatesReferenceBoundsIntoBoundary = true
               
                
                
               //self.dynamicAnimator.addBehavior(self.dynamicItemBehaviour)
                self.collisionBehavior.addItem(carsfalling)
                
                
                //print(index)
                
                //self.collisionBehavior.addItem(carsfalling)
                //self.dynamicAnimator.addBehavior(self.collisionBehavior)
                
            }
        }
    }
    
    
    func changeSomething() {
        collisionBehavior.removeAllBoundaries()
        //collisionBehavior.addBoundary(withIdentifier: "Crashed" as NSCopying, for: UIBezierPath(rect: carsfalling.frame) )
        
    }
    
    var bombSoundEffect: AVAudioPlayer?
    
    func onHitExplosion() {
        
        let path = Bundle.main.path(forResource: "example.mp3", ofType:nil)!
        let url = URL(fileURLWithPath: path)
        do {
            bombSoundEffect = try AVAudioPlayer(contentsOf: url)
            bombSoundEffect?.play()
        } catch {
            // couldn't load file :(
        }
        
    }
    
    func Timer(){
        let time = DispatchTime.now() + 20
        DispatchQueue.main.asyncAfter(deadline: time){
            let over = self.storyboard?.instantiateViewController(withIdentifier: "GameOver")
            self.show(over!, sender: nil)
            
            
        }
        
    }
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        //dragCars.myDelegate = self
        
        Timer()
        carsfalling()
        
        var imageArray: [UIImage]!
    
        imageArray = [UIImage(named:"road1.png")!,
                      UIImage(named:"road2.png")!,
                      UIImage(named:"road3.png")!,
                      UIImage(named:"road4.png")!,
                      UIImage(named:"road5.png")!,
                      UIImage(named:"road6.png")!,
                      UIImage(named:"road7.png")!,
                      UIImage(named:"road8.png")!,
                      UIImage(named:"road9.png")!,
                      UIImage(named:"road10.png")!,
                      UIImage(named:"road11.png")!,
                      UIImage(named:"road12.png")!,
                      UIImage(named:"road13.png")!,
                      UIImage(named:"road14.png")!]
//                      UIImage(named:"road15.png")!,
//                      UIImage(named:"road16.png")!,
//                      UIImage(named:"road17.png")!,
//                      UIImage(named:"road18.png")!]

        
        
        dynamicAnimator = UIDynamicAnimator(referenceView: self.view)
        
        MoveRoadImages.image = UIImage.animatedImage(with: imageArray, duration: 2.0)
        MoveRoadImages.frame = UIScreen.main.bounds
        
        
        var draggedCar: [UIImage]!
        
        draggedCar = [UIImage(named:"car0.png")!]
        
        
        
        
        DraggingCar.image = UIImage.animatedImage(with: draggedCar, duration: 0.5)
      //  DraggingCar.frame = UIScreen.main.bounds
        DraggingCar.frame = CGRect(x:130, y: 400, width: 50 , height: 80)
 
        
        self.dynamicAnimator = UIDynamicAnimator(referenceView: self.view)
        self.collisionBehavior = UICollisionBehavior(items: [])
        self.dynamicItemBehaviour = UIDynamicItemBehavior(items:[])
        self.dynamicAnimator.addBehavior(self.collisionBehavior)
        self.dynamicAnimator.addBehavior(self.dynamicItemBehaviour)
        
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


