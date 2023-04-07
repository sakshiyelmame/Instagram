//
//  ImageDetailsViewController.swift
//  Instagram
//
//  Created by Sakshi Yelmame on 10/03/23.
//

import UIKit

class ImageDetailsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    var imageList = [InstagramModel]()
    var selectedIndexPath: IndexPath?
    
    
    @IBOutlet weak var ImageUICollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.ImageUICollectionView.reloadData()
        
        ImageUICollectionView.scrollToItem(at: selectedIndexPath!, at: .left, animated: false)
    }
    override func viewWillAppear(_ animated: Bool) {
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let imageCell = ImageUICollectionView.dequeueReusableCell(withReuseIdentifier: "imagecell", for: indexPath) as! ImageDetailsCollectionViewCell
        let object = imageList[selectedIndexPath!.row]
        imageCell.descriptionUILabel.text = "Description :- \(object.alt_description)"
        imageCell.createdAtUILabel.text = "Created At :- \(object.created_at)"
        imageCell.likesUILabel.text = "Likes :- \(object.likes)"
        if let url = URL(string: object.thumImageURL){
            imageCell.image.kf.setImage(with: url)
        }
        return imageCell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionWidth = ImageUICollectionView.bounds.width
        let collectionHeight = ImageUICollectionView.bounds.height
        return(CGSize(width: collectionWidth, height: collectionHeight))
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
