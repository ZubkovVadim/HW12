import UIKit
import StorageService

protocol LogInViewControllerOutput: AnyObject {
    func didLogin(username: String)
}

class LogInViewController: UIViewController {
    weak var output: LogInViewControllerOutput?
    let loginService: LoginServing
    
    init(output: LogInViewControllerOutput, loginService: LoginServing) {
        self.output = output
        self.loginService = loginService
        
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let containerView: UIView = {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()
    
    private let logoImageView: UIImageView = {
        let logo = UIImageView()
        logo.contentMode = .scaleAspectFill
        logo.image = #imageLiteral(resourceName: "logo")
        logo.translatesAutoresizingMaskIntoConstraints = false
        return logo
    }()
    
    private let userNameTextField: UITextField = {
        let emailOrPhoneTextField = UITextField()
        emailOrPhoneTextField.backgroundColor = .systemGray6
        emailOrPhoneTextField.textColor = .black
        emailOrPhoneTextField.autocapitalizationType = .none
        emailOrPhoneTextField.leftView = UIView(frame: CGRect(x: 0,
                                                              y: 0,
                                                              width: 10,
                                                              height: emailOrPhoneTextField.frame.height))
        emailOrPhoneTextField.leftViewMode = .always
        emailOrPhoneTextField.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        emailOrPhoneTextField.layer.borderColor = UIColor.lightGray.cgColor
        emailOrPhoneTextField.layer.borderWidth = 0.5
        emailOrPhoneTextField.layer.cornerRadius = 10
        emailOrPhoneTextField.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        emailOrPhoneTextField.placeholder = "Username"
        emailOrPhoneTextField.translatesAutoresizingMaskIntoConstraints = false
        return emailOrPhoneTextField
    }()
    private let passwordTextField: UITextField = {
        let passwordTextField = UITextField()
        passwordTextField.backgroundColor = .systemGray6
        passwordTextField.textColor = .black
        passwordTextField.autocapitalizationType = .none
        passwordTextField.leftView = UIView(frame: CGRect(x: 0,
                                                          y: 0,
                                                          width: 10,
                                                          height: passwordTextField.frame.height))
        passwordTextField.leftViewMode = .always
        passwordTextField.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        passwordTextField.layer.borderColor = UIColor.lightGray.cgColor
        passwordTextField.layer.borderWidth = 0.5
        passwordTextField.layer.cornerRadius = 10
        passwordTextField.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMinXMaxYCorner]
        passwordTextField.placeholder = "Password"
        passwordTextField.isSecureTextEntry = true
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        return passwordTextField
    }()
    
    private let logInButton: UIButton = {
        let logInButton = UIButton(type: .system)
        logInButton.layer.masksToBounds = true
        logInButton.setTitle("Log In", for: .normal)
        logInButton.setBackgroundImage(UIImage(named: "MyColor1"), for: .normal)
        logInButton.layer.cornerRadius = 10
        logInButton.addTarget(self, action: #selector(tapLoginButton), for: .touchUpInside)
        logInButton.setTitleColor(.white, for: .normal)
        logInButton.setTitleColor(.lightGray, for: .disabled)
        logInButton.translatesAutoresizingMaskIntoConstraints = false
        logInButton.isEnabled = false
        return logInButton
    }()
    
    private let singUpButton: UIButton = {
        let logInButton = UIButton(type: .system)
        logInButton.layer.masksToBounds = true
        logInButton.setTitle("Sing Up", for: .normal)
        logInButton.setBackgroundImage(UIImage(named: "MyColor1"), for: .normal)
        logInButton.layer.cornerRadius = 10
        logInButton.addTarget(self, action: #selector(tapSingUpButton), for: .touchUpInside)
        logInButton.setTitleColor(.white, for: .normal)
        logInButton.setTitleColor(.lightGray, for: .disabled)
        logInButton.translatesAutoresizingMaskIntoConstraints = false
        logInButton.isEnabled = false
        return logInButton
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [logInButton, singUpButton])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        scrollView.keyboardDismissMode = .onDrag
        containerView.addSubview(logoImageView)
        containerView.addSubview(userNameTextField)
        containerView.addSubview(passwordTextField)
        containerView.addSubview(stackView)
        
        userNameTextField.delegate = self
        passwordTextField.delegate = self
        
        navigationController?.navigationBar.isHidden = true
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeKeyboard()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    private func subscribeKeyboard() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(notification:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(notification:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyBoardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            scrollView.contentInset.bottom = keyBoardSize.height
            scrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyBoardSize.height, right: 0)
        }
    }
    
    @objc func keyBoardWillHide(notification:  NSNotification){
        scrollView.contentInset.bottom = .zero
        scrollView.verticalScrollIndicatorInsets = .zero
    }
    
    override func viewWillLayoutSubviews() {
        let constrains = [
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            
            logoImageView.topAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.topAnchor, constant: 120),
            logoImageView.centerXAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 100),
            logoImageView.heightAnchor.constraint(equalTo: logoImageView.widthAnchor),
            logoImageView.bottomAnchor.constraint(equalTo: userNameTextField.topAnchor, constant: -120),
            
            
            userNameTextField.leadingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            userNameTextField.trailingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            userNameTextField.heightAnchor.constraint(equalToConstant: 50),
            
            passwordTextField.topAnchor.constraint(equalTo: userNameTextField.bottomAnchor),
            passwordTextField.leadingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            passwordTextField.trailingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            stackView.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 50),
            stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -120)
        ]
        NSLayoutConstraint.activate(constrains)
    }

    @objc func tapLoginButton() {
        guard let email = userNameTextField.text,
              let password = passwordTextField.text else {
                  // Show error, need to fill fileds
            return
        }

        loginService.signIn(email: email, password: password) { [weak self] result in
            switch result {
                
            case let .success(name):
                self?.output?.didLogin(username: name)
                
            case let .failure(error):
//                self?.tapSingUpButton()
                
                
                
                print("Error login", error.localizedDescription)
                self?.setErrorState()
            }
        }
    }
    
    @objc func tapSingUpButton() {
        // sing
        // show loader
        // disable buttons
        
        guard let email = userNameTextField.text,
              let password = passwordTextField.text else {
            return
        }
        
        loginService.signUp(email: email, password: password) { [weak self] result in
            switch result {
                
            case let .success(name):
                self?.output?.didLogin(username: name)
                
            case let .failure(error):
                
                switch error {
                case .nameNotFound:
                    print("nameNotFound")
                case .alreadyInUse:
                    print("email is is use")
                case let .firebase(error):
                    print("Error login", error.localizedDescription)
                }

                self?.setErrorState()
            }
        }
    }
    
    private func setErrorState() {
        userNameTextField.layer.borderColor = UIColor.red.cgColor
        passwordTextField.layer.borderColor = UIColor.red.cgColor
    }
    
    private func setDefaultState() {
        userNameTextField.layer.borderColor = UIColor.lightGray.cgColor
        passwordTextField.layer.borderColor = UIColor.lightGray.cgColor
    }
}

extension LogInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("Tap return")
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        var username = userNameTextField.text ?? ""
        var password = passwordTextField.text ?? ""
        var isEnabled = false
        
        if textField == userNameTextField {
            username = username.replacing(range: range, string: string)
            isEnabled = !username.isEmpty && !password.isEmpty
            
        } else if textField == passwordTextField {

            password = password.replacing(range: range, string: string)
            isEnabled = !username.isEmpty && !password.isEmpty
        }
        
        logInButton.isEnabled = isEnabled
        singUpButton.isEnabled = isEnabled
        setDefaultState()
        
        return true
    }
}

extension String {
    func replacing(range: NSRange, string: String) -> String {
        if let textRange = Range(range, in: self) {
            return replacingCharacters(in: textRange, with: string)
        }

        return self
    }
}
