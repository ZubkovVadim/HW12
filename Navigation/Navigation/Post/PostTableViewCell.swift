
import UIKit
import StorageService
import iOSIntPackage

class PostTableViewCell: UITableViewCell {
    
    var imageFilter = ImageProcessor()
    
    
    var post: PostModel?{
        didSet{
            imagePostUIImageView.image = UIImage (named: post!.image)
            authorLabel.text = post?.author
            discriptionLabel.text = post?.discription
            likesLabel.text = String ("Likes: \(post!.likes)")
            viewsLabel.text = String ("Views: \(post!.views)")
            self.imageFilter.processImage(sourceImage: self.imagePostUIImageView.image!, filter: .bloom(intensity: 5.0)) {
                filterImage in self.imagePostUIImageView.image=filterImage
            }
        }
    }
    
    let imagePostUIImageView: UIImageView = {
    let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .black
        return imageView
    }()
    
    let authorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let discriptionLabel: UILabel = {
        let label = UILabel()
        label.font=UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = .systemGray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var likesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let viewsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpViews()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
extension PostTableViewCell {
    
    func setUpViews() {
        contentView.addSubview(imagePostUIImageView)
        contentView.addSubview(authorLabel)
        contentView.addSubview(discriptionLabel)
        contentView.addSubview(likesLabel)
        contentView.addSubview(viewsLabel)
    }
    func setUpConstraints () {
        let constraints = [
            authorLabel.topAnchor.constraint(equalTo: contentView.topAnchor , constant: 16),
            authorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            imagePostUIImageView.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 12),
            imagePostUIImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imagePostUIImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imagePostUIImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            imagePostUIImageView.heightAnchor.constraint(equalTo: imagePostUIImageView.widthAnchor),

            discriptionLabel.topAnchor.constraint(equalTo: imagePostUIImageView.bottomAnchor, constant: 16),
            discriptionLabel.leadingAnchor.constraint(equalTo: authorLabel.leadingAnchor),
            discriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            likesLabel.topAnchor.constraint(equalTo: discriptionLabel.bottomAnchor, constant: 16),
            likesLabel.leadingAnchor.constraint(equalTo: authorLabel.leadingAnchor),
            likesLabel.trailingAnchor.constraint(equalTo: viewsLabel.leadingAnchor, constant: -100),

            viewsLabel.topAnchor.constraint(equalTo: likesLabel.topAnchor),
            viewsLabel.leadingAnchor.constraint(equalTo: likesLabel.trailingAnchor, constant: 100),
            viewsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            viewsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
            
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

