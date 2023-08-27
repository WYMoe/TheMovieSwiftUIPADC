//
//  ContentView.swift
//  TheMovieSwiftUIPADC
//
//  Created by Wai Yan Moe on 18/04/2023.
//

import SwiftUI

struct ContentView: View {
    //navigation
 //   @State var isShowDetails: Bool = false
    
    //data model
    let mMovieModel : MovieModel = MovieModelImpl.shared
    
    //state variables
    @State var mNowPlayingMovies : [MovieVO]? = nil
    @State var mPopularMovies : [MovieVO]? = nil
    @State var mTopRatedMovies : [MovieVO]? = nil
    @State var mGenres : [GenreVO]? = nil
    @State var mMoviesByGenre : [MovieVO]? = nil
    @State var mActors : [ActorVO]? = nil

    
    var body: some View {
        NavigationStack {
            ZStack{
                
                //background
                Color(PRIMARY_COLOR)
                
                VStack(alignment: .leading, spacing: 0.0){
                    //appbar
                    AppBarView()
                    ScrollView(.vertical){
                        
                        VStack(alignment:.leading){
                            //banner view
                            BannerSectionView(mNowPlayingMovies: mNowPlayingMovies) {
                            //    isShowDetails = true
                            }
                            
                            //popular movie list
                            PopularMovieSectionView(mPopularMovies: mPopularMovies)
                            
                            //checkmovieshowtime section
                            CheckMovieShowtimesSectionView()
                            
                           //spacer
                            Spacer().frame(height: MARGIN_LARGE)
                            
                            //genre section
                            VStack(spacing:0.0) {
                                GenreTabLayoutView(genres: mGenres,onTapGenre: { genreId in
                                    mGenres = mGenres?.map({ iteratedGenre in
                                        if genreId == iteratedGenre.id {
                                            return GenreVO(id: iteratedGenre.id,name: iteratedGenre.name,
                                                           isSelected:true)
                                        } else {
                                            return GenreVO(id:iteratedGenre.id,name: iteratedGenre.name,
                                                           isSelected:false)
                                        }
                                    })
                                    self.getMoviesByGenre(genreId: genreId)
                                    
                                }).padding([.leading,.trailing],MARGIN_CARD_MEDIUM_2)
                                
                                
                                HorizontalMovieListView(mMovieList: mMoviesByGenre).padding([.top,.bottom],MARGIN_MEDIUM_3)
                                    .background(Color(PRIMARY_DARK_COLOR))
                            }
                            
                            //showcase section
                            ShowcaseSectionView(mTopRatedMovies: mTopRatedMovies)
                            
                            //spacer
                            Spacer().frame(height: MARGIN_LARGE)
                            
                            //actors section
                            ActorsOrCreatorsListView(mActors: mActors,label: LABEL_ACTORS,moreLabel: LABEL_MOREACTORS)
                                .padding([.top,.bottom],MARGIN_MEDIUM_3)
                                .background(Color(PRIMARY_DARK_COLOR))
                            
                        }
                        
                    }.padding(.top, MARGIN_MEDIUM_3)
                    
                }.padding(.top, MARGIN_XXLARGE)
                  
            }
            .edgesIgnoringSafeArea([.top,.bottom])
            .onAppear{
                requestData()
            }
            .navigationDestination(for: MovieVO.self) { movie in
                MovieDetailScreen(movieId: movie.id ?? 0)
            }
            
            
           
        }
        
          
        
    }
    
    func requestData(){
        
        
        //database
        self.mNowPlayingMovies = mMovieModel.getNowPlayingMoviesFromDatabase()
        self.mTopRatedMovies = mMovieModel.getTopRatedMoviesFromDatabase()
        self.mPopularMovies = mMovieModel.getPopularMoviesFromDatabase()
        
        
        //now playing movies
        mMovieModel.getNowPlayingMovies(page: 1) { movies in
            self.mNowPlayingMovies = movies
        } onFailure: { error in
        }
        
        //popular movies
        mMovieModel.getPopularMovies(page: 1) { movies in
            self.mPopularMovies = movies
        } onFailure: { error in
        }
        
        //genres
        mMovieModel.getGenres { genres in
            self.mGenres = genres.enumerated().map({ index,genre in
             
                if index == 0 {
                   
                    return  GenreVO(id: genre.id, name: genre.name, isSelected: true)
                } else {
                    return genre
                }
                
                
            })
            self.getMoviesByGenre(genreId: mGenres?.first?.id ?? 0)
          
        } onFailure: { error in
           
        }
        
        //top rated movies
        mMovieModel.getTopRatedMovies(page: 1) { movies in
            self.mTopRatedMovies = movies
        } onFailure: { error in
            
        }
        
        //actors
        mMovieModel.getActors { actors in
            self.mActors = actors
        } onFailure: { error in
         //   print(error)
        }

    }
    
    func getMoviesByGenre(genreId:Int) {
        mMovieModel.getMoviesByGenre(genreId: genreId) { movies in
            self.mMoviesByGenre = movies 
        
        } onFailure: { error in
            
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct AppBarView: View {
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
        }.padding([.leading,.trailing],MARGIN_CARD_MEDIUM_2)
    }
}



struct BannerSectionView: View {
    
    var onTapMovie: () -> Void
    var mNowPlayingMovies  : [MovieVO]?
    
    init(mNowPlayingMovies : [MovieVO]?, onTapMovie:@escaping ()->Void) {
        
        self.onTapMovie = onTapMovie
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
