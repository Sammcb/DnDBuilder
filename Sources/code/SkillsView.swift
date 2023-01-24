import TokamakShim

struct SkillsView: View {
	@EnvironmentObject private var player: Player
	
	var body: some View {
		Section(header: Text("Skills").font(.title)) {
			PointsView(points: $player.character.skillPoints.available, min: DnD.Character.pointRange.lowerBound)
			Text("Bonus: \(player.character.featPoints.bonus)")
			ForEach(player.character.skills.indices) { index in
				HStack {
					let needsType = player.character.skills[index].skill.needsType
					let type = needsType ? " (\(player.character.skills[index].type))" : ""
					Text("\(player.character.skills[index].skill.displayName)\(type)")
					PointsView(points: $player.character.skills[index].points, min: DnD.Character.Skill.pointRange.lowerBound)
					if needsType {
						TextField("Type", text: $player.character.skills[index].type)
					}
				}
			}
		}
		.navigationTitle("Skills")
	}
}
