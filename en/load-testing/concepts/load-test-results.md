---
title: Load test results
description: In this article, you will learn about the load test results, response time quantiles, testing threads for the entire test, network response codes, HTTP response codes.
---

# Load test results

You can monitor load test results on the **Test results** page. It provides a graphic visualization of the following dependencies:

1. [Response time quantiles](#quantiles)
1. [Testing threads for the entire test](#test-streams)
1. [Network response codes](#network-codes)
1. [HTTP response codes](#http-codes)

All charts are combined with the load pattern, i.e., the number of responses per second (RPS).
A table representation of test results is available on the **Tables** page.

You can set up the charts to only display the lines you need. To do this, click the required metrics in the chart legend while pressing **Ctrl** on Windows and Linux or **Cmd** on MacOS. 

## Response time quantiles {#quantiles}

This chart shows how different-level quantiles (percentiles, to be more exact) depend on time. 

An N-level quantile indicates the time that N% responses fall within. The 50th quantile is a median value and the 100th quantile is the maximum one.

A general principle for chart analysis is: the shorter and more stable the response times, the better.

The presence of a point where response times begin to spike as the load grows indicates that the maximum service performance is reached. The service may still continue to respond, but long response times indicate that some subsystems are overloaded. This point is called a <q>fault point</q> and may serve as an [auto stop criterion](auto-stop.md#basic-criteria) in the test configuration.

## Testing threads for the entire test {#test-streams}

This chart shows how the number of [testing threads](testing-stream.md) depends on time.
A testing thread is a separate instance of a load generator. It usually equals the number of connections established between the [agent](agent.md) and the service being tested.

## Network response codes {#network-codes}

During a load test, the service being tested returns an error for some requests rather than a response for various reasons. This could be a protocol error, a timeout, or an internal error on the generator side. If successful, `0` is returned on the network code chart.

This chart shows how network codes depend on time.

If there are no errors, the chart should feature only the `0` code. If it has other codes, this may indicate network issues both on the hardware and the service side.

{% cut "Full list of supported network codes" %} 

{% include [network-response-codes.md](../../_includes/load-testing/network-response-codes.md) %}

{% endcut %} 

## HTTP response codes {#http-codes}

This chart shows how [HTTP response codes](https://en.wikipedia.org/wiki/List_of_HTTP_status_codes) depend on time.

If there are no errors, the chart should feature only the `2xx` codes. If it also has the `4xx` or `5xx` codes, this may indicate issues with the service or the test data.