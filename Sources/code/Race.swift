import Foundation

extension DnD.Character {
	enum Race: String, Identifiable, CaseIterable, Displayable {
		case human
		case dwarf
		case elf
		case gnome
		case halfElf
		case halfOrc
		case halfling
		
		var id: Self {
			self
		}
		
		var displayName: String {
			switch self {
			case .human, .dwarf, .elf, .gnome, .halfling: return rawValue.capitalized
			case .halfElf: return "Half-Elf"
			case .halfOrc: return "Half-Orc"
			}
		}
	}
}
