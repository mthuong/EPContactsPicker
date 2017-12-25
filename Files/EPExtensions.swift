//
//  EPExtensions.swift
//  EPContactPicker
//
//  Created by Prabaharan Elangovan on 14/10/15.
//  Copyright © 2015 Prabaharan Elangovan. All rights reserved.
//

import UIKit
import Foundation

extension String {
  subscript(r: Range<Int>) -> String? {
    get {
      let stringCount = self.characters.count as Int
      if (stringCount < r.upperBound) || (stringCount < r.lowerBound) {
        return nil
      }
      let startIndex = self.characters.index(self.startIndex, offsetBy: r.lowerBound)
      let endIndex = self.characters.index(self.startIndex, offsetBy: r.upperBound - r.lowerBound)
      return self[(startIndex ..< endIndex)]
    }
  }
  
  func containsAlphabets() -> Bool {
    //Checks if all the characters inside the string are alphabets
    let set = CharacterSet.letters
    return self.utf16.contains( where: {
      guard let unicode = UnicodeScalar($0) else { return false }
      return set.contains(unicode)
    })
  }
}

extension UIAlertController {
  func updateFont(view:UIView, font:UIFont) {
    for item in view.subviews {
      if item.isKind(of: UICollectionView.self) {
        let col = item as! UICollectionView
        for  row in col.subviews{
          updateFont(view: row, font: font)
        }
      }
      if item.isKind(of: UILabel.self) {
        let label = item as! UILabel
        label.font = font
      } else {
        updateFont(view: item, font: font)
      }
      
    }
  }
  open override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    let font = UIFont(name: "HelveticaNeue-Medium", size: 17.0)
    updateFont(view: self.view, font: font! )
  }
}

public extension UIView {
  public func addSubviewAutoLayoutFill(_ view: UIView) {
    self.addSubview(view)
    self.addConstraint(NSLayoutConstraint(item: view, attribute: .left, relatedBy: .equal,
                                          toItem: self, attribute: .left, multiplier: 1.0, constant: 0.0))
    self.addConstraint(NSLayoutConstraint(item: view, attribute: .right, relatedBy: .equal,
                                          toItem: self, attribute: .right, multiplier: 1.0, constant: 0.0))
    self.addConstraint(NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal,
                                          toItem: self, attribute: .top, multiplier: 1.0, constant: 0.0))
    self.addConstraint(NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal,
                                          toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0.0))
  }
}

extension UITextField {
  func setLeftPaddingPoints(_ amount: CGFloat) {
    let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
    self.leftView = paddingView
    self.leftViewMode = .always
  }
  func setRightPaddingPoints(_ amount: CGFloat) {
    let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
    self.rightView = paddingView
    self.rightViewMode = .always
  }
}
