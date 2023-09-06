//
//  ContentView.swift
//  TheMovieSwiftUIPADC
//
//  Created by Wai Yan Moe on 18/04/2023.
//

import SwiftUI
import RxSwift
struct ContentView: View {

    //view model
    @StateObject var mViewModel = ContentViewModel()
   

    let disposeBag = DisposeBag()
    var body: some View {
        NavigationStack {
            ZStack{
                
                //background
                Color(PRIMARY_COLOR)
                
                VStack(alignment: .leading, spacing: 0.0){
                    //appbar
                    AppBarView(isPresented: $mViewModel.isPresented)
                    ScrollView(.vertical){
                        
                        VStack(alignment:.leading){
                            //banner view
                            BannerSectionView(mNowPlayingMovies: mViewModel.mNowPlayingMovies)
                            
                            //popular movie list
                            PopularMovieSectionView(mPopularMovies: mViewModel.mPopularMovies)
                            
                            //checkmovieshowtime section
                            CheckMovieShowtimesSectionView()
                            
                           //spacer
                            Spacer().frame(height: MARGIN_LARGE)
                            
                            //genre section
                            VStack(spacing:0.0) {
                                GenreTabLayoutView(genres: mViewModel.mGenres,onTapGenre: { genreId in
                                    self.mViewModel.onTapGenre(genreId: genreId)
                                    
                                }).padding([.leading,.trailing],MARGIN_CARD_MEDIUM_2)
                                
                                
                                HorizontalMovieListView(mMovieList: mViewModel.mMoviesByGenre).padding([.top,.bottom],MARGIN_MEDIUM_3)
                                    .background(Color(PRIMARY_DARK_COLOR))
                            }
                            
                            //showcase section
                            ShowcaseSectionView(mTopRatedMovies: mViewModel.mTopRatedMovies)
                            
                            //spacer
                            Spacer().frame(height: MARGIN_LARGE)
                            
                            //actors section
                            ActorsOrCreatorsListView(mActors: mViewModel.mActors,label: LABEL_ACTORS,moreLabel: LABEL_MOREACTORS)
                                .padding([.top,.bottom],MARGIN_MEDIUM_3)
                                .background(Color(PRIMARY_DARK_COLOR))
                            
                        }
                        
                    }.padding(.top, MARGIN_MEDIUM_3)
                    
                }.padding(.top, MARGIN_XXLARGE)
                  
            }
            .edgesIgnoringSafeArea([.top,.bottom])
            .navigationDestination(for: MovieVO.self) { movie in
                MovieDetailScreen(movieId: movie.id ?? 0)
            }
            .navigationDestination(isPresented: $mViewModel.isPresented) {
                SearchScreen()
            }
            
            
           
        }
        
          
        
    }
    

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct AppBarView: View {
    @Binding var isPresented : Bool
    var body: some View {
        HStack{
            //menu icon
            Image(systemName: IC_HORIZONTAL_LINES)
                .resizable()
                .foregroundColor(.white)
                .frame(width: MARGIN_LARGE, height: MARGIN_LARGE)
            Spacer()
            
            //title
            Text(LABEL_DISCOVER)
                .foregroundColor(.white)
                .font(.system(size: TEXT_REGULAR_3X))
                .fontWeight(.bold)
            Spacer()
            
            //search icon
            Image(systemName: IC_MAGNIFYING_GLASS)
                .resizable()
                .foregroundColor(.white)
                .frame(width: MARGIN_LARGE, height: MARGIN_LARGE)
                .onTapGesture {
                    isPresented = true
                }
        }.padding([.leading,.trailing],MARGIN_CARD_MEDIUM_2)
    }
}



struct BannerSectionView: View {
    
   
    var mNowPlayingMovies  : [MovieVO]?
    
    init(mNowPlayingMovies : [MovieVO]?) {
        
        
        self.mNowPlayingMovies = mNowPlayingMovies
        //UIKit code
        UIPageControl.appearance().pageIndicatorTintColor = .gray
        UIPageControl.appearance().currentPageIndicatorTintColor = .yellow
    }
    
