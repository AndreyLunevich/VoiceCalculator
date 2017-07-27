import Speech

class Recognizer {

    let speechRecognizer: SFSpeechRecognizer?
    private let audioEngine = AVAudioEngine()
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?

    init(locale: Locale = Locale(identifier: "en-US")) {
        self.speechRecognizer = SFSpeechRecognizer(locale: locale)
    }

    func start(handler: @escaping (SFSpeechRecognitionResult?, Error?, Bool) -> Void) throws {
        if self.recognitionTask != nil {
            self.recognitionTask?.cancel()
            self.recognitionTask = nil
        }

        let audioSession = AVAudioSession.sharedInstance()
        try audioSession.setCategory(AVAudioSessionCategoryRecord)
        try audioSession.setMode(AVAudioSessionModeMeasurement)
        try audioSession.setActive(true, with: .notifyOthersOnDeactivation)

        self.recognitionRequest = SFSpeechAudioBufferRecognitionRequest()

        guard let inputNode = self.audioEngine.inputNode else {
            fatalError("Audio engine has no input node")
        }

        guard let recognitionRequest = self.recognitionRequest else {
            fatalError("Unable to create an SFSpeechAudioBufferRecognitionRequest object")
        }

        self.recognitionTask = self.speechRecognizer?.recognitionTask(with: recognitionRequest, resultHandler: { (result, error) in

            let isFinal = result?.isFinal ?? false

            if error != nil || isFinal {
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)

                self.recognitionRequest = nil
                self.recognitionTask = nil
            }

            handler(result, error, isFinal)
        })

        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, _) in
            self.recognitionRequest?.append(buffer)
        }

        self.audioEngine.prepare()

        try self.audioEngine.start()
    }

    func stop() {
        if self.audioEngine.isRunning {
            self.audioEngine.stop()
            self.recognitionRequest?.endAudio()
        }
    }
}
