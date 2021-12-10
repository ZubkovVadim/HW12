import UIKit
import SnapKit
import StorageService

class FeedViewController: UIViewController{
    var checkerModel = CheckerModel()
    var coordinator: FeedCoordinator?
    var onModuleFinish: (() -> Void)?
    var onOrganizeTapButton: (() -> Void)?
    
    //    let post: Post = Post(title: "Пост")
    let checkLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var checkButton: CustomButton = {
        let button = CustomButton(title: "Enter", titleColor: .white, backgroundColor: .gray, backgroundImage: nil, onOrganizeTapButton: onOrganizeTapButton!)
        //        button.backgroundColor = .gray
        button.layer.cornerRadius = 14
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        //        button.addTarget(self, action: #selector(buttonTaped), for: .touchUpInside)
        //        button.setTitle("Enter", for: .normal)
        //        button.setTitleColor(.white, for: .normal)
        button.isEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let checkTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.backgroundColor = .systemGray6
        textField.textColor = .black
        textField.autocapitalizationType = .none
        textField.leftView = UIView(frame: CGRect(x: 0,
                                                  y: 0,
                                                  width: 10,
                                                  height: textField.frame.height))
        textField.leftViewMode = .always
        textField.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = 10
        textField.placeholder = "Set Password"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonTaped()
        view.addSubview(checkButton)
        view.addSubview(checkTextField)
        view.addSubview(checkLabel)
        checkTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        setUpConstraints()
        view.backgroundColor = .systemGreen
        navigationItem.title = "Feed"
        print(type(of: self), #function)
        self.onModuleFinish?()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(notification:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(notification:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    func buttonTaped() {
        onOrganizeTapButton = { [weak self] in
            guard let self = self else {return}
            self.checkerModel.check(word: self.checkTextField.text) { result in
                if result {
                    self.checkLabel.text = self.checkTextField.text
                    self.checkLabel.textColor = .green
                } else {
                    self.checkLabel.text = self.checkTextField.text
                    self.checkLabel.textColor = .red
                }
            }
        }
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyBoardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let constraints = [
                checkButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: keyBoardSize.height + 100)
            ]
            NSLayoutConstraint.activate(constraints)
        }
    }
    
    @objc func keyBoardWillHide(notification:  NSNotification){
        let constraints = [
            checkButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 100)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    func setUpConstraints() {
        let constraints = [
            checkTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            checkTextField.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -16),
            checkTextField.heightAnchor.constraint(equalToConstant: 50),
            //            checkTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: -32),
            
            checkButton.topAnchor.constraint(equalTo: checkTextField.bottomAnchor, constant: 16),
            checkButton.centerXAnchor.constraint(equalTo: checkTextField.centerXAnchor),
            checkButton.widthAnchor.constraint(equalTo: checkTextField.widthAnchor),
            checkButton.heightAnchor.constraint(equalTo: checkTextField.heightAnchor),
            checkButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -200),
            
            checkLabel.bottomAnchor.constraint(equalTo: checkTextField.topAnchor, constant: -16),
            checkLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            checkLabel.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -16),
            checkLabel.heightAnchor.constraint(equalToConstant: 200)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    @objc func textFieldDidChange () {
        if checkTextField.text!.isEmpty {
            checkButton
                .isEnabled = false
            checkButton.backgroundColor = .gray
        } else {
            checkButton.isEnabled = true
            checkButton.backgroundColor = .blue
        }
    }
}
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard segue.identifier == "post" else {
//            return
//        }
//        guard let postViewController = segue.destination as? PostViewController else {
//            return
//        }
//        postViewController.post = post
//    }


