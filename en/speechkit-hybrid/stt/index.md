---
title: "How to get started with speech recognition in {{ speechkit-full-name }}"
description: "In this tutorial, you will learn how to get started with speech recognition in {{ speechkit-name }}."
---

# Speech recognition

## Getting started {#before-you-begin}

1. Install [Docker Engine](https://docs.docker.com/engine/install/) and [Docker Compose](https://docs.docker.com/compose/install/) on your server.

1. [Get authenticated](../../container-registry/operations/authentication) in {{ container-registry-name }}.

For the recommended hardware configuration, see [{#T}](../system-requirements.md).

## Installing and setting up the streaming speech recognition service {#installing}

1. Place the `docker-compose.yaml` file you received from the SpeechKit team in a folder on your server

1. Edit `docker-compose.yaml`: replace `N` with your number of CPU threads in the `CPU_THREADS_NUM: N` parameter.

   In Linux, you can find out the number of threads on your server using the following command:

   ```bash
   cat /proc/cpuinfo | grep -E "processor.+:" | wc -l
   ```

1. Download all the required Docker containers:

   ```bash
   docker-compose pull
   ```

1. Start {{ speechkit-name }}:

   ```bash
   docker-compose up -d
   ```

1. Wait until the service loads
   ```bash
   docker logs stt-server
   ```

   ```text
   stt-server  | Server listening on 0.0.0.0:50053
   stt-server  | Waiting for join...
   ```

The speech recognition service will be available on TCP port **8080**.
