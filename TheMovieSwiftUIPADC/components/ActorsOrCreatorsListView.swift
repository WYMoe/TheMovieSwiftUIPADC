//
//  ActorsOrCreatorsListView.swift
//  TheMovieSwiftUIPADC
//
//  Created by Wai Yan Moe on 22/04/2023.
//

import SwiftUI

struct ActorsOrCreatorsListView: View {
    var mActors : [ActorVO]?
    var label: String = ""
    var moreLabel: String = ""
    var body: some View {
        if  mActors?.isEmpty ?? true {
            Text("Empty")
        } else {
            VStack(alignment:.leading){
                HStack{
                    Text(label)
                        .foregroundColor(Color(TITLE_LABEL_COLOR))
                        .font(.system(size:TEXT_REGULAR_2X))
                        .fontWeight(.bold)
                    Spacer()
                    
                    Text(moreLabel)
                        .foregroundColor(.black)
                        .font(.system(size:TEXT_REGULAR_2X))
                        .fontWeight(.bold)
                        .underline()
                }.padding([.leading,.trailing], MARGIN_CARD_MEDIUM_2)
                
                
                ScrollView(.horizontal,showsIndicators: false){
                    
                    HStack {
                        ForEach(mActors ?? [], id:\.id){
                            a in
                            ActorItemView(mActor: a)
                            
                        }
                    }.padding([.leading,.trailing],MARGIN_CARD_MEDIUM_2)
                }
                
            }
            
        }
    }
}

struct ActorsOrCreatorsListView_Previews: PreviewProvider {
    static var previews: some View {
        ActorsOrCreatorsListView()
    }
}

struct ActorItemView : View {
    var mActor : ActorVO
    var body: some View {
        ZStack{
            //image
            ActorImageView(imageUrl: mActor.getProfilePathTogetherWithImageBaseUrl() )
            
            VStack(alignment:.leading) {
                //fav icon
                HStack{
                    Spacer()
                    Image(systemName: IC_HEARTFILL)
                        .resizable()
                        .foregroundColor(.yellow)
                        .frame(width: MARGIN_LARGE,height: MARGIN_LARGE)
                        .padding([.top,.trailing],MARGIN_CARD_MEDIUM_2)
                }
                //spacer
                Spacer()
                
                //actor info
                VStack(alignment: .leading) {
                    Text(mActor.name ?? "")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .font(.system(size: TEXT_REGULAR))
                    
                    HStack{
                        
                        Image(systemName:
                        IC_THUMBSUPFILL)
                            .resizable()
                            .foregroundColor(.yellow)
                            .frame(width: MARGIN_MEDIUM_2,height: MARGIN_MEDIUM_2)
                        Text("You like 18 movies")
                            .foregroundColor(Color(TITLE_LABEL_COLOR))
                            .font(.system(size:TEXT_SMALL))
                            .fontWeight(.bold)
                        
                    }.padding(.top,MARGIN_SMALL)
                }.padding([.leading,.bottom],MARGIN_MEDIUM)
                
            }
        }.frame(
            width: ACTOR_ITEM_WIDTH,height: ACTOR_ITEM_HEIGHT)
    }
}


struct ActorImageView: View {
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
                    .frame(width: ACTOR_ITEM_WIDTH, height: ACTOR_ITEM_HEIGHT)
                    .aspectRatio(contentMode: .fill)
            case .failure:
                Image(systemName: "exclamationmark.icloud")
                
            @unknown default:
                EmptyView()
            }
        }
       
    }
}
