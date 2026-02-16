---
title: '{{ sk-hybrid-name }} settings'
description: In this tutorial, you will learn how to set up {{ sk-hybrid-name }} components.
---

# {{ sk-hybrid-name }} settings

To configure the [service components](architecture.md), provide each setting in the respective environment variable in the `--env` parameter of the command to run the component's Docker container:

```bash
docker run --it \
    --env <setting_1>=<value> \
    --env <setting_2>=<value> \
    ... \
    <container_name>
```

If you run containers using the `docker compose` command, add or edit the service's description settings in the `environment` section of the `docker-compose.yaml` file.

| **Component**  | **Environment variable**                 | **Setting description**                                                                                                                                    |
|:---------------|:-----------------------------------------|:----------------------------------------------------------------------------------------------------------------------------------------------------------|
| All            | `LOGGING_LEVEL`                          | [Logging level](operations/logging.md). The default value is `INFO`.                                                                             |
| STT/TTS server | `SERVICE_PORT`                           | Port for requests to speech/text processing services                                                                                                    |
| STT server     | `LICENSE_SERVICE_ENDPOINTS`              | FQDN License server and the service registration port specified in the `UPSTREAM_ASR_REGISTRATIONS_SERVER_PORT` setting in `<FQDN_License_server>:<port>` format. |
| TTS server     | `LICENSE_SERVICE_ENDPOINTS`              | FQDN License server and the service registration port specified in the `UPSTREAM_TTS_REGISTRATIONS_SERVER_PORT` setting in `<FQDN_License_server>:<port>` format. |
| License server | `POSTGRES_JDBC_URL`                      | URL for connecting to the DB server of the {{ PG }} consumption metric storage in `jdbc:postgresql://host:<port>/database?properties` format.                         |
| License server | `POSTGRES_PASSWORD`                      | Password to access the DB server of the consumption metric storage.                                                                                               |
| License server | `POSTGRES_USER`                          | Username for the DB server of the consumption metric storage.                                                                                                 |
| License server | `PROMETHEUS_PORT`                        | {{ prometheus-name }} port for [sending the service's metrics](monitoring.md). The default value is `8003`.                                                  |
| License server | `STATIC_API_KEY`                         | [API key](../iam/concepts/authorization/api-key.md) for authentication on the gateway for incoming consumption metrics in the [Cloud Billing licensing model](architecture.md#billing). |
| License server | `UPSTREAM_ASR_PROXY_PORT`                | Port for handling incoming requests for the STT server. Used by Envoy. The default value is `8080`.                                                    |
| License server | `UPSTREAM_ASR_REGISTRATIONS_SERVER_PORT` | Speech recognition service registration port. The default value is `8087`.                                                                              |
| License server | `UPSTREAM_TTS_PROXY_PORT`                | Port for handling incoming requests for the TTS server. Used by Envoy. The default value is `9080`.                                                    |
| License server | `UPSTREAM_TTS_REGISTRATIONS_SERVER_PORT` | Speech synthesis service registration port. The default value is `9087`.                                                                                    |

## Reserved ports {#reserved-ports}

There are ports in the service that you cannot configure:

* License server: Port for responses from Envoy, `8086`.
* STT/TTS server: Monitoring port, `17002`.

## Run component command example {#cmd-example}

The example assumes that the license server runs on host `172.10.19.12` with port `8083` to register an STT application. To run the STT server, use this command:

```bash
docker run -it \
   --env LICENSE_SERVICE_ENDPOINTS=172.10.19.12:8083 \
   --env SERVICE_PORT=17019 \
   {{ registry }}/<registry_ID>/stt/cpu_x86_64/stt_server:<STT_application_version>
```

Where:

* `<registry_ID>`: Registry with Docker images for deployment of {{ sk-hybrid-name }} components.
* `<STT_application_version>`: Provided STT version.
