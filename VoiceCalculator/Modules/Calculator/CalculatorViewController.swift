import UIKit

class CalculatorViewController: BaseViewController {

    @IBOutlet weak var btnStartStop: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = L10n.voiceCalculator

    }
}
