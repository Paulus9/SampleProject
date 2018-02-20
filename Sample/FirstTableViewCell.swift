//
//  FirstTableViewCell.swift
//  Sample
//
//  Created by SysBig on 13/01/18.
//  Copyright © 2018 SysBig. All rights reserved.
//

import UIKit

class FirstTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    let  dataArray = ["ALL","Nelapati","Tarlupadu","Andhra Pradesh","Bangalore","pspk","Anandh","Anandh Kumar","pranay kumar","Paulus"]
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.dataSource = self
        collectionView.delegate =  self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
extension FirstTableViewCell : UICollectionViewDataSource
{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return dataArray.count
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! FirstCollectionViewCell
        cell.productName.text = dataArray[indexPath.row]
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width

        cell.productName.layer.cornerRadius = cell.productName.bounds.height/2
        cell.productName.layer.masksToBounds = true

        if screenWidth <= 414
        {
           cell.productName.font = UIFont.systemFont(ofSize: 12)
        }
        else
        {
            cell.productName.font = UIFont.systemFont(ofSize: 16)
        }
        return cell
    }
}
extension FirstTableViewCell : UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        
        let text =  dataArray[indexPath.row]
        let customLabel = UILabel()
        customLabel.text = text
        print(customLabel.intrinsicContentSize.width)
        let width = customLabel.intrinsicContentSize.width
     return CGSize(width: width + 16, height: 50)
    }
}

