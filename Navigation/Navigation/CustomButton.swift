
import UIKit

class CustomButton: UIButton {

    private var onOrganizeTapButton: (() -> Void)

    init(title: String?, titleColor: UIColor?, backgroundColor: UIColor?, backgroundImage: UIImage?, onOrganizeTapButton: @escaping () -> Void) {
        self.onOrganizeTapButton = onOrganizeTapButton
        super.init(frame: .zero)
        
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.backgroundColor = backgroundColor
        self.setBackgroundImage(backgroundImage, for: .normal)
        
        self .addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc private func buttonTapped() {
        onOrganizeTapButton()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



