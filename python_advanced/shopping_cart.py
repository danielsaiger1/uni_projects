#####################
#                   #
#   Daniel Saiger   #
#                   #
#####################

import datetime as dt

items = []
shopping_cart = []
price_floor = 5.00


def log_transaction(func):
    """
    Decorator, um Laufzeizt von Funktionen zu loggen.
    
    :param func: Die zu dekorierende Funktion.
    :return: Die dekorierte Funktion mit Logging.
    """
    def wrapper(*args, **kwargs):
        start_time = dt.datetime.now()
        print(f"Transaktion gestartet: {func.__name__} um {start_time}")
        result = func(*args, **kwargs)
        end_time = dt.datetime.now()
        print(f"Transaktion abgeschlossen: {func.__name__} um {end_time}")
        return result
    return wrapper


@log_transaction
def add_item(name: str, price = 10.00, category = 'General') -> None:
    """
    Fügt ein Item mit angegebenem Namen, Preis und Kategorie zum Warenkorb hinzu.

    Parameters
    ----------
    name : str
        Der Name des Items, das hinzugefügt werden soll.
    price : float, int
        Preis des Items. Standardwert: 10,00€.
    category : str, optional
        Kategorie des Items. Standardwert: "General".

    Returns
    -------
    None
        Diese Funktion gibt keinen Wert zurück.
    """
    item = (name, price, category)
    items.append(item)
    shopping_cart.append(list(item))
    print(f"{name} has been added to the cart")

@log_transaction

def calculate_discounted_price(discount_rate:float,/,*extra_discounts:float):
    """
    Wendet die gegebenen Rabatte auf den Preis der Items an.

    Parameters
    ----------
    price : float
        Der ursprüngliche Preis des Items
    discount_rate : float
        Der Rabattprozentsatz, der auf den Preis angewendet werden soll
    extra_discounts : float
        Zusätzliche Rabatte, die angewendet werden sollen (optional)

    Returns
    -------
    float
        Der rabattierte Preis, auf zwei Nachkommastellen gerundet.
    """
    for item in shopping_cart:
        initial_price = item[1]
        discounted_price = initial_price * (1 - discount_rate)
        for additional_discount in extra_discounts:
            discounted_price *= (1 - additional_discount)
        item[1] = round(discounted_price, 2)


@log_transaction
def shopping_cart_total(items:list[list]) -> float|int:
    """
    Berechnet den Gesamtpreis des Warenkorbs. Falls ein Preis unter dem gegebenen Mindestpreis
    liegen sollte, wird dieser auf den Mindestpreis gesetzt.

    Parameters
    ----------
    cart : list
        Liste der Items im Warenkorb, aus denen der Gesamtpreis berechnet werden soll
    min_price : float, optional
        Der Mindestpreis, unter dem kein Artikel verkauft wird

    Returns
    -------
    float
        Die Gesamtsumme der Artikelpreise im Warenkorb, auf zwei Nachkommastellen gerundet
    """
    shopping_cart_total = lambda items: sum(max(i[1], price_floor) for i in items)
    #print(f"Total price: {shopping_cart_total(shopping_cart)}")
    return shopping_cart_total(items)


def generate_receipt(items:list[list]):
    """
    Erstellt den Beleg für den Warenkorb.

    Das Total wird erneut berechnet, da bei der Verwendung von shopping_cart_total
    der Decorator von shopping_cart_total nochmal ausgeführt werden würde

    Parameters
    ----------
    cart : list 
        Liste der Items im Warenkorb, für die der Beleg generiert werden soll
    total : float
        Die Gesamtsumme der Artikelpreise im Warenkorb

    Returns
    -------
    String
        Zuordnung Produkt zu Preis
    """
    total = 0
    for i in items:
        if i[1] < price_floor:
            i[1] = price_floor
        total += i[1]
        yield f"{i[0]}: {i[1]} €"
    print(f'-----------\nTotal: {total} €')


def main():
    add_item("Laptop", 799.99, "Electronics")
    add_item("Book", 15.00)
    add_item("Pen",)
    add_item("Paper", 4.98, 'Office Supplies')

    print(f'Your Items: {items}')

    calculate_discounted_price(0.1, 0.05, 0.02)

    print(f'Total Price after discounts: {shopping_cart_total(shopping_cart)} €')

    print('###Your Receipt### ')

    receipt = generate_receipt(shopping_cart)
    while True:
        try:
            print (next(receipt))
        except StopIteration:
            break


if __name__ == "__main__":
    main()





