import TokamakShim

struct SavingsView: View {
	@EnvironmentObject private var player: Player
	let unit: DnD.Money.Unit
	private var amount: Int {
		let money = player.character.money
		switch unit {
		case .gold: return DnD.Money.shared.goldFrom(money: money)
		case .silver: return DnD.Money.shared.silverFrom(money: money)
		case .copper: return DnD.Money.shared.copperFrom(money: money)
		}
	}
	private let adjustments = [1, 5, 10, 50]
	
	var body: some View {
		HStack {
			ForEach(adjustments, id: \.self) { adjustment in
				Button("-\(adjustment)") {
					guard player.character.money - adjustment * unit.rawValue >= DnD.Character.moneyRange.lowerBound else {
						return
					}
					player.character.money -= adjustment * unit.rawValue
				}
			}
			Text("\(unit.displayName): \(amount)")
			ForEach(adjustments.reversed(), id: \.self) { adjustment in
				Button("+\(adjustment)") {
					player.character.money += adjustment * unit.rawValue
				}
			}
		}
	}
}

struct ShopView: View {
	@EnvironmentObject private var player: Player
	
	var body: some View {
		Section(header: Text("Shop").font(.title)) {
			SavingsView(unit: .gold)
			SavingsView(unit: .silver)
			SavingsView(unit: .copper)
			let shopEquipment = DnD.Equipment.allCases.filter({ $0.properties.cost != nil })
			ForEach(shopEquipment.indices) { index in
				let equipment = shopEquipment[index]
				HStack {
					Text("\(equipment.displayName) (\(Shop.shared.amount(for: equipment)))")
					if player.character.canAfford(item: equipment) {
						Button("Buy") {
							player.character.purchase(item: equipment)
						}
					} else {
						Text("Too expensive - \(Shop.shared.displayCost(for: equipment))")
							.foregroundColor(.red)
					}
				}
			}
		}
		.navigationTitle("Shop")
	}
}
