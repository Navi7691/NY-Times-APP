//
//  Observeable.swift
//  NyTimesApp
//
//  Created by Naveed Tahir on 16/11/2024.
//

import Foundation

class Observable<T> {
  private let thread : DispatchQueue
    
  var property : T? {
    willSet(newValue) {
      if let newValue = newValue/*,  property != newValue*/ {
          thread.async {
            self.observe?(newValue)
          }
      }
   }
  }
    
 var observe : ((T) -> ())?
    
 init(_ value: T? = nil, thread dispatcherThread: DispatchQueue = DispatchQueue.main) {
    self.thread = dispatcherThread
    self.property = value
 }
}
