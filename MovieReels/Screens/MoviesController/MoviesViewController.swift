//
//  ViewController.swift
//  MovieReels
//
//  Created by Apple M1 on 12.11.2023.
//

import UIKit

class MoviesViewController: UIViewController {
    
    let viewModel = MovieViewModel()
    
    let imagePerRow: CGFloat = 3
    let leftSectionInset: CGFloat = 10.0
    let rightSectionInset: CGFloat = 10.0
    let minimumInteritemSpacing: CGFloat = 20.0
    let minimumLineSpacing: CGFloat = 20.0
    
    lazy var collectionView: UICollectionView = {
        //let layout = UICollectionViewFlowLayout()
        //layout.scrollDirection = .vertical
        let layout = ProminentCellLayout()
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: Constants.movieCellIndetifier)
        collectionView.register(HeaderAndFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderAndFooterView.identifier)
        collectionView.register(HeaderAndFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: HeaderAndFooterView.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.loadNetworkData()
    }
    
    func setupUI() {
        view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
}

extension MoviesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let movieCell: MovieCollectionViewCell = collectionView.dequeCell(for: indexPath)
        movieCell.configure()
        
        return movieCell
    }
}

extension MoviesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        //
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        //
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("select \(indexPath.row)")
    }
}

extension MoviesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (collectionView.bounds.width / imagePerRow) - (leftSectionInset + rightSectionInset)
        let height = width
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return minimumLineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return minimumInteritemSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderAndFooterView.identifier, for: indexPath) as! HeaderAndFooterView
            headerView.backgroundColor = .black
            headerView.label.text = "My super header view!"
            return headerView
        case UICollectionView.elementKindSectionFooter:
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderAndFooterView.identifier, for: indexPath) as! HeaderAndFooterView
            footerView.backgroundColor = .black
            footerView.label.text = "My super footer view!"
            return footerView
        default:
            fatalError()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 42)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 42)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: leftSectionInset, bottom: 20, right: rightSectionInset)
    }
}

extension UICollectionView {
    func dequeCell<CellType: CellReusable>(for indexPath: IndexPath) -> CellType {
        return self.dequeueReusableCell(withReuseIdentifier: CellType.cellId, for: indexPath) as! CellType
    }
}

class ProminentCellLayout: UICollectionViewFlowLayout {
    var isSetup = false
    
    let _sectionInset: CGFloat = 0.0
    let _minimumInteritemSpacing: CGFloat = 0.0
    let _minimumLineSpacing: CGFloat = 10.0
    
    override func prepare() {
        super.prepare()
        
        if isSetup == false {
            setupCollectionView()
            isSetup = true
        }
    }
    
    private func setupCollectionView() {
        self.itemSize = CGSize(width: 200, height: 200)
        self.minimumLineSpacing = _minimumLineSpacing
        self.minimumInteritemSpacing = _minimumInteritemSpacing
        self.sectionInset = UIEdgeInsets(top: _sectionInset, left: _sectionInset, bottom: _sectionInset, right: _sectionInset)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)
        var attributesCopy = [UICollectionViewLayoutAttributes]()
        
        for itemAttributes in attributes! {
            let itemAttributesCopy = itemAttributes.copy() as! UICollectionViewLayoutAttributes
            itemAttributesCopy.alpha = self.isInCenter(attribute: itemAttributesCopy) ? 0.5 : 1
            attributesCopy.append(itemAttributesCopy)
        }
        return attributesCopy
    }
    
    func isInCenter(attribute: UICollectionViewLayoutAttributes) -> Bool {
        if attribute.indexPath.row == 1 {
            return true
        } else {
            return false
        }
    }
}
