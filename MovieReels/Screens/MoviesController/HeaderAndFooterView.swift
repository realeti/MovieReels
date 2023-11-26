//
//  HeaderAndFooterView.swift
//  MovieReels
//
//  Created by Apple M1 on 16.11.2023.
//

import UIKit

class HeaderAndFooterView: UICollectionReusableView {
    static let identifier = "HeaderAndFooterView"
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        setupInterface()
        setupConstraints()
    }
    
    private func setupInterface() {
        addSubview(label)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}
