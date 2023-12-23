#!/usr/bin/env python3
#
# Check if all docker containers are running.
#

# imports
from docker_tools import Docker_tools
import os

# init.
container_str = os.getenv('DOCKER_CONTAINER_LIST')
container_list = container_str.split()

docker = Docker_tools()
running_containers = docker.ps()
is_error = False
running_list = []
not_running_list = []

# check env. variable
if container_str == None:
  print('DOCKER_CONTAINER_LIST env. variable not set')
  exit(1)

# check every single container
for container in container_list:
  if container in running_containers:
    running_list.append(container + ' is running')
  else:
    not_running_list.append(container + ' is NOT running')
    is_error = True


# output header
if is_error == True:
  print('Error : at least one container is not running')
else:
  print('All containers are running')


# output display
print('-')
for line in running_list:
  print(line)
if len(running_list) > 0:
  print('-')
for line in not_running_list:
  print(line)


# at leat one container is not running properly
if is_error == True:
  exit(1)


# everything is okay
exit(0)
