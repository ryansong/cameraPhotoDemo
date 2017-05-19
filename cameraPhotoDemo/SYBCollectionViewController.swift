//
//  SYBCollectionViewController.swift
//  cameraPhotoDemo
//
//  Created by Ryan on 5/2/17.
//  Copyright © 2017 Song Xiaoming. All rights reserved.
//

import UIKit
import Photos

private let reuseIdentifier = "Cell"

class SYBCollectionViewController: UICollectionViewController {
    
    let viewModel:SYBLibraryViewModel = SYBLibraryViewModel.shared
    
    var currentCollection:PHCollection? = nil
    var array:PHFetchResult<PHCollection>? = nil
    
    convenience init() {
        let layout = SYBCollectionViewLineLayout()
        layout.height = 44;
        
        self.init(collectionViewLayout:layout)
        
    }
    
    override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: layout)
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = NSLocalizedString("Library", comment: "Library")
        self.collectionView?.backgroundColor = UIColor.white

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(SYBCollectionFolderViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.

    }

    override func viewWillAppear(_ animated: Bool) {
        self.viewModel.requestAuthorMask { (status) in
            switch status{
            case .denied, .restricted:
                UIAlertController.showAlert({ (vc) in
                    // #TODO
                })
                break
            case.authorized:
               
                weak var weakself = self;
                self.viewModel.fetchPhotoCollection(collection: nil, fetchBlock: { (array) in
                    weakself?.array = array;
                    weakself?.collectionView?.reloadData()
                })
                
                break
            default:
                break
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if (self.array != nil) {
            return (self.array?.count)!
        }
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:SYBCollectionFolderViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! SYBCollectionFolderViewCell
    
        let model = self.array?.object(at: indexPath.row)
        cell.textLabel.text = model?.localizedTitle
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
