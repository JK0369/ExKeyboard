//
//  ViewController.swift
//  ExKeyboard
//
//  Created by Jake.K on 2021/12/27.
//

import UIKit
import SnapKit

class ViewController: BaseViewController {
  
  private let sampleTextField: UITextField = {
    let textField = UITextField()
    textField.textColor = .black
    textField.borderStyle = .roundedRect
    return textField
  }()
  
  private let myImageView: UIImageView = {
    let view = UIImageView()
    view.image = UIImage(systemName: "star.fill")
    return view
  }()
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesEnded(touches, with: event)
    self.view.endEditing(true)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.addSubview(self.sampleTextField)
    self.keyboardSafeAreaView.addSubview(myImageView)
    
    self.sampleTextField.snp.makeConstraints {
      $0.top.equalToSuperview().inset(56)
      $0.left.right.equalToSuperview().inset(16)
    }
    self.myImageView.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.bottom.equalToSuperview().inset(150)
    }
  }
}
