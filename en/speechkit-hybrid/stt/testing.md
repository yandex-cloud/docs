# Performance testing

To test the performance of your {{ sk-hybrid-name }} installation's speech recognition service, use a [container with a testing utility](#test-order-asr). The utility runs synthetic tests using a prepared set of audio files.

## Tests and expected results {#test-asr-description}

{% note info %}

Testing results depend on your hardware configuration and system response time requirements.

{% endnote %}

{{ speechkit-name }} is designed for real-time speech recognition. Information is passed in two data streams: from a user to a server and from the server to the user. The testing utility uses these streams and simulates real load on the service. The number of channels that can be concurrently active in a stream is set by the `CONNECTIONS` parameter in the [utility settings](#test-order-asr). Stream processing metrics of service audio data are written to a container log.

Speech is recognized in chunks until a stream ends. Intermediate results of recognizing each chunk of audio data (part of a phrase) are sent to the user with a delay. Complete recognition results are returned in a stream from the service to the user after the last chunk of audio data is received (with a delay, too).

The service <q>responsiveness</q> is described by the `q99` metric: the `0.99` quantile of the time of service response to the last data fragment (in 99 out of 100 cases, the response time is less than or equal to the quantile value). For example, the user finished sending an audio stream at time `T0` and received a response at time `T1`. The response time `T1-T0` shows a lag between the time of processing the entire session and the actual time.

Sample testing log fragment with the `q99` quantile value:

```text
INFO: 2021-09-22 13:48:25.677 +0000 load_test.cpp:110 Last chunk latency
INFO: 2021-09-22 13:48:25.677 +0000 load_test.cpp:119 q=0.99: 200ms
```

{{ sk-hybrid-name }} containers are designed to support the [specified number of channels for two recommended server configurations](../system-requirements.md#hardware). With these characteristics, the `q99` value doesn't exceed 600 ms. Increase the `CONNECTIONS` value until the `q99` metric value goes beyond this threshold. Testing results will help you estimate the performance of your installation and how an increase in the number of active channels affects a delay in service response.

## Testing steps {#test-order-asr}

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

   * `ENVOY_HOST`: The IP address of the speech recognition service. If you run tests and the speech recognition service on the same server, enter `0.0.0.0`.
   * `ENVOY_PORT`: The port of the speech recognition service (`8080` by default).
   * `CONNECTIONS`: The number of simultaneously active channels.

1. The test results will be available in the container logs:

   ```bash
   docker logs stt-tools
   ```
