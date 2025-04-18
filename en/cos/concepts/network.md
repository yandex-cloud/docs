# Working with the network

In {{ coi }}, Docker containers run using a host network interface. All ports opened in a Docker container will also be opened on the host.

All host ports have internet access, enabling you to automatically access the ports of a running Docker container.

## Use cases {#examples}

* [{#T}](../tutorials/serial-port.md)
* [{#T}](../tutorials/deploy-app-container.md)
* [{#T}](../tutorials/coi-fluent-bit-logging.md)
