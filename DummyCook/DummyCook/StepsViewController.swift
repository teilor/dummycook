//
//  StepsViewController.swift
//  DummyCook
//
//  Created by Aline Ebone on 13/11/17.
//  Copyright © 2017 Aline Ebone. All rights reserved.
//

import UIKit
import Speech

class StepsViewController: UIViewController {
    
    @IBOutlet weak var stepsTitle: UILabel!
    @IBOutlet weak var stepsImage: UIImageView!
    @IBOutlet weak var stepsViewVideo: videoPlayer!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var descricaoPasso: UILabel!
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    let audioEngine = AVAudioEngine()
    let speechRecognizer: SFSpeechRecognizer? = SFSpeechRecognizer()
    let request = SFSpeechAudioBufferRecognitionRequest()
    var recognitionTask: SFSpeechRecognitionTask?
    
    // timer
    var seconds = 200
    var timer = Timer()
    var isTimerRunning = false
    var resumeTapped = false
    @IBOutlet weak var timerLabel: UILabel!
    
    // timer functions
    @IBAction func play(_ sender: Any) {
        runTimer()
    }
    
    @IBAction func pause(_ sender: Any) {
        if self.resumeTapped == false {
            timer.invalidate()
            self.resumeTapped = true
        } else {
            runTimer()
            self.resumeTapped = false
        }
    }
    
    @IBAction func reset(_ sender: Any) {
        timer.invalidate()
        seconds = 60
        timerLabel.text = timeString(time: TimeInterval(seconds))
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(self.updateTimer)), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        seconds -= 1
        timerLabel.text = timeString(time: TimeInterval(seconds))
    }
    
    func timeString(time:TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        stepsTitle.text = listaDePassos2[index].tituloDoPasso
        verifMidia()
        descricaoPasso.text = listaDePassos2[index].texto
        progressBar.progress = setProgress()
    
        }
    
    override func viewWillAppear(_ animated: Bool) {
        uptadeUI()

        startRecording()
    }
    
    
    
    @IBAction func botaoProximo(_ sender: Any) {
        if(index != (listaDePassos2.count - 1)){
            index = index + 1
             progressBar.progress = setProgress()
            uptadeUI()
            //viewWillAppear(true)
            //stepsTitle.text = listaDePassos2[index].tituloDoPasso
            //stepsImage.image = UIImage(named: listaDePassos2[index].imagemPasso!)
            //VIDEO
            //descricaoPasso.text = listaDePassos2[index].texto
        }
    }
    
    
    
    @IBAction func botaoVolta(_ sender: Any) {
        if(index != 0){
            //self.navigationController?.popViewController(animated: true)
            index = index - 1
            progressBar.progress = setProgress()
            uptadeUI()
            //viewWillAppear(true)
            //stepsTitle.text = listaDePassos2[index].tituloDoPasso
            //stepsImage.image = UIImage(named: listaDePassos2[index].imagemPasso!)
            //VIDEO
            //descricaoPasso.text = listaDePassos2[index].texto
        }
    }
    
    func setProgress() -> Float {
        return ((Float(index + 1) * 100) / Float(listaDePassos2.count) / 100)
    }
    
    var listaDePassos2: [CDPasso]!
    var index: Int!

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func verifUltimo(){
        if(index == listaDePassos2.count - 1){
            
        }
    }
    
    func uptadeUI(){
        stepsTitle.text = listaDePassos2[index].tituloDoPasso
        verifMidia()
        descricaoPasso.text = listaDePassos2[index].texto
        progressBar.progress = setProgress()
    }
    
    func verifMidia(){
        stepsImage.isHidden = true
        stepsViewVideo.isHidden = true
     
        if(listaDePassos2[index].video?.isEmpty)!{ //Se o video for vazio
            stepsImage.isHidden = false
            stepsImage.image = UIImage(named: listaDePassos2[index].imagemPasso!)
            
        } else { //Se a imagem for vazia
            stepsViewVideo.isHidden = false
            
            let recognizer = UITapGestureRecognizer(target: self.stepsViewVideo, action: #selector(videoPlayer.playPress)) //Cria um reconhecedor de gesto, no caso do toque singular (tap) e efetua uma ação
            
            stepsViewVideo.addGestureRecognizer(recognizer) //Adicionha o reconhecedor pra View que vai reproduzir o vídeo
            stepsViewVideo.playerVideo(withFile: listaDePassos2[index].video!) //Chama a classe definindo o video a ser reproduzido
        }
    }
    
    func startRecording() {
        
        // Setup audio engine and speech recognizer
        let node = audioEngine.inputNode// else { return }
        let recordingFormat = node.outputFormat(forBus: 0)
        node.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
            self.request.append(buffer)
        }
        
        // Prepare and start recording
        
        audioEngine.prepare()
        do {
            try audioEngine.start()
        } catch {
            return print(error)
        }
        
        // Analyze the speech
        
        recognitionTask = speechRecognizer?.recognitionTask(with: request, resultHandler: { result, error in
            if let result = result {
                
                if(result.bestTranscription.formattedString.contains("next") ||
                    result.bestTranscription.formattedString.contains("Next")){
                    self.cancelRecording()
                    self.botaoProximo(true)
                    print("Avanca")
                }
                
                if(result.bestTranscription.formattedString.contains("Back") || result.bestTranscription.formattedString.contains("back")){
                    self.botaoVolta(true)
                    self.cancelRecording()
                    print("Volta")
                }
            } else if let error = error {
                print(error)
            }
        })
        
    }
    
    /// Stops and cancels the speech recognition.
    func cancelRecording() {
        audioEngine.stop()
        let node = audioEngine.inputNode //{
        node.removeTap(onBus: 0)
        //}
        recognitionTask?.cancel()
    }
    
    
    /*
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if( segue.identifier == "segueProximoPasso" ) {
            let destinoIniciaReceita = segue.destination as! StepsViewController
            if(index != (listaDePassos2.count - 1)){
                index = index + 1
                destinoIniciaReceita.listaDePassos2 = listaDePassos2
                destinoIniciaReceita.index = index
            }
            else{
                print("Nao há mais passos")
                destinoIniciaReceita.listaDePassos2 = listaDePassos2
                destinoIniciaReceita.index = index
            }
        }
        
        if( segue.identifier == "segueVoltaPasso" ) {
            let destinoIniciaReceita = segue.destination as! StepsViewController
            if(index != 0){
                index = index - 1
                destinoIniciaReceita.listaDePassos2 = listaDePassos2
                destinoIniciaReceita.index = index
            }
            else{
                print("Nao há mais passos")
                destinoIniciaReceita.listaDePassos2 = listaDePassos2
                destinoIniciaReceita.index = index
            }
        }
     }
        */
        
    

}