    var body: some View {
        
        if mNowPlayingMovies?.isEmpty ?? true {
            EmptyView()
        }else {
            TabView{
                ForEach(mNowPlayingMovies ?? [], id:\.id){ movie in
             
                    NavigationLink(value: movie) {
                        BannerItemView(mMovie: movie)
                            .padding(.bottom, MARGIN_XLARGE)
                           
                    }
               
                }
            }.tabViewStyle(.page)
                .frame(height:BANNER_SECTION_HEIGHT)
                
        }
    }
}



struct PopularMovieSectionView: View {
    
    var mPopularMovies : [MovieVO]?
 
    var body: some View {
        if mPopularMovies?.isEmpty ?? true {
            EmptyView()
        } else {
            VStack(alignment: .leading){
                
                //title
                Text("BEST POPULAR MOVIES AND SERIES")
                    .foregroundColor(.white)
                    .font(.system(size: TEXT_REGULAR_2X))
                    .fontWeight(.bold)
                    .padding(.leading,MARGIN_CARD_MEDIUM_2)
                
                // movie list
                HorizontalMovieListView(mMovieList: mPopularMovies)
                
                
                
            }.padding(.top,MARGIN_CARD_MEDIUM_2)
        }
    }
}

struct CheckMovieShowtimesSectionView: View {
    var body: some View {
        ZStack{
            //bg color
            Color(PRIMARY_LIGHT_COLOR).frame(height:200)
            
            //content
            HStack{
                VStack(alignment: .leading){
                    //label
                    
                    Text("Check Movie \n Showtimes")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .font(.system(size:TEXT_HEADING_2X))
                        .padding([.top,.leading],MARGIN_MEDIUM_2)
                    Spacer()
                    
                    //see more label
                    Text("SEE MORE")
                        .foregroundColor(.yellow)
                        .underline()
                        .padding([.leading,.bottom],MARGIN_MEDIUM_2)
                }
                
                Spacer()
                
                Image(systemName: "location.fill")
                    .resizable()
                    .foregroundColor(.white)
                    .frame(width: 40,height: 40)
                    .padding(.trailing,MARGIN_XLARGE)
            }
            
        }.padding(EdgeInsets(top: MARGIN_MEDIUM_2, leading: MARGIN_MEDIUM_2, bottom: 0, trailing: MARGIN_MEDIUM_2))
    }
}

struct HorizontalMovieListView: View {
    var mMovieList : [MovieVO]?
  
    var body: some View {
        
        if mMovieList?.isEmpty ?? true {
            EmptyView()
        } else {
            ScrollView(.horizontal){
                HStack{
                    
                    ForEach(mMovieList ?? [MovieVO](), id: \.id, content: { movie in
                       NavigationLink(value: movie) {
                            MovieItemView(mMovie: movie)

                        }
                        
                    })
                }
            }
        }
    }
}



struct ShowcaseSectionView: View {
    var mTopRatedMovies : [MovieVO]?
    
    
    var body: some View {
        
        if mTopRatedMovies?.isEmpty ?? true {
            Text("Empty")
        } else {
            VStack(alignment:.leading){
                //title
                HStack{
                    Text(LABEL_SHOWCASE)
                        .foregroundColor(Color(TITLE_LABEL_COLOR))
                        .fontWeight(.bold)
                        .font(.system(size:TEXT_REGULAR_2X))
                    
                    //spacer
                    Spacer()
                    
                    //more showcase
                    Text(LABEL_MORESHOWCASE)
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .font(.system(size: TEXT_REGULAR_2X))
                        .underline()
                }.padding([.leading,.trailing],MARGIN_CARD_MEDIUM_2)
                
                //spacer
                Spacer().frame(height: MARGIN_CARD_MEDIUM_2)
                
                
                ScrollView(.horizontal){
                    HStack(spacing:0.0){
                        ForEach(mTopRatedMovies ?? [],id: \.id){
                            movie in
                          NavigationLink(value: movie) {
                                ShowcaseItemView(mMovie: movie)

                          }
                    
                        }
                    }.padding(.trailing,MARGIN_CARD_MEDIUM_2)
                }
                
            }.padding(.top,MARGIN_MEDIUM_2)
        }
    }
}
