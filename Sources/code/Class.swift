import Foundation

extension DnD.Character {
	enum Class: String, Identifiable, CaseIterable, Displayable {
		case barbarian
		case bard
		case cleric
		case druid
		case fighter
		case monk
		case paladin
		case ranger
		case rogue
		case sorcerer
		case wizard
		
		var id: Self {
			self
		}

		var displayName: String {
			rawValue.capitalized
		}
	}
}
