import Foundation

extension DnD {
	struct Money {
		static let shared = Money()
		private init() {}
		
		enum Unit: Int, CaseIterable, Identifiable, Displayable {
			case gold = 10000
			case silver = 100
			case copper = 1
			
			var id: Self {
				self
			}
			
			var displayName: String {
				switch self {
				case .gold: return "Gold"
				case .silver: return "Silver"
				case .copper: return "Copper"
				}
			}
		}
		
		func goldFrom(money: Int) -> Int {
			return money / Unit.gold.rawValue
		}
		
		func silverFrom(money: Int) -> Int {
			let silver = money % Unit.gold.rawValue
			return silver / Unit.silver.rawValue
		}
		
		func copperFrom(money: Int) -> Int {
			let copper = (money % Unit.gold.rawValue) % Unit.silver.rawValue
			return copper / Unit.copper.rawValue
		}
	}
}
