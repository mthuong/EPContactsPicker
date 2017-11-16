/*
 *
 * Copyright (c) 2015. Nexar Inc. - All Rights Reserved. Proprietary and confidential.
 *
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 *
 */
import Foundation

open class EPLocalizationUtil {
  
  open class func with(_ string: String) -> String {
    return NSLocalizedString(string, comment: "")
  }
  
  open static let preferredLanguage: String? = Bundle.main.preferredLocalizations[0]
  
  open class var country : String? {
    let region = Locale.current.identifier
    if let index = region.index(of: "_"),
      let nextIndex = region.index(index, offsetBy: 1, limitedBy: region.endIndex) {
      return region.substring(from: nextIndex)
    }
    if region == "" &&
      EPLocalizationUtil.preferredLanguage?.caseInsensitiveCompare("he") == .orderedSame {
      return "IL"
    }
    return (Locale.current as NSLocale).object(forKey: NSLocale.Key.countryCode) as? String
  }
  
  open class var characterDirection : NSLocale.LanguageDirection {
    if let language = preferredLanguage {
      return Locale.characterDirection(forLanguage: language)
    }
    return NSLocale.LanguageDirection.unknown
  }
  
  open class func embedAsRightToLeftIfNeeded(_ str: String) -> String {
    if characterDirection == .rightToLeft {
      return "\u{202B}\(str)\u{202C}"
    }
    return str
  }
}

