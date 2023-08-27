//
//  SearchScreen.swift
//  TheMovieSwiftUIPADC
//
//  Created by Wai Yan Moe on 27/08/2023.
//

import SwiftUI

struct SearchScreen: View {
    
    //dismiss
  @Environment(\.dismiss) var dismiss
    
    //viewmodel
    @StateObject var mSearchViewModel = SearchViewModel()
    
    var body: some View {
        ZStack{
            //bg color
            Color(PRIMARY_COLOR)
            
            VStack(spacing: MARGIN_XLARGE){
                
                //back button and textfield
                
                HStack (spacing : MARGIN_MEDIUM_2){
                    
                    //back button
                    Image(systemName: "chevron.left")
                        .resizable()
                        .frame(width: MARGIN_CARD_MEDIUM_2,height: MARGIN_MEDIUM_3)
                        .aspectRatio(contentMode: .fill)
                        .foregroundColor(.white)
                        .onTapGesture {
                            dismiss()
                        }
                    
                    //search textfield
                    
                    TextField("", text:$mSearchViewModel.query, prompt: Text("Please enter movie name").foregroundColor(.gray))
                        .foregroundColor(.white)
                        .accentColor(.white)
                    
                    
                    
                    
                }
                
                //search result view
                
                SearchResultsView(results: mSearchViewModel.results)
            }
            .padding(EdgeInsets(top: MARGIN_XXLARGE + MARGIN_MEDIUM_2, leading: MARGIN_MEDIUM_2, bottom: 0, trailing: MARGIN_MEDIUM_2))
        }
        .edgesIgnoringSafeArea(.all)
        .navigationBarBackButtonHidden(true)
    }
}

struct SearchScreen_Previews: PreviewProvider {
    static var previews: some View {
        SearchScreen()
    }
}

struct SearchResultsView : View {
    
    var	results : [MovieVO]  = []
    
    var columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        if results.isEmpty {
            Spacer()
        } else {
            ScrollView{
                LazyVGrid(columns: columns) {
                    ForEach(results, id:\.id){
                        movie in
                        
                        MovieItemView(mMovie: movie)
                    }
                }
            }
        }
    }
}
