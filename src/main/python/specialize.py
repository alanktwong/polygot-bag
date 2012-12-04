# -*- coding: utf-8 -*-


# Below is from _Learning Python_, p 691
class Super:								# Super is root of its hierarchy
	def method(self):
		print("in Super.method")
	def delegate(self):
		self.action()						# expected to be defined
	def action(self):
		# assert False, "action must be defined!"
		raise NotImplementedError("Action must be defined")

class Inheritor(Super):						# Inherit method verbatim
	pass

class Replacer(Super):
	def method(self):
		print("In Replacer.method")

class Extender(Super):
	def method(self):
		print("Starting Extender.method")
		Super.method(self)
		print("Ending Extender.method")

class Provider(Super):
	def action(self):
		print("In Provider.action")


if __name__ == '__main__':
	for klass in (Inheritor, Replacer, Extender):
		print('\n' + klass.__name__ + ' ...')
		klass().method()
	print('\n' + "Provider ...")
	x = Provider()
	x.delegate()
	

