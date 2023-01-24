import Foundation

extension DnD.Character {
	enum Gender: String, Identifiable, CaseIterable, Displayable {
		case male
		case female
		
		var id: Self {
			self
		}
		
		var displayName: String {
			rawValue.capitalized
		}
	}
}
