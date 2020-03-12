//
//  CalculatorViewController.swift
//  Smart Calculator
//
//  Created by Søren Møller Gade Hansen on 25/01/2019.
//  Copyright © 2019 Søren Møller Gade Hansen. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CalculatorViewController: UIViewController {
    
    // MARK: Properties
    private let animationDuration: TimeInterval = 0.2
    let viewModel = CalculatorViewModel()
    let disposeBag = DisposeBag()
    var resultsViewControllerViewBottomConstraint: NSLayoutConstraint!
    var isResultsViewInBottom: Bool {
        get {
            return resultsViewControllerViewBottomConstraint.constant >= numpadView.frame.height - 10
        }
    }
    
    let resultsViewController: ResultsViewController = {
        let vc = ResultsViewController()
        vc.view.translatesAutoresizingMaskIntoConstraints = false
        return vc
    }()
    
    let numpadView: NumpadView = {
        let view = NumpadView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.background
        
        setupDelegates()
        setupViews()
        setupRx()
    }
    
    private func setupRx() {
    viewModel.rx_calculation.asDriver().drive(resultsViewController.collectionView.rx.items(cellIdentifier: resultsViewController.cellIdentifier, cellType: ResultCollectionViewCell.self)) { (index, result, cell) in
            cell.transform = CGAffineTransform.init(scaleX: 1, y: -1)
            cell.item = result
            if index == self.resultsViewController.collectionView.numberOfItems(inSection: 0) - 1 {
                guard let initialValue = self.viewModel.calculator.calculation.initialValue else { return }
                cell.label.text = "\(initialValue.clean)\(result._operator.rawValue)\(result.value.clean)"
            }
        
        }.disposed(by: disposeBag)
    }
    
    private func setupDelegates() {
        resultsViewController.delegate = self
        numpadView.delegate = self
        viewModel.delegate = self
    }

    private func setupViews() {
        setupNumpad()
        
        setupResultsView()
    }
    
    private func setupNumpad() {
        view.addSubview(numpadView)
        
        let buttonWidth = (((view.frame.size.width - 32) - 16 * 3) / 4)
        let viewHeight = buttonWidth * 5 + 16 * 4
        
        NSLayoutConstraint.activate([
            numpadView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            numpadView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            numpadView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            numpadView.heightAnchor.constraint(equalToConstant: viewHeight)
        ])
    }
    
    private func setupResultsView() {
        resultsViewControllerViewBottomConstraint = resultsViewController.view.bottomAnchor.constraint(equalTo: numpadView.topAnchor)
        
        self.add(child: resultsViewController)
        NSLayoutConstraint.activate([
            resultsViewControllerViewBottomConstraint,
            resultsViewController.view.leftAnchor.constraint(equalTo: view.leftAnchor),
            resultsViewController.view.rightAnchor.constraint(equalTo: view.rightAnchor),
            resultsViewController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])

        // Add gesture recognizer
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handleResultsViewPan(_:)))
        resultsViewController.view.addGestureRecognizer(panGestureRecognizer)
    }
    
    // MARK: Action handlers
    // TODO: Optimize and clean up
    @objc private func handleResultsViewPan(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self.view)
        guard let constraint = resultsViewControllerViewBottomConstraint else { return }

        if gesture.state == .ended {
            // Snap to nearest edge
            constraint.constant = constraint.constant > numpadView.frame.height / 2 ? numpadView.frame.height : 0
            constraint.constant = gesture.velocity(in: self.view).y > 200 ? numpadView.frame.height : 0
            
            resultsViewController.isScrollEnabled = isResultsViewInBottom
            resultsViewController.isReturnButtonHidden = !isResultsViewInBottom
            
            UIView.animate(withDuration: animationDuration) {
                self.view.layoutIfNeeded()
            }
            return
        } else if gesture.state == .began {
            if viewModel.rx_calculation.value.count != 0 {
                resultsViewController.scrollToBottom()
            }
        }

        let deltaY = translation.y + constraint.constant

        if constraint.constant <= 0 && deltaY < 0 {
            constraint.constant = 0
            return
        }
        constraint.constant = deltaY

        // Check if we have reached bottom of view
        constraint.constant = constraint.constant >= numpadView.frame.height ? numpadView.frame.height : constraint.constant

        
        resultsViewController.isScrollEnabled = isResultsViewInBottom
        resultsViewController.isReturnButtonHidden = !isResultsViewInBottom

        gesture.setTranslation(CGPoint(x: 0, y: 0), in: self.view)
    }
    
    fileprivate func generateResultsText() -> String {
        let calculator = viewModel.calculator
        
        if let oldValue = calculator.oldValue {
            var text = String(oldValue.clean)
            if let _operator = calculator.submittedOperator {
                text += _operator.rawValue
                text += calculator.newValue
            }
            return text
        }
        return calculator.newValue
    }
}


// MARK: Delegate methods
extension CalculatorViewController: CalculatorButtonDelegate {
    func didTapButton(sender: CalculatorButton) {
        viewModel.handleButtonTap(sender.type)
    }
}

extension CalculatorViewController: CalculatorViewModelDelegate {
    func valuesChanged() {
        resultsViewController.resultsLabel.text = generateResultsText()
    }
}

extension CalculatorViewController: ResultsViewDelegate {
    func returnResultsViewToDefaultPosition() {
        guard let constraint = resultsViewControllerViewBottomConstraint else { return }
        constraint.constant = 0
        resultsViewController.isReturnButtonHidden = !isResultsViewInBottom
        UIView.animate(withDuration: animationDuration) {
            self.view.layoutIfNeeded()
        }
    }
}
