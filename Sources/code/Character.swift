import Foundation

extension DnD.Character {
	struct Points {
		var available = 0
		var spent = 0
		var bonus = 0
	}
}

extension DnD.Character {
	enum Size {
		case small
		case medium
	}
}

extension DnD {
	struct Character {
		static let levelRange = 1...20
		static let moneyRange = 0...
		static let pointRange = 0...
		
		var name = ""
		var player = ""
		var classIndex = 0 {
			didSet {
				changeClass(from: DnD.Character.Class.allCases[oldValue], to: DnD.Character.Class.allCases[classIndex])
			}
		}
		var raceIndex = 0 {
			didSet {
				changeRace(from: DnD.Character.Race.allCases[oldValue], to: DnD.Character.Race.allCases[raceIndex])
			}
		}
		var genderIndex = 0 {
			didSet {
				changeGender(from: DnD.Character.Gender.allCases[oldValue], to: DnD.Character.Gender.allCases[genderIndex])
			}
		}
		var level = 1
		var alignmentIndex = 0
//		var age = 0
//		var height = 0
//		var weight = 0
		var diety = ""
		var eyes = ""
		var hair = ""
		var skin = ""
		var abilityPoints = Points()
		var abilities: [Ability] = []
		var skillPoints = Points()
		var skills: [Skill] = []
		var featPoints = Points()
		var feats: [Feat] = []
		var money = 0
		var equipment: [Equipment] = [.init(equipment: .unarmedStrike)]
		var speed = 30
		var size: Size = .medium
		var languages: [DnD.Language] = [.common]
		
		init() {
			resetAdvancedFields()
		}
		
		mutating private func modify(ability targetAbility: DnD.Ability, by bonus: Int) {
			guard let abilityIndex = abilities.firstIndex(where: { $0.ability == targetAbility }) else {
				return
			}
			abilities[abilityIndex].bonus = bonus
		}
		
		mutating private func changeClass(from oldClass: DnD.Character.Class, to newClass: DnD.Character.Class) {
			resetAdvancedFields()
		}
		
		mutating private func changeRace(from oldRace: DnD.Character.Race, to newRace: DnD.Character.Race) {
			resetAdvancedFields()
			switch newRace {
			case .human:
				skillPoints.available += 4
				featPoints.available += 1
			case .dwarf:
				modify(ability: .constitution, by: 2)
				modify(ability: .charisma, by: -2)
				speed = 20
				languages.append(.dwarven)
			case .elf:
				modify(ability: .dexterity, by: 2)
				modify(ability: .constitution, by: -2)
				languages.append(.elven)
			case .gnome:
				modify(ability: .constitution, by: 2)
				modify(ability: .strength, by: 2)
				speed = 20
				size = .small
				languages.append(.gnome)
			case .halfElf:
				languages.append(.elven)
			case .halfOrc:
				modify(ability: .strength, by: 2)
				modify(ability: .intelligence, by: -2)
				modify(ability: .charisma, by: -2)
				languages.append(.orc)
			case .halfling:
				modify(ability: .dexterity, by: 2)
				modify(ability: .strength, by: -2)
				speed = 20
				size = .small
				languages.append(.halfling)
			}
		}
		
		mutating private func changeGender(from oldGender: DnD.Character.Gender, to newGender: DnD.Character.Gender) {
			resetAdvancedFields()
		}
		
		mutating func resetAbilities() {
			abilityPoints = Points()
			abilities = []
			for ability in DnD.Ability.allCases {
				abilities.append(.init(ability))
			}
		}
		
		mutating private func resetAdvancedFields() {
			level = 1
			skillPoints = Points()
			skills = []
			featPoints = Points(available: 1)
			feats = []
			money = 0
			speed = 30
			size = .medium
			languages = [.common]
			
			resetAbilities()
			
			for skill in DnD.Skill.allCases {
				skills.append(.init(skill))
				switch skill {
				case .craft: skills.append(contentsOf: [.init(skill), .init(skill)])
				default: continue
				}
			}
			
			for feat in DnD.Feat.allCases {
				feats.append(.init(feat))
			}
			
			equipment = [.init(equipment: .unarmedStrike)]
		}
		
		mutating func randomizeAbilities() {
			for abilityIndex in abilities.indices {
				abilities[abilityIndex].randomize()
			}
		}
		
		func canAfford(item: DnD.Equipment) -> Bool {
			guard let itemCost = item.properties.cost else {
				return false
			}
			
			return money >= itemCost * Shop.shared.amount(for: item)
		}
		
		mutating func purchase(item: DnD.Equipment) {
			guard let itemCost = item.properties.cost else {
				return
			}
			
			let amount = Shop.shared.amount(for: item)
			
			let cost = itemCost * Shop.shared.amount(for: item)
			money -= cost
			
			for (equipmentIndex, inventoryItem) in equipment.enumerated() {
				if inventoryItem.equipment == item {
					equipment[equipmentIndex].amount += amount
					return
				}
			}
			equipment.append(.init(equipment: item, amount: amount))
		}
		
		mutating func set(ability: DnD.Ability, to newLevel: Int) {
			guard let characterAbility = abilities.first(where: { $0.ability == ability }) else {
				return
			}
			
			guard newLevel >= Ability.pointBuyRange.lowerBound && newLevel <= Ability.pointBuyRange.upperBound else {
				return
			}
			
			let currentPointsSpent = Ability.pointBuyCost(for: characterAbility.points)
			let newPointsSpent = Ability.pointBuyCost(for: newLevel)
			let pointDelta = newPointsSpent - currentPointsSpent
			
			guard abilityPoints.spent + pointDelta <= abilityPoints.available + abilityPoints.bonus else {
				return
			}
			
			guard let abilityIndex = abilities.firstIndex(where: { $0.ability == ability }) else {
				return
			}
			
			abilities[abilityIndex].points = newLevel
			abilityPoints.spent += pointDelta
		}
	}
}
