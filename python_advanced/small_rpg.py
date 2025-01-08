
""""
Daniel Saiger
"""


from abc import ABC, abstractmethod
from dataclasses import dataclass
import random   
import time
from enum import Enum



def delay(seconds: int|float):
    """
    Decorator to delay the execution of a function by a specified number of seconds.
        
    Args:
        seconds (int): Number of seconds to delay the function execution.
    """
    def inner(func): 
        def wrapper(*args, **kwargs):
            time.sleep(seconds)
            return func(*args, **kwargs)
        return wrapper
    return inner



class Character(ABC):
    """
    Abstract base class representing a generic character in the game.
    """
    default_health = 100

    def __init__(self, name: str, health:int, power: int) -> None:
        self.name = name
        self._health = health if health is not None else Character.default_health
        self.power = power
        self.weapon = None

    @property
    def health(self) -> int:
        return self._health

    @health.setter
    def health(self, value: int) -> None:
        self._health = max(0, value)  # ist nicht kleiner als null

    @abstractmethod
    def attack(self, target: "Character") -> None:
        """
        Abstract method for attacking a target. Must be implemented by subclasses.
        
        Args:
            target (Character): The target being attacked.
        """
        pass

    @abstractmethod
    def defend(self, damage: int) -> None:
        """
        Abstract method for defending against an attack. Must be implemented by subclasses.
        
        Args:
            damage (int): The amount of damage to defend against.
        """
        pass

    def __str__(self):
        return f"{self.name} (HP: {self.health}, Power: {self.power})"

    def __repr__(self):
        return f"Character(name={self.name}, health={self.health}, power={self.power}, weapon={self.weapon})"


@dataclass
class Weapon:
    """
    Class representing a weapon with attributes for name, damage, and weight.
    """
    name: str
    damage: int | float
    weight: int | float

    def calculate_effect(self) -> int:
        """
        Calculate the effective damage of the weapon based on its weight.

        Example:

        Power = 10
        weapon.damage = 10
        weapon.weight = 5

        --> calculated effect = 10 * (1 + 5/10) = 15
        --> character.damage = 15 + 10 = 25
        
        Returns:
            int: Effective damage of the weapon
        """
        damage = self.damage * (1 + self.weight /10)
        return int(damage)


class PlayerCharacter(Character):
    """
    Class representing a player-controlled character with weapons and attacks.
    """
    def __init__(self, name: str, health: int, power: int = 10, weapon = 'Sword'):
        """
        Initialize a player character with name, health, power, and an optional weapon.
        """
        super().__init__(name, health, power)
        self.weapon = weapon
        self.power = power
        self.weapon = weapon 

    @classmethod
    def from_default(cls, name):
        """
        Create a PlayerCharacter instance with default attributes.
        
        Args:
            name (str): Name of the character.
        
        Returns:
            PlayerCharacter: An instance with default settings.
        """
        
        
        return cls(name=name, health= PlayerCharacter.default_health, power = PlayerCharacter.power, weapon = PlayerCharacter.weapon)
    
    @staticmethod
    def critical_hit() -> bool:
        """
        Determine if the attack is a critical hit.
        
        Returns:
            bool: True if critical hit, False otherwise.
        """
        return random.choice([True, False])

    @delay(0.5)
    def defend(self, damage:int) -> None:
        """
        Reduce the player's health by the given damage.
        
        Args:
            damage (int): Amount of damage taken.
        """
        self.health -= damage
        print(f"{self.name} took {damage} damage, remaining HP: {self.health}")


class MeleeCharacter(PlayerCharacter):
    """
    Subclass of PlayerCharacter specializing in melee attacks.
    """
    @delay(1)
    def attack(self, target):
        """
        Perform a melee attack on a target, considering weapon damage and critical hits
        
        Args:
            target (Character): The target being attacked.
        """
        damage = self.power
        if self.weapon:
            damage += self.weapon.calculate_effect()
        if self.critical_hit():
            print('CRITICAL HIT!')
            damage *= 2
        print(f"{self.name} attacks {target.name} with {self.weapon.name} and deals {damage} damage points (Melee)")
        target.defend(damage)

class RangedCharacter(PlayerCharacter):
    """
    Subclass of PlayerCharacter specializing in ranged attacks.
    """
    @delay(1)
    def attack(self, target):
        """
        Perform a ranged attack on a target, considering weapon damage and critical hits.
        
        Args:
            target (Character): The target being attacked.
        """
        damage = int(self.power * 0.7)
        if self.weapon:
            damage += self.weapon.calculate_effect()
        if self.critical_hit():
            print('CRITICAL HIT!')
            damage *= 2
        print(f"{self.name} attacks {target.name} with {self.weapon.name} and deals {damage} damage points (Ranged)")
        target.defend(damage)

