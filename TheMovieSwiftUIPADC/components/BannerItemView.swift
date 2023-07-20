//
//  BannerItemView.swift
//  TheMovieSwiftUIPADC
//
//  Created by Wai Yan Moe on 18/04/2023.
//

import SwiftUI

struct BannerItemView: View {
    var mMovie : MovieVO?
    var body: some View {
        ZStack(alignment:Alignment(horizontal:.leading,vertical:.bottom)) {
            ZStack {
                //image
                BannerImageView(imageUrl: mMovie?.getBackdropPathTogetherWithBaseUrl() ?? "")
                //gradient
                LinearGradient(colors: [.clear,Color(PRIMARY_COLOR)], startPoint: .top, endPoint: .bottom)
                //play button
                Image(systemName: IC_PLAY_BUTTON)
                    .resizable()
                    .foregroundColor(.yellow)
                    .frame(width: MARGIN_XXLARGE, height: MARGIN_XXLARGE)
            }
            //movie name
            Text(mMovie?.title ?? "")
                .foregroundColor(.white)
                .font(.system(size: TEXT_HEADING_1X))
                .fontWeight(.bold)
                .padding(EdgeInsets(top: 0.0, leading: MARGIN_CARD_MEDIUM_2, bottom: MARGIN_CARD_MEDIUM_2, trailing: 0.0))
        }
    }
}

struct BannerItemView_Previews: PreviewProvider {
    static var previews: some View {
        BannerItemView().previewLayout(.fixed(width: 500, height: 250))
    }
}
struct BannerImageView: View {
    var imageUrl : String = ""
    
    var body: some View  {
        AsyncImage(url: URL(string: imageUrl)!) { phase in
            switch phase {
            case .empty:
                 ProgressView()
            case .success(let image):
                 image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(minWidth: 0, idealWidth: .infinity, maxWidth: .infinity, minHeight: 0, idealHeight: BANNER_IMAGE_HEIGHT, maxHeight: BANNER_IMAGE_HEIGHT)
                    .clipped()
            case .failure:
                Image(systemName: "exclamationmark.icloud")
                
            @unknown default:
                EmptyView()
            }
            
        }
    }
}
