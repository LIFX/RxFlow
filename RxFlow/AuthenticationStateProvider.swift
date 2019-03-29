//
//  AuthenticationStateProvider.swift
//  RxFlow
//
//  Created by Megan Efron on 29/3/19.
//

public protocol AuthenticationStateProvider {
    var isAuthenticated: Bool { get }
}

public struct OptimisticAuthProvider: AuthenticationStateProvider {
    public let isAuthenticated: Bool = true
    
    public init() { }
}
