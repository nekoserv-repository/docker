#!/usr/bin/env python3
#
# Check all container ports.
#

# imports
from docker_tools import Docker_tools
import socket


## check every containers
def check_containers():
  # init.
  docker = Docker_tools()
  list = docker.pc()
  is_error = False
  open_list = []
  closed_list = []

  # check every single container
  for container in list:
    # get host
    host = container[0]
    # check all redirections for the container
    for redirections in container[1:]:
      # no redirections, nothing to check
      if redirections == {}:
        continue
      for current_redir in redirections:
        port = current_redir.split('/')[0]
        proto = current_redir.split('/')[1]
        if is_port_open(host, port, proto, open_list, closed_list) == False:
          is_error = True

  # output header
  if is_error == True:
    print('Error : at least one container is not reachable')
  else:
    print('All containers are reachable')

  # output display
  print('-')
  for line in open_list:
    print(line)
  if len(open_list) > 0:
    print('-')
  for line in closed_list:
    print(line)

  # check for errors
  if is_error == True:
    exit(1)
  # everything is okay
  exit(0)


## check if port is open or not
def is_port_open(host, port, proto, open_list, closed_list):
  proto_dict = { "tcp": socket.SOCK_STREAM, "udp": socket.SOCK_DGRAM }
  # check protocol availability
  if proto not in proto_dict:
    print(proto+" is not supported yet")
    return False
  port_and_proto = port+"/"+proto
  # check port
  s = socket.socket(socket.AF_INET, proto_dict[proto])
  try:
    r = s.connect_ex((host, int(port)))
  except:
    closed_list.append("error : "+host+" is NOT reachable on port "+port_and_proto)
    return False
  finally:
    s.close()
  # check results
  if r == 0:
    open_list.append(host+" : port "+port_and_proto+" is open")
    return True
  else:
    closed_list.append(host+" : port "+port_and_proto+" is NOT open")
    return False


## main
if __name__ == '__main__':
  check_containers()
