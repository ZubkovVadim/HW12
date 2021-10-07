
//

import UIKit
import StorageService

class PhotosCollectionViewCell: UICollectionViewCell {
    var photo: UIImage? {
        didSet{
            photosUIImageView.image = photo
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
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension PhotosCollectionViewCell {
    func setUpViews() {
        contentView.addSubview(photosUIImageView)
    }
}
