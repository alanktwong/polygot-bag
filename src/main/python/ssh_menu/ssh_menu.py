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
# SSH_MENU_XML = "ssh_menu.xml"
SSH_MENU_XML = "test.xml"


class Common:
	def __init__(self, id, name):
		self.id = id
		self.name = name

class Client(Common):
	def __init__(self, id, name, environments):
		Common.__init__(self, id, name)
		self.environments = environments

class Environment(Common):
	def __init__(self, id, name, servers):
		Common.__init__(self, id, name)
		self.servers = servers

class Server(Common):
	def __init__(self, id, hostname, username, password, description):
		Common.__init__(self, id, hostname)
		self.hostname = hostname
		self.username = username
		self.password = password
		self.description = description

"""
Below is the functionality for the main program
"""

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
	clientId = 1
	for clientElement in clientElements:
		clientName = clientElement.get('name')
		environments = []
		environmentElements = clientElement.findall('environment')
		envId = 1
		for environmentElement in environmentElements:
			environmentName = environmentElement.get('name')
			serverElements = environmentElement.findall('server')
			servers = []
			serverId = 1
			for serverElement in serverElements:
				hostname = serverElement.get('hostname')
				username = serverElement.get('username')
				password = serverElement.get('password')
				descriptionElement = serverElement.find('description')
				description = ""
				if descriptionElement is not None:
					description = descriptionElement.text
				server = Server(serverId, hostname, username, password, description)
				servers.append(server)
				serverId = serverId + 1
			environment = Environment(envId, environmentName, servers)
			environments.append(environment)
			envId = envId + 1
		client = Client(clientId, clientName, environments)
		clients.append(client)
		clientId = clientId + 1
	return clients 


def load_xml():
	log("BEGIN load_xml")
	tree = ET.parse(SSH_MENU_XML)
	document = tree.getroot()
	return document

def create_clients():
	document = load_xml()
	clients = xml_2_clients(document)
	return clients

def ssh_connect_to(server):
	# // To transfer all the files from a remote directory to a folder on the local machine
	# scp -rpC  {username}@{hostname}:{/path/to/remote/directory} .
	command = "sshpass -p " + server.password +" ssh " + server.username + "@" + server.hostname
	os.system(command)
	# exit python process

def select_from(list, prompt):
	selected = None
	while True:
		for each in list:
			print each.id, each.name
		
		entry = raw_input(prompt)
		is_blank = len(entry.strip()) <= 0
		if (is_blank):
			break
		else:
			entry = entry.strip()
			selecteds = filter_common(list, entry)
			if len(selecteds) > 0:
				selected = selecteds[0]
				log("SELECTED: " + selected.name)
				break
	return selected
	
def filter_common(menu_items, entry):
	# convert menu_item.id to string
	filtered = [menu_item for menu_item in menu_items if (str(menu_item.id) == entry or menu_item.name == entry)]
	return filtered


def present_menu(clients):
	log("BEGIN present_menu for " + str(len(clients))  + " clients \n")
	# http://stackoverflow.com/questions/70797/python-and-user-input

	selected_client = select_from(clients, "Choose a client (<ENTER> exits): ")
	# selected_environments = [enviroment for enviroment in selected_client.enviroments if (enviroment.name == entry)]
	selected_environment = None
	selected_server = None
	if selected_client is not None:
		selected_environment = select_from(selected_client.environments, "Choose an environment (<ENTER> exits): ")
		if selected_environment is not None:
			selected_server = select_from(selected_environment.servers, "Choose a server (<ENTER> exits): ")
	return (selected_client, selected_environment, selected_server)

def filterbyvalue(seq, value):
	for el in seq:
		if el.attribute==value: yield el

def main():
	clients = create_clients
	(client,environment,server) = present_menu(clients)
	# now use selection to ssh
	ssh_connect_to(server)
	
if __name__ == '__main__':
	main()

