import UIKit

class RegisterViewController: UIViewController {
    @IBOutlet var userFirstNameText: UITextField!
    @IBOutlet var userLastNameText: UITextField!
    @IBOutlet var userEmailText: UITextField!
    @IBOutlet var userPhoneText: UITextField!
    @IBOutlet var passwordText: UITextField!
    @IBOutlet var repeatPasswordText: UITextField!
    var profileStore: ProfileStore!
    var oneSizeRestApi: OneSizeRestApi!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboard()
        
        profileStore = ProfileStore.instance
        oneSizeRestApi = OneSizeRestApi.instance
    }
    
    @IBAction func registerUserButton(_ sender: Any) {
        let userFirstName = userFirstNameText.text
        let userLastName = userLastNameText.text
        let userEmail = userEmailText.text
        let userPhone = userPhoneText.text
        let password = passwordText.text
        let repeatPassword = repeatPasswordText.text
        
        let fields = [userFirstName, userLastName, userEmail, userPhone,
                      password, repeatPassword]
            
        if(fields.contains { string in string?.isEmpty ?? true }) {
            displayAlertMessage(message: "All fields are required.")
            return
        }

        if(password != repeatPassword){
            displayAlertMessage(message: "Password fields do not match.")
            return
        }
        
        oneSizeRestApi.registerProfile(request: RegistrationRequest(
            firstName: userFirstName!,
            lastName: userLastName!,
            email: userEmail!,
            phoneNumber: userPhone!,
            password: password!)) { profile in
            
            guard let profile = profile else {
                DispatchQueue.main.async {
                    self.displayAlertMessage(message: "Registration Failed")
                }
                return
            }
            
            DispatchQueue.main.async {
                self.displayAlertMessage(
                    message: "Registration Successful for " +
                        "\(profile.firstName) \(profile.lastName)") { _ in
                            
                    let nav = self.navigationController!
                    nav.popViewController(animated: true)
                }
            }
        }
    }
    
    func displayAlertMessage(
        message: String,
        okActionHandler: ((UIAlertAction) -> Void)? = nil) {
        
        let myAlert = UIAlertController(
            title: "Alert",
            message: message,
            preferredStyle: .alert)
        
        myAlert.addAction(UIAlertAction(
            title: "Ok",
            style: .default,
            handler: okActionHandler))
        
        present(myAlert, animated: true, completion: nil)
    }
}
