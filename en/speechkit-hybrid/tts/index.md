# Speech synthesis

## Available voices {#voices}

{{ sk-hybrid-name }} offers [premium voices](../../speechkit/tts/voices.md#premium) and [Brand Voice](../../speechkit/tts/brand-voice/).

## Before you start {#before-you-begin}

1. Install [Docker Engine](https://docs.docker.com/engine/install/) and [Docker Compose](https://docs.docker.com/compose/install/) on your server.

1. [Log in](../../container-registry/operations/authentication.md) to Container Registry.

For the recommended hardware configuration, see [{#T}](../system-requirements.md).

## Installing and setting up speech synthesis {#installing}

1. Place the  `docker-compose.yaml` file you received from the SpeechKit team in a folder on your server.

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
   tts-server              | INFO: 2021-09-22 15:36:02.765 +0000 server_base.cpp:144 Load finished. Ready to server requests on 0.0.0.0:17001
   ```

The speech synthesis service will be available on TCP port **9080**.

## Performance testing {#testing}

1. Download the container with tests:

   ```bash
   docker pull cr.yandex/${REGISTRY_ID}/tts-tools
   ```

1. Run the `tts-tools` container:

   ```bash
   docker run --network=host \
      --env ENVOY_HOST=0.0.0.0 \
      --env ENVOY_TTS_PORT=9080 \
      --env RPS=1 \
      tts-tools
   ```

   Where:

   * `ENVOY_HOST`: The IP address of the synthesis service. If you run tests on the same server as the synthesis service, enter `0.0.0.0`.
   * `ENVOY_TTS_PORT`: The port of the speech synthesis service (`9080` by default).
   * `RPS`: The number of speech synthesis requests per second.

1. The test results will be available in the container logs:

   ```bash
   docker logs tts-tools
   ```

