---
title: '{{ load-testing-full-name }} pricing policy'
description: This article covers the {{ load-testing-name }} pricing policy.
editable: false
---

# {{ load-testing-full-name }} pricing policy



{% include [without-use-calculator](../_includes/pricing/without-use-calculator.md) %}

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

A fee for the computing resources used by [agents](concepts/agent.md) is charged according to the [{{ compute-full-name }}](../compute/pricing.md) pricing policy.

You are charged per second of usage. The monthly prices are based on 720 hours per month.

Tests run by multiple agents are charged as a sum of tests run by each agent.

## Prices for the Russia region {#prices}

{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

### Test running time {#test-time}

You are charged based on the test runtime.



{% include [test-time-usd](../_pricing/load-testing/test-time-usd.md) %}

{% include [usd-test-time](../_pricing_examples/load-testing/usd-test-time.md) %}


### Storing test results {#test-results-storage}

You are charged based on the runtime of tests whose results will be stored.



{% include [test-results-usd](../_pricing/load-testing/test-results-usd.md) %}

{% include [usd-test-results](../_pricing_examples/load-testing/usd-test-results.md) %}

