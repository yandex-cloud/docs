---
title: "How to get started with {{ sk-hybrid-name }}"
description: "Follow this guide to create and set up your speech synthesis and recognition applications and load testing utilities."
---

# Getting started with {{ sk-hybrid-name }}

{{ sk-hybrid-name }} provides the following {{ speechkit-full-name }} applications for speech synthesis and recognition:

* Application for speech synthesis: `tts`.
* Application for speech recognition: `stt`.
* Load testing utilities.

To get started with the service, test the deployment of applications in Docker containers in your infrastructure.

## Getting started {#before-you-begin}

1. Make sure your hardware meets the [system requirements](system-requirements.md#hardware).
1. [Install and configure](system-requirements.md#software) the required environment.
1. Install [Docker Engine](https://docs.docker.com/engine/install/) and [Docker Compose](https://docs.docker.com/compose/install/) on your server.

## Deploying the speech synthesis application {#example-tts}

1. Create a `docker-compose.yaml` file in a separate directory to only be used for testing the application deployment:

   {% cut "docker-compose.yaml" %}

   ```yaml
   version: '3'
   services:

     tts:
       network_mode: host
       environment:
         - LICENSE_SERVICE_ENDPOINTS=0.0.0.0:9087
         - SERVICE_HOST=0.0.0.0
         - SERVICE_PORT=17009
         - UNISTAT_PORT=17003
         - GRPC_VERBOSITY=debug
         - LOGGING_LEVEL=INFO
         - TZ=UTC
         - NVIDIA_VISIBLE_DEVICES=0
         - NVIDIA_DRIVER_CAPABILITIES=compute,utility
       image: cr.yandex/<registry_ID>/tts/v100/tts_server:<version>
       deploy:
         resources:
           reservations:
             devices:
               - capabilities: ["gpu"]
                 driver: nvidia
                 device_ids: ["0"]

     license_server:
       network_mode: host
       environment:
         LICENSE_MODE: billing_agent
         LOGGING_LEVEL: INFO
         USE_TLS: "false"
         STATIC_API_KEY: <API_key>
       image: cr.yandex/<registry_ID>/license_server:<version>

     envoy:
       network_mode: host
       image: cr.yandex/<registry_ID>/envoy:<version>
       environment:
         LOGGING_LEVEL: INFO
         ENVOY_UID: 0
       volumes:
         - ./log:/var/log/envoy
       depends_on:
         - license_server
   ```

   {% endcut %}

   In the file, specify the parameters obtained during the [environment setup](#before-you-begin):

   * `STATIC_API_KEY`: ID of the created API key.
   * `<registry_ID>`: ID of the {{ container-registry-name }} registry.
   * `<version>`: {{ sk-hybrid-name }} image version.

1. Run the application from the directory with the `docker-compose.yaml` file:

   ```bash
   docker-compose up
   ```

## Deploying the speech recognition application {#example-stt}

{% note warning %}

We do not recommend deploying the applications for speech synthesis and recognition on the same VM instance, as this will generate a heavy load on the system.

{% endnote %}

1. Create a `docker-compose.yaml` file in a separate directory to only be used for testing the application deployment:

   {% cut "docker-compose.yaml" %}

   ```yaml
   version: '3'
   services:

     asr:
       network_mode: host
       privileged: true
       environment:
         - LICENSE_SERVICE_ENDPOINTS=0.0.0.0:8087
         - SERVICE_HOST=0.0.0.0
         - SERVICE_PORT=17002
         - UNISTAT_PORT=17003
         - GRPC_VERBOSITY=debug
         - LOGGING_LEVEL=INFO
         - TZ=UTC
         - NVIDIA_VISIBLE_DEVICES=0
         - NVIDIA_DRIVER_CAPABILITIES=compute,utility
       image: cr.yandex/<registry_ID>/stt/v100/stt_server:<version>
       deploy:
         resources:
           reservations:
             devices:
               - capabilities: ["gpu"]
                 driver: nvidia
                 device_ids: ["0"]

     license_server:
       network_mode: host
       environment:
         LICENSE_MODE: billing_agent
         LOGGING_LEVEL: INFO
         USE_TLS: "false"
         STATIC_API_KEY: <API_key>
       image: cr.yandex/<registry_ID>/license_server:<version>

     envoy:
       network_mode: host
       image: cr.yandex/<registry_ID>/envoy:<version>
       environment:
         LOGGING_LEVEL: INFO
         ENVOY_UID: 0
       volumes:
         - ./log:/var/log/envoy
       depends_on:
         - license_server
   ```

   {% endcut %}

   In the file, specify the parameters obtained during the [environment setup](#before-you-begin):

   * `STATIC_API_KEY`: ID of the created API key.
   * `<registry_ID>`: ID of the {{ container-registry-name }} registry.
   * `<version>`: {{ sk-hybrid-name }} image version.

1. Run the speech recognition application from the directory with the `docker-compose.yaml` file:

   ```bash
   docker-compose up
   ```

## Load testing {#load-testing}

To check that the {{ sk-hybrid-name }} test installation works properly and evaluate its performance, use containers with a load testing utility for speech [synthesis](tts/testing.md) and [recognition](stt/testing.md).

1. Run speech synthesis load testing on the VM instance with the application for speech synthesis:

   ```bash
   docker run -it \
       --network=host \
       --env ENVOY_HOST="0.0.0.0" \
       --env ENVOY_TTS_PORT=9080 \
       --env USE_SSL=1 \
       --env RPS=1 \
       cr.yandex/<registry_ID>/tools/tts-tools:0.19
   ```

1. Run speech recognition load testing on the VM instance with the application for speech recognition:

   ```bash
   docker run -it \
       --network=host \
       --env SEND_MODE=RealTime \
       --env CONNECTIONS=30 \
       --env ENVOY_HOST="0.0.0.0" \
       --env ENVOY_PORT=8080 \
       --env USE_SSL=1 \
       --env ERRORS_THRESHOLD=0.1
       cr.yandex/<registry_ID>/tools/stt-tools:0.20
   ```

If the applications are running properly, you will see messages with request processing time percentiles and other details output to the console, such as:

```text
INFO: 2023-02-17 11:22:37.106 +0000 load_test.cpp:167 q=0.75: 250ms
INFO: 2023-02-17 11:22:37.106 +0000 load_test.cpp:167 q=0.9: 300ms
INFO: 2023-02-17 11:22:37.106 +0000 load_test.cpp:167 q=0.95: 300ms
INFO: 2023-02-17 11:22:37.106 +0000 load_test.cpp:167 q=0.99: 850ms
INFO: 2023-02-17 11:22:37.186 +0000 load_test.cpp:112 Total billing units: 260
INFO: 2023-02-17 11:22:37.186 +0000 load_test.cpp:218 SPS = 27.09172898
INFO: 2023-02-17 11:22:37.186 +0000 load_test.cpp:263 Errors statistics: 0% (0/50)
```

## See also {#what-is-next}

* [Installing and setting up the streaming speech recognition service](stt/index.md).
* [Installing and setting up the speech synthesis service](tts/index.md).
* [Monitoring services](monitoring.md).
