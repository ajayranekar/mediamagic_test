//
//  HomeVC.swift
//  MediaMagicTest
//
//  Created by Ajay Ranekar on 31/05/20.
//  Copyright © 2020 Ajay Ranekar. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var authorDataArray: [AuthorDataModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        InitialSetup()
    }
    
    fileprivate func InitialSetup() -> Void {
        
        self.title = "Media Magic Tech"
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.prefetchDataSource = self
        callAPI()
    }
    
    fileprivate func callAPI() -> Void {
        DispatchQueue.global().async {
            APIClient.getData(apiName: Constants.LIST) { (response) in
                if let jsonData = response as? Data {
                    self.authorDataArray = try? JSONDecoder().decode([AuthorDataModel].self, from: jsonData)
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                } else {
                    print(response as? String ?? "")
                }
            }
        }
    }
    
}

// MARK:- CollectionView delegate and datsource methods
extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return authorDataArray?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let authorData = authorDataArray?[indexPath.item]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as! HomeCollectionViewCell
        
        cell.authorNameLabel.text = authorData?.author
        
        if let authorImg = authorData?.authImage {
            cell.authorImageView.image = authorImg
        } else {
            
            DispatchQueue.main.async {
                cell.authorImageView.image = nil
            }
            
            authorData?.fetchImage(completionHandler: { (authImage) in
                DispatchQueue.main.async {
                    cell.authorImageView.image = authImage
                }
            })
        }
        
        return cell
    }
    
}

// MARK:- Delegate methods for prefetching data
extension HomeVC: UICollectionViewDataSourcePrefetching {
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            let authorData = authorDataArray?[indexPath.item]
            authorData?.fetchImage(completionHandler: nil)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
        let authorData = authorDataArray?[indexPath.item]
        authorData?.cancelFetchImage()
    }
    
}

extension HomeVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if UIApplication.shared.statusBarOrientation.isLandscape {
            // activate landscape changes
            return CGSize.init(width: collectionView.frame.width/3, height: ((collectionView.frame.width/3) * 1.15))
        } else {
            // activate portrait changes
            return CGSize.init(width: collectionView.frame.width/2, height: ((collectionView.frame.width/2) * 1.15))
        }
    }
    
}
