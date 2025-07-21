import Foundation

struct Movie: Identifiable, Codable {
    let id = UUID()
    let title: String
    let year: Int
    let genre: String
    let rating: Double
    let description: String
    let imageName: String
    let type: MovieType
    let duration: String
    
    enum MovieType: String, Codable, CaseIterable {
        case movie = "Фильм"
        case series = "Сериал"
    }
}

extension Movie {
    static let sampleMovies: [Movie] = [
        Movie(
            title: "Побег из Шоушенка",
            year: 1994,
            genre: "Драма",
            rating: 9.3,
            description: "История о надежде, дружбе и выживании в тюрьме Шоушенк. Энди Дюфрейн был осужден за убийство жены и ее любовника.",
            imageName: "movie1",
            type: .movie,
            duration: "142 мин"
        ),
        Movie(
            title: "Крестный отец",
            year: 1972,
            genre: "Криминал, Драма",
            rating: 9.2,
            description: "Эпическая сага о семье Корлеоне. Дон Вито Корлеоне - глава одной из нью-йоркских мафиозных семей.",
            imageName: "movie2",
            type: .movie,
            duration: "175 мин"
        ),
        Movie(
            title: "Темный рыцарь",
            year: 2008,
            genre: "Боевик, Криминал",
            rating: 9.0,
            description: "Бэтмен сталкивается с самым опасным противником - Джокером, который хочет погрузить Готэм в хаос.",
            imageName: "movie3",
            type: .movie,
            duration: "152 мин"
        ),
        Movie(
            title: "Игра престолов",
            year: 2011,
            genre: "Фэнтези, Драма",
            rating: 9.5,
            description: "Эпическая фэнтези-сага о борьбе за власть в Семи Королевствах Вестероса.",
            imageName: "series1",
            type: .series,
            duration: "8 сезонов"
        ),
        Movie(
            title: "Во все тяжкие",
            year: 2008,
            genre: "Драма, Криминал",
            rating: 9.4,
            description: "Учитель химии Уолтер Уайт начинает варить наркотики, чтобы обеспечить семью после диагноза рака.",
            imageName: "series2",
            type: .series,
            duration: "5 сезонов"
        ),
        Movie(
            title: "Интерстеллар",
            year: 2014,
            genre: "Научная фантастика",
            rating: 8.6,
            description: "В недалеком будущем Земля становится непригодной для жизни. Группа исследователей отправляется в космос.",
            imageName: "movie4",
            type: .movie,
            duration: "169 мин"
        ),
        Movie(
            title: "Очень странные дела",
            year: 2016,
            genre: "Ужасы, Фэнтези",
            rating: 8.7,
            description: "Группа детей из маленького городка сталкивается с паранормальными явлениями и государственными заговорами.",
            imageName: "series3",
            type: .series,
            duration: "4 сезона"
        ),
        Movie(
            title: "Форрест Гамп",
            year: 1994,
            genre: "Драма, Комедия",
            rating: 8.8,
            description: "История жизни простодушного Форреста Гампа, который стал свидетелем важных событий американской истории.",
            imageName: "movie5",
            type: .movie,
            duration: "142 мин"
        ),
        Movie(
            title: "Шерлок",
            year: 2010,
            genre: "Детектив, Драма",
            rating: 9.1,
            description: "Современная адаптация историй о Шерлоке Холмсе, действие которой происходит в современном Лондоне.",
            imageName: "series4",
            type: .series,
            duration: "4 сезона"
        ),
        Movie(
            title: "Мстители: Финал",
            year: 2019,
            genre: "Боевик, Фэнтези",
            rating: 8.4,
            description: "Финальная битва против Таноса. Мстители должны собраться в последний раз, чтобы спасти вселенную.",
            imageName: "movie6",
            type: .movie,
            duration: "181 мин"
        )
    ]
}