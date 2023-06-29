# Load generators

_A load generator_ is a tool that lets you simulate the load on a service based on a given configuration. The testing tools, which is used in {{ load-testing-name }}, uses Pandora and Phantom load generators.

## Pandora {#pandora}

Pandora is the main load generator in {{ load-testing-name }}. Pandora is written in Go and can support more than 100000 concurrent connections and generate a load of up to 90000 simple requests per second. Pandora features built-in testing tools for the following protocols:

* gRPC
* HTTP/2
* HTTP(S)

You can use Pandora as a framework for developing custom versions. This allows you to generate a scenario-based load and to load most protocols that have client libraries written in Go (such as WebSocket, PostgreSQL, or DNS).

## Phantom {#phantom}

A low-level generator for loading applications over HTTP and HTTPS. It can generate more than 100000 requests per seconds and support more than 50000 concurrent connections to a service. It uses vCPU and memory efficiently, but may require a large disk size. To generate the load, Phantom saves all the payloads to be passed to the service during load testing to the disk.