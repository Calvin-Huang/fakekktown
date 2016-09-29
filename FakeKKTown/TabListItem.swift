//
//  TabListItem.swift
//  CarouselPratice
//
//  Created by Calvin on 6/14/16.
//  Copyright © 2016 CapsLock. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

class TabListItem: UICollectionViewCell, CollectionCellProtocol {
    static var itemSize: CGSize { return CGSize(width: UIScreen.main.bounds.width / 3, height: 95) }
    static var reuseIdentifier: String { return "\(TabListItem.self)" }
    
    var disposeBag: DisposeBag?
    
    var name: String? {
        didSet {
            disposeBag = DisposeBag()
            self.nameLabel.text = name
        }
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func prepareForReuse() {
        disposeBag = nil
    }
}
