//
//  CustomInputTextView.swift
//  AeonTask
//
//  Created by Kirill Anisimov on 22.02.2021.
//

import Foundation
import UIKit

class CustomInputTextView: UIView {
    
    let labelFont = UIFont.systemFont(ofSize: 14)
    let textFieldFont = UIFont.systemFont(ofSize: 18)
    let mainColor = UIColor.gray
    let errorColor = UIColor.red
    let inset: CGFloat = 10
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.font = textFieldFont
        textField.textColor = .darkGray
        textField.backgroundColor = .clear
        textField.autocapitalizationType = .none
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    } ()
    
    lazy var layerView: UIView = {
        let layerView = UIView()
        layerView.backgroundColor = .clear
        layerView.layer.borderWidth = 1
        layerView.layer.borderColor = UIColor.gray.cgColor
        layerView.translatesAutoresizingMaskIntoConstraints = false
        return layerView
    } ()
    
    lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.font = labelFont
        label.backgroundColor = .white
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        label.textAlignment = .center
        label.textColor = mainColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    lazy var footerLabel: UILabel = {
        let label = UILabel()
        label.font = labelFont
        label.backgroundColor = .clear
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.textColor = errorColor
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView() {
        backgroundColor = .clear
        
        addSubview(layerView)
        addSubview(headerLabel)
        addSubview(footerLabel)
        addSubview(textField)
    }
    
    private func setupLayout() {
        
        guard let headerText = headerLabel.text else { return }
        let headerLabelHeight = getTextViewSize(text: "", font: labelFont).height
        let headerLabelWidth = getTextViewSize(text: headerText, font: labelFont).width + inset*2
        let footerLabelHeight = headerLabelHeight * 2
        
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: layerView.leadingAnchor, constant: inset/2),
            textField.trailingAnchor.constraint(equalTo: layerView.trailingAnchor, constant: -inset/2),
            textField.bottomAnchor.constraint(equalTo: footerLabel.topAnchor, constant: -inset/2),
            
            headerLabel.topAnchor.constraint(equalTo: topAnchor),
            headerLabel.bottomAnchor.constraint(equalTo: textField.topAnchor),
            headerLabel.leadingAnchor.constraint(equalTo: textField.leadingAnchor, constant: inset*2),
            headerLabel.heightAnchor.constraint(equalToConstant: headerLabelHeight),
            headerLabel.widthAnchor.constraint(equalToConstant: headerLabelWidth),

            layerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            layerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            layerView.topAnchor.constraint(equalTo: headerLabel.centerYAnchor),
            layerView.bottomAnchor.constraint(equalTo: textField.bottomAnchor),
            
            footerLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            footerLabel.leadingAnchor.constraint(equalTo: textField.leadingAnchor, constant: inset/2),
            footerLabel.trailingAnchor.constraint(equalTo: textField.trailingAnchor, constant: -inset/2),
            footerLabel.heightAnchor.constraint(equalToConstant: footerLabelHeight)
        ])
    }
    
    override class var requiresConstraintBasedLayout: Bool {
        return true
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 300, height: 80)
    }
   
    func setup(headerText: String? = "", footerText: String? = "") {
        guard let footerText = footerText else { return }
        if footerText.isEmpty {
            headerLabel.textColor = mainColor
        } else {
            headerLabel.textColor = errorColor
        }
        headerLabel.text = headerText
        footerLabel.text = footerText

        setupLayout()
    }
    
    private func getTextViewSize(text: String, font: UIFont, width: CGFloat? = CGFloat.greatestFiniteMagnitude) -> CGSize {
        let textBlock = CGSize(width: width!, height: CGFloat.greatestFiniteMagnitude)
            let rect = text.boundingRect(with: textBlock, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
            let size = CGSize(width: ceil(rect.size.width), height: ceil(rect.size.height))
            return size
        }

}
