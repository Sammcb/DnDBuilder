import Foundation

extension DnD {
	enum Language: String {
		case abyssal
		case aquan
		case auran
		case celestial
		case common
		case draconic
		case druidic
		case dwarven
		case elven
		case giant
		case gnome
		case goblin
		case gnoll
		case halfling
		case ignan
		case infernal
		case orc
		case sylvan
		case terran
		case undercommon
		
		var secret: Bool {
			self == .druidic
		}
	}
}
