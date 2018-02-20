//
//  ViewController.swift
//  Sample
//
//  Created by SysBig on 16/10/17.
//  Copyright © 2017 SysBig. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    let dataArray = ["Pranay","All","Kumar","Andhra Pradesh","Electronics & Office"]
    @IBOutlet weak var contentView: UIView!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
       // let firstViewController = self.storyboard?.instantiateViewController(withIdentifier: "FirstViewController") as! FirstViewController
        //addControllerAsChild(controller: firstViewController)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func secondButtonAction(_ sender: UIButton)
    {
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        removeChildControllers(controller: secondViewController)
        addControllerAsChild(controller: secondViewController)

    }
    @IBAction func firstButtonAction(_ sender: Any)
    {
        let firstViewController = self.storyboard?.instantiateViewController(withIdentifier: "FirstViewController") as! FirstViewController
        removeChildControllers(controller: firstViewController)
        addControllerAsChild(controller: firstViewController)
        
    }
    func addControllerAsChild(controller:UIViewController)
    {
        self.addChildViewController(controller)
        controller.view.frame = self.contentView.bounds
        self.contentView.addSubview(controller.view)
        controller.didMove(toParentViewController: self)

    }
    func removeChildControllers(controller:UIViewController)
    {
        controller.didMove(toParentViewController: nil)
        controller.view.removeFromSuperview()
        controller.removeFromParentViewController()
    }
}
extension ViewController : UICollectionViewDataSource
{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! SampleCollectionViewCell
        cell.customLabel.text = dataArray[indexPath.row]
        return cell
    }
}
extension ViewController : UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let size = (dataArray[indexPath.row] as NSString).size(withAttributes:nil)
        print(size.width)
         return CGSize(width: size.width + 45, height: 75)
    }

}

