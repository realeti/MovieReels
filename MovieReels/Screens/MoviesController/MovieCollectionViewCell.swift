//
//  MovieCollectionViewCell.swift
//  MovieReels
//
//  Created by Apple M1 on 12.11.2023.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    lazy var testView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .systemYellow
        
        return view
    }()
    
    func configure() {
        setupUI()
    }
    
    func setupUI() {
        self.backgroundColor = .systemGreen
        //self.layer.cornerRadius = self.frame.width / 2
        //addSubview(testView)
        
        /*testView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            testView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            testView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            testView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            testView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        ])*/
    }
}

extension MovieCollectionViewCell: CellReusable {
    static var cellId: String {
        return Constants.movieCellIndetifier
    }
}
