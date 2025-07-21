import SwiftUI

struct MovieCardView: View {
    let movie: Movie
    let index: Int
    let currentIndex: Int
    let onSwipe: (SwipeDirection) -> Void
    
    @State private var offset = CGSize.zero
    @State private var rotation: Double = 0
    @State private var scale: CGFloat = 1.0
    
    private var isTopCard: Bool {
        index == currentIndex
    }
    
    private var cardOffset: CGFloat {
        CGFloat(index - currentIndex) * 10
    }
    
    private var cardScale: CGFloat {
        if index == currentIndex {
            return 1.0
        } else if index == currentIndex + 1 {
            return 0.95
        } else {
            return 0.9
        }
    }
    
    var body: some View {
        ZStack {
            // Карточка фильма
            RoundedRectangle(cornerRadius: 20)
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color.black.opacity(0.8),
                            Color.gray.opacity(0.3)
                        ]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .frame(width: 320, height: 500)
                .overlay(
                    // Содержимое карточки
                    VStack(alignment: .leading, spacing: 12) {
                        // Изображение фильма (заглушка)
                        RoundedRectangle(cornerRadius: 15)
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(colors: [
                                        Color.purple.opacity(0.6),
                                        Color.blue.opacity(0.4),
                                        Color.indigo.opacity(0.8)
                                    ]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .frame(height: 200)
                            .overlay(
                                VStack {
                                    Image(systemName: movie.type == .movie ? "tv" : "tv.and.hifispeaker.fill")
                                        .font(.system(size: 40))
                                        .foregroundColor(.white.opacity(0.8))
                                    
                                    Text(movie.type.rawValue)
                                        .font(.caption)
                                        .foregroundColor(.white.opacity(0.7))
                                }
                            )
                            .padding(.horizontal)
                            .padding(.top)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            // Название и год
                            HStack {
                                Text(movie.title)
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .lineLimit(2)
                                
                                Spacer()
                                
                                Text("\(movie.year)")
                                    .font(.subheadline)
                                    .foregroundColor(.white.opacity(0.8))
                            }
                            
                            // Жанр и длительность
                            HStack {
                                Text(movie.genre)
                                    .font(.subheadline)
                                    .foregroundColor(.white.opacity(0.8))
                                
                                Spacer()
                                
                                Text(movie.duration)
                                    .font(.subheadline)
                                    .foregroundColor(.white.opacity(0.8))
                            }
                            
                            // Рейтинг
                            HStack {
                                ForEach(0..<5) { star in
                                    Image(systemName: star < Int(movie.rating / 2) ? "star.fill" : "star")
                                        .foregroundColor(.yellow)
                                        .font(.caption)
                                }
                                
                                Text(String(format: "%.1f", movie.rating))
                                    .font(.subheadline)
                                    .foregroundColor(.white.opacity(0.8))
                                
                                Spacer()
                            }
                            
                            // Описание
                            Text(movie.description)
                                .font(.caption)
                                .foregroundColor(.white.opacity(0.7))
                                .lineLimit(6)
                                .multilineTextAlignment(.leading)
                        }
                        .padding(.horizontal)
                        .padding(.bottom)
                        
                        Spacer()
                    }
                )
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
            
            // Индикаторы свайпа
            if isTopCard {
                // Лайк индикатор
                if offset.width > 50 {
                    VStack {
                        HStack {
                            Spacer()
                            Text("НРАВИТСЯ")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.green)
                                .padding()
                                .background(Color.green.opacity(0.2))
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .rotationEffect(.degrees(-20))
                            Spacer()
                        }
                        Spacer()
                    }
                    .padding(.top, 50)
                }
                
                // Дизлайк индикатор
                if offset.width < -50 {
                    VStack {
                        HStack {
                            Spacer()
                            Text("НЕ НРАВИТСЯ")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.red)
                                .padding()
                                .background(Color.red.opacity(0.2))
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .rotationEffect(.degrees(20))
                            Spacer()
                        }
                        Spacer()
                    }
                    .padding(.top, 50)
                }
                
                // Супер лайк индикатор
                if offset.height < -50 {
                    VStack {
                        Text("СУПЕР!")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.blue)
                            .padding()
                            .background(Color.blue.opacity(0.2))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        Spacer()
                    }
                    .padding(.top, 30)
                }
            }
        }
        .scaleEffect(cardScale * scale)
        .offset(x: isTopCard ? offset.width : 0, y: isTopCard ? offset.height : cardOffset)
        .rotationEffect(.degrees(isTopCard ? rotation : 0))
        .opacity(index < currentIndex + 3 ? 1.0 : 0.0)
        .gesture(
            isTopCard ?
            DragGesture()
                .onChanged { value in
                    offset = value.translation
                    rotation = Double(value.translation.width / 10)
                    
                    // Эффект масштабирования при свайпе вверх
                    if value.translation.height < 0 {
                        scale = 1.0 + abs(value.translation.height) / 1000
                    } else {
                        scale = 1.0
                    }
                }
                .onEnded { value in
                    withAnimation(.spring()) {
                        if abs(value.translation.width) > 100 {
                            // Горизонтальный свайп
                            if value.translation.width > 0 {
                                onSwipe(.right)
                            } else {
                                onSwipe(.left)
                            }
                        } else if value.translation.height < -100 {
                            // Свайп вверх
                            onSwipe(.up)
                        } else {
                            // Возврат в исходное положение
                            offset = .zero
                            rotation = 0
                            scale = 1.0
                        }
                    }
                }
            : nil
        )
        .animation(.spring(response: 0.6, dampingFraction: 0.8), value: cardScale)
        .animation(.spring(response: 0.6, dampingFraction: 0.8), value: cardOffset)
    }
}

#Preview {
    MovieCardView(
        movie: Movie.sampleMovies[0],
        index: 0,
        currentIndex: 0,
        onSwipe: { _ in }
    )
    .preferredColorScheme(.dark)
}