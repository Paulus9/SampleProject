//
//  SecondTableViewCell.swift
//  Sample
//
//  Created by SysBig on 13/01/18.
//  Copyright © 2018 SysBig. All rights reserved.
//

import UIKit

class SecondTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var headerLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
extension SecondTableViewCell : UICollectionViewDataSource
{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return 1
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! FirstCollectionViewCell
        return cell
    }
}
extension SecondTableViewCell : UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:collectionView.frame.size.width/3, height: 100)
    }
}
