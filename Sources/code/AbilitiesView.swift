import TokamakShim

struct AbilitiesView: View {
	@EnvironmentObject private var player: Player

	var body: some View {
		Section(header: Text("Abilities").font(.title)) {
			Button(player.pointBuy ? "Roll setup" : "Point Buy setup") {
				player.character.resetAbilities()
				player.pointBuy.toggle()
				if !player.pointBuy {
					player.character.randomizeAbilities()
				}
			}
			if player.pointBuy {
				PointsView(points: $player.character.abilityPoints.available, min: DnD.Character.pointRange.lowerBound, steps: [-5, -1, 1, 5])
				Text("Bonus: \(player.character.abilityPoints.bonus)")
				Text("Spent: \(player.character.abilityPoints.spent)")
				ForEach(player.character.abilities.indices) { index in
					let ability = player.character.abilities[index]
					HStack {
						Text(ability.ability.displayName)
						Button("-1") {
							player.character.set(ability: ability.ability, to: ability.points - 1)
						}
						Text("\(player.character.abilities[index].points)")
						Button("+1") {
							player.character.set(ability: ability.ability, to: ability.points + 1)
						}
					}
				}
			} else {
				Button("Randomize") {
					player.character.randomizeAbilities()
				}
				ForEach(player.character.abilities.indices) { index in
					let ability = player.character.abilities[index]
					Text("\(ability.ability.displayName) - \(ability.points)")
				}
			}
		}
		.navigationTitle("Abilities")
	}
}
