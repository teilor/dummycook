//
//  videoPlayer.swift
//  DummyCook
//
//  Created by Teilor Soares on 14/11/17.
//  Copyright © 2017 Aline Ebone. All rights reserved.
//

import Foundation
import UIKit
import AVKit
import AVFoundation

class videoPlayer: UIView {
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    var player: AVPlayer? { //Player de video
        didSet {
            player?.play()
        }
    }
    
    var playerObserver: Any?
    
    deinit {
        guard let obserserver = playerObserver else { return }
        NotificationCenter.default.removeObserver(obserserver)
    }
    
    var playerLayer: AVPlayerLayer? //Layer que define o visual do player
    
    @IBInspectable var file:String = "" //Nome do video a ser recebido
    
    func playerVideo(withFile file: String) { //Função que seta o player de video
        
        let fileName = file.components(separatedBy: ".") //Divide o nome do arquivo entre nome e extensão
        
        guard let caminho = Bundle.main.path(forResource: fileName[0], ofType: fileName[1]) else {
            debugPrint("\(fileName.joined(separator:".")) not found") //Caso não encontre o video
            return
        }
        
        player = AVPlayer(url: URL(fileURLWithPath: caminho)) //Define o caminho do video
        
        player?.isMuted = true
        
        playerLayer = AVPlayerLayer(player: player) //Cria o layer
        
        playerLayer?.frame = self.bounds //Define o layer pro player se limitar a View que o contém
        self.layer.addSublayer(playerLayer!)
        
        let resetPlayer = {
            self.player?.seek(to: kCMTimeZero)
            self.player?.play()
        }
        playerObserver = NotificationCenter.default.addObserver(forName: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player?.currentItem, queue: nil) { notification in
            resetPlayer()
        }
    }
    
    @objc func playPress(){ //Função chamada ao dar um toque no video
        if let player = player{ //Verifica se o player ta setado antes de começar a usar os comandos de reprodução
            if( (player.rate != 0) && (player.error == nil)){
                //print("Playing")
                player.pause()
            } else {
                //print("Paused")
                player.play()
            }
        } else {
            print("Nil")
            //player?.play()
        }
    }
    
}
