//
//  PopFlow.swift
//  RxFlow
//
//  Created by Alexander Stonehouse on 29/10/18.
//

import Foundation
import RxSwift

/// A flow that takes an initial VC and listens to its pop event to end the flow.
/// Useful for cases where multiple flows are presented within the same navigation
/// controller.
open class PopFlow: Flow {
    
    // MARK: - Properties
    
    /// The root. Override for custom root.
    public var root: Presentable {
        return initial
    }
    
    /// The initial view controller of the flow that we listen to pop events for,
    /// and is the root by default.
    let initial: UIViewController
    
    /// A stepper that can accept a `PoppedStep`.
    private let popStepper: PopStepper
    
    // MARK: - Lifecycle
    
    public init(initial: UIViewController, stepper: PopStepper) {
        self.initial = initial
        self.popStepper = stepper
        
        initial.rx.popped.subscribe(onNext: { [weak self] _ in
            self?.popStepper.popped()
        }).disposed(by: disposeBag)
    }
    
    // MARK: - Flow
    
    open func navigate(to step: Step) -> NextFlowItems {
        if step is PoppedStep {
            return .end(withStepForParentFlow: NoneStep())
        }
        
        return .none
    }
}

public struct PoppedStep: Step {
}

public protocol PopStepper: Stepper {
    func popped()
}

public extension PopStepper {
    public func popped() {
        self.step.accept(PoppedStep())
    }
}
