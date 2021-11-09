

import UIKit
import StorageService
import iOSIntPackage

protocol MyViewControllerOutput: AnyObject {
    func configurePublisher()
    func cancelSubscription()
}

protocol MyViewControllerInput: AnyObject {
    func reload(images: [UIImage])
}
class PhotosViewController: UIViewController, MyViewControllerOutput {
    private let publisher = ImagePublisherFacade()
    
 
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize (width: (UIScreen.main.bounds.width - 8 * 4)/3, height: 120)
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: PhotosCollectionViewCell.self))
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        return collectionView
    }()
    

    let cellID = "CellID"
    var images = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionView()
        viewWillLayoutSubviews()
        setupImageView()
        configurePublisher()
        
    }
    func setUpCollectionView () {
        view.backgroundColor = .gray
        navigationController?.navigationBar.isHidden = false
        self.navigationItem.title = "Photos Gallery"
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        collectionView.frame = CGRect(x: view.safeAreaInsets.left,
                                      y: view.safeAreaInsets.top,
                                      width: view.frame.width - view.safeAreaInsets.left - view.safeAreaInsets.right,
                                      height: view.frame.height - view.safeAreaInsets.top)
    }
    private func setupImageView() {
        view.addSubview(collectionView)
    }
  
    func configurePublisher() {
        publisher.subscribe(self)
        let initialImages = PhotosStorage.photos.compactMap { UIImage(named: $0.image) }
        publisher.addImagesWithTimer(time: 5,
                                     repeat: 10,
                                     userImages: initialImages)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        cancelSubscription()
        collectionView.reloadData()
    }
    func cancelSubscription() {
        publisher.rechargeImageLibrary()
        publisher.removeSubscription(for: self)
    }
}

extension PhotosViewController: UICollectionViewDataSource, ImageLibrarySubscriber {
    func receive(images: [UIImage]) {
        reload(images: images)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PhotosCollectionViewCell.self), for: indexPath) as! PhotosCollectionViewCell
        cell.photo = images[indexPath.row]
        return cell
    }
}

extension PhotosViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,  collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width - 8 * 4)/3,
                      height: 120)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
 
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8,  bottom: 8, right: 8)
    }
}

extension PhotosViewController: MyViewControllerInput {
    func reload(images: [UIImage]) {
        self.images = images
        self.collectionView.reloadData()
    }
}
