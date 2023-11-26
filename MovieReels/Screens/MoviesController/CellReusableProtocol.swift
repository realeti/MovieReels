//
//  CellReusableProtocol.swift
//  MovieReels
//
//  Created by Apple M1 on 12.11.2023.
//

import UIKit

protocol CellReusable: UICollectionViewCell {
    static var cellId: String { get }
}
