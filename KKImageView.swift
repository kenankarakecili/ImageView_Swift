//
//  KKImageView.swift
//
//  Created by Kenan Karakecili on 10/07/2016.
//  Copyright © 2016 Kenan Karakecili. All rights reserved.
//

import UIKit

class KKImageView: UIImageView {
  
  private static let shared = KKImageView()
  private var images: [[String: UIImage]] = []
  
  func downloadImage(urlString: String) {
    for item in KKImageView.shared.images {
      if item[urlString] != nil {
        image = item.values.first
        return
      }
    }
    image = UIImage(named: "")
    NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: urlString)!) { (data: NSData?, response: NSURLResponse?, error: NSError?) in
      guard let myData = data else { return }
      let anImage = UIImage(data: myData)
      guard let myImage = anImage else { return }
      dispatch_async(dispatch_get_main_queue(), {
        self.image = myImage
        KKImageView.shared.images.append([urlString: myImage])
      })
      }.resume()
  }
  
}
