//
//  EPAlertView.swift
//  Contacts Picker
//
//  Created by Hilla Barkal on 11/16/17.
//  Copyright © 2017 Prabaharan Elangovan. All rights reserved.
//

import UIKit
import Foundation

open class EPAlertView: UIView {
  fileprivate let FramePortrait = CGRect(x: 0, y: 0, width: 320, height: 500)
  fileprivate let FrameLandscape = CGRect(x: 0, y: 0, width: 400, height: 300)
  internal var view = UIView()
  @IBOutlet weak var nameField: UITextField!
  @IBOutlet weak var numberField: UITextField!
  @IBOutlet weak var inviteButton: UIButton!
  @IBOutlet weak var cancelButton: UIButton!

  required public override init(frame: CGRect) {
    super.init(frame: frame)
    view = Bundle.main
      .loadNibNamed("EPAlertView", owner: self, options: nil)!.first as! UIView
    view.frame = frame
    self.addSubviewAutoLayoutFill(view)
    cancelButton.layer.borderColor = UIColor.white.cgColor
    cancelButton.layer.borderWidth = 2.0
    setupTargetIsNotEmptyTextFields()
    
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(EPAlertView.onOrientationChanged),
                                           name: NSNotification.Name.UIDeviceOrientationDidChange,
                                           object: nil)
  }
  
  required public init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setupTargetIsNotEmptyTextFields() {
    inviteButton.isEnabled = false
    nameField.addTarget(self, action: #selector(EPAlertView.textFieldsIsNotEmpty), for: .editingChanged)
    numberField.addTarget(self, action: #selector(EPAlertView.textFieldsIsNotEmpty), for: .editingChanged)
  }
  
  func textFieldsIsNotEmpty() {
    guard let name = nameField.text,
      let number = numberField.text else {
        self.inviteButton.isEnabled = false
        return
    }
    // enable invite button if all conditions are met
    inviteButton.isEnabled = !name.isEmpty && !number.isEmpty
  }
  
  func onOrientationChanged() {
    self.updateConstraints()
    self.layoutSubviews()
//    let height = self.frame.size.height
//    let width = self.frame.size.width
//      self.view.bounds = self.bounds
//    if UIDevice.current.orientation.isLandscape {
//      
//      self.bounds = CGRect(x: 0, y: 0, width: height, height: width)
//    } else {
//      self.bounds = CGRect(x: 0, y: 0, width: height, height: width)
//    }
  }
}
