import TokamakShim

protocol Displayable {
	var displayName: String { get }
}

protocol DiceRoller {
	func roll(_ times: Int, d dice: Int) -> Int
}

extension DiceRoller {
	func roll(_ times: Int = 1, d dice: Int = 20) -> Int {
		let range = 1...dice
		var sum = 0
		for _ in 0..<times {
			sum += Int.random(in: range)
		}
		return sum
	}
}

struct DnD {}

class Player: ObservableObject {
	@Published var character = DnD.Character()
	@Published var pointBuy = false
}
