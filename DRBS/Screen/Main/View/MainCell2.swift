//
//  MainCell2.swift
//  DRBS
//
//  Created by 김성호 on 2023/07/21.
//

import UIKit
import Then
import SnapKit


class MainCell2: UICollectionViewCell {
    //    //MARK: - Properties
    let backgroundUIView = UIView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .white
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.darkGray.cgColor
        $0.layer.cornerRadius = 8
    }
    
    //MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    //    //MARK: - Helpers
    func configureUI() {
        self.addSubview(backgroundUIView)
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
            backgroundUIView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            backgroundUIView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            backgroundUIView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            backgroundUIView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
            
        ])
    }
    //
    // MARK: - Actions
    //
    //
    override var isSelected: Bool {
        didSet {
            backgroundColor = isSelected ? .systemGray3 : .white
        }
    }
}
