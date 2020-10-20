//
//  GroupNewsDataProvider.swift
//  SocialApp
//
//  Created by Дима Давыдов on 16.10.2020.
//

import Foundation

class GroupNewsDataProvider: MemoryDataProvider<NewsItem> {
    static var instance = GroupNewsDataProvider()
    
    override init() {
        super.init()
        
        loadFakeData()
    }
    
    private func loadFakeData() {
        
        let titleList: [String] = [
            "Эрдоган заявил Зеленскому, что Турция не признает Крым российским debugger",
            "Больше восьми миллионов. В США преодолён очередной психологический порог в статистике заболевших COVID-19",
            "Совет нацбезопасности США отверг предложение Путина продлить на год без обсуждения действие СНВ-3",
            "Найдено объяснение странного поведения Бетельгейзе, которую все мы знаем в лицо. Это звук",
            "Городское агентство по телевидению и радиовещанию избрало совет директоров. В него вошёл гендиректор Борис Петров",
            "Глава ВОЗ назвал единственный препарат, эффективный против коронавируса в тяжёлой форме",
            "На М-11 водитель «Лексуса» заигрался со скоростью. Прямо у пункта оплаты он ушёл под грузовик",
            "Радимов о Плющенко и Рудковской: Достали хайпожоры, превратившие фигурку в грязный шоубиз",
            "Проезд к аэропорту Пулково и Суздальский проспект — в списке ограничений из-за ремонта дороги",
            "В Италии снова тяжело: число заболевших ковидом за сутки превысило 10 тысяч",
            "Наш проект: 90-е — не только бандитский Петербург. Эволюция банковской сферы за три десятка лет",
            "Учителя и родители Петербурга выступили за ранние каникулы. Результаты опроса о коронавирусных ограничениях в школах",
        ]
        
        for (i, title) in titleList.enumerated() {
            _ = addDataItem(
                item: NewsItem(id: UUID().uuidString,
                               title: title,
                               imageUrl: "https://picsum.photos/600",
                               likesCount: Int.random(in: 1...1000),
                               isLiked:i % 3 == 0,
                               viewedCount: Int.random(in: 1...10000)
                )
            )
        }
    }
    
}