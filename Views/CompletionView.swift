import SwiftUI

struct CompletionView: View {
    let onRestart: () -> Void
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.9)
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                // Анимированная иконка
                ZStack {
                    Circle()
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color.purple.opacity(0.8),
                                    Color.blue.opacity(0.6)
                                ]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 120, height: 120)
                        .shadow(radius: 20)
                    
                    Image(systemName: "checkmark")
                        .font(.system(size: 50, weight: .bold))
                        .foregroundColor(.white)
                }
                .scaleEffect(1.0)
                .animation(
                    Animation.spring(response: 0.6, dampingFraction: 0.8)
                        .repeatForever(autoreverses: true),
                    value: UUID()
                )
                
                VStack(spacing: 15) {
                    Text("🎉 Отлично!")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text("Вы просмотрели все фильмы и сериалы!")
                        .font(.title3)
                        .foregroundColor(.white.opacity(0.8))
                        .multilineTextAlignment(.center)
                    
                    Text("Теперь можете выбрать что-то из понравившегося")
                        .font(.body)
                        .foregroundColor(.white.opacity(0.6))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }
                
                // Кнопка перезапуска
                Button(action: {
                    withAnimation(.spring()) {
                        onRestart()
                    }
                }) {
                    HStack(spacing: 10) {
                        Image(systemName: "arrow.clockwise")
                            .font(.title2)
                        
                        Text("Начать заново")
                            .font(.title3)
                            .fontWeight(.semibold)
                    }
                    .foregroundColor(.white)
                    .padding(.horizontal, 30)
                    .padding(.vertical, 15)
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color.purple.opacity(0.8),
                                Color.blue.opacity(0.8)
                            ]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .clipShape(Capsule())
                    .shadow(radius: 10)
                }
                .scaleEffect(1.0)
                .onAppear {
                    withAnimation(
                        Animation.easeInOut(duration: 1.0)
                            .repeatForever(autoreverses: true)
                    ) {
                        // Можно добавить анимацию кнопки
                    }
                }
                
                Spacer()
                    .frame(height: 50)
            }
            .padding()
        }
    }
}

#Preview {
    CompletionView {
        print("Restart tapped")
    }
}