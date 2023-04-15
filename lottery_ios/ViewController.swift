//
//  ViewController.swift
//  lottery_ios
//
//  Created by JeffApp on 2023/3/22.
//
//SceneDelegate 為App的視窗(window)
import UIKit
import AVFoundation

class ViewController: UIViewController {
    let moneyEmitterLayer = CAEmitterLayer()
    var player = AVPlayer()
   
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet var numberLabels: [UILabel]!
    
    func dropMoney(){
        //建立要發射的物件
        let moneyEmitterCell = CAEmitterCell()
        //設定物件的內容
        moneyEmitterCell.contents = UIImage(named: "money")?.cgImage
        moneyEmitterLayer.emitterCells = [moneyEmitterCell]
        //物件的參數
        //設定每秒發射幾個物件
        moneyEmitterCell.birthRate = 0.8
        //物件維持的秒數
        moneyEmitterCell.lifetime = 5
        //物件移動的速率
        moneyEmitterCell.velocity = 50
        //y軸落下加速度
        moneyEmitterCell.yAcceleration = 100
        //透明度範圍
        moneyEmitterCell.alphaRange = 0.5
        //物件發射的位置
        moneyEmitterLayer.emitterPosition = CGPoint(x: view.bounds.width/2, y: -50)
        moneyEmitterLayer.emitterSize = CGSize(width: view.bounds.width, height: 0)
        moneyEmitterLayer.emitterShape = .line
        //將發射圖成加進view
        view.layer.addSublayer(moneyEmitterLayer)
    }
    //shake的動作觸發大樂透
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        var numbers:Set<Int> = []
        while numbers.count < 6{
            numbers.insert(Int.random(in: 1...50))
        }
        var numbers_Arr = [Int]()
        numbers_Arr.sort()
        for n in numbers{
            numbers_Arr.append(n)
        }
        for i in 0...5{
            numberLabels[i].text = String( numbers_Arr[i])
        }
        if player.timeControlStatus == .playing{
            print("playing")
        }else{
            let url = Bundle.main.url(forResource: "dog", withExtension: "mp3")!
            let playerItem = AVPlayerItem(url: url)
            player.replaceCurrentItem(with: playerItem)
            player.play()
        }

        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor(red: 1, green: 221/255, blue: 131/255, alpha: 1)
        for i in numberLabels{
            i.layer.borderWidth = CGFloat(5)
            i.textAlignment = NSTextAlignment.center
        }
    }

    @IBAction func pickNumberButton(_ sender: Any) {
        //建立集合來接取亂數選出來的數字
        var numbers:Set<Int> = []
        //利用While迴圈重複執行選數字的動作
        while numbers.count < 6{
            numbers.insert(Int.random(in: 1...50))
        }
        //為了將數字做排序，將Set的數字轉成Array
        var numbers_Arr = [Int]()
        numbers_Arr.sort()
        for n in numbers{
            numbers_Arr.append(n)
        }
        //希望Label由上到下數字分別為由小到大(因為拉成Array的順序關係，Label由上到下的index為0~5)
        //因此將數字做由小排到大此時index為0~5，這麼一來即可利用相同的index來將數字傳入Label
        for i in 0...5{
            numberLabels[i].text = String( numbers_Arr[i])
        }
        textLabel.text = "中獎請捐獻罐罐乙個❤️"
        textLabel.textAlignment = NSTextAlignment.center
        //掉錢
        dropMoney()
        //聲音
        //每個app等於一個資料夾，不能越獄到其他的資料夾拿檔案，所以只能把要的資源丟到自己的包，然後到 Build phase裡把資源加進去Copy bundle resources
         //.main用來抓主包
        
        if player.timeControlStatus == .playing{
            print("playing")
        }else{
            let url = Bundle.main.url(forResource: "dog", withExtension: "mp3")!
            let playerItem = AVPlayerItem(url: url)
            player.replaceCurrentItem(with: playerItem)
            player.play()
        }
        }
    }


