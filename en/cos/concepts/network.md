# Specifics of working with the network

In {{ coi }}, {% if lang == "ru" %}[Docker containers](/blog/posts/2022/03/docker-containers){% else %}Docker containers{% endif %} are run using a host's network interface. All ports opened in a Docker container will also be opened on the host.

All host ports have access to the internet. This lets you automatically access the ports of a running Docker container.