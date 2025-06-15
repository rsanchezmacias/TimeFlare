//
//  PoliciesAndTermsView.swift
//  TimeFlare
//
//  Created by Ricardo Sanchez-Macias on 9/21/23.
//

import SwiftUI

struct PoliciesAndTermsView: View {
    
    let privacyPolicyURL = URL(string: "https://rsanchezmacias.github.io/TimeFlare/privacy_policy.html")
    let termsAndConditionsURL = URL(string: "https://rsanchezmacias.github.io/TimeFlare/terms_and_conditions.html")
    let contactUsURL = URL(string: "https://rsanchezmacias.github.io/TimeFlare/")
    
    var body: some View {
        HStack(alignment: .center, spacing: 4, content: {
            Link("Contact Us", destination: contactUsURL!)
            Spacer()
            Link("Terms & Conditions", destination: termsAndConditionsURL!)
            Spacer()
            Link("Privacy Policy", destination: privacyPolicyURL!)
        })
        .font(.system(size: 12))
        .foregroundColor(.metal)
        .padding()
    }
}

#Preview {
    PoliciesAndTermsView()
}
