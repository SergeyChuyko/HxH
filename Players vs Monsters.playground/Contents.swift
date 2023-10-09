import Foundation

class Creature {
    var attack: Int
    var defense: Int
    var health: Int
    var damageRange: ClosedRange<Int>

    init(attack: Int, defense: Int, health: Int, damageRange: ClosedRange<Int>) {
        self.attack = min(max(attack, 1), 30)
        self.defense = min(max(defense, 1), 30)
        self.health = health
        self.damageRange = damageRange
    }

    func attack(target: Creature) {
        print("\(type(of: self)) атакует \(type(of: target))!")
        let attackModifier = max(attack - target.defense + 1, 1)
        let numberOfDice = attackModifier
        var totalDamage = 0
        var attackSuccessful = false
        
        for _ in 1...numberOfDice {
            let diceRoll = Int.random(in: 1...6)
            if diceRoll >= 5 {
                let damage = Int.random(in: damageRange)
                totalDamage += damage
                attackSuccessful = true
                print("Успешная атака! \(type(of: target)) получает \(damage) урона.")
            }
        }

        if attackSuccessful {
            target.takeDamage(amount: totalDamage)
        } else {
            print("Атака не наносит урона \(type(of: target)).")
        }
    }

    func takeDamage(amount: Int) {
        health -= amount
        if health < 0 {
            health = 0
        }
        print("\(type(of: self)) получает урон: \(amount). Текущее здоровье: \(health)")
    }

    func heal() {
        let maxHeal = Int(Double(health) * 0.3)
        let healAmount = Int.random(in: 1...maxHeal)
        health += healAmount
        if health > 100 {
            health = 100
        }
        print("\(type(of: self)) исцеляется на \(healAmount) единиц. Текущее здоровье: \(health)")
    }
}


class Player: Creature {
    func selfHeal() {
        heal()
    }
}

class Monster: Creature {
}

let player = Player(attack: 25, defense: 20, health: 100, damageRange: 1...6)
let monster = Monster(attack: 20, defense: 15, health: 80, damageRange: 2...8)

player.attack(target: monster)
monster.attack(target: player)
monster.attack(target: player)
monster.attack(target: player)
monster.attack(target: player)


player.selfHeal()


print("")
print("Финальные результаты:")
print("здоровье игрока: \(player.health)")
print("здоровье монстра: \(monster.health)")
