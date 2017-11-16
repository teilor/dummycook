//
//  StepsViewController.swift
//  DummyCook
//
//  Created by Aline Ebone on 13/11/17.
//  Copyright © 2017 Aline Ebone. All rights reserved.
//

import UIKit
import Speech

class StepsViewController: UIViewController, SFSpeechRecognitionTaskDelegate {
    
    @IBOutlet weak var stepsTitle: UILabel!
    @IBOutlet weak var stepsImage: UIImageView!
    @IBOutlet weak var stepsViewVideo: videoPlayer!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var descricaoPasso: UILabel!
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    let audioEngine = AVAudioEngine()
    let speechRecognizer: SFSpeechRecognizer? = SFSpeechRecognizer(locale: Locale.init(identifier: "en-US"))
    var request = SFSpeechAudioBufferRecognitionRequest()
    var recognitionTask: SFSpeechRecognitionTask?
    
    
    // timer
    var timer = Timer()
    var isTimerRunning = false
    var resumeTapped = false
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var timerView: UIView!
    var seconds: Int = 0
    
    // timer functions
    @IBAction func play(_ sender: Any) {
        if(isTimerRunning == false){
            runTimer()
        }
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
        seconds = Int(listaDePassos2[index].timer!)!
        timerLabel.text = timeString(time: TimeInterval(seconds))
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(self.updateTimer)), userInfo: nil, repeats: true)
        isTimerRunning = true
    }
    
    @objc func updateTimer() {
        if(seconds > 0){
        seconds -= 1
        timerLabel.text = timeString(time: TimeInterval(seconds))
        }
        else{
            timer.invalidate()
        }
    }
    
    func timeString(time:TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Step \(index+1) of \(listaDePassos2.count)"
        stepsTitle.text = listaDePassos2[index].tituloDoPasso
        verifMidia()
        descricaoPasso.text = listaDePassos2[index].texto
        progressBar.progress = setProgress()
    
        }
    
    override func viewWillAppear(_ animated: Bool) {
        
//        stepsTitle.text = listaDePassos2[index].tituloDoPasso
//        verifMidia()
//        descricaoPasso.text = listaDePassos2[index].texto
//        progressBar.progress = setProgress()
        updateUI()
        requestSpeechAuthorization()
    }
    
    
    
    @IBAction func botaoProximo(_ sender: Any) {
        if(index != (listaDePassos2.count - 1)){
            //self.seconds = 0
            index = index + 1
             progressBar.progress = setProgress()
            self.cancelRecording()
            updateUI()
            self.startRecording()
            
            //stepsTitle.text = listaDePassos2[index].tituloDoPasso
            //stepsImage.image = UIImage(named: listaDePassos2[index].imagemPasso!)
            //VIDEO
            //descricaoPasso.text = listaDePassos2[index].texto
            
        }
    }
    
    @IBAction func botaoVolta(_ sender: Any) {
        if(index != 0){
            //self.seconds = 0
            //self.navigationController?.popViewController(animated: true)
            index = index - 1
            progressBar.progress = setProgress()
            self.cancelRecording()
            updateUI()
            self.startRecording()
            
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
    
    func verifMidia(){
        stepsImage.isHidden = true
        stepsViewVideo.isHidden = true
        
//        if (listaDePassos2[index].timer?.isEmpty)! {
//            timerView.isHidden = true
//            //self.seconds = 0
//            print("should hide")
//        } else {
//            seconds = Int(listaDePassos2[index].timer!)!
//            timerView.isHidden = false
//            print("should show")
//        }
        
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
    
    func updateUI(){
        if (listaDePassos2[index].timer?.isEmpty)! {
            timerView.isHidden = true
            //self.seconds = 0
            
            self.timer.invalidate()
            isTimerRunning = false
            print("should hide")
        } else {
            //runTimer()
            //self.timer.fire()
            seconds = Int(listaDePassos2[index].timer!)!
            timerView.isHidden = false
            print("should show")
            timerLabel.text = timeString(time: TimeInterval(seconds))
        }
        self.title = "Step \(index+1) of \(listaDePassos2.count)"
        //self.seconds = 0
        
        //timerLabel.text = timeString(time: TimeInterval(seconds))
        stepsTitle.text = listaDePassos2[index].tituloDoPasso
        verifMidia()
        descricaoPasso.text = listaDePassos2[index].texto
        progressBar.progress = setProgress()
        
    }

    
    func startRecording() {
        self.request = SFSpeechAudioBufferRecognitionRequest()
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
                print(result)
                
                if(result.bestTranscription.formattedString.contains("next") ||
                    result.bestTranscription.formattedString.contains("Next")){
                    //self.cancelRecording()
                    //self.recognitionTask?.finish()
                    self.botaoProximo(true)
                    //self.cancelRecording()
                    print("Avanca")
                }
                
                if(result.bestTranscription.formattedString.contains("Back") || result.bestTranscription.formattedString.contains("back")){
                    //self.cancelRecording()
                    //self.recognitionTask?.finish()
                    self.botaoVolta(true)
                    //self.cancelRecording()
                    print("Volta")
                }
                
                if (result.bestTranscription.formattedString.contains("Start") || result.bestTranscription.formattedString.contains("start")){
                    self.play(true)
                    self.resetaVoz()
                    print("Iniciou timer")
                }
                
                
                if (result.bestTranscription.formattedString.contains("Stop") || result.bestTranscription.formattedString.contains("stop")){
                    self.timer.invalidate()
                    self.resetaVoz()
                    self.isTimerRunning = false
                    print("Pausou timer")
                }
                
                if (result.bestTranscription.formattedString.contains("Reset") || result.bestTranscription.formattedString.contains("reset")){
                    self.reset(true)
                    self.resetaVoz()
                    self.isTimerRunning = false
                    print("Resetou timer")
                }
                
                
            } else if let error = error {
                print(error)
            }
        })
        
    }
    
    func resetaVoz() {
        self.cancelRecording()
        self.startRecording()
    }
    
    func cancelRecording() {
        audioEngine.stop()
        audioEngine.inputNode.removeTap(onBus: 0) //{
        //            node.removeTap(onBus: 0)
        //        }
        recognitionTask?.cancel()
        //self.recognitionTask?.finish()
    }
    
    func requestSpeechAuthorization() {
        SFSpeechRecognizer.requestAuthorization { authStatus in
            OperationQueue.main.addOperation {
                switch authStatus{
                case .authorized:
                    self.startRecording()
                case .denied:
                    self.cancelRecording()
                case .restricted:
                    self.cancelRecording()
                case .notDetermined:
                    self.cancelRecording()
                }
            }
        }
    }
    
    
    func speechRecognitionTaskFinishedReadingAudio(_ task: SFSpeechRecognitionTask) {
        startRecording()
    }
}

