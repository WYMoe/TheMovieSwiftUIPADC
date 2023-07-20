//
//  RatingStarView.swift
//  TheMovieSwiftUIPADC
//
//  Created by Wai Yan Moe on 20/04/2023.
//

import SwiftUI

struct RatingStarView: View {
    
    var maximumRating: Int = 5
    var currentRating: Int = 3
    
    var body: some View {
        
        HStack{
            ForEach(1...currentRating, id: \.self, content: { _ in
                
                Image(systemName: IC_STARFILL)
                    .resizable()
                    .foregroundColor(.yellow)
                    .frame(width: MARGIN_CARD_MEDIUM_2,
                           height: MARGIN_CARD_MEDIUM_2)
                
            })
            ForEach(1...(maximumRating-currentRating), id: \.self, content: { _ in
                
                Image(systemName: IC_STAR)
                    .resizable()
                    .foregroundColor(.yellow)
                    .frame(width: MARGIN_CARD_MEDIUM_2,
                           height: MARGIN_CARD_MEDIUM_2)
                
            })
        }
    }
}


struct RatingStarView_Previews: PreviewProvider {
    static var previews: some View {
        RatingStarView().previewLayout(.sizeThatFits)
    }
}
