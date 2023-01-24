import TokamakShim

struct PointsView: View {
	@Binding var points: Int
	let min: Int
	var max: Int? = nil
	var steps = [-1, 1]
	
	var body: some View {
		HStack {
			ForEach(steps.filter({ $0 < 0 }), id: \.self) { step in
				Button("\(step)") {
					guard points > min else {
						return
					}
					points += step
				}
			}
			Text("\(points)")
			ForEach(steps.filter({ $0 > 0 }), id: \.self) { step in
				Button("+\(step)") {
					if let max, points + step > max {
						return
					}
					points += step
				}
			}
		}
	}
}

struct SetupCharacterView: View {
	@StateObject private var player = Player()
	
	var body: some View {
		NavigationView {
			List {
				NavigationLink("Basic", destination: BasicView())
				NavigationLink("Abilities", destination: AbilitiesView())
				NavigationLink("Skills", destination: SkillsView())
				NavigationLink("Feats", destination: FeatsView())
				NavigationLink("Shop", destination: ShopView())
				NavigationLink("Equipment", destination: EquipmentView())
			}
			.navigationTitle("DnDBuilder")
		}
		.environmentObject(player)
	}
}

