//
//  TestViewController.swift
//  Sample
//
//  Created by SysBig on 13/01/18.
//  Copyright © 2018 SysBig. All rights reserved.
//

import UIKit

class TestViewController: UIViewController
{

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
extension TestViewController : UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let firstCell = tableView.dequeueReusableCell(withIdentifier: "firstCell", for: indexPath) as! FirstTableViewCell
        return firstCell
    }
}
extension TestViewController : UITableViewDelegate
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 60
    }
}

