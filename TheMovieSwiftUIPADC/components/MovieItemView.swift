//
//  MovieItemView.swift
//  TheMovieSwiftUIPADC
//
//  Created by Wai Yan Moe on 20/04/2023.
//

import SwiftUI

struct MovieItemView: View {
    var mMovie : MovieVO?
    var body: some View {
        VStack(alignment:.leading,spacing: 0.0){
            //movie image
            MovieListItemImageView(imageUrl: mMovie?.getPosterPathTogetherWithBaseUrl() ?? "")
                
            
            //movie name
            Text(mMovie?.title ??  "")
                .foregroundColor(.white)
                .font(.system(size: TEXT_REGULAR_2X))
                .fontWeight(.bold)
                .padding(.top,MARGIN_MEDIUM)
            
            //rating info
            HStack{
                
                //rating text
                Text(String(mMovie?.voteAverage ?? 0.0))
                    .foregroundColor(.white)
                    .font(.system(size: TEXT_REGULAR_2X))
                    .fontWeight(.bold)
                    .padding(.top,MARGIN_MEDIUM)
                
                //rating star
                RatingStarView(maximumRating: 5,currentRating: 2)
            }
            //spacer
            Spacer()
            
        }
        .frame(width: 150, height: 280)
        .padding([.leading],MARGIN_CARD_MEDIUM_2)
    }
}

struct MovieItemView_Previews: PreviewProvider {
    static var previews: some View {
        MovieItemView(mMovie: MovieVO()).previewLayout(.sizeThatFits)
    }
}


struct MovieListItemImageView : View {
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
                    .frame(width: 150,height: 180)
                    .clipped()
            case .failure:
                Image(systemName: "exclamationmark.icloud")
                
            @unknown default:
                EmptyView()
            }
        }
    }
}
