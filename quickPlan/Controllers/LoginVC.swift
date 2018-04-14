import UIKit

class LoginVC: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var createAccountBtn: UIButton!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    // MARK: Variables
    var textFieldDelegate = TextFieldDelegate()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        cleanFields()
    }
    
    func cleanFields(){
        emailTxt.text = ""
        passwordTxt.text = ""
    }
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue){}
    
    // MARK: Setup All view adjusts before render
    func setupView(){
        loginBtn.setTitleColor(UIColor.clear, for: .disabled)
        passwordTxt.delegate = textFieldDelegate
        emailTxt.delegate = textFieldDelegate
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(LoginVC.handleTap))
        view.addGestureRecognizer(tap)
    }
    
    
    // MARK: Dismiss keyboard when user tap anywhere
    @objc func handleTap(){
        view.endEditing(true)
    }
    
    // MARK: If is loading disable actions and fields and start spinner
    func loading(isLoading: Bool){
        emailTxt.isEnabled = !isLoading
        passwordTxt.isEnabled = !isLoading
        loginBtn.isEnabled = !isLoading
        createAccountBtn.isEnabled = !isLoading
        if isLoading {
            spinner.startAnimating()
        } else {
            spinner.stopAnimating()
        }
    }
    
    @IBAction func loginBtnPressed(_ sender: Any) {
        
        guard let email = emailTxt.text, emailTxt.text != "" else {return}
        guard let pass = passwordTxt.text, passwordTxt.text != "" else {return}
        
        loading(isLoading: true)
        
        AuthService.instance.loginUser(email: email, password: pass) { (success) in
            if success{
                AuthService.instance.findUserByEmail(completion: { (success) in
                    if success{
                        NotificationCenter.default.post(name: Constants.Notifications.UserDataDidChange, object: nil)
                        self.performSegue(withIdentifier: Constants.Segues.ToChannels, sender: nil)
                    } else {
                        self.loginErrorMessage()
                    }
                    self.loading(isLoading: false)
                })
            } else {
                self.loading(isLoading: false)
                self.loginErrorMessage()
            }
        }
        
        
    }
    
    func loginErrorMessage(){
        let alert = UIAlertController(title: "Ops...", message: "Wrong e-mail or password", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(alertAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func createAccountBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: Constants.Segues.ToCreateAccount, sender: nil)
    }
    
}

