# -*- coding: utf-8 -*-

    
class MixedNames:
    data = 'spam'                            # Assign class attribute
    def __init__(self, value):               # constructor method
        self.data = value                    # Assign instance attribute
    def display(self):
        print(self.data, MixedNames.data)    # Instance attribute, class attribute
    
    def get_data(self):                      # superfluous getter since instance.data access the member
        return self.data
        
    def set_data(self, value):               # superfluous setter since instance.data = value will also mutate the member
        self.data = value
        
class SuperClass:                            # SuperClass is root of its hierarchy
    def __init__(self, x):
        self.x = x
    def method(self):
        print("in SuperClass.method")
    def delegate(self):
        self.action()                        # expected to be defined


class SubClass(SuperClass):                  # SubClass extends SuperClass
    def __init__(self, x, y):
        SuperClass.__init__(self, x)
        self.y = y
    def method(self):                        # Override method
        print("Starting SubClass.method")
        SuperClass.method(self)
        print("Ending SubClass.method")

