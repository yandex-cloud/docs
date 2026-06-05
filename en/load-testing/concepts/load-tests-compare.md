---
title: Comparing load test results in {{ load-testing-full-name }}
description: Follow this guide to learn how to compare results of multiple load tests in {{ load-testing-name }} using response time distribution charts, quantiles, as well as network and HTTP response codes.
---

# Comparing load test results

{% include [loadtesting-sunset-warning](../../_includes/load-testing/sunset-warning.md) %}


You can compare the results of multiple tests on the **Comparison** page.
The **{{ ui-key.yacloud.load-testing.label_results-comparison-section-title }}** tab provides a graph overlay visualization of the following dependencies:

1. Response time distribution.
1. Response time distribution (cumulative).
1. [Response time quantiles](load-test-results.md#quantiles).
1. [Network response codes](load-test-results.md#network-codes).
1. [HTTP response codes](load-test-results.md#http-codes).

You can find a table with results on the **{{ ui-key.yacloud.load-testing.label_tables }}** page.

## Use cases {#examples}

* [{#T}](../tutorials/loadtesting-results-compare.md)
* [{#T}](../tutorials/loadtesting-multiply.md)
