import Foundation

extension DnD {
	enum Skill: String, CaseIterable, Identifiable, Displayable {
		case appraise
		case balance
		case bluff
		case climb
		case concentration
		case craft
		case decipherScript
		case diplomacy
		case disableDevice
		case disguise
		case escapeArtist
		case forgery
		case gatherInformation
		case handleAnimal
		case heal
		case hide
		case intimidate
		case jump
		case knowledge
		case listen
		case moveSilently
		
		var id: Self {
			self
		}
		
		var displayName: String {
			switch self {
			case .decipherScript: return "Decipher Script"
			case .disableDevice: return "Disable Device"
			case .escapeArtist: return "Escape Artist"
			case .gatherInformation: return "Gather Information"
			case .handleAnimal: return "Handle Animal"
			default: return rawValue.capitalized
			}
		}
		
		var trained: Bool {
			switch self {
			case .decipherScript, .disableDevice, .handleAnimal, .knowledge: return true
			default: return false
			}
		}
		
		var needsType: Bool {
			switch self {
			case .craft, .knowledge: return true
			default: return false
			}
		}
	}
}

extension DnD.Character {
	struct Skill: Identifiable {
		static let pointRange = 0...
		
		let id = UUID()
		let skill: DnD.Skill
		var type = ""
		var points = 0
		
		init(_ skill: DnD.Skill) {
			self.skill = skill
		}
	}
}
