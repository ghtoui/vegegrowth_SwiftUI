//
//  VegetableRepositoryList.swift
//  vegegrowth_SwiftUI
//
//  Created by toui on 2023/10/27.
//

import Foundation

struct VegetableRepositoryList {
    func getVegeRepositoryList() -> [VegetableRepository] {
        let vegeRepoList = [
            VegetableRepository(
                name: "mikan",
                uuid: UUID().uuidString,
                itemUuid: UUID().uuidString,
                size: 1,
                memo: "1",
                date: "2023-10-10 10:10:10"),
            VegetableRepository(
                name: "mikan",
                uuid: UUID().uuidString,
                itemUuid: UUID().uuidString,
                size: 2,
                memo: "2",
                date: "2023-10-11 10:10:10"),
            VegetableRepository(
                name: "mikan",
                uuid: UUID().uuidString,
                itemUuid: UUID().uuidString,
                size: 3,
                memo: "3",
                date: "2023-10-12 10:10:10"),
            VegetableRepository(
                name: "mikan",
                uuid: UUID().uuidString,
                itemUuid: UUID().uuidString,
                size: 2,
                memo: "4",
                date: "2023-10-13 10:10:10"),
            VegetableRepository(
                name: "mikan",
                uuid: UUID().uuidString,
                itemUuid: UUID().uuidString,
                size: 1,
                memo: "5",
                date: "2023-10-14 10:10:10"),
        ]
        return vegeRepoList
    }
}
