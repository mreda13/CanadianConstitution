//
//  IAPHelper.swift
//  Canadian Constitution
//
//  Created by Mohamed Metwaly on 2019-12-15.
//
// https://www.raywenderlich.com/5456-in-app-purchase-tutorial-getting-started

import StoreKit

public typealias ProductIdentifier = String
public typealias ProductsRequestCompletionHandler = (_ success: Bool, _ products: [SKProduct]?) -> Void


open class IAPHelper: NSObject  {
  
  private let productIdentifiers: Set<ProductIdentifier>
  private var purchasedProductIdentifiers: Set<ProductIdentifier> = []
  private var productsRequest: SKProductsRequest?
  private var productsRequestCompletionHandler: ProductsRequestCompletionHandler?
    
  var onBuyProductHandler: ((Result<Bool, Error>) -> Void)?
  var totalRestoredPurchases = 0

  
  public init(productIds: Set<ProductIdentifier>) {
    productIdentifiers = productIds
    for productIdentifier in productIds {
      let purchased = UserDefaults.standard.bool(forKey: productIdentifier)
      if purchased {
        purchasedProductIdentifiers.insert(productIdentifier)
        //print("Previously purchased: \(productIdentifier)")
      } else {
        //print("Not purchased: \(productIdentifier)")
      }
    }
    super.init()

    SKPaymentQueue.default().add(self)
  }
}

// MARK: - StoreKit API

extension IAPHelper {
  
  public func requestProducts(_ completionHandler: @escaping ProductsRequestCompletionHandler) {
    productsRequest?.cancel()
    productsRequestCompletionHandler = completionHandler

    productsRequest = SKProductsRequest(productIdentifiers: productIdentifiers)
    productsRequest!.delegate = self
    productsRequest!.start()
  }

    public func buyProduct(_ product: SKProduct, _ completionHandler:@escaping ((_ result:Result<Bool,Error>)->Void)) {
    //print("Buying \(product.productIdentifier)")
    onBuyProductHandler = completionHandler
    let payment = SKPayment(product: product)
    SKPaymentQueue.default().add(payment)
  }

  public func isProductPurchased(_ productIdentifier: ProductIdentifier) -> Bool {
    return purchasedProductIdentifiers.contains(productIdentifier)
  }
  
  public class func canMakePayments() -> Bool {
    return SKPaymentQueue.canMakePayments()
  }
  
    public func restorePurchases(_ completionHandler: @escaping ((_ result:Result<Bool,Error>)->Void)) {
        onBuyProductHandler = completionHandler
    SKPaymentQueue.default().restoreCompletedTransactions()
  }
}

// MARK: - SKProductsRequestDelegate

extension IAPHelper: SKProductsRequestDelegate {

  public func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
    //print("Loaded list of products...")
    let products = response.products
    productsRequestCompletionHandler?(true, products)
    clearRequestAndHandler()

    /*for p in products {
      print("Found product: \(p.productIdentifier) \(p.localizedTitle) \(p.price.floatValue)")
    }*/
  }

  public func request(_ request: SKRequest, didFailWithError error: Error) {
    //print("Failed to load list of products.")
    //print("Error: \(error.localizedDescription)")
    productsRequestCompletionHandler?(false, nil)
    clearRequestAndHandler()
  }

  private func clearRequestAndHandler() {
    productsRequest = nil
    productsRequestCompletionHandler = nil
  }
}

// MARK: - SKPaymentTransactionObserver

extension IAPHelper: SKPaymentTransactionObserver {

  public func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
    for transaction in transactions {
       // SKPaymentQueue.default().finishTransaction(transaction)
      switch (transaction.transactionState) {
      case .purchased:
        complete(transaction: transaction)
        break
      case .failed:
        fail(transaction: transaction)
        break
      case .restored:
        restore(transaction: transaction)
        break
      case .deferred:
        break
      case .purchasing:
        break
      @unknown default:
        break
        }
    }
  }
    
    public func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
        if totalRestoredPurchases != 0{
            onBuyProductHandler?(.success(true))
        }
        else {
            onBuyProductHandler?(.success(false))
        }
    }
    
  private func complete(transaction: SKPaymentTransaction) {
    
    print("Purchase complete.")
    guard let productIdentifier = transaction.original?.payment.productIdentifier else { return }

    UserDefaults.standard.set(true, forKey: productIdentifier)
    purchasedProductIdentifiers.insert(productIdentifier)
    onBuyProductHandler?(.success(true))
    SKPaymentQueue.default().finishTransaction(transaction)
  }

  private func restore(transaction: SKPaymentTransaction) {
    guard let productIdentifier = transaction.original?.payment.productIdentifier else { return }
    
    print("Restoring \(productIdentifier)")
    UserDefaults.standard.set(true, forKey: productIdentifier)
    purchasedProductIdentifiers.insert(productIdentifier)
    totalRestoredPurchases+=1
    SKPaymentQueue.default().finishTransaction(transaction)
  }

  private func fail(transaction: SKPaymentTransaction) {
    //print("Purchase failed")
    if let transactionError = transaction.error as NSError?,
      let localizedDescription = transaction.error?.localizedDescription,
        transactionError.code != SKError.paymentCancelled.rawValue {
        print("Transaction Error: \(localizedDescription)")
        onBuyProductHandler?(.failure(transactionError))
      }

    SKPaymentQueue.default().finishTransaction(transaction)
  }
}
