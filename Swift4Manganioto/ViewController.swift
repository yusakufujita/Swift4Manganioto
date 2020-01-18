//
//  ViewController.swift
//  Swift4Manganioto
//
//  Created by 藤田優作 on 2019/03/18.
//  Copyright © 2019 藤田優作. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet var countLabel: UILabel!
    
    
    @IBOutlet var runnerImageView: UIImageView!

    var imageArray = [UIImage]()
    
    var timer1 = Timer()
    
    var timer2 = Timer()
    
    var updateCount = 0
    
    var audioPlayer : AVAudioPlayer!
    

    @IBOutlet weak var runButton: UIButton!
    
    //経過時間
    var countUp = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countLabel.text =
        "0"
        
        let image0 = UIImage(named: "dash0.png")
        let image1 = UIImage(named: "dash1.png")
        let image2 = UIImage(named: "dash2.png")
        let image3 = UIImage(named: "dash3.png")
        let image4 = UIImage(named: "dash4.png")
        let image5 = UIImage(named: "dash5.png")
        
        imageArray = [image0!,image1!,image2!,image3!,image4!,image5!]
    }

    @IBAction func run(_ sender: Any) {
        
        runButton.isEnabled = false
        
        //ここから音をつける
        if let url = Bundle.main.url(forResource: "bgm_maoudamashii_fantasy15", withExtension: "mp3"){
            do{
                print("音楽再生")
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.play()
            }catch{
                print("音楽再生失敗")
                //プレイヤー作成失敗
                //その場合は、プレイヤーをurlとする
                audioPlayer = nil
            }
            
        }else{
            print("ファイルが存在しない")
            //urlがnilなので再生できない
                fatalError("Url is nil.")
            
        }
        //タイマーをスタートさせる
        timer1 = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { (timer) in
            
            //カウントアップ
            self.countUp = self.countUp + 1
            
            //ラベルに反映
            self.countLabel.text = String(self.countUp)
            
            
        })
 timer2 = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { (timer) in
    
    //タンスの中から画像を取り出して、UIImageViewに反映していく
    
    if(self.updateCount > 5){
        
        self.updateCount = 0
        self.runnerImageView.image = UIImage(named: "dash0.png")
    }else{
        self.runnerImageView.image = self.imageArray[self.updateCount]
    }
    self.updateCount = self.updateCount + 1
    
 })
        
       
    
    
    
    }



    @IBAction func stop(_ sender: Any) {
        
        runButton.isEnabled = true
        //プレーヤーをstopさせる
         audioPlayer.stop()
        
        timer1.invalidate()
        timer2.invalidate()
        
        
    }
    


}
