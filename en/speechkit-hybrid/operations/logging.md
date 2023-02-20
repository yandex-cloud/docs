# Operations logging {{ sk-hybrid-name }}

You can control which {{ sk-hybrid-name }} container actions will be written to logs. The logging level is determined by the `LOGGING_LEVEL` parameter.

Supported logging levels:

* `DEBUG`
* `NOTICE`
* `INFO` (default)
* `WARNING`
* `ERROR`
* `EMERG`
* `ALERT`
* `CRITICAL_INFO`

## Setting the logging level when running a container {#run}

To set the logging level, assign a value to the variable when running your {{ sk-hybrid-name }} container, for example:

```bash
docker run --network=host-e LOGGING_LEVEL=DEBUG -e LICENSE_MODE=billing_agent <license_server_image>
```

## Setting the logging level in the docker compose file {#docker-compose}

If you use Docker Compose to run your {{ sk-hybrid-name }} containers, you can set the logging level for each container in the configuration file.

For example, the following configuration will set the logging levels: `INFO` for the `billing_agent` container, `NOTICE` for the license server, and `WARNING` for the `envoy` container.

```text
version: '3'
services:
  billing_agent:
    network_mode: host
    volumes:
      - persistent:/var/swaydb
    environment:
      LOGGING_LEVEL: INFO
      STATIC_API_KEY: XXX
    image: billing_agent:0.15
  license_server:
    network_mode: host
    environment:
      LICENSE_MODE: billing_agent
      LOGGING_LEVEL: NOTICE
    image: license-server:0.15
    depends_on:
      - billing_agent
  envoy:
    network_mode: host
    environment:
      LOGGING_LEVEL: WARNING
      ENVOY_UID: 0      
    image: envoy:0.15
    depends_on:
      - license_server

```
