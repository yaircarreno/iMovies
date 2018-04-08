//
//  Coordinator.swift
//  iMovies
//
//  Created by Yair Ivan Carreño Lizarazo on 4/1/18.
//  Copyright © 2018 qualityfull. All rights reserved.
//

import Foundation
import RxSwift


class Coordinator<ResultType> {
    
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    typealias CoordinationResult = ResultType
    private let identifier = UUID()
    
    private var childCoordinators = [UUID: Any]()
    
    private func store<T>(coordinator: Coordinator<T>) {
        childCoordinators[coordinator.identifier] = coordinator
        print("Coordinators in stack \(childCoordinators.count)")
    }
    
    private func free<T>(coordinator: Coordinator<T>) {
        childCoordinators[coordinator.identifier] = nil
        print("Coordinator removed from stack")
    }
    
    func coordinate<T>(to coordinator: Coordinator<T>) -> Single<T> {
        self.store(coordinator: coordinator)
        return Observable.just(coordinator.start()).do(onNext: {
            [weak self] _ in self?.free(coordinator: coordinator)
        }).asSingle()
    }
    
    func start() -> ResultType {
        fatalError("Start method should be implemented.")
    }
}
