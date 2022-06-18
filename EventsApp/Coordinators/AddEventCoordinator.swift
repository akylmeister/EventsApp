//
//  AddEventListCoordinator.swift
//  EventsApp
//
//  Created by admin on 04.06.2022.
//

import UIKit

final class AddEventCoordinator: Coordinator{
    var childCoordinators: [Coordinator] = []
    private let navigationController: UINavigationController
    private var modalNavigationController: UINavigationController?
    
    var parentCoordinator: (EventUpdatingCoordinator & Coordinator)?
    private var completion: (UIImage) -> Void = { _ in }
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        modalNavigationController = UINavigationController()
        let addEventViewController: AddEventViewController = .instantiate()
        modalNavigationController?.setViewControllers([addEventViewController], animated: false)
        let addEventViewModel = AddEventViewModel(cellBuilder: EventsCellBuilder())
        addEventViewModel.coordinator = self
        addEventViewController.viewModel = addEventViewModel
        if let modalNavigationController = modalNavigationController {
            navigationController.present(modalNavigationController, animated: true, completion: nil)
        }
    }
    
    func didFinish() {
        parentCoordinator?.childDidFinish(self)
    }
    
    func didFinishSaveEvent() {
        parentCoordinator?.onUpdateEvent()
        navigationController.dismiss(animated: true)
    }
    
    func showImagePicker(completion: @escaping(UIImage) -> Void) {
        guard let modalNavigationController = modalNavigationController else {
            return
        }
        self.completion = completion
        let imagePickerCoordinator = ImagePickerCoordinator(navigationController: modalNavigationController)
        imagePickerCoordinator.onFinishPicking = { image in
            self.completion(image)
            self.modalNavigationController?.dismiss(animated: true)
        }
        imagePickerCoordinator.parentCoordinator = self
        childCoordinators.append(imagePickerCoordinator)
        imagePickerCoordinator.start()
    }
    
    func childDidFinish(_ childCoordinator: Coordinator){
        if let index = childCoordinators.firstIndex(where: { (coordinator) -> Bool in
            return childCoordinator === coordinator
        }){
            childCoordinators.remove(at: index)
        }
    }
}
