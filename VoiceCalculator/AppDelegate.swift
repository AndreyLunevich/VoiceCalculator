import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        let calculator = CalculatorViewController()
        calculator.router = CalculatorRouter()

        let navi = UINavigationController(rootViewController: calculator)
        navi.navigationBar.isTranslucent = false

        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = navi
        self.window?.makeKeyAndVisible()

        return true
    }
}
