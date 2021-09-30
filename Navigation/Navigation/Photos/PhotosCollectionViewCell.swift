
//

import UIKit
import StorageService

class PhotosCollectionViewCell: UICollectionViewCell {
    var photo: Photos?{
        didSet{
            photosUIImageView.image = UIImage (named: photo!.image)
        }
    }
    let photosUIImageView: UIImageView = {
    let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        

        return imageView
    }()
  
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
        photosUIImageView.frame = bounds
        photosUIImageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        
        
//        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension PhotosCollectionViewCell {
    func setUpViews() {
        contentView.addSubview(photosUIImageView)
    }
//    func setUpConstraints () {
//        _ = [
//            photosUIImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
//            photosUIImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
//            photosUIImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
//            photosUIImageView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -8)
//        ]
//        NSLayoutConstraint.activate(constraints)
//    }
}
