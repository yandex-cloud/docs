---
title: "How to get started with speech synthesis in {{ speechkit-full-name }}"
description: "In this tutorial, you will learn how to get started with speech synthesis in {{ speechkit-name }}."
---

# Speech synthesis

## Available voices {#voices}

{{ sk-hybrid-name }} offers [premium voices](../../{{ speechkit-slug }}/tts/voices.md#premium) and [Brand Voice](../../{{ speechkit-slug }}/tts/brand-voice/).

## Getting started {#before-you-begin}

1. Install [Docker Engine](https://docs.docker.com/engine/install/) and [Docker Compose](https://docs.docker.com/compose/install/) on your server.

1. [Authenticating](../../container-registry/operations/authentication.md) in {{ container-registry-full-name }}.

For the recommended hardware configuration, see [{#T}](../system-requirements.md).

## Installing and setting up speech synthesis {#installing}

1. Place the `docker-compose.yaml` file you received from the SpeechKit team in a folder on your server.

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
   docker logs tts-server
   tts-server            | INFO: 2021-09-22 15:36:02.765 +0000 server_base.cpp:144 Load finished. Ready to server requests on 0.0.0.0:17001
   ```

The speech synthesis service will be available on TCP port **9080**.
