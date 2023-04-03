//
//  PlaceHeaderView.swift
//  TATapp
//
//  Created by Waleerat Gottlieb on 2023-04-03.
//

import SwiftUI


struct CardView: View {
    var food: Food
    var body: some View {
        
        HStack{
            
            VStack(alignment: .leading, spacing: 10, content: {
                
                Text(food.title)
                    .fontWeight(.bold)
                
                Text(food.description)
                    .font(.caption)
                    .lineLimit(3)
                
                Text(food.price)
                    .fontWeight(.bold)
            })
            
            Spacer(minLength: 10)
            
            Image(food.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 130, height: 130)
                .cornerRadius(10)
        }
        .padding(.horizontal)
    }
}

struct PlaceHeaderView: View {
    
    @EnvironmentObject var homeData : HomeViewModel
    @Environment(\.colorScheme) var scheme
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0){
            
            HStack(spacing: 0){
                
                // BackButton...
                Button(action: {}, label: {
                    Image(systemName: "arrow.left")
                        .font(.system(size: 20, weight: .bold))
                        .frame(width: getSize(), height: getSize())
                        .foregroundColor(.primary)
                })
                
                Text("Kavsoft Bakery")
                    .font(.title)
                    .fontWeight(.bold)
            }
            
            ZStack{
                
                VStack(alignment: .leading, spacing: 10, content: {
                    
                    Text("Asiatisch . Koreanisch . Japnisch")
                        .font(.caption)
                    
                    HStack(spacing: 8){
                        
                        Image(systemName: "clock")
                            .font(.caption)
                        
                        Text("30-40 Min")
                            .font(.caption)
                        
                        Text("4.3")
                            .font(.caption)
                        
                        Image(systemName: "star.fill")
                            .font(.caption)
                        
                        Text("$6.40 Fee")
                            .font(.caption)
                            .padding(.leading,10)
                    }
                    .frame(maxWidth: .infinity,alignment: .leading)
                })
                .opacity(homeData.offset > 200 ? 1 - Double((homeData.offset - 200) / 50) : 1)
                
                // Custom ScrollView....
                
                // For Automatic Scrolling...
                
                ScrollViewReader {reader in
                    
                    ScrollView(.horizontal, showsIndicators: false, content: {
                        
                        HStack(spacing: 0){
                            
                            ForEach(tabsItems){tab in
                                
                                Text(tab.tab)
                                    .font(.caption)
                                    .padding(.vertical,10)
                                    .padding(.horizontal)
                                    .background(Color.primary.opacity(homeData.selectedtab == tab.tab ? 1 : 0))
                                    .clipShape(Capsule())
                                     
                                    //.foregroundColor(homeData.selectedtab == tab.tab ? scheme == .dark ? .black : .white : .primary)
                                    .id(tab.tab)
                            }
                            .onChange(of: homeData.selectedtab, perform: { value in
                                
                                // When Scrolling Very Fastly
                                // Animation Is Having Some Problem In Scroll Reader...
                                // May Be It's A Bug....
                                // Comment withAnimation Clouse in That Case....
                                
                                withAnimation(.easeInOut){
                                    reader.scrollTo(homeData.selectedtab,anchor: .leading)
                                }
                            })
                        }
                    })
                    
                    // Visible Only When Scrolls Up...
                    .opacity(homeData.offset > 200 ? Double((homeData.offset - 200) / 50) : 0)
                }
            }
            // Default Frame = 60...
            // Top Fram = 40
            // So Total = 100
            .frame(height: 60)
            
            if homeData.offset > 250{
                Divider()
            }
        }
        .padding(.horizontal)
        .frame(height: 100)
        .background(scheme == .dark ? Color.black : Color.white)
    }
    
    // Getting Size Of Button And Doing ANimation...
    func getSize()->CGFloat{
        
        if homeData.offset > 200{
            let progress = (homeData.offset - 200) / 50
            
            if progress <= 1.0{
                return progress * 40
            }
            else{
                return 40
            }
        }
        else{
            return 0
        }
    }
}


// Food Model And Sample Food items....

struct Food: Identifiable {
    var id = UUID().uuidString
    var title: String
    var description: String
    var price: String
    var image: String
}


var foods = [

    Food(title: "Choclate Cake", description: "Chocolate cake or chocolate gâteau is a cake flavored with melted chocolate, cocoa powder, or both", price: "$19",image: "choclates"),
    Food(title: "Cookies", description: "A biscuit is a flour-based baked food product. Outside North America the biscuit is typically hard, flat, and unleavened", price: "$10",image: "cookies"),
    Food(title: "Sandwich", description: "Trim the bread from all sides and apply butter on one bread, then apply the green chutney all over.", price: "$9",image: "sandwich"),
    Food(title: "French Fries", description: "French fries, or simply fries, chips, finger chips, or French-fried potatoes, are batonnet or allumette-cut deep-fried potatoes.", price: "$15",image: "fries"),
    Food(title: "Pizza", description: "Pizza is a savory dish of Italian origin consisting of a usually round, flattened base of leavened wheat-based dough topped", price: "$39",image: "pizza"),
]

