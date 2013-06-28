#!/usr/bin/env python
# -*- coding: utf-8 -*-

#
# For overkill example see virtualenv.py.
# By convention, please indent with tabs not spaces

# @author awong
#
"""Prompt an "ssh_menu" on frodo for convenience logins to the servers of Arvato clients
"""

import sys
import os

try:
	# import C implementation of ElementTree for perf reasons
	import xml.etree.cElementTree as ET
except ImportError:
	import xml.etree.ElementTree as ET

#import optparse
#import re
#import shutil
import logging
# import tempfile
# import distutils.sysconfig

SSU_MENU_VERSION = "1.0.0"



class Client:
	def __init__(self, id, name, environments):
		self.id = id
		self.name = name
		self.environments = environments

class Environment:
	def __init__(self, name, servers):
		self.name = name
		self.servers = servers

class Server:
	def __init__(self, hostname, username, password, description):
		self.hostname = hostname
		self.username = username
		self.password = password
		self.description = description

"""
Below is the functionality for the main program
"""
# SSH_MENU_XML = "ssh_menu.xml"
SSH_MENU_XML = "test.xml"

def log(msg):
	print(msg)

def xml_2_clients(document):
	log("BEGIN xml_2_clients")
	# load <clients>
	# for each client, load <environment>
	# for each environment, load <server>
	# return an array of Client, that is fully initialized from the XML
	clients = []
	clientElements = document.findall('client')
	for clientElement in clientElements:
		id = clientElement.get('id')
		clientName = clientElement.get('name')
		environments = []
		environmentElements = clientElement.findall('environment')
		for environmentElement in environmentElements:
			environmentName = environmentElement.get('name')
			serverElements = environmentElement.findall('server')
			servers = []
			for serverElement in serverElements:
				hostname = serverElement.get('hostname')
				username = serverElement.get('username')
				password = serverElement.get('password')
				descriptionElement = serverElement.find('description')
				description = ""
				if descriptionElement is not None:
					description = descriptionElement.text
				server = Server(hostname, username, password, description)
				servers.append(server)
			environment = Environment(environmentName, servers)
			environments.append(environment)
		client = Client(id, clientName, environments)
		clients.append(client)
	return clients 


def load_xml():
	log("BEGIN load_xml")
	tree = ET.parse(SSH_MENU_XML)
	document = tree.getroot()
	return document

def present_menu(clients):
	log("BEGIN present_menu for " + str(len(clients))  + " clients")
	for client in clients:
		print client.id, client.name

def main():
	document = load_xml()
	clients = xml_2_clients(document)
	
	present_menu(clients)
	
if __name__ == '__main__':
	main()

