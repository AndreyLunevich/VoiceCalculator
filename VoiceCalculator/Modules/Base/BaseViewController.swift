import UIKit

class BaseViewController: UIViewController {

    convenience init() {
        let type = type(of: self)
        let nibName = String(describing: type)

        self.init(nibName: nibName, bundle: nil)
    }
}
