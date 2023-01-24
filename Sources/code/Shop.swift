import Foundation

struct Shop {
	static let shared = Shop()
	
	private init() {}
	
	func amount(for equipment: DnD.Equipment) -> Int {
		switch equipment {
		case .arrow: return 20
		case .crossbowBolt: return 10
		case .repeatingCrossbowBolt: return 5
		default: return 1
		}
	}
	
	func displayCost(for equipment: DnD.Equipment) -> String {
		guard let itemCost = equipment.properties.cost else {
			return "Unknown"
		}
		
		let cost = itemCost * amount(for: equipment)
		let gold = DnD.Money.shared.goldFrom(money: cost)
		let silver = DnD.Money.shared.silverFrom(money: cost)
		let copper = DnD.Money.shared.copperFrom(money: cost)
		
		let goldString = gold > 0 ? "\(gold)g" : ""
		let silverString = silver > 0 ? "\(silver)s" : ""
		let copperString = copper > 0 ? "\(copper)c" : ""
		
		return "\(goldString) \(silverString) \(copperString)".trimmingCharacters(in: .whitespacesAndNewlines)
	}
}
