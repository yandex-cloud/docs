---
title: '{{ search-api-full-name }} pricing policy'
description: This article provides the {{ search-api-name }} pricing policy.
editable: false
---

# {{ search-api-name }} pricing policy



{% include [without-use-calculator](../_includes/pricing/without-use-calculator.md) %}

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}

## What goes into the cost of using {{ search-api-name }} {#rules}

The cost of using {{ search-api-name }} is calculated based on the number of search requests initiated within a calendar month ([reporting period](../billing/concepts/reporting-period.md)).

At the [Preview](../overview/concepts/launch-stages.md) stage [deferred queries](concepts/web-search.md) are not charged.

## Prices for the Russia region {#prices}

{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

Free tier includes 1,000 queries per user per month during night hours^1^ from 00:00:00 to 07:59:59. The following pricing applies to queries beyond this threshold.



{% include [usd](../_pricing/search-api/usd.md) %}


The service has a quota of 30,000 queries per month (1,000 queries per day) for all new users. For more information on limits, see [Quotas and limits](concepts/limits.md). To request a change in quotas, contact [technical support]({{ link-console-support }}) or your account manager.

^1^ The time zone is [UTC+3](https://en.wikipedia.org/wiki/UTC%2B03:00).
