
import UIKit

public struct PostModel {
    public let author: String
    public let image: String
    public var discription: String? = nil
    public var likes: Int
    public var views: Int
//    public var filter: CIFilter
    
}

public struct Storage {
    public static let posts = [PostModel(author: "vedmak.official",
                                  image: "vedmak",
                                  discription: "New teasers of the 2 season of vedmak",
                                  likes: 222,
                                  views: 323),
//                                  filter: .init(name: "CISepiaTone")!),
                        PostModel(author: "netology", image: "netology", discription: "Это быстро: вам потребуется меньше одного года, чтобы освоить новую востребованную профессию.Каждый выпускник получит консультацию с персональными рекомендациями от HR-специалиста red_mad_robot и возможность трудоустройства или участия в стажировке. При успешном прохождении вам предложат вакансию в группе компаний red_mad_robot в одном из городов (Москва, Санкт-Петербург, Новосибирск, Калининград, Ярославль, Томск, Самара, Тольятти, Иннополис, Киев) или в компаниях-клиентах red_mad_robot. Выпускники с хорошими результатами, но которым ещё нужно попрактиковаться, смогут попасть на стажировку в red_mad_robot в одном из городов.",
                                  likes: 343,
                                  views: 222),
//                                  filter: .init(name: "CIVignette")!),
                        PostModel(author: "sports.ru",
                                  image: "euro2020",
                                  discription: "Сборная Италии одержала победу в финале чемпионата Европы по футболу, обыграв в Лондоне на «Уэмбли» в серии послематчевых пенальти национальную команду Англии. Джанлуиджи Доннарумма отразил три одиннадцатиметровых.", likes: 502,
                                  views: 980),
//                                  filter: .init(name: "CIPhotoEffectNoir")!),
                        PostModel(author: "bbcnews",
                                  image: "bezos",
                                  discription: "Основатель компании Amazon и самый богатый человек в мире Джефф Безос во вторник успешно слетал в космос на корабле New Shepard, который построила его компания Blue Origin.",
                                  likes: 655,
                                  views: 788)
//                                  filter: .init(name: "CIPhotoEffectChrome")!)
                        
                    ]
}

