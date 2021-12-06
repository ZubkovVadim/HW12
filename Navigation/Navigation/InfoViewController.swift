//
//  InfoViewController.swift
//  Navigation
//
//  Created by Artem Novichkov on 12.09.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit
import SnapKit
import StorageService

class InfoViewController: UIViewController {
    private let networkManager = JSONNetworkManager()
    
    lazy var placeholdersLabel = UILabel()
    lazy var planetLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        executePlaceholders()
        executePlanet()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(placeholdersLabel)
        placeholdersLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview().offset(-50)
            $0.centerX.equalToSuperview()
        }
        
        view.addSubview(planetLabel)
        planetLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview().offset(50)
            $0.centerX.equalToSuperview()
        }
    }
    
    private func executePlaceholders() {
        networkManager.getPlaceholders { [weak self] arrayModels in
            self?.placeholdersLabel.text = arrayModels.first?.title
        }
    }
    
    private func executePlanet() {
        PlanetNetworkManager.executeRequest(configuration: .planets) { [weak self] planet in
            self?.planetLabel.text = planet.orbitalPeriod
        }
    }
}

