import TokamakShim

struct FeatsView: View {
	@EnvironmentObject private var player: Player
	
	var body: some View {
		Section(header: Text("Feats").font(.title)) {
			PointsView(points: $player.character.featPoints.available, min: DnD.Character.pointRange.lowerBound)
			Text("Bonus: \(player.character.featPoints.bonus)")
			Text("Spent: \(player.character.featPoints.spent)")
			ForEach(player.character.feats.indices) { index in
				HStack {
					Text(player.character.feats[index].feat.displayName)
					PointsView(points: $player.character.feats[index].points, min: DnD.Character.Feat.pointRange.lowerBound)
				}
			}
		}
		.navigationTitle("Feats")
	}
}
