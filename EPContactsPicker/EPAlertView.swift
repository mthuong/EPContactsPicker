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
  fileprivate var framePortrait = CGRect(x: 0, y: 0, width: 300, height: 383)
  fileprivate var frameLandscape = CGRect(x: 0, y: 0, width: 375, height: 250)
  var contentView = UIView()
  var backgroundView = UIView()
  var nameField = UITextField()
  var numberField = UITextField()
  var inviteButton = UIButton()
  var cancelButton = UIButton()
  var titleView = UILabel()

  fileprivate func addTitle() {
    titleView.font = EPGlobalConstants.Fonts.titleFont
    titleView.text = EPLocalizationUtil.with("ADD CONTACT")
    titleView.textColor = EPGlobalConstants.Colors.nxYellow
    contentView.addSubview(titleView)
    titleView.translatesAutoresizingMaskIntoConstraints = false
    contentView.addConstraint(NSLayoutConstraint(item: titleView, attribute: .centerX, relatedBy: .equal,
                                          toItem: contentView, attribute: .centerX, multiplier: 1.0, constant: 1.0))
    contentView.addConstraint(NSLayoutConstraint(item: titleView, attribute: .top, relatedBy: .equal,
                                          toItem: contentView, attribute: .top, multiplier: 1.0, constant: 50.0))
  }
  
  fileprivate func addNameField() {
    nameField.autocapitalizationType = .words
    nameField.placeholder = EPLocalizationUtil.with("Name")
    nameField.backgroundColor = UIColor.white
    nameField.font = EPGlobalConstants.Fonts.feildFont
    contentView.addSubview(nameField)
    nameField.translatesAutoresizingMaskIntoConstraints = false
    self.addConstraint(NSLayoutConstraint(item: nameField, attribute: .centerX, relatedBy: .equal,
                                          toItem: contentView, attribute: .centerX, multiplier: 1.0, constant: 1.0))
    self.addConstraint(NSLayoutConstraint(item: nameField, attribute: .top, relatedBy: .equal,
                                          toItem: titleView, attribute: .bottom, multiplier: 1.0, constant: 30.0))
    self.addConstraint(NSLayoutConstraint(item: nameField, attribute: .width, relatedBy: .equal,
                                          toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 250.0))
    self.addConstraint(NSLayoutConstraint(item: nameField, attribute: .height, relatedBy: .equal,
                                          toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 30.0))
  }
  
  fileprivate func addNumberField() {
    numberField.keyboardType = .numberPad
    numberField.placeholder = EPLocalizationUtil.with("Number")
    numberField.backgroundColor = UIColor.white
    numberField.font = EPGlobalConstants.Fonts.feildFont
    contentView.addSubview(numberField)
    numberField.translatesAutoresizingMaskIntoConstraints = false
    self.addConstraint(NSLayoutConstraint(item: numberField, attribute: .centerX, relatedBy: .equal,
                                          toItem: contentView, attribute: .centerX, multiplier: 1.0, constant: 1.0))
    self.addConstraint(NSLayoutConstraint(item: numberField, attribute: .top, relatedBy: .equal,
                                          toItem: nameField, attribute: .bottom, multiplier: 1.0, constant: 10.0))
    self.addConstraint(NSLayoutConstraint(item: numberField, attribute: .width, relatedBy: .equal,
                                          toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 250.0))
    self.addConstraint(NSLayoutConstraint(item: numberField, attribute: .height, relatedBy: .equal,
                                          toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 30.0))
  }
  
  fileprivate func addButtons() {
    cancelButton.layer.borderColor = UIColor.white.cgColor
    cancelButton.layer.borderWidth = 2.0
    cancelButton.backgroundColor = UIColor.black
    cancelButton.titleLabel?.font = EPGlobalConstants.Fonts.buttonFont
    cancelButton.titleLabel?.textColor = UIColor.black
    cancelButton.setTitle(EPLocalizationUtil.with("CANCEL"), for: .normal)
    cancelButton.translatesAutoresizingMaskIntoConstraints = false
    
    inviteButton.setTitle(EPLocalizationUtil.with("INVITE"), for: .normal)
    inviteButton.backgroundColor = EPGlobalConstants.Colors.nxYellow
    inviteButton.titleLabel?.textColor = UIColor.black
    inviteButton.titleLabel?.font = EPGlobalConstants.Fonts.buttonFont
    inviteButton.translatesAutoresizingMaskIntoConstraints = false
    
    contentView.addSubview(cancelButton)
    contentView.addSubview(inviteButton)
    self.addConstraint(NSLayoutConstraint(item: cancelButton, attribute: .top, relatedBy: .equal,
                                          toItem: nameField, attribute: .bottom, multiplier: 1.0, constant: 70.0))
    self.addConstraint(NSLayoutConstraint(item: inviteButton, attribute: .top, relatedBy: .equal,
                                          toItem: nameField, attribute: .bottom, multiplier: 1.0, constant: 70.0))
    self.addConstraint(NSLayoutConstraint(item: inviteButton, attribute: .width, relatedBy: .equal,
                                          toItem: cancelButton, attribute: .width, multiplier: 1.0, constant: 1.0))
    self.addConstraint(NSLayoutConstraint(item: cancelButton, attribute: .right, relatedBy: .equal,
                                          toItem: inviteButton, attribute: .left, multiplier: 1.0, constant: -30.0))
    self.addConstraint(NSLayoutConstraint(item: cancelButton, attribute: .left, relatedBy: .equal,
                                          toItem: nameField, attribute: .left, multiplier: 1.0, constant: 1.0))
    self.addConstraint(NSLayoutConstraint(item: inviteButton, attribute: .right, relatedBy: .equal,
                                          toItem: nameField, attribute: .right, multiplier: 1.0, constant: 1.0))
    setupTargetIsNotEmptyTextFields()
  }
  
  required public override init(frame: CGRect) {
    super.init(frame: frame)
    
    var width = frame.size.width
    var height = frame.size.height
    if UIDevice.current.orientation.isLandscape {
      let temp = width
      width = height
      height = temp
    }
    
    frameLandscape = CGRect(x: 0, y: 0, width: height, height: width)
    framePortrait = CGRect(x: 0, y: 0, width: width, height: height)
    
//    backgroundView = UIView(frame: frame)
//    backgroundView.backgroundColor = UIColor(white: 0, alpha: 0.8)
    contentView.frame = frame
    contentView.backgroundColor = UIColor.clear
//    self.addSubviewAutoLayoutFill(backgroundView)
    self.addSubviewAutoLayout(contentView)
    
    addTitle()
    addNameField()
    addNumberField()
    addButtons()

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
    if UIDevice.current.orientation.isLandscape {
      self.frame = frameLandscape
//      self.contentView.frame = frameLandscape
//      self.backgroundView.frame = frameLandscape
    } else {
      self.frame = framePortrait
//      self.contentView.frame = framePortrait
//      self.backgroundView.frame = framePortrait
    }
  }
}
