//
//  EventListViewModel.swift
//  EventsApp
//
//  Created by admin on 04.06.2022.
//

import Foundation

final class EventListViewModel{
    
    let title = "Events"
    var coordinator: EventListCoordinator?
    var onUpdate = {}
    enum Cell {
        case event(EventCellViewModel)
    }
    
    fileprivate var cells: [Cell] = []
//    private let coreDataManager: CoreDataManager
    
    init(coreDataManager: CoreDataManager = CoreDataManager.shared) {
        self.coreDataManager = coreDataManager
    }
    
    func viewDidLoad() {
        
        cells = [.event(EventCellViewModel()), .event(EventCellViewModel())]
        onUpdate()
    }
    
    func tappedAddEvent(){
        coordinator?.startAddEvent()
    }
    
    func numberOfRows() -> Int{
        return cells.count
    }
    
    func cell(at indexPath: IndexPath) -> Cell{
        return cells[indexPath.row]
    }
}
