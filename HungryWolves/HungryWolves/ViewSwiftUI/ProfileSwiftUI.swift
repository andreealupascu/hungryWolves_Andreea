//
//  ProfileSwiftUI.swift
//  HungryWolves
//
//  Created by Andreea Lupașcu on 16.08.2022.
//

import SwiftUI

let profileViewModel = ProfileViewModel()

struct ProfileSwiftUI: View {
    private var favoriteButtonPressed: () -> ()
    private var termsAndConditionPressed: () -> ()
    
    internal init(termsAndConditionPressed: @escaping () -> (), favoriteButtonPressed: @escaping () -> ()) {
        self.termsAndConditionPressed = termsAndConditionPressed
        self.favoriteButtonPressed = favoriteButtonPressed
    }
    
    var body: some View {
        NavigationView {
            
            VStack( spacing: 50) {
                Text("My profile")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .frame(width: 350.0, height: 50.0, alignment: .leading)
                
                
                HStack{
                    Image("logo")
                        .resizable(resizingMode: .stretch)
                        .cornerRadius(10)
                        .frame(width: 100, height: 100, alignment: .leading)
                        .padding()
                    
                    VStack (alignment: .leading, spacing: 5){
                        Text(profileViewModel.profile.name ?? "")
                            .font(.title2)
                        Text(profileViewModel.profile.email ?? "")
                            .lineLimit(0)
                            .font(.body)
                            .foregroundColor(Color.gray)
                        Rectangle().frame(width: 150, height: 1, alignment: .leading)
                            .padding(.vertical, 5.0)
                        Text(profileViewModel.profile.phone ?? "")
                            .lineLimit(0)
                            .font(.body)
                            .foregroundColor(Color.gray)
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(20)
                .frame(width: 350, height: 150)
                .shadow(color: .gray.opacity(0.2), radius: 5, x: 0, y: 2.0)
                
                HStack{
                    Text("Favourites")
                        .padding()
                    Spacer()
                    Button (action: {
                        favoriteButtonPressed()
                    }) {
                        Image(systemName: "chevron.forward")
                            .foregroundColor(Color.black)
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(20)
                .frame(width: 350, height: 70, alignment: .center)
                .shadow(color: .gray.opacity(0.2), radius: 5, x: 0, y: 2.0)
                
                HStack{
                    Text("Terms and conditions")
                        .padding()
                    Spacer()
                    Button (action: {
                        termsAndConditionPressed()
                    }) {
                        Image(systemName: "chevron.forward")
                            .foregroundColor(Color.black)
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(20)
                .frame(width: 350, height: 70, alignment: .center)
                .shadow(color: .gray.opacity(0.2), radius: 5, x: 0, y: 2.0)
                
                Spacer()
                Spacer()
                
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background(Color("Background"))
        }
    }
}

struct ProfileSwiftUI_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSwiftUI(termsAndConditionPressed: {}, favoriteButtonPressed: {})
            .previewDevice("iPhone 13 Pro Max").background()
    }
}

extension NSNotification.Name {
    static let tapViewTapped = NSNotification.Name("tapViewTapped")
}
