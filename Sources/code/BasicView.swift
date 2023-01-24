import Foundation
import TokamakShim

struct PickerView: View {
	@Binding var index: Int
	let options: [Displayable]
	let optionTitle: String
	
	var body: some View {
		Picker(optionTitle, selection: $index) {
			Text("Choose \(optionTitle.lowercased())...")
			ForEach(options.indices) { index in
				Text(options[index].displayName)
			}
		}
		Text("\(optionTitle): \(options[index].displayName)")
	}
}

struct BasicView: View {
	@EnvironmentObject private var player: Player
	
	var body: some View {
		Section(header: Text("Basic").font(.title)) {
			HStack {
				VStack {
					TextField("Name", text: $player.character.name)
					TextField("Player", text: $player.character.player)
					TextField("Diety", text: $player.character.diety)
					TextField("Eyes", text: $player.character.eyes)
					TextField("Hair", text: $player.character.hair)
					TextField("Skin", text: $player.character.skin)
					HStack {
						Text("Level")
						PointsView(points: $player.character.level, min: DnD.Character.levelRange.lowerBound, max: DnD.Character.levelRange.upperBound, steps: [1])
					}
				}
				Spacer()
				VStack {
					PickerView(index: $player.character.classIndex, options: DnD.Character.Class.allCases, optionTitle: "Class")
					PickerView(index: $player.character.raceIndex, options: DnD.Character.Race.allCases, optionTitle: "Race")
					PickerView(index: $player.character.alignmentIndex, options: DnD.Character.Alignment.allCases, optionTitle: "Alignment")
					PickerView(index: $player.character.genderIndex, options: DnD.Character.Gender.allCases, optionTitle: "Gender")
				}
			}
		}
		.navigationTitle("Basic")
	}
}
