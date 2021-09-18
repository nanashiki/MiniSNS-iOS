//
//  EntranceView.swift
//  MiniSNS
//
//  Created by nanashiki on 2021/08/23.
//

import SwiftUI

struct EntranceView: View {
    enum SheetType: Int, Identifiable {
        case signUp = 1
        case login = 2
        
        var id: Int {
            self.rawValue
        }
    }
    
    let loginWireframe: LoginWireframe
    
    @State var sheetType: SheetType? = nil

    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .foregroundColor(.blue)
                Text("Mini SNS")
                    .font(.title.bold())
                    .foregroundColor(.white)
            }
            .edgesIgnoringSafeArea(.vertical)
            .frame(height: 296)
            
            
//            Button {
//                sheetType = .signUp
//            } label: {
//                Text("Sign Up")
//                    .frame(maxWidth: .infinity)
//                    .padding()
//                    .background(Color.blue.cornerRadius(6.0))
//                    .foregroundColor(.white)
//            }
//            .padding()

            Button {
                sheetType = .login
            } label: {
                Text("Login")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue.cornerRadius(6.0))
                    .foregroundColor(.white)
            }
            .padding()
            
            Spacer()
        }
        .sheet(item: $sheetType) {
            switch $0 {
            case .signUp:
                loginWireframe.generateView()
            case .login:
                loginWireframe.generateView()
            }
        }
    }
}

struct EntranceView_Previews: PreviewProvider {
    static var previews: some View {
        EntranceView(loginWireframe: LoginRouter())
    }
}
