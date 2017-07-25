import UIKit
import Speech
import RxCocoa
import RxSwift

class CalculatorViewController: BaseViewController {

    @IBOutlet weak var recognizedLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var btnStartStop: UIButton!

    private let disposeBag = DisposeBag()
    private let available = Variable<Bool>(false)

    private let recognizer = Recognizer()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = L10n.voiceCalculator

        self.btnStartStop.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let sself = self else { return }

                let available = sself.available.value
                if available {
                    sself.startRecognizer()
                } else {
                    sself.stopRecognizer()
                }

                sself.available.value = !available
            })
            .addDisposableTo(self.disposeBag)

        self.available.asObservable()
            .map({ !$0 })
            .bind(to: self.btnStartStop.rx.isSelected)
            .addDisposableTo(self.disposeBag)

        SFSpeechRecognizer.requestAuthorization { (status) in
            OperationQueue.main.addOperation {
                switch status {
                case .authorized:
                    self.available.value = true

                case .denied, .restricted, .notDetermined:
                    self.available.value = false
                }
            }
        }
    }

    private func startRecognizer() {
        do {
            try self.recognizer.start { (result, error, isFinal) in
                let value = result?.bestTranscription.formattedString ?? ""

                self.recognizedLabel.text = L10n.calculateValue(value)
                self.available.value = error != nil || isFinal
            }
        } catch {
            print("Can't start recognition")
        }
    }

    private func stopRecognizer() {
        self.recognizer.stop()
    }
}
