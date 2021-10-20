import UIKit
import SnapKit
import StorageService

class ProfileHeaderView: UITableViewHeaderFooterView {
    
    var user: User? {
        didSet {
            headerImageView.image = user?.avatar
            fullNameLabel.text = user?.fullName
            statusLabel.text = user?.status
        }
    }
    private var onOrganizeTapButton: (() -> Void)?
    
    private let headerImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleToFill
        iv.image = #imageLiteral(resourceName: "avatar")
        iv.clipsToBounds = true
        iv.layer.masksToBounds = true
        iv.layer.borderColor = UIColor.white.cgColor
        iv.layer.borderWidth = 3
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.cornerRadius = 75
      
        return iv
    }()
    private lazy var setStatusButton: CustomButton = {
        let button = CustomButton(title: "Show status", titleColor: .white, backgroundColor: .blue, backgroundImage: nil, onOrganizeTapButton: onOrganizeTapButton!)
        button.layer.shadowColor = UIColor.black.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 14
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
//        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()
    
    let fullNameLabel: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        title.text = "Grumpy cat"
        title.textColor = .black
        return title
    }()
    
    let statusLabel: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        title.text = "Waiting for something..."
        title.textColor = .systemGray2
        return title
    }()
    
    let statusTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false

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
        textField.placeholder = "Set your status..."
        return textField
    }()
    override init(reuseIdentifier: String?) {
            super.init(reuseIdentifier: reuseIdentifier)
        setUpUI()
        setUpView()
        
    }
    func setUpView() {
        contentView.addSubview(headerImageView)
        contentView.addSubview(setStatusButton)
        contentView.addSubview(fullNameLabel)
        contentView.addSubview(statusLabel)
        contentView.addSubview(statusTextField)
        statusTextField.addTarget(self, action: #selector(statusTextFieldDidChange), for: .editingChanged)
        
        headerImageView.snp.makeConstraints { (make) -> Void in
            make.width.height.equalTo(150)
            make.topMargin.leading.equalTo(16)
            make.bottom.equalTo(setStatusButton.snp.top).inset(-16)
        }
        
        fullNameLabel.snp.makeConstraints { (make) -> Void in
            make.topMargin.equalTo(27)
            make.left.equalTo(headerImageView.snp.right).inset(-16)
            make.rightMargin.equalTo(-16)
        }

        statusLabel.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(fullNameLabel.snp.left)
            make.top.equalTo(fullNameLabel.snp.bottom).inset(-16)
            make.right.equalTo(fullNameLabel.snp.right)
        }

        statusTextField.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(fullNameLabel.snp.left)
            make.top.equalTo(statusLabel.snp.bottom).inset(-10)
            make.right.equalTo(setStatusButton.snp.right)
            make.height.equalTo(40)
        }
        
        setStatusButton.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(contentView.snp.centerX)
            make.top.equalTo(headerImageView.snp.bottom).inset(32)
            make.left.equalTo(headerImageView.snp.left)
            make.rightMargin.equalTo(-16)
            make.height.equalTo(50)
            make.bottomMargin.equalTo(-12)
        }
}
        required init?(coder: NSCoder) {
            super.init(coder: coder)
        }
    func setUpUI() {
        onOrganizeTapButton = { [weak self] in
            guard let self = self else {return}
            self.statusLabel.text = self.statusTextField.text
    }
    }
//    @objc func buttonPressed(_ sender: Any) {
//         statusLabel.text = statusTextField.text
//     }
    @objc func statusTextFieldDidChange () {
            if statusTextField.text!.isEmpty {
                setStatusButton.isEnabled = false
            }
            else {
                setStatusButton.isEnabled = true
            }

    }
}
    
