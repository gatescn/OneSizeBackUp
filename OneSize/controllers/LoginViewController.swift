import UIKit

class LoginViewController: UIViewController {
    @IBOutlet var loginUsernameText: UITextField!
    @IBOutlet var loginPasswordText: UITextField!
    var oneSizeRestApi: OneSizeRestApi!
    var profileStore: ProfileStore!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboard()
        
        self.oneSizeRestApi = OneSizeRestApi.instance
        self.profileStore = ProfileStore.instance
    }

    @IBAction func loginButton(_ sender: Any) {
        let loginUsername = loginUsernameText.text
        let loginPassword = loginPasswordText.text
        
        oneSizeRestApi.login(request: LoginRequest(
            email: loginUsername!,
            password: loginPassword!)) { profile in
        
            DispatchQueue.main.async {
                if (profile != nil) {
                    print(profile!)
                    self.performSegue(withIdentifier: "categoryPage", sender: nil)
                }
                else {
                    let myAlert = UIAlertController(
                        title: "Alert",
                        message: "Username or Password Incorrect",
                        preferredStyle: .alert)
                    
                    myAlert.addAction(UIAlertAction(
                        title: "Ok",
                        style: .default))

                    self.present(myAlert, animated: true, completion: nil)
                }
            }
        }
    }
}
