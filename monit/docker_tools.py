#!/usr/bin/env python3
 #
# Docker_tools.
#

import docker

class Docker_tools:

  ## list running containers, similar to : docker ps -f status=running --format "{{.Names}}"
  def ps( self ):
    # init.
    list = []
    # get client
    client = docker.from_env()
    # get running containers
    for container in client.containers.list():
      list.append(container.name)
    # close all adapters
    client.close()
    # get running containers
    return list

  ## list containers ports
  def pc( self ):
    # init.
    list = []
    # get client
    client = docker.from_env()
    # get running containers
    for container in client.containers.list():
      list.append([container.name, container.ports])
    # close all adapters
    client.close()
    # get running containers
    return list

  ## list unhealthy containers
  def unhealthy( self ):
    # init.
    list = []
    # get client
    client = docker.from_env()
    # get running containers
    unhealthy_containers = client.containers.list(filters={'health':'unhealthy'})
    for container in unhealthy_containers:
      list.append(container.name)
    # close all adapters
    client.close()
    # get running containers
    return list
