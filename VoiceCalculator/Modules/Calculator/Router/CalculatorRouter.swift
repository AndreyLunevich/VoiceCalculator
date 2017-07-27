import UIKit

class CalculatorRouter {

    func presentInfoAlert(from controller: UIViewController, title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))

        controller.present(alert, animated: true, completion: nil)
    }
}
