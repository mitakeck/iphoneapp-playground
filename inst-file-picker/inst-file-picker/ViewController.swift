//
//  ViewController.swift
//  inst-file-picker
//
//  Created by mitake on 2017/05/04.
//  Copyright © 2017 mitake. All rights reserved.
//

import UIKit
import Photos
import AVFoundation
import AVKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var previewView: UIView!
    @IBOutlet weak var topToolBar: UIToolbar!
    var moviePlayer: AVPlayerViewController!
    
    var videoAsset = [PHAsset]()
    var previewHeight = 300
    var totalOffset: CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        getAllVideoInfo()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        collectionView.frame.origin.y = topToolBar.frame.height + previewView.frame.height
        collectionView.frame.size.height = self.view.frame.height - collectionView.frame.origin.y
        print(collectionView.frame)
    }
    
    fileprivate func setup() {
        collectionView.dataSource = self
        collectionView.delegate = self
        
        // 見た目の設定
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width/4 - 4, height: UIScreen.main.bounds.width/4 - 4)
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 4
        
        collectionView.collectionViewLayout = flowLayout
        
        previewView.frame.size.height = self.view.frame.size.width * 9.0 / 16.0
        
        moviePlayer = AVPlayerViewController()
        moviePlayer.view.frame = CGRect(x: 0, y: 0, width: previewView.frame.size.width, height: previewView.frame.size.height)
        previewView.addSubview(moviePlayer.view)
    }
    
    func getAllVideoInfo() {
        self.videoAsset = [PHAsset]()
        
        let options = PHFetchOptions()
        options.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]

        let assets: PHFetchResult = PHAsset.fetchAssets(with: .video, options: options)
        assets.enumerateObjects({ (asset, index, stop) -> Void in
            self.videoAsset.append(asset as PHAsset)
        })
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videoAsset.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! MovieCollectionViewCell
        cell.setConfigure(assets: videoAsset[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? MovieCollectionViewCell {
            cell.select()
            if let asset = cell.assets {
               setPreview(asset: asset)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell: MovieCollectionViewCell = collectionView.cellForItem(at: indexPath) as? MovieCollectionViewCell {
            cell.deselect()
        }
    }
    
    func setPreview(asset: PHAsset) {
        let options: PHVideoRequestOptions = PHVideoRequestOptions()
        options.version = .original
        PHImageManager.default().requestAVAsset(forVideo: asset, options: options, resultHandler: {(asset: AVAsset?, audioMix: AVAudioMix?, info: [AnyHashable : Any]?) -> Void in
            if let urlAsset = asset as? AVURLAsset {
                let localVideoUrl: URL = urlAsset.url
                self.moviePlayer.player = AVPlayer(url: localVideoUrl)
                self.moviePlayer.player?.play()
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
  
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func done(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

