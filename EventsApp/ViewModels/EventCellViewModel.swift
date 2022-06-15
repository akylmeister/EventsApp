//
//  EventCellViewModel.swift
//  EventsApp
//
//  Created by admin on 15.06.2022.
//

import Foundation

struct EventCellViewModel {
    let date = Date()
    
    var timeRemainingStrings: [String] {
        guard let eventDate = event.date else { return [] }
        return date.timeRemaining(until: eventDate)?.components(separatedBy: ",") ?? []
        //date.timeRemaining(until: event.date)
    }
    var dateText: String {
        "25 Mar 2020"
    }
    var eventName: String {
        "Barbados"
    }
//    var backgroundImage: String {
//
//    }
    private let event: Event
    init(_ event: Event) {
        self.event = event
    }
}
