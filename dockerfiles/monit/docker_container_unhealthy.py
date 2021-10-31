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

  # everything is okay
  if is_error == False:
    print('All containers are healthy')
    exit(0)

  # display unhealthy containers
  print('Error : %d container(s) are not healthy' % len(unhealthy_list))
  print('-')
  for line in unhealthy_list:
    print(line)
  # exit
  exit(1)


## main
if __name__ == '__main__':
  check_containers()
