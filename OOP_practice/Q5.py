class Vehicle:

    def __init__(self, name, max_speed, mileage):
        self.name = name
        self.max_speed = max_speed
        self.mileage = mileage
    
    def print_color(self, color = 'white'):
        return f"The color of the {self.name} is {color}"

class Bus(Vehicle):
    def print_color(self, color = 'yellow'):
        return super().print_color(color)

class Car(Vehicle):
    pass

bus = Bus("School Volvo", 180, 12)

print(bus.print_color())