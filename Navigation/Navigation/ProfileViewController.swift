import UIKit
import StorageService

class ProfileViewController: UIViewController {
    
    var userService: UserService
    var userName: String
    var user: User?
    
    
    let tableView = UITableView(frame: .zero, style: .plain)
    let cellIDPosts = "CellIDPosts"
    let cellIDPhotos = "CellIDPhotos"
    let allPosts = Storage.posts
    let photos = PhotosStorage.photos
    
    init(userService: UserService, userName: String ) {
        self.userService = userService
        self.userName = userName
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        setUpTableView()
        user = userService.returnUser(userName: userName)
    }

    func setUpTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: cellIDPosts)
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: cellIDPhotos)
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
         
        #if Debug
        view.backgroundColor = .systemPink
        #else
        view.backgroundColor = .systemGray5
        #endif
        
        
        let constraints = [
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}


extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIDPosts) as! PostTableViewCell
            cell.post = allPosts[indexPath.row]
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIDPhotos) as! PhotosTableViewCell
            cell.photo = Array(photos.prefix(4))
            cell.openPhotosViewController = {[weak self] in
                let vc = PhotosViewController()
                self?.navigationController?.pushViewController(vc, animated: true)
            }
            return cell
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return allPosts.count
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
}

extension ProfileViewController: UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let header = ProfileHeaderView()
            header.user = user
            return header
        } else {
            return nil
        }
    }
}







