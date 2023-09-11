//
//  DeadlineDeepLinkModel.swift
//  TimeFlare
//
//  Created by Ricardo Sanchez-Macias on 9/7/23.
//

import Combine
import Foundation

class DeadlineDeepLinkModel: ObservableObject {
    
    @Published var path: [Deadline] = []
    
    func handleDeepLink(url: URL, deadlines: [Deadline]) {
        guard url.scheme == DeepLink.rawScheme else {
            return
        }
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            print("[DeadlineDeepLinkModel] Invalid URL")
            return
        }
        
        guard let action = components.host, action == DeepLinkAction.show.rawValue else {
            print("[DeadlineDeepLinkModel] Unsupported link")
            return
        }
        
        guard let deadlineId = components.queryItems?.first(where: { $0.name == "id" })?.value else {
            print("[DeadlineDeepLinkModel] Deadline ID not found")
            return
        }
        
        guard let correspondingDeadline = deadlines.first(where: { deadline in "\(deadline.id)" == deadlineId}) else {
            print("[DeadlineDeepLinkModel] Not deadline found for given ID")
            return
        }
        
        path = [correspondingDeadline]
    }
    
}
