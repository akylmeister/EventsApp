//
//  AppCoordinator.swift
//  EventsApp
//
//  Created by admin on 03.06.2022.
//

import Foundation
import UIKit

protocol Coordinator: class{
    var childCoordinators: [Coordinator] { get }
    func start()
    func childDidFinish(_ childCoordinator: Coordinator)
}

extension Coordinator {
    func childDidFinish(_ childCoordinator: Coordinator) {}
}

final class AppCoordinator: Coordinator{
    public var childCoordinators: [Coordinator] = []
    private let window: UIWindow
    
    init(window: UIWindow){
        self.window = window
    }
    func start() {
        
        let navigationController = UINavigationController()
        let eventListCoordinator = EventListCoordinator(navigationController: navigationController)
        childCoordinators.append(eventListCoordinator)
        eventListCoordinator.start()
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    
}
