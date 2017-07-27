import UIKit
import Speech
import Foundation
import RxCocoa
import RxSwift

class CalculatorViewController: BaseViewController {

    @IBOutlet weak var recognizedLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var btnStartStop: UIButton!

    var router: CalculatorRouter?

    private let disposeBag = DisposeBag()
    private let isRunning = Variable<Bool>(false)

    private let recognizer = Recognizer()
    private let brain = CalculatorBrain()
    private var speechSynthesizer = AVSpeechSynthesizer()
    private var timer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = L10n.voiceCalculator

        self.btnStartStop.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let sself = self else { return }

                let isRunning = sself.isRunning.value
                if isRunning {
                    sself.stopRecognizer()
                } else {
                    sself.startRecognizer()
                }

                sself.isRunning.value = !isRunning
            })
            .addDisposableTo(self.disposeBag)

        self.isRunning.asObservable()
            .bind(to: self.btnStartStop.rx.isSelected)
            .addDisposableTo(self.disposeBag)

        SFSpeechRecognizer.requestAuthorization { (status) in
            OperationQueue.main.addOperation {
                // can add switch for more detailed error message
                if status != .authorized {
                    self.router?.presentInfoAlert(from: self, title: "", message: "You didn't accept permissions")
                }
            }
        }
    }

    private func startRecognizer() {
        do {
            try self.recognizer.start { [weak self] (result, _, isFinal) in
                let expression = result?.bestTranscription.formattedString ?? ""

                var calculationResult = ""
                if let value = self?.brain.compute(expression) {
                    calculationResult = String(format: "%g (%@)", value, value.asWord)

                    if isFinal {
                        self?.speak(text: value.asWord)
                    }
                }

                self?.recognizedLabel.text = L10n.calculateValue(expression)
                self?.resultLabel.text = L10n.calculatedValue(calculationResult)

                self?.restartTimer()
            }
        } catch {
            print("Can't start recognition")
        }
    }

    private func stopRecognizer() {
        self.recognizer.stop()

        self.recognizedLabel.text = L10n.calculateValue("")
        self.resultLabel.text = L10n.calculatedValue("")
    }

    private func speak(text: String) {
        let speechUtterance = AVSpeechUtterance(string: text)
        speechUtterance.volume = 1.0
        speechUtterance.rate = 0.5
        speechUtterance.pitchMultiplier = 1.15

        self.speechSynthesizer.speak(speechUtterance)
    }

    private func restartTimer() {
        self.timer?.invalidate()
        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { [weak self] (_) in
            self?.isRunning.value = false

            self?.stopRecognizer()
        }
    }
}
