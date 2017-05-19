//
//  SYBViewController.swift
//  cameraPhotoDemo
//
//  Created by Ryan on 5/2/17.
//  Copyright © 2017 Song Xiaoming. All rights reserved.
//

import UIKit
import Photos

class SYBViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var slider: UISlider!
    
    class func initFromNib() -> SYBViewController {
        let vc:SYBViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SYBViewController") as! SYBViewController
        
        return vc
    }
    
    var imageOption:PHImageRequestOptions {
        get {
            let op:PHImageRequestOptions = PHImageRequestOptions()
            op.version = .current
            op.deliveryMode = .opportunistic
            op.resizeMode = .fast
            op.isNetworkAccessAllowed = true
            op.isSynchronous = false
            
            self.slider.maximumValue = 1.0;
            self.slider.minimumValue = 0.0;
            weak var weakSelf = self
            op.progressHandler = { rate, error, isStop, dict in
                weakSelf?.slider.value = Float(rate)
            }
            return op
        }
    }
    
    @IBAction func pickImageAction(_ sender: Any) {
        let vc = SYBCollectionViewController()
        self.navigationController?.show(vc, sender: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
