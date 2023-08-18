---
editable: false
---

# Pricing for {{ search-api-name }}

## What goes into the cost of using {{ search-api-name }} {#rules}

The cost of using {{ search-api-name }} is calculated based on the number of initiated search requests per calendar month ([Reporting period](../billing/concepts/reporting-period.md)).

## Pricing {#prices}

{% note info %}

The prices listed below will take effect on September 1, 2023.

{% endnote %}

The level of non-tariff consumption (free tier) for each user is 1000 requests per month during the night hours ^1^ from 00:00:00 to 07:59:00. Requests exceeding these values are paid at the following rates.




{% include [usd](../_pricing/search-api/usd.md) %}


There is a quota of 30,000 requests per month (1,000 requests per day) for all new users of the service. For more information about restrictions, see [Quotas and limits](concepts/limits.md). To change the quota values, contact [technical support]({{ link-console-support }}) or your account manager.

^1^ The time is indicated in the time zone [UTC+3](https://en.wikipedia.org/wiki/UTC%2B03:00).