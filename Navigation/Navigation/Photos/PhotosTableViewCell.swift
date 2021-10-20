

import UIKit
import StorageService

class PhotosTableViewCell: UITableViewCell {
    var openPhotosViewController:(() -> Void)?
    var onOrganizeTapButton: (() -> Void)?
    var photo: [Photos] = [] {
        didSet{
            stackPhotoView.arrangedSubviews.forEach { view in
                stackPhotoView.removeArrangedSubview(view)
                view.removeFromSuperview()
            }
            photo.forEach { photo in
                stackPhotoView.addArrangedSubview(createImageView(named: photo.image))
            }
        }
    }
    func createImageView (named: String) -> UIImageView {
        let photo = UIImageView(image: UIImage (named: named))
        photo.translatesAutoresizingMaskIntoConstraints = false
        photo.contentMode = .scaleAspectFill
        photo.clipsToBounds = true
        photo.layer.masksToBounds = true
        photo.layer.cornerRadius = 6
        return photo
    }
    
    lazy var stackPhotoView: UIStackView = {
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        return stackView
    }()
    let photoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = "Photos"
        return label
    }()
    
   private lazy var photoButton: CustomButton = {
        var button = CustomButton(title: nil, titleColor: nil, backgroundColor: nil, backgroundImage: UIImage(systemName: "arrowshape.turn.up.forward.circle"), onOrganizeTapButton: onOrganizeTapButton!)
        button.translatesAutoresizingMaskIntoConstraints = false
//        button.setImage(UIImage(systemName: "arrowshape.turn.up.forward.circle"), for: .normal)
//        button.addTarget(self, action: #selector(tap), for: .touchUpInside)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        tap()
        setUpViews()
        setUpConstraints()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension PhotosTableViewCell {
    
    func setUpViews() {
        contentView.addSubview(stackPhotoView)
        contentView.addSubview(photoLabel)
        contentView.addSubview(photoButton)
        photoLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        photoButton.setContentHuggingPriority(.defaultLow, for: .vertical)
        photoButton.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        photoButton.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    }
    func setUpConstraints () {
        let constraints = [
            stackPhotoView.topAnchor.constraint(equalTo: photoLabel.bottomAnchor, constant: 12),
            stackPhotoView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            stackPhotoView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            stackPhotoView.heightAnchor.constraint(equalToConstant: 100),
            stackPhotoView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            
            
            photoLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            photoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            
            photoButton.topAnchor.constraint(equalTo: photoLabel.topAnchor),
            photoButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            photoButton.heightAnchor.constraint(equalTo: photoLabel.heightAnchor),
            photoButton.widthAnchor.constraint(equalTo: photoLabel.heightAnchor),
            photoButton.centerYAnchor.constraint(equalTo: photoLabel.centerYAnchor)
            
        ]
        NSLayoutConstraint.activate(constraints)
    }
    func tap() {
        onOrganizeTapButton = { [weak self] in
            guard let self = self else {return}
            self.openPhotosViewController?()
        print ("taped")
    }
}
}
