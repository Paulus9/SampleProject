//
//  AnimateViewController.swift
//  Sample
//
//  Created by SysBig on 03/11/17.
//  Copyright © 2017 SysBig. All rights reserved.
//

import UIKit

class AnimateViewController: UIViewController {
    var array = [Any]()
    var array1 = [Any]()

    @IBOutlet weak var sideView: UIView!
    @IBOutlet weak var settingLabel: UILabel!
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        widthConstraint.constant = 0
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapOnSettingsLabel))
        self.view.addGestureRecognizer(tapGesture)
        
        
 array = ["pranay","kumar","Sysbig","Anand","India","Playing","Animations","pranay","kumar","Sysbig","Anand","India","Playing","Animations","pranay","kumar","Sysbig","Anand","India","Playing","Animations","pranay","kumar","Sysbig","Anand","India","Playing","Animations","pranay","kumar","Sysbig","Anand","India","Playing","Animations","pranay","kumar","Sysbig","Anand","India","Playing","Animations","pranay","kumar","Sysbig","Anand","India","Playing","Animations","pranay","kumar","Sysbig","Anand","India","Playing","Animations","pranay","kumar","Sysbig","Anand","India","Playing","Animations"]
        
        array1 = ["Pranay",99,"kumar",9]
        
    }
    
    override func viewWillAppear(_ animated: Bool) {

    }
    @objc func tapOnSettingsLabel()
    {
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: .curveEaseOut, animations:
        {
            self.widthConstraint.constant = 200
            self.view.layoutIfNeeded()
        }, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func animateCell1(cell:UITableViewCell)
    {
        cell.contentView.layer.opacity = 0.1
        UIView.animate(withDuration: 1.5) {
            cell.contentView.layer.opacity = 1
        }
    }
    func animateCell2(cell:UITableViewCell)
    {
        cell.alpha = 0.5
        cell.layer.transform = CATransform3DTranslate(CATransform3DIdentity, -250, 20, 0)
        UIView.animate(withDuration: 1)
        {
            cell.alpha = 1.0
            cell.layer.transform = CATransform3DIdentity
        }
    }
    func animateCell3(cell:UITableViewCell)
    {
        
        var index = 0
        let cells = tableView.visibleCells
        let tableHeight = tableView.bounds.size.height

        for _ in cells
        {
            cell.transform = CGAffineTransform(translationX: 0, y: tableHeight)
        }
        for _ in cells
        {
            UIView.animate(withDuration:1.5, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: 0)
            }, completion: nil)
            
            index += 1
        }
    }

}
extension AnimateViewController : UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array1.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        cell.dataLabel.text  = String(describing: array1[indexPath.row])
        cell.delegate = self
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    {
        //animateCell1(cell: cell)
        //animateCell2(cell: cell)
        animateCell3(cell: cell)
       
        
    }
}
extension AnimateViewController : UITableViewDelegate
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
extension AnimateViewController : TapDelegate
{
    func didTapOnCell()
    {
        UIView.animate(withDuration: 0.5, delay: 0.0,options: .curveEaseOut, animations:
            {
                self.widthConstraint.constant = 0
                self.view.layoutIfNeeded()
        }, completion: nil)
    }
}


