#!/usr/bin/env python3
#
# Check all unhealthy containers.
#

# imports
from docker_tools import Docker_tools
import socket


## check every containers
def check_containers():
  # init.
  docker = Docker_tools()
  unhealthy_list = docker.unhealthy()
  is_error = False

  # check list
  if len(unhealthy_list) > 0:
    is_error = True

  # output header
  if is_error == True:
    print('Error : at least one container is not healthy')
  else:
    print('All containers are healthy')

  # output display
  if is_error == True:
    print('-')
  for line in unhealthy_list:
    print(line)

  # check for errors
  if is_error == True:
    exit(1)
  # everything is okay
  exit(0)


## main
if __name__ == '__main__':
  check_containers()
