//
//  NumpadView.swift
//  Smart Calculator
//
//  Created by Søren Møller Gade Hansen on 07/02/2019.
//  Copyright © 2019 Søren Møller Gade Hansen. All rights reserved.
//

import UIKit

class NumpadView: UIView {
    
    let buttonStack: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.distribution = .fillEqually
        return view
    }()
    
    var currentlySelectedOperator: CalculatorButton? = nil
    
    // MARK: Properties
    // 2 dimensional array to layout buttons
    let newButtons = [
        [CalculatorType(method: Method.clear), CalculatorType(method: Method.invert), CalculatorType(method: Method.percent), CalculatorType(operation: Operator.divide)],
        [CalculatorType(number: Number.seven), CalculatorType(number: Number.eight), CalculatorType(number: Number.nine), CalculatorType(operation: Operator.multiply)],
        [CalculatorType(number: Number.four), CalculatorType(number: Number.five), CalculatorType(number: Number.six), CalculatorType(operation: Operator.subtraction)],
        [CalculatorType(number: Number.one), CalculatorType(number: Number.two), CalculatorType(number: Number.three), CalculatorType(operation: Operator.addition)],
        [CalculatorType(number: Number.zero), CalculatorType(number: Number.comma), CalculatorType(isEquals: true)]
    ]
    var delegate: CalculatorButtonDelegate?
    
    // MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupViews()
    }
    
    private func setupViews() {
        self.addSubview(buttonStack)
        buttonStack.fillSuperview()
        
        for array in newButtons {
            let horizontalStack = UIStackView()
            horizontalStack.axis = .horizontal
            horizontalStack.distribution = .fill
            for buttonItem in array {
                let button = setupButton(for: buttonItem)
                horizontalStack.addArrangedSubview(button)
                horizontalStack.setCustomSpacing(16, after: button)
            }
            buttonStack.addArrangedSubview(horizontalStack)
            buttonStack.setCustomSpacing(16, after: horizontalStack)
        }
    }
    
    private func setupButton(for type: CalculatorType) -> CalculatorButton {
        let button = CalculatorButton()
        button.type = type
        button.layer.cornerRadius = ((self.frame.height - (16 * 4)) / 5) / 2
        var widthAnchor = button.widthAnchor.constraint(equalToConstant: (self.frame.size.width - 3 * 16) / CGFloat(newButtons[0].count))
        
        var title: String!
        if let operation = type.operation {
            button.backgroundColor = UIColor.operatorButtonColor
            button.setTitleColor(UIColor.operatorButtonTextColor, for: .normal)
            switch operation {
            case .divide:
                title = "/"
            case .multiply:
                title = "\u{00D7}"
            case .subtraction:
                title = "-"
            case .addition:
                title = "+"
            }
        }
        
        if let method = type.method {
            button.backgroundColor = UIColor.methodButtonColor
            button.setTitleColor(UIColor.methodButtonTextColor, for: .normal)
            switch method {
            case .percent:
                title = "%"
            case .clear:
                title = "C"
            case .invert:
                title = "\u{00B1}"
            }
        }
        
        if let number = type.number {
            button.backgroundColor = UIColor.numberButtonColor
            button.setTitleColor(UIColor.numberButtonTextColor, for: .normal)
            switch number {
            case .zero:
                title = "0"
                print(self.frame.size.width)
                widthAnchor = button.widthAnchor.constraint(equalToConstant: widthAnchor.constant * 2 + 16)
                button.layer.zPosition = 1
            case .one:
                title = "1"
            case .two:
                title = "2"
            case .three:
                title = "3"
            case .four:
                title = "4"
            case .five:
                title = "5"
            case .six:
                title = "6"
            case .seven:
                title = "7"
            case .eight:
                title = "8"
            case .nine:
                title = "9"
            case .comma:
                title = ","
            }
        }
        
        if type.isEquals {
            title = "="
            button.backgroundColor = UIColor.equalsButtonColor
            button.setTitleColor(UIColor.equalsButtonTextColor, for: .normal)
        }
        
        // Setup button
        button.setTitle(title, for: .normal)
        button.addTarget(self, action: #selector(handleButtonTapped(_:)), for: .touchUpInside)
        widthAnchor.isActive = true
        return button
    }
    
    // MARK: Action handlers
    @objc private func handleButtonTapped(_ sender: CalculatorButton) {
        if let _ = sender.type.operation {
            toggleButton(sender)
        } else {
            if currentlySelectedOperator != nil {
                toggleButton(nil)
            }
            animateButton(sender)
        }
        delegate?.didTapButton(sender: sender)
    }
    
    private func toggleButton(_ button: CalculatorButton?) {
        // Deselect button
        if let button = currentlySelectedOperator {
            button.isSelected = !button.isSelected
            animateToggleButton(button)
        }
        currentlySelectedOperator = button
        guard let operatorButton = button else { return }
        operatorButton.isSelected = !operatorButton.isSelected
        animateToggleButton(operatorButton)
    }
        
    private func animateButton(_ button: UIButton) {
        let buttonColor = button.backgroundColor
        UIView.animate(withDuration: 0.5, delay: 0, options: .allowUserInteraction, animations: {
            button.backgroundColor = UIColor.buttonTintColor
            button.backgroundColor = buttonColor
        })
    }
    
    private func animateToggleButton(_ button: UIButton) {
        UIView.animate(withDuration: 0.5, delay: 0, options: .allowUserInteraction, animations: {
            button.backgroundColor = button.isSelected ? UIColor.buttonTintColor : UIColor.operatorButtonColor
        })
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension NumpadView: CalculatorDelegate {
    func operatorDidChange(_ _operator: Operator?) {
//        if _operator == nil {
//            toggleButton(nil)
//        }
    }
    
    func calculationDidChange() {}
}
