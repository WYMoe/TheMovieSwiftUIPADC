//
//  GenreTabLayoutView.swift
//  TheMovieSwiftUIPADC
//
//  Created by Wai Yan Moe on 20/04/2023.
//

import SwiftUI

struct GenreTabLayoutView: View {
    
    var genres : [GenreVO]? // to ask @state
    var onTapGenre: ((Int)->Void)?
    
   
    var body: some View {
        
        
        if genres?.isEmpty ?? true {
            Text("Empty")
        }else {
            ScrollView(.horizontal,showsIndicators: false){
                ScrollViewReader{ scrollView in
                    
                    HStack(spacing:MARGIN_MEDIUM_2){
                        
                        
                        ForEach(genres ?? [], id: \.id){
                            genre in
                            VStack {
                                Text(genre
                                    .name ?? "")
                                .foregroundColor(genre.isSelected ? .white : Color(TITLE_LABEL_COLOR))
                                .fontWeight(genre.isSelected ? .bold : .medium)
                                .font(.system(size: TEXT_REGULAR_2X))
                                
                                Rectangle()
                                    .fill(genre.isSelected ? .yellow : .clear)
                                    .frame(height:GENRE_TAB_INDICATOR_HEIGHT)
                            }.onTapGesture {
                                
                                guard let onTapGenre = self.onTapGenre else {
                                    return
                                }
                                onTapGenre(genre.id ?? 0 )
                               
                                withAnimation {
                                    
                                    scrollView.scrollTo(genre.id,anchor: .center)
                                 
                                }
                                
                            }
                            
                            
                            
                        }
                    }
                    
                    
                    
                }
            }
        }
    }
}

struct GenreTabLayoutView_Previews: PreviewProvider {
    static var previews: some View {
        GenreTabLayoutView()
    }
}
