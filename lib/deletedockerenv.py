#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import docker
import sys
import traceback

errors = []

def pruneImages(client):
    try:
        client.Images.prune()
    except:
        errors.append('pruneImage')
        pass

def pruneContainers(client):
    try:
        client.Containers.prune()
    except:
        errors.append('pruneContainer')
        pass

def removeImage(client, name):
    try:
        client.images.remove(image=name, force=True)
    except:
        errors.append('removeImage')
        pass

def removeNetwork(client, name):
    try:
        client.networks.get(name).remove()
    except:
        errors.append('removeNetwork')
        pass

def removeContainer(client, name):
    try:
        client.containers.get(name).remove()
    except:
        errors.append('removeContainer')
        pass

def stopContainer(client, name):
    try:
        target = client.containers.get(name)
        if target.status == 'running':
            target.stop()
    except:
        errors.append('stopContainer')
        pass

if __name__ == '__main__':
    try:
        if len(sys.argv) != 2:
            print('You only need "Name" argument.')
            sys.exit(1)

        name = sys.argv[1]
        client = docker.from_env()

        stopContainer(client, name)
        removeContainer(client, name)
        removeNetwork(client, name)
        removeImage(client, name)
        pruneContainers(client)
        pruneImages(client)

        if len(errors) > 0:
            for error in errors:
                print(error, file=sys.stderr)
    except:
        pass
