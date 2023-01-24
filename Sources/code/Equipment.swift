import Foundation

extension DnD {
	enum Equipment: String, CaseIterable, Identifiable, Displayable {
		struct Properties {
			enum Group {
				case general
				case weapons
				case armor
			}
			
			enum Subgroup {
				case adventure
				case special
				case tools
				case cloths
				case food
				case mounts
				case transport
				case spellcasting
			}
			
			let group: Group
			let subgroup: Subgroup?
			let weight: Double
			let cost: Int?
			
			init(group: Group = .general, subgroup: Subgroup? = nil, weight: Double = 0, cost: Int? = nil, unit: Money.Unit = .gold) {
				self.group = group
				self.subgroup = subgroup
				self.weight = weight
				if let cost {
					self.cost = cost * unit.rawValue
				} else {
					self.cost = cost
				}
			}
		}
		
		struct WeaponProperties {
			enum Training {
				case simple
				case martial
				case exotic
			}
			
			enum Use {
				case melee
				case reach
				case double
				case thrown
				case projectile
				case ammunition
			}
			
			enum Encumbrance {
				case light
				case oneHanded
				case twoHanded
			}
			
			struct Critical {
				let main: Int
				let secondary: Int?
				let threat: ClosedRange<Int>?
				
				init(_ main: Int, secondary: Int? = nil, threat: ClosedRange<Int>? = nil) {
					self.main = main
					self.secondary = secondary
					self.threat = threat
				}
			}
			
			struct SizeCategories {
				enum SizeCategory {
					case fine
					case diminutive
					case tiny
					case small
					case medium
					case large
					case huge
					case gargantuan
					case colossal
				}
				
				let main: SizeCategory
				let secondary: SizeCategory?
				
				init(_ main: SizeCategory, secondary: SizeCategory? = nil) {
					self.main = main
					self.secondary = secondary
				}
			}
			
			struct DamageTypes {
				enum DamageType {
					case bludgeoning
					case piercing
					case slashing
				}
				
				enum Relationship {
					case additional
					case alternative
				}
				
				let main: DamageType
				let secondary: DamageType?
				let relationship: Relationship
				
				init(_ main: DamageType, secondary: DamageType? = nil, relationship: Relationship = .additional) {
					self.main = main
					self.secondary = secondary
					self.relationship = relationship
				}
			}
			
			let training: Training?
			let use: Use
			let lethal: Bool
			let critical: Critical?
			let rangeIncrement: Int?
			let encumberance: Encumbrance?
			let sizeCategories: SizeCategories?
			let damageTypes: DamageTypes?
			
			init(training: Training? = nil, use: Use = .melee, lethal: Bool = true, critical: Critical? = nil, rangeIncrement: Int? = nil, encumberance: Encumbrance? = nil, sizeCategories: SizeCategories? = nil, damageTypes: DamageTypes? = nil) {
				self.training = training
				self.use = use
				self.lethal = lethal
				self.critical = critical
				self.rangeIncrement = rangeIncrement
				self.encumberance = encumberance
				self.sizeCategories = sizeCategories
				self.damageTypes = damageTypes
			}
		}
		
		struct ArmorProperties {
			enum ArmorType {
				case armor
				case shiled
			}
			
			enum Category {
				case light
				case medium
				case heavy
			}
			
			let type: ArmorType
			let bonus: Int?
			let maxDexterityBonus: Int?
			let armorCheckPenalty: Int
			let arcaneSpellFailureChance: Double
			let category: Category?
			
			init(type: ArmorType = .armor, bonus: Int? = nil, maxDexterityBonus: Int? = nil, armorCheckPenalty: Int = 0, arcaneSpellFailureChance: Double = 0, category: Category? = nil) {
				self.type = type
				self.bonus = bonus
				self.maxDexterityBonus = maxDexterityBonus
				self.armorCheckPenalty = armorCheckPenalty
				self.arcaneSpellFailureChance = arcaneSpellFailureChance
				self.category = category
			}
		}
		
		case arrow
		case orcDoubleAxe
		case bolas
		case crossbowBolt
		case repeatingCrossbowBolt
		
		case unarmedStrike
		
		case bandedMail
		case armorSpikes
		case shieldSpikes
		
		case caltrops
		
		var id: Self {
			self
		}
		
		var displayName: String {
			switch self {
			case .orcDoubleAxe: return "Orc Double Axe"
			case .crossbowBolt: return "Crossbow Bolt"
			case .repeatingCrossbowBolt: return "Repeating Crossbow Bolt"
				
			case .unarmedStrike: return "Unarmed Strike"
				
			case .bandedMail: return "Banded Mail"
			case .armorSpikes: return "Armor Spikes"
			case .shieldSpikes: return "Shield Spikes"
			default: return rawValue.capitalized
			}
		}
		
		var properties: Properties {
			switch self {
			case .arrow: return .init(group: .weapons, weight: 0.15, cost: 5, unit: .silver)
			case .orcDoubleAxe: return .init(group: .weapons, weight: 7.5, cost: 60)
			case .bolas: return .init(group: .weapons, weight: 1, cost: 5)
			case .crossbowBolt: return .init(group: .weapons, weight: 0.1, cost: 10, unit: .silver)
			case .repeatingCrossbowBolt: return .init(group: .weapons, weight: 0.2, cost: 20, unit: .silver)
				
			case .unarmedStrike: return .init(group: .weapons)
				
			case .bandedMail: return .init(group: .armor, weight: 17.5, cost: 250)
			case .armorSpikes: return .init(group: .armor, weight: 5, cost: 50)
			case .shieldSpikes: return .init(group: .armor, weight: 2.5, cost: 10)
				
			case .caltrops: return .init(subgroup: .adventure, weight: 2, cost: 1)
			}
		}
		
		var weaponProperties: WeaponProperties? {
			switch self {
			case .arrow, .crossbowBolt, .repeatingCrossbowBolt: return .init(use: .ammunition)
			case .orcDoubleAxe: return .init(training: .exotic, critical: .init(3, secondary: 3), encumberance: .twoHanded, sizeCategories: .init(.large, secondary: .large), damageTypes: .init(.slashing))
			case .bolas: return .init(training: .exotic, use: .thrown, lethal: false, critical: .init(2), rangeIncrement: 10, sizeCategories: .init(.tiny), damageTypes: .init(.bludgeoning))
				
			case .unarmedStrike: return .init(training: .simple, lethal: false, critical: .init(2), sizeCategories: .init(.diminutive), damageTypes: .init(.bludgeoning))
			default: return nil
			}
		}
		
		var armorProperties: ArmorProperties? {
			switch self {
			case .bandedMail: return .init(bonus: 6, maxDexterityBonus: 1, armorCheckPenalty: -6, arcaneSpellFailureChance: 0.35, category: .heavy)
			default: return nil
			}
		}
	}
}

extension DnD.Character {
	struct Equipment: Identifiable {
		let id = UUID()
		let equipment: DnD.Equipment
		var amount = 1
	}
}
