//
//  PassThroughView.swift
//  ExKeyboard
//
//  Created by Jake.K on 2021/12/27.
//

import Foundation
import UIKit

// https://ios-development.tistory.com/327
class PassThroughView: UIView {
  override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
    let hitView = super.hitTest(point, with: event)
    return hitView == self ? nil : hitView
  }
}
