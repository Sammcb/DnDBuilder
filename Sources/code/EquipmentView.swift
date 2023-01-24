import TokamakShim

struct EquipmentView: View {
	@EnvironmentObject private var player: Player
	
	var body: some View {
		Section(header: Text("Equipment").font(.title)) {
			ForEach(player.character.equipment.indices) { index in
				let equipment = player.character.equipment[index]
				Text("\(equipment.equipment.displayName) (\(equipment.amount))")
			}
		}
		.navigationTitle("Equipment")
	}
}
