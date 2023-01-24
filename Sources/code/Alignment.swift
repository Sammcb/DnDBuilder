import Foundation

extension DnD.Character {
	enum Alignment: String, Identifiable, CaseIterable, Displayable {
		case lawfulGood
		case neutralGood
		case chaoticGood
		case lawfulNeutral
		case neutralNeutral
		case chaoticNeutral
		case lawfulEvil
		case neutralEvil
		case chaoticEvil
		
		var id: Self {
			self
		}
		
		var displayName: String {
			switch self {
			case .lawfulGood: return "Lawful Good"
			case .neutralGood: return "Neutral Good"
			case .chaoticGood: return "Chaotic Good"
			case .lawfulNeutral: return "Lawful Neutral"
			case .neutralNeutral: return "Neutral Neutral"
			case .chaoticNeutral: return "Chaotic Neutral"
			case .lawfulEvil: return "Lawful Evil"
			case .neutralEvil: return "Neutral Evil"
			case .chaoticEvil: return "Chaotic Evil"
			}
		}
	}
}
