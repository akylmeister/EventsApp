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
    
    func tappedAddEvent(){
        coordinator?.startAddEvent()
    }
}
