//
//  ContentView.swift
//  FirstAppSwiftUIpt2
//
//  Created by user on 21/06/22.
//

import SwiftUI
import Foundation

struct ContentView: View {
    
    @State var pass: String = " "
    
    var body: some View {
        var cont : String = "0"
        var myUrl = " "
        
        VStack{
            Text("Your Password is:\n\(pass)")
                .frame(alignment: .top)
                .font(Font.custom("Montserrat-Bold", size: 30.0))
                .multilineTextAlignment(.center)
            
            Button("Generate"){
                Task {
                    myUrl = passwordType(cont)
                    let (data, _) = try await URLSession.shared.data(from: URL(string: myUrl)!)
                    let decodedResponse = try? JSONDecoder().decode(Password.self, from: data)
                    pass = decodedResponse?.data ?? " "
                    print("Pass " + pass)
                }
            }
            
            Button("Basic password"){
                cont = "0"
            }.buttonStyle(MyButton())
            HStack{
                Button("Password with numbers"){
                    cont = "1"
                }.buttonStyle(MyButton())
                Button("Password with caps"){
                    cont = "2"
                }.buttonStyle(MyButton())
            } ; HStack{
                Button("Password with char"){
                    cont = "3"
                }.buttonStyle(MyButton())
                Button("Password with lenght 18"){
                   cont = "4"
                }.buttonStyle(MyButton())
            }
            Button("Password with all"){
                cont = "5"
            }.buttonStyle(MyButton())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct MyButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(12).background(Color(UIColor.systemIndigo)).foregroundColor(.white).cornerRadius(8).multilineTextAlignment(.center)
    }
}
struct MyButton2: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(12).background(Color(UIColor.red)).foregroundColor(.white).cornerRadius(8).multilineTextAlignment(.center)
    }
}

func passwordType (_ code: String)-> String{
    var url = "https://passwordinator.herokuapp.com?"
    switch code{
    case "0":
        return url
    case "1":
        url += "num=true"
    case "2":
        url += "caps=true"
    case "3":
        url += "char=true"
    case "4":
        url += "len=18"
    case "5":
        url += "num=true&caps=true&char=true&len=18"
    default:
        return "errore"
    }; return url
}

struct Password: Codable{
    let data: String
}
