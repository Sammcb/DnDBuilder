import Foundation

extension DnD {
	enum Ability: String, Identifiable, CaseIterable, Displayable {
		case strength
		case dexterity
		case constitution
		case intelligence
		case wisdom
		case charisma
		
		var id: Self {
			self
		}
		
		var displayName: String {
			rawValue.capitalized
		}
	}
}

extension DnD.Character {
	struct Ability: Identifiable, DiceRoller {
		static let pointBuyRange = 8...18
		static let randomRange = 3...18
		let id = UUID()
		let ability: DnD.Ability
		var points = 8
		var bonus = 0
		
		init(_ ability: DnD.Ability) {
			self.ability = ability
		}
		
		static func pointBuyCost(for level: Int) -> Int {
			switch level {
			case 9...14: return level - pointBuyRange.lowerBound
			case 15: return 8
			case 16: return 10
			case 17: return 13
			case 18: return 16
			default: return 0
			}
		}
		
		mutating func randomize() {
			var rolls: [Int] = []
			for _ in 0..<4 {
				let roll = roll(d: 6)
				rolls.append(roll)
			}
			rolls.sort()
			rolls.removeFirst()
			points = 0
			for diceRoll in rolls {
				points += diceRoll
			}
		}
	}
}
