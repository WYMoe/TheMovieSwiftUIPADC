//
//  ShowcaseItemView.swift
//  TheMovieSwiftUIPADC
//
//  Created by Wai Yan Moe on 22/04/2023.
//

import SwiftUI

struct ShowcaseItemView: View {
    var mMovie : MovieVO?
    var body: some View {
        
        ZStack(alignment:Alignment(horizontal: .leading, vertical: .bottom)) {
            ZStack {
                ShowcaseImageView(imageUrl: mMovie?.getPosterPathTogetherWithBaseUrl() ?? "")
                
                Image(systemName: IC_PLAY_BUTTON)
                    .resizable()
                    .frame(width: MARGIN_XXLARGE,height: MARGIN_XXLARGE)
                    .foregroundColor(.yellow)
            }
            
            VStack(alignment: .leading,spacing: 0.0){
                
                Text(mMovie?.title ?? "")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .font(.system(size: TEXT_REGULAR_2X))
                
                
                Text(mMovie?.releaseDate?.split(separator: "-")[0] ?? "" )
                    .foregroundColor(.gray.opacity(8.0))
                    .font(.system(size: TEXT_REGULAR))
                    .fontWeight(.medium)
                    .padding(.top,MARGIN_SMALL)
                
            }.padding([.leading,.bottom], MARGIN_CARD_MEDIUM_2)
        }.padding(.leading,MARGIN_CARD_MEDIUM_2)
    }
}


struct ShowcaseItemView_Previews: PreviewProvider {
    static var previews: some View {
        ShowcaseItemView()
    }
}

struct ShowcaseImageView: View {
    
    var imageUrl : String = ""
    
    var body: some View {
        
        AsyncImage(url: URL(string: imageUrl)!){
            phase in
            switch phase {
            case .empty:
                 ProgressView()
            case .success(let image):
                 image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: SHOWCASE_ITEM_WIDTH,height: SHOWCASE_ITEM_HEIGHT)
                   
            case .failure:
                Image(systemName: "exclamationmark.icloud")
                
            @unknown default:
                EmptyView()
            }
        }
           
             
                
                
           
        
    }
}
