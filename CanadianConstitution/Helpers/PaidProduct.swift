//
//  PaidProduct.swift
//  Canadian Constitution
//
//  Created by Mohamed Metwaly on 2019-12-15.
//
// https://www.raywenderlich.com/5456-in-app-purchase-tutorial-getting-started

import Foundation

public struct PaidProduct {
  
  public static let premium = "premium"
  
  private static let productIdentifiers: Set<ProductIdentifier> = [PaidProduct.premium]

  public static let store = IAPHelper(productIds: PaidProduct.productIdentifiers)
}

func resourceNameForProductIdentifier(_ productIdentifier: String) -> String? {
  return productIdentifier.components(separatedBy: ".").last
}