class MagicUser:
    """
    Mixin class to add magic abilities to a character.
    """
    def cast_spell(self, target):
        """
        Cast a magical spell on a target, dealing double the character's power as damage
        
        Args:
            target (Character): The target of the spell.
        """
        magical_damage = self.power * 2
        print(f"{self.name} casts a spell on {target.name}, dealing {magical_damage} damage")
        target.defend(magical_damage)


class SummonerCharacter(PlayerCharacter, MagicUser):
    """
    Subclass of PlayerCharacter that can perform both melee attacks and cast spells.
    """
    @delay(1)
    def attack(self, target):
        """
        Perform either a melee attack or cast a spell on a target based on random chance.
        
        Args:
            target (Character): The target being attacked.
        """
        if random.choice([0,1]) == 0: # decides if normal melee attack or spell attack. 0 = melee, 1 = spell
            damage = self.power
            if self.weapon:
                damage += self.weapon.calculate_effect()
            if self.critical_hit():
                damage *= 2
            print(f"{self.name} attacks {target.name} with {self.weapon.name} and deals {damage} damage (Melee)")
            target.defend(damage)
        else:
            self.cast_spell(target)

class NPC(Character):
    """
    Class representing a NPC
    """
    def __init__(self, name: str, health: int, power: int, npc_type:str):
        """
        Initialize an NPC with name, health, power, and type.
        
        Args:
            name (str): Name of the NPC.
            health (Optional[int]): Health points of the NPC. Defaults to 100 if not provided.
            power (int): Power level of the NPC.
            npc_type (Optional[str]): Type of the NPC.
        """
        super().__init__(name, health, power)
        self.npc_type = npc_type

    @delay(0.5)
    def taunt(self):
        """
        NPC taunts the player with a provocative message.
        """
        return print(f"{self.name} the {self.npc_type} calls you an coward!")
    
    @delay(1)
    def defend(self, damage: int) -> None:
        """
        Reduce the NPC's health by the given damage.
        
        Args:
            damage (int): Amount of damage taken.
        """
        self.health -= damage
        print(f"{self.name} took {damage} damage, remaining HP: {self.health}")

    @delay(1)
    def attack(self, target: Character) -> None:
        """
        NPC performs a basic attack on a target, dealing power-based damage
        
        Args:
            target (Character): The target being attacked.
        """
        damage = self.power
        print(f"{self.name} attacks {target.name} and deals {damage} damage points")
        target.defend(damage)

class NpcTypes(Enum):
    """
    Enumeration representing different types of NPCs
    """
    Goblin = 1
    Orc = 2
    Dragon = 3


class CharacterBuilder:
    """
    Builder class for creating custom characters with specific attributes.
    """
    def __init__(self):
        self.name = "Unknown Hero"
        self.health = 100
        self.power = 10
        self.weapon = "Wood Stick"
        self.class_type = None
    
    def set_name(self, name: str) -> "CharacterBuilder":
        self.name = name
        return self
    
    def set_health(self, health: int) -> "CharacterBuilder":
        self.health = health
        return self
    
    def set_damage(self, power: int) -> "CharacterBuilder":
        self.power = power
        return self

    def set_weapon(self, weapon: Weapon) -> "CharacterBuilder":
        self.weapon = weapon
        return self  
    
    def set_class_type(self, class_type: str) -> "CharacterBuilder":
        self.class_type = class_type
        if class_type == "Melee":
            self.health = 150
            self.power = 15
            self.weapon = Weapon(name="Sword", damage = 10, weight = 5)
        elif class_type == "Ranged":
            self.health = 80
            self.power = 25
            self.weapon = Weapon(name="Bow", damage = 15, weight = 3)
        elif class_type == "Summoner":
            self.health = 90
            self.power = 20
            self.weapon = Weapon(name="Sword", damage = 10, weight = 5)
        return self
    
    def get_character(self) -> Character: 
        if self.class_type == "Melee":
            return MeleeCharacter(name=self.name, health=self.health, power=self.power, weapon=self.weapon)
        elif self.class_type == "Ranged":
            return RangedCharacter(name=self.name, health=self.health, power=self.power, weapon=self.weapon)
        elif self.class_type == "Summoner":
            return SummonerCharacter(name=self.name, health=self.health, power=self.power, weapon=self.weapon)
        else:
            raise ValueError("Class Type not valid.")
    

