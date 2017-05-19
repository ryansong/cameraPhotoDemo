//
//  SYBLibraryViewModel.swift
//  cameraPhotoDemo
//
//  Created by Ryan on 5/3/17.
//  Copyright © 2017 Song Xiaoming. All rights reserved.
//

import UIKit
import Photos

class SYBLibraryViewModel: NSObject {
    
    
    var status:PHAuthorizationStatus {
        get {
          return PHPhotoLibrary.authorizationStatus()
        }
    }
    
    private var topCollection:PHFetchResult<PHCollection>? = nil
    var topPHCollections:PHFetchResult<PHCollection>? {
        get {
            let phOptions = PHFetchOptions.init()
            phOptions.includeHiddenAssets = true
            phOptions.includeAllBurstAssets = true
            
            self.topCollection = PHCollection.fetchTopLevelUserCollections(with: phOptions)
            return self.topCollection
        }
    }
    
    var photos:[SYBImageAssetModel] = []
    
    open class var shared: SYBLibraryViewModel {
        get{
            let s = SYBLibraryViewModel()
            return s
        }
    }
    
    func requestAuthorMask(_ handler: @escaping (PHAuthorizationStatus) -> Swift.Void) {
        if (self.status == .notDetermined) {
            UIAlertController.showAlert({ (alert) in
                alert.title = NSLocalizedString("CameraUsage", comment: "CameraUsage");
                alert.message = Bundle.objectFor("NSPhotoLibraryUsageDescription") as? String;
                let action = UIAlertAction.init(title: NSLocalizedString("OK", comment: "OK"), style:.`default`, handler: { (action) -> Void in
                    self.requestAuthor({ (status) in
                        handler(status);
                    })
                    });
                let cancelAction = UIAlertAction.init(title: NSLocalizedString("Don't Allow", comment: "Don't Allow"), style:.cancel, handler: nil)
                alert.addAction(action)
                alert.addAction(cancelAction)
            })
        } else {
            handler(self.status);
        }
    }
    
    private func requestAuthor(_ handler: @escaping (PHAuthorizationStatus) -> Swift.Void) {
        switch self.status {
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({ (status) in
                handler(status)
            })
            break
        default:
            handler(self.status)
            break
        }
    }
    
    func fetchPhotoCollection(collection coll:PHCollection?, fetchBlock:((PHFetchResult<PHCollection>)->Void)?) -> Void {
       
        let phOptions = PHFetchOptions.init()
        phOptions.includeHiddenAssets = true
        phOptions.includeAllBurstAssets = true
        
        var result:PHFetchResult<PHCollection>? = nil
        if (coll == nil) {
           result = PHCollection.fetchTopLevelUserCollections(with: phOptions)
        } else {
            result = PHCollection.fetchCollections(in: coll as! PHCollectionList, options: phOptions)
        }
        
        
        if (fetchBlock != nil) {
            fetchBlock!(result)
        }
    }
    
}

extension UIAlertController {
    class func showAlert(_ vcBlock:(UIAlertController) -> Void) -> Void {
        let alertVC = UIAlertController.init(title: "", message: "", preferredStyle: .alert)
        vcBlock(alertVC)
        let rootVC:UIViewController = (UIApplication.shared.delegate?.window??.rootViewController)!
        if (rootVC.isKind(of: UINavigationController.self)) {
            let topVC = (rootVC as! UINavigationController).viewControllers.first
            topVC?.present(alertVC, animated: true, completion: nil)
            
            return
            }
        rootVC.present(alertVC, animated: true, completion: nil)
    }
}

extension Bundle {
    class func objectFor(_ key:String) -> Any? {
        let bundle = Bundle.main
        let dict = bundle.infoDictionary
        return dict?[key]
    }
}
