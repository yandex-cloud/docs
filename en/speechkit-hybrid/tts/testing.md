# Performance testing

To test the performance of your {{ sk-hybrid-name }} installation's speech synthesis service, use a [container with a testing utility](#test-order-synthesis). The utility runs synthetic tests using a prepared set of text files.

## Tests and expected results {#test-synthesis-description}

{% note info %}

Testing results depend on your hardware configuration and system response time requirements.

{% endnote %}

{{ speechkit-name }} performs speech synthesis in <q>request-response</q> mode. The testing utility sends requests to the service and simulates real load on it. The frequency of requests is set by the `RPS` (requests per second) parameter in the [utility settings](#test-order-synthesis). Service response metrics are written to a container log:

* Process metrics:
   * Seconds per second (SPS): The number of seconds of synthesized text generated per runtime second.
   * Resulting audio length.
   * Response delay.
* Resulting metrics:
   * `q99`: The `0.99` quantile of the time of service response to a request (in 99 out of 100 cases, a phrase's synthesis time is less than or equal to the quantile value):
      * For synthesizing phrases that are shorter than 6 seconds.
      * For synthesizing phrases that are longer than 6 seconds.
      * For synthesizing phrases of any length.

Sample testing log fragment with process metric values:

```text
INFO: 2021-09-22 15:07:00.882 +0000 load_test.cpp:89 Sample=but fear and, at the same time, hopes for a miracle stopped me from saying that., duration=4.305375s, latency=0.371161s
INFO: 2021-09-22 15:07:00.882 +0000 load_test.cpp:92 Passed time: 4.384470733, seconds generated=49.561, sps=11.17579835, avgAudioLength=5506
```

Where:

* `duration`: Resulting audio length.
* `latency`: Response delay.
* `sps`: Seconds per second (SPS).

Sample testing log fragment with the `q99` quantile value for phrases that are shorter than 6 seconds:

```text
INFO: 2021-09-22 15:07:00.059 +0000 load_test.cpp:260 Audio < 6 seconds latencies
INFO: 2021-09-22 15:07:00.059 +0000 load_test.cpp:262 q=0.99: 390ms
```

Sample testing log fragment with the `q99` quantile value for phrases that are longer than 6 seconds:

```text
INFO: 2021-09-22 15:06:59.734 +0000 load_test.cpp:260 Audio >= 6 seconds latencies
INFO: 2021-09-22 15:06:59.734 +0000 load_test.cpp:262 q=0.99: 505ms
```

Sample testing log fragment with `q99` quantile values for phrases of any length:

```text
INFO: 2021-09-22 15:07:00.059 +0000 load_test.cpp:260 Utterance latency
INFO: 2021-09-22 15:07:00.059 +0000 load_test.cpp:262 q=0.99: 505ms
```

{{ sk-hybrid-name }} containers are designed to support the [specified SPS metric values for two recommended server configurations](../system-requirements.md#hardware). With these SPS values, the `q99` quantile value doesn't exceed 500-600 ms. Increase the `RPS` value until the SPS and `q99` metric values go beyond this threshold. Testing results will help you estimate the performance of your installation and how an increase in the number of requests per second increases the SPS value and affects a delay in service response.

## Testing steps {#test-order-synthesis}

1. Download the container with tests:

   ```bash
   docker pull {{ registry }}/${REGISTRY_ID}/tts-tools
   ```

2. Run the `tts-tools` container:

   ```bash
   docker run --network=host \
      --env ENVOY_HOST=0.0.0.0 \
      --env ENVOY_TTS_PORT=9080 \
      --env RPS=1 \
      tts-tools
   ```

   Where:

   * `ENVOY_HOST`: The IP address of the speech synthesis service. If you run tests on the same server as the speech synthesis service, enter `0.0.0.0`.
   * `ENVOY_TTS_PORT`: The port of the speech synthesis service (`9080` by default).
   * `RPS`: The number of speech synthesis requests per second.

3. The test results will be available in the container logs:

   ```bash
   docker logs tts-tools
   ```
