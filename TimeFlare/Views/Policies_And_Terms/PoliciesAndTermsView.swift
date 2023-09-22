//
//  PoliciesAndTermsView.swift
//  TimeFlare
//
//  Created by Ricardo Sanchez-Macias on 9/21/23.
//

import SwiftUI

struct PoliciesAndTermsView: View {
    
    let privacyPolictyURL = URL(string: "https://rsanchezmacias.github.io/TimeFlare/privacy_policy.html")
    let termsAndConditionsURL = URL(string: "https://rsanchezmacias.github.io/TimeFlare/terms_and_conditions.html")
    let contactUsURL = URL(string: "https://www.facebook.com/timeflareapp/")
    
    var body: some View {
        HStack(alignment: .center, spacing: 4, content: {
            Link("Terms & Conditions", destination: privacyPolictyURL!)
            Spacer()
            Text("•")
                .font(.system(size: 16))
            Spacer()
            Link("Privacy Policy", destination: termsAndConditionsURL!)
            Spacer()
            Text("•")
                .font(.system(size: 16))
            Spacer()
            Link("Contact Us", destination: contactUsURL!)
        })
        .font(.system(size: 12))
        .foregroundColor(.metal)
        .padding()
    }
}

#Preview {
    PoliciesAndTermsView()
}
