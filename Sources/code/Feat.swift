import Foundation

extension DnD {
	enum Feat: String, CaseIterable, Identifiable, Displayable {
		enum Category: String, Displayable {
			case general
			case itemCreation
			case metamagic
			
			var displayName: String {
				switch self {
				case .itemCreation: return "Item Creation"
				default: return rawValue.capitalized
				}
			}
		}
		
		case acrobatic
		case agile
		case alertness
		case animalAffinity
		case armorProtectionLight
		case armorProtectionMedium
		case armorProtectionHeavy
		case athletic
		case augmentSummoning
		case blindFight
		
		var id: Self {
			self
		}
		
		var displayName: String {
			switch self {
			case .animalAffinity: return "Animal Affinity"
			case .armorProtectionLight: return "Armor Protection Light"
			case .armorProtectionMedium: return "Armor Protection Medium"
			case .armorProtectionHeavy: return "Armor Protection Heavy"
			case .augmentSummoning: return "Augment Summoning"
			case .blindFight: return "Blind Fight"
			default: return rawValue.capitalized
			}
		}
		
		var type: Category {
			switch self {
			default: return .general
			}
		}
		
		var fighterBonus: Bool {
			switch self {
			case .blindFight: return true
			default: return false
			}
		}
		
		var wizardBonus: Bool {
			switch self {
			default: return self.type == .itemCreation || self.type == .metamagic
			}
		}
	}
}

extension DnD.Character {
	struct Feat: Identifiable {
		static let pointRange = 0...
		let id = UUID()
		let feat: DnD.Feat
		var points = 0
		
		init(_ feat: DnD.Feat) {
			self.feat = feat
		}
	}
}
