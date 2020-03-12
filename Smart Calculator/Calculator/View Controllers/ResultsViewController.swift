//
//  ResultsViewController.swift
//  Smart Calculator
//
//  Created by Søren Møller Gade Hansen on 07/02/2019.
//  Copyright © 2019 Søren Møller Gade Hansen. All rights reserved.
//

import UIKit
import RxSwift

final class ResultsViewController: UIViewController {
    
    // MARK: Properties

    let cellIdentifier = "cellId"
    private let disposeBag = DisposeBag()
    public var delegate: ResultsViewDelegate?
    public var isScrollEnabled: Bool! {
        didSet {
            collectionView.isScrollEnabled = isScrollEnabled
        }
    }
    public var isReturnButtonHidden: Bool! {
        didSet {
            returnButton.isHidden = isReturnButtonHidden
        }
    }

    let collectionView: ResultCollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = ResultCollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    let resultsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.textColor = UIColor.resultTextColor
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.text = "0"
        return label
    }()
    
    private let resultsLabelContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let expandImage: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "Arrow_down"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let returnButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.returnButtonColor
        button.isHidden = true
        return button
    }()
    
    // MARK: Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    override func viewWillLayoutSubviews() {
        returnButton.layer.cornerRadius = returnButton.frame.height / 2
    }
    
    private func setupViews() {
        view.backgroundColor = UIColor.background
        
        setupExpandImage()
        setupResultsView()
        setupCollectionView()
    }
    
    fileprivate func setupExpandImage() {
        view.addSubview(expandImage)
        NSLayoutConstraint.activate([
            expandImage.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -4),
            expandImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            expandImage.widthAnchor.constraint(equalToConstant: 41),
            expandImage.heightAnchor.constraint(equalToConstant: 16)
        ])
    }
    
    fileprivate func setupResultsView() {
        view.addSubview(resultsLabelContainer)
        NSLayoutConstraint.activate([
            resultsLabelContainer.leftAnchor.constraint(equalTo: view.leftAnchor),
            resultsLabelContainer.rightAnchor.constraint(equalTo: view.rightAnchor),
            resultsLabelContainer.bottomAnchor.constraint(equalTo: expandImage.topAnchor, constant: -4),
            resultsLabelContainer.heightAnchor.constraint(equalToConstant: 50)
        ])
        resultsLabelContainer.addSubview(resultsLabel)
        resultsLabel.fillSuperview(inset: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
    }
    
//    private func setupReturnButton() {
//        view.addSubview(returnButton)
//        returnButton.addTarget(self, action: #selector(handleReturnButtonPressed), for: .touchUpInside)
//        NSLayoutConstraint.activate([
//            returnButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
//            returnButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16),
//            returnButton.heightAnchor.constraint(equalToConstant: 32),
//            returnButton.widthAnchor.constraint(equalToConstant: 32)
//            ])
//    }
    
    private func setupCollectionView() {
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.bottomAnchor.constraint(equalTo: resultsLabel.topAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor)
        ])
        
        collectionView.isScrollEnabled = false
        
        collectionView.register(ResultCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    
    public func scrollToBottom() {
        collectionView.scrollToBottom(animated: true)
    }
    
    // MARK: Action handlers
    @objc private func handleReturnButtonPressed() {
        delegate?.returnResultsViewToDefaultPosition()
    }
}

// MARK: Collection View Flow Layout
extension ResultsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 50)
    }
}