def create_character():
    """
    Creates the PlayerCharacter based on user input
    """
    # Create instance of CharacterBuilder
    builder = CharacterBuilder()

    # Choose name
    print("Welcome to the Character Creator \n---------------------------------")
    name = input("Please enter the name of your Character \n >: ")
    builder.set_name(name)

    # Choose class
    print("Please choose a class:")
    print("1. Melee")
    print("2. Ranged")
    print("3. Summoner")

    class_choice = input("Enter the number of your desired class \n >: ")

    if class_choice == '1':
        builder.set_class_type("Melee")
        char_type = "melee"
    elif class_choice == '2':
        builder.set_class_type("Ranged")
        char_type = "ranged"
    elif class_choice == '3':
        builder.set_class_type("Summoner")
        char_type = "summoner"
    else:
        print("Invalid choice")
        return None

    character = builder.get_character()
    print(f"{character.name} the {char_type} hero has been created!")
    return character

class Arena:
    """
    Class which represents the arena where the battle is happening
    """
    @delay(1)
    def random_heal(self, char = Character) -> None:
        """
        Randomly heals a character for a value between 10 and 30 HP.
        
        Args:
            char (Character): The character to be healed.
        """
        if random.choice([0,1]) == 1: # 1 = heal, 0 = no Heal
            heal = random.randint(10,30)
            char.health += heal  #Random heal between 10 and 30
            print(f"{char.name} has been healed for {heal} HP. Current HP: {char.health}")

    @delay(1)
    def find_new_weapon(self, char):
        """
        Randomly upgrades a character's weapon with a increase in damage and weight.
        
        Args:
            char (Character): The character who may find a new weapon
        """
        if random.choice([0,1]) == 1: # 1 = find new weapon, 0 = don't find new weapon
            new_weapon = Weapon(
                name = char.weapon.name, 
                damage=int(char.weapon.damage * 1.05), 
                weight=char.weapon.weight + 1
            ) # New weapon gains 5% more damage and 1 more weight per round
            char.weapon = new_weapon
            print(f"{char.name} found a stronger {char.weapon.name}")

    @delay(1)
    def battle(self, player: PlayerCharacter, npc: NPC) -> None:
        """
        Conducts a battle between the player and an NPC.
        
        Args:
            player (PlayerCharacter): The player character involved in the battle.
            npc (NPC): The non-player character involved in the battle.
        """

        print(f"{player.name} is competing against {npc.name} the {npc.npc_type}")

        while player.health > 0 and npc.health > 0:
            player.attack(npc)

            if npc.health <= 0:
                print(f"{npc.name} has been defeated!")
                break

            if random.choice([0,1]) == 1: # 1 = taunt, 0 = no taunt
                npc.taunt() 

            npc.attack(player)

            if player.health <= 0:
                print(f"{player.name} has been defeated!")
                break
        
        print('The battle is over! \n-----------------------------------------')


    def episodic_battle(self, player: PlayerCharacter) -> None:
        """
        Runs multiple battles until the player is defeated
        
        Args:
            player (PlayerCharacter): The player character involved in the episodic battles.
        """
        battle_counter = 0
        random_int = random.randint(1, 3) 
        names = ['Olaf', 'Erik', 'Bjorn']
        rand_npc_type = str(NPC_types(random_int).name)
        rand_npc_name = names[random_int-1]
        if rand_npc_type == 'Dragon':
            npc = NPC(name=rand_npc_name, health=100, power=1000, npc_type=rand_npc_type) #Dragon is oneshot, because no one wins against a dragon
        else:
            npc = NPC(name=rand_npc_name, health=100, power=10, npc_type=rand_npc_type)

        while player.health > 0:
            print(f"--- Start of Battle {battle_counter + 1} ---")
            
            self.battle(player, npc)

            battle_counter += 1

            if player.health <= 0:
                print(f"After {battle_counter} battles, the hero {player.name} falls!")
                break
            
            # Random heal and random find new weapon
            self.random_heal(player)
            self.find_new_weapon(player)
    
            # Create new NPC for next battle
            random_int = random.randint(1, 3) 
            npc.name = names[random_int-1]
            npc.npc_type = str(NPC_types(random_int).name)
            if npc.npc_type == 'Dragon':
                npc.power = int(npc.power * 1000) # Dragon is oneshot, because nobody wins against a dragon
            else:
                npc.power = int(npc.power * 1.20)  # Scale NPC power by +20%
            npc.health = 100  # Reset NPC health        


def main():
    # Create a player character with a weapon
    player = create_character()

    # Create an instance of the Arena
    arena = Arena()

    def start_arena():
        """
        Starts the arena battle based on user input.
        """
        choice = input("Are you ready to start the battle (Y/N)? \n :> ")
        if choice in ("Y", "y"):
            arena.episodic_battle(player)
        elif choice in ("N", "n"):
            print("game has been cancelled")
        else:
            print("invalid input")

    #start battle
    start_arena()

if __name__ == "__main__":
    main()





