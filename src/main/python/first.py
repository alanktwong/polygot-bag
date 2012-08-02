# -*- coding: utf-8 -*-

def whatIsFavoriteColor():
	print "what is your favorite color?"
	return "yellow"
	
def fib(n):
	"""Print a Fibonacci series up to n."""
	a, b = 0, 1
	while a < n:
		print a,
		a, b = b, a+b

def fib2(n): # return Fibonacci series up to n
	"""Return a list containing the Fibonacci series up to n."""
	result = []
	a, b = 0, 1
	while a < n:
		result.append(a)    # see below
		a, b = b, a+b
	return result

def whatever(x):
	if x < 0:
	     x = 0
	     print 'Negative changed to zero'
	elif x == 0:
	     print 'Zero'
	elif x == 1:
	     print 'Single'
	else:
	     print 'More'
	
	# Measure some strings:
	a = ['cat', 'window', 'defenestrate']
	for x in a:
	    print x, len(x)
	
	b = ['Mary', 'had', 'a', 'little', 'lamb']
	for i in range(len(b)):
	    print i, b[i]

def ask_ok(prompt, retries=4, complaint='Yes or no, please!'):
	while True:
		ok = raw_input(prompt)
		if ok in ('y', 'ye', 'yes'):
			return True
		if ok in ('n', 'no', 'nop', 'nope'):
			return False
		retries = retries - 1
		if retries < 0:
			raise IOError('refusenik user')
		print complaint

def parrot(voltage, state='a stiff', action='voom', type='Norwegian Blue'):
	print "-- This parrot wouldn't", action,
	print "if you put", voltage, "volts through it."
	print "-- Lovely plumage, the", type
	print "-- It's", state, "!"


def cheeseshop(kind, *arguments, **keywords):
	print "-- Do you have any", kind, "?"
	print "-- I'm sorry, we're all out of", kind
	for arg in arguments:
		print arg
	print "-" * 40
	keys = sorted(keywords.keys())
	for kw in keys:
		print kw, ":", keywords[kw]

def make_incrementor(n):
	return lambda x: x + n