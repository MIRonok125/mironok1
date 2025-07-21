import SwiftUI
import Combine

class MovieManager: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var currentIndex: Int = 0
    @Published var likedMovies: [Movie] = []
    @Published var dislikedMovies: [Movie] = []
    @Published var superLikedMovies: [Movie] = []
    
    init() {
        loadMovies()
    }
    
    func loadMovies() {
        movies = Movie.sampleMovies.shuffled()
        currentIndex = 0
    }
    
    func resetMovies() {
        loadMovies()
        likedMovies.removeAll()
        dislikedMovies.removeAll()
        superLikedMovies.removeAll()
    }
    
    func swipeMovie(direction: SwipeDirection) {
        guard currentIndex < movies.count else { return }
        
        let movie = movies[currentIndex]
        
        switch direction {
        case .left:
            dislikedMovies.append(movie)
            print("❌ Дизлайк: \(movie.title)")
        case .right:
            likedMovies.append(movie)
            print("❤️ Лайк: \(movie.title)")
        case .up:
            superLikedMovies.append(movie)
            print("⭐ Супер лайк: \(movie.title)")
        }
        
        withAnimation(.spring()) {
            currentIndex += 1
        }
    }
    
    func getCurrentMovie() -> Movie? {
        guard currentIndex < movies.count else { return nil }
        return movies[currentIndex]
    }
    
    func hasMoreMovies() -> Bool {
        return currentIndex < movies.count
    }
}

enum SwipeDirection {
    case left, right, up
}