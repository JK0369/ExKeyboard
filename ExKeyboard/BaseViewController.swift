//
//  BaseViewController.swift
//  ExKeyboard
//
//  Created by Jake.K on 2021/12/27.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import RxKeyboard

class BaseViewController: UIViewController {
  // MARK: UI
  private let keyboardWrapperView: PassThroughView = {
    let view = PassThroughView()
    view.isUserInteractionEnabled = false
    return view
  }()
  let keyboardSafeAreaView: PassThroughView = {
    let view = PassThroughView()
    return view
  }()
  
  // MARK: Properties
  private let disposeBag = DisposeBag()
  private let keyboardHeight = BehaviorRelay<CGFloat>(value: 0)
  
  // MARK: View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.addSubview(self.keyboardWrapperView)
    self.view.addSubview(self.keyboardSafeAreaView)
    
    RxKeyboard.instance.visibleHeight
      .asObservable()
      .filter { 0 <= $0 }
      .bind { [weak self] in self?.keyboardHeight.accept($0) }
      .disposed(by: disposeBag)
    
    self.keyboardWrapperView.snp.makeConstraints {
      $0.left.right.bottom.equalToSuperview()
      $0.height.equalTo(0).priority(.high)
    }
    
    self.keyboardSafeAreaView.snp.makeConstraints {
      $0.top.left.right.equalToSuperview()
      $0.bottom.equalTo(self.keyboardWrapperView.snp.top)
    }
    
    self.keyboardHeight
      .withUnretained(self)
      .bind(onNext: { ss, height in
        ss.updateKeyboardHeight(height)
        UIView.transition(
          with: ss.keyboardWrapperView,
          duration: 0.25,
          options: .init(rawValue: 458752),
          animations: ss.view.layoutIfNeeded
        )
      })
      .disposed(by: disposeBag)
  }
  
  private func updateKeyboardHeight(_ height: CGFloat) {
    self.keyboardWrapperView.snp.updateConstraints {
      $0.height.equalTo(self.keyboardHeight.value).priority(.high)
    }
  }
}
