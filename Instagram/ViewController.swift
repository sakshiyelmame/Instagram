//
//  ViewController.swift
//  Instagram
//
//  Created by Sakshi Yelmame on 08/03/23.
//

import UIKit
import Kingfisher
class ViewController: UIViewController {
    var instagramFeeds = [InstagramModel] ()
    
    @IBOutlet weak var imageUICollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        // Do any additional setup after loading the view.
    }
    func fetchData(){
        let url = URL(string: "https://api.unsplash.com/photos/?client_id=nyLCTvFK3GU9pyT9bU784NDsXSevO0V2Lf5oGDHetzk")!
        let task = URLSession.shared.dataTask(with: url, completionHandler: {
            (data,response,error) in
            guard let data = data ,error == nil else {
                return
            }
            do{
                // first method using codable protocol and JSONDecoder class
                //let products = try JSONDecoder().decode(Urls.self, from: data)
                // second method using JsonSerialization
                
                guard let dictArray = try JSONSerialization.jsonObject(with: data) as? [[AnyHashable: Any]] else { return }
                
                for dict in dictArray {
                    
                    let id = dict["id"] as! String
                    let createdAt = dict["created_at"] as! String
                    let altDescription = dict["alt_description"] as! String
                    let likes = dict["likes"] as! Int
                    let urlsDictionary = dict["urls"] as! [String: String]
                    let thumb = urlsDictionary["regular"]!
                    
                    
                    let newInstaModel = InstagramModel(id: id, created_at: createdAt, alt_description: altDescription, thumImageURL: thumb, likes: likes)
                    self.instagramFeeds.append(newInstaModel)
                }
                
                DispatchQueue.main.sync {
                    self.imageUICollectionView.reloadData()
                }
            }
            catch let error {
                print("Error \(error.localizedDescription)")
            }
        })
        task.resume()
    }
}

extension ViewController : UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return instagramFeeds.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = imageUICollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ImageCollectionViewCell
        let instaModelObj = instagramFeeds[indexPath.row]
        let url = URL(string: instaModelObj.thumImageURL)
        cell.imageUIImageView.kf.setImage(with: url)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionWidth = collectionView.frame.width
        return CGSize(width: collectionWidth/3,height: collectionWidth/3)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "ImageDetailsViewController") as! ImageDetailsViewController
        vc.selectedIndexPath = indexPath
        vc.imageList = instagramFeeds
        navigationController?.pushViewController(vc, animated: true)
        
        
    }
}

