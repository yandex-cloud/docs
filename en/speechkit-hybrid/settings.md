---
title: "{{ sk-hybrid-name }} settings"
description: "In this tutorial, you will learn how to set up {{ sk-hybrid-name }} components."
---

# {{ sk-hybrid-name }} service settings

To configure [service components](architecture.md), provide each setting in the respective environment variable in the `--env` parameter of a component's Docker container run command:

```bash
docker run --it \
    --env <setting 1>=<value> \
    --env <setting 2>=<value> \
    ... \
    <container name>
```

If you run containers using the `docker compose` command, add or edit service specification settings in the `environment` section of the `docker-compose.yaml` file.

| **Component** | **Environment variable** | **Setting description** |
|:---------------|:-----------------------------------------|:---------------------------------------------------------------------------------------------------------------------------------------------------------|
| All | `LOGGING_LEVEL` | [Logging level](operations/logging.md). The default value is `INFO`. |
| Envoy | `UPSTREAM_ASR_PROXY_PORT` | Port for handling incoming requests for the STT server. By default, it is set to `8080`. |
| Envoy | `UPSTREAM_TTS_PROXY_PORT` | Port for handling incoming requests for the TTS server. By default, it is set to `9080`. |
| License server | `UPSTREAM_ASR_REGISTRATIONS_SERVER_PORT` | Speech recognition service registration port. By default, it is set to `8087`. |
| License server | `UPSTREAM_TTS_REGISTRATIONS_SERVER_PORT` | Speech synthesis service registration port. By default, it is set to `9087`. |
| License server | `PROMETHEUS_PORT` | Prometheus port for [service metric delivery](monitoring.md). By default, it is set to `8003`. |
| STT/TTS server | `SERVICE_PORT` | Port for making requests to speech/text processing services |
| STT server | `LICENSE_SERVICE_ENDPOINTS` | FQDN License server and the service registration server specified in the `UPSTREAM_ASR_REGISTRATIONS_SERVER_PORT` setting in `<FQDN License server>:<port>` format |
| TTS server | `LICENSE_SERVICE_ENDPOINTS` | FQDN License server and the service registration server specified in the `UPSTREAM_TTS_REGISTRATIONS_SERVER_PORT` setting in `<FQDN License server>:<port>` format |

## Reserved ports {#reserved-ports}

There are ports in the service that you cannot configure:

* License server: Port for receiving responses from Envoy, `8086`.
* STT/TTS server: Monitoring port, `17002`.
* For [CPU-based servers](system-requirements-cpu.md):
   * STT model server: Port `50051` for incoming requests from the STT server.
   * TTS model server: Ports `50052`, `50053`, and `50054` for incoming requests from the TTS server.

## Run component command example {#cmd-example}

The example assumes that the License server is running on host `172.10.19.12` and port `8083` to register an STT application. To run the STT server, use this command:

```bash
docker run -it \
   --env LICENSE_SERVICE_ENDPOINTS=172.10.19.12:8083 \
   --env SERVICE_PORT=17019 \
   cr.yandex/<registry ID>/stt/cpu_x86_64/stt_server:<STT application version>
```

Where:

* `<registry ID>`: Registry with Docker images for deploying {{ sk-hybrid-name }} components.
* `<STT application version>`: Provided STT service version.
