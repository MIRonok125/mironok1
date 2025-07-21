import SwiftUI

struct ContentView: View {
    @StateObject private var movieManager = MovieManager()
    
    var body: some View {
        ZStack {
            // Градиентный фон
            LinearGradient(
                gradient: Gradient(colors: [
                    Color.purple.opacity(0.8),
                    Color.blue.opacity(0.6),
                    Color.black
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack {
                // Заголовок
                HStack {
                    Text("🎬 MovieSwipe")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Button(action: {
                        movieManager.resetMovies()
                    }) {
                        Image(systemName: "arrow.clockwise")
                            .font(.title2)
                            .foregroundColor(.white)
                    }
                }
                .padding(.horizontal)
                .padding(.top, 10)
                
                Spacer()
                
                // Стек карточек
                ZStack {
                    ForEach(movieManager.movies.indices.reversed(), id: \.self) { index in
                        if index >= movieManager.currentIndex && index < movieManager.currentIndex + 3 {
                            MovieCardView(
                                movie: movieManager.movies[index],
                                index: index,
                                currentIndex: movieManager.currentIndex,
                                onSwipe: { direction in
                                    movieManager.swipeMovie(direction: direction)
                                }
                            )
                            .zIndex(Double(movieManager.movies.count - index))
                        }
                    }
                }
                .padding(.horizontal, 20)
                
                Spacer()
                
                // Кнопки действий
                HStack(spacing: 40) {
                    // Дизлайк
                    Button(action: {
                        movieManager.swipeMovie(direction: .left)
                    }) {
                        Image(systemName: "xmark")
                            .font(.title)
                            .foregroundColor(.white)
                            .frame(width: 60, height: 60)
                            .background(Color.red.opacity(0.8))
                            .clipShape(Circle())
                            .shadow(radius: 10)
                    }
                    
                    // Супер лайк
                    Button(action: {
                        movieManager.swipeMovie(direction: .up)
                    }) {
                        Image(systemName: "star.fill")
                            .font(.title)
                            .foregroundColor(.white)
                            .frame(width: 60, height: 60)
                            .background(Color.blue.opacity(0.8))
                            .clipShape(Circle())
                            .shadow(radius: 10)
                    }
                    
                    // Лайк
                    Button(action: {
                        movieManager.swipeMovie(direction: .right)
                    }) {
                        Image(systemName: "heart.fill")
                            .font(.title)
                            .foregroundColor(.white)
                            .frame(width: 60, height: 60)
                            .background(Color.green.opacity(0.8))
                            .clipShape(Circle())
                            .shadow(radius: 10)
                    }
                }
                .padding(.bottom, 40)
                
                // Индикатор прогресса
                if movieManager.currentIndex < movieManager.movies.count {
                    HStack {
                        Text("Осталось: \(movieManager.movies.count - movieManager.currentIndex)")
                            .foregroundColor(.white.opacity(0.7))
                            .font(.caption)
                        
                        Spacer()
                        
                        Text("\(movieManager.currentIndex + 1) из \(movieManager.movies.count)")
                            .foregroundColor(.white.opacity(0.7))
                            .font(.caption)
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 20)
                }
            }
            
            // Экран завершения
            if movieManager.currentIndex >= movieManager.movies.count {
                CompletionView {
                    movieManager.resetMovies()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}