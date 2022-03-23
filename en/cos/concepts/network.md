# Specifics of working with the network

In {{ coi }}, Docker containers are run using a host's network interface. All ports opened in a Docker container will also be opened on the host.

All host ports have access to the internet. This lets you automatically access the ports of a running Docker container.