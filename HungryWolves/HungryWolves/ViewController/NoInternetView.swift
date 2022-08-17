//
//  NoInternetView.swift
//  HungryWolves
//
//  Created by Andreea Lupașcu on 15.08.2022.
//

import SwiftUI

struct NoInternetView: View {
    var body: some View {
        Group {
            VStack {
                Spacer()
                Image("noInternet")
                    .resizable()
                    .frame(width: 130, height: 130)
                    .fixedSize()
                    .padding()
                
                Text("No internet Connection")
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding()
                
                Text("Your internet connection is currently not available please check or try again.")
                    .font(.subheadline)
                    .foregroundColor(Color.gray)
                    .multilineTextAlignment(.center)
                    .padding([.leading, .bottom, .trailing])
                
                Button("Try again") {
                    NetworkConnection.shared.dismissOfflineAlert()
                }
                .frame(width: 314, height: 75)
                .background(Color("noInternet"))
                .cornerRadius(50)
                .foregroundColor(Color.white)
                .padding(.vertical)
                
                Spacer()
            }
            .padding()
        }
    }
}

struct NoInternetView_Previews: PreviewProvider {
    static var previews: some View {
        NoInternetView()
            .previewDevice("iPhone 13 Pro Max")
    }
}
