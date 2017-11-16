//
//  EPAlertView.swift
//  Contacts Picker
//
//  Created by Hilla Barkal on 11/16/17.
//  Copyright © 2017 Prabaharan Elangovan. All rights reserved.
//

import UIKit

open class EPAlertView: UIView {
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
    self.addSubview(view)
    cancelButton.layer.borderColor = UIColor.white.cgColor
    cancelButton.layer.borderWidth = 2.0
    setupTargetIsNotEmptyTextFields()
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
}
