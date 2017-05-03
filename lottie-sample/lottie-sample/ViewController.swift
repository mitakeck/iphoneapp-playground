//
//  ViewController.swift
//  lottie-sample
//
//  Created by mitake on 2017/05/03.
//  Copyright © 2017 mitake. All rights reserved.
//

import UIKit
import Lottie

class ViewController: UIViewController {

    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var button: UIButton!
    
    var timer: Timer? = nil
    var animationView: LOTAnimationView? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animationView = LOTAnimationView(name: "LottieLogo1")
        self.animationView?.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 500)
        self.view.addSubview(self.animationView!)
        
        animationView?.play(completion: { finished in
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(update(t:)), userInfo: nil, repeats: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer?.invalidate()
    }
    
    func update(t: Timer) {
        if let progress = self.animationView?.animationProgress {
            self.slider.value = Float(progress)
        }
    }

    @IBAction func change(_ sender: UISlider) {
        self.animationView?.animationProgress = CGFloat(sender.value)
    }
    
    @IBAction func click(_ sender: Any) {
        self.animationView?.play()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

