---
title: '{{ search-api-full-name }} pricing policy'
description: This article covers the {{ search-api-name }} pricing policy.
editable: false
---

# {{ search-api-name }} pricing policy



{% include [without-use-calculator](../_includes/pricing/without-use-calculator.md) %}

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

{% include [vat](../_includes/vat.md) %}

## What goes into the cost of using {{ search-api-name }} {#rules}

The cost of using {{ search-api-name }} is calculated based on the number of search requests initiated within a calendar month ([reporting period](../billing/concepts/reporting-period.md)).

## Prices for the Russia region {#prices}

{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

Free tier includes 1,000 synchronous queries per user per month using API v1 during night hours^1^ from 00:00:00 to 07:59:59. Queries in excess of this threshold are priced as detailed below. Free tier does not apply to queries run via [API v2](concepts/index.md#api-v2).



{% include [usd](../_pricing/search-api/usd.md) %}


Users are subject to quotas. For more information, see [Quotas and limits](concepts/limits.md). To have your quotas revised, contact [support]({{ link-console-support }}) or your account manager.

^1^ The time zone is [UTC+3](https://en.wikipedia.org/wiki/UTC%2B03:00).


## Examples of cost calculation {#price-example}

### Requests through API v2 {#price-example-api-v2}

Cost of using {{ search-api-name }} for initiating search queries through [API v2](./concepts/index.md#api-v2) with the following parameters:

* **Number of synchronous requests per month**: 250,000
* **Number of deferred requests per month**: 50,000
* **Number of synchronous requests with a generative response per month**: 10,000



{% include [usd-api-v2](../_pricing_examples/search-api/usd-api-v2.md) %}

