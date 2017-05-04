//
//  InitViewController.swift
//  inst-file-picker
//
//  Created by mitake on 2017/05/04.
//  Copyright © 2017 mitake. All rights reserved.
//

import UIKit
import Photos

class InitViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        libraryRequestAuthorization()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // カメラロールへのアクセス許可
    fileprivate func libraryRequestAuthorization() {
        PHPhotoLibrary.requestAuthorization({ [weak self] status in
            guard let wself = self else {
                return
            }
            switch status {
            case .authorized:
                print("authorized")
            case .denied:
                wself.showDenaiedAlert()
            case .notDetermined:
                print("not determined")
            case .restricted:
                print("resticted")
                //            default:
                //                print("not defind status")
            }
        })
    }
    
    fileprivate func showDenaiedAlert() {
        let alert = UIAlertController(title: "エラー", message: "写真へのアクセスが拒否されています。設定より変更してください", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "キャンセル", style: .cancel, handler: nil)
        let ok = UIAlertAction(title: "設定画面へ", style: .default, handler: { [weak self] (action) -> Void in
            guard let wself = self else {
                return
            }
            wself.transitionToSettingsAppication()
        })
        alert.addAction(cancel)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
    fileprivate func transitionToSettingsAppication() {
        let url = URL(string: UIApplicationOpenSettingsURLString)
        if let url = url {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }

}
