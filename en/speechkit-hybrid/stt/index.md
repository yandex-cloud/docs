# Speech recognition

## Before you start {#before-you-begin}

1. Install [Docker Engine](https://docs.docker.com/engine/install/) and [Docker Compose](https://docs.docker.com/compose/install/) on your server.

1. [Log in](../../container-registry/operations/authentication) to Container Registry.

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
   stt-server
   ```

   ```
   stt-server  | Server listening on 0.0.0.0:50053
   stt-server  | Waiting for join...
   ```

The speech recognition service will be available on TCP port **8080**.

## Performance testing {#testing}

1. Download the container with tests:

   ```bash
   docker pull cr.yandex/${REGISTRY_ID}/stt-tools
   ```

1. Run the `stt-tools` container:

   ```bash
   docker run -it --network=host \
      --env ENVOY_HOST="0.0.0.0" \
      --env ENVOY_PORT=8080 \
      --env CONNECTIONS=10 \
      stt-tools
   ```

   Where:

   * `ENVOY_HOST`: The IP address of the speech recognition service. If you run tests and the speech recognition service on the same server, enter `0.0.0.0`.
   * `ENVOY_TTS_PORT`: The port of the speech recognition service (`8080` by default).
   * `CONNECTIONS`: The number of simultaneously active channels.

1. The test results will be available in the container logs:

   ```bash
   docker logs stt-tools
   ```

