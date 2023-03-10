# TLS termination

When working with {{ sk-hybrid-name }}, you can enable the [TLS termination](https://en.wikipedia.org/wiki/TLS_termination_proxy) to ensure security of your speech synthesis or recognition data when transmitted over a public network. In this case, the source data received by the Envoy server in clear text will be transmitted over a secure connection.

To enable TLS termination:

1. Copy the TLS certificate and private key to the `envoy` container. Put the certificate file to `/etc/envoy/certs/cert.pem ` and the key to `/etc/envoy/certs/key.pem`.
1. Send the `USE_TLS="true"` environment variable to the container of the license server (`license_server`).

You can also enable TLS proxying using `docker compose`:


```text
version: '3'
services:
  billing_agent:
    network_mode: host
    volumes:
      - persistent:/var/swaydb
    environment:
      STATIC_API_KEY: XXX
    image: billing_agent:0.15
  license_server:
    network_mode: host
    environment:
      USE_TLS: "true"
      LICENSE_MODE: billing_agent
    image: license-server:0.15
    depends_on:
      - billing_agent
  envoy:
    network_mode: host
    volumes:
      - certs:/etc/envoy/certs
    environment:
      ENVOY_UID: 0      
    image: envoy:0.15
    depends_on:
      - license_server

```
