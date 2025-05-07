---
title: '{{ lockbox-full-name }} pricing policy'
description: This article covers the {{ lockbox-name }} pricing policy.
editable: false
---

# {{ lockbox-name }} pricing policy

{% include [without-use-calculator](../_includes/pricing/without-use-calculator.md) %}

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}

The cost of using {{ lockbox-name }} is calculated based on:

* Number of secret versions.
* Number of completed [get](api-ref/Payload/get) operations on a secret.

There is no charge for using secrets created with {{ connection-manager-name }}.


{% note warning %}

The prices are valid as of March 10, 2024.

{% endnote %}



## Prices for the Russia region {#prices}



{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}


### Secret storage price {#secrets}

Billed hourly. The price per month is provided for reference only based on 720 hours (30 days) per month. The value is rounded. Secrets that are [deactivated](operations/secret-activation-manage.md) but not deleted are charged as active ones.




Billing is hourly. The cost per month is provided for reference only, assuming a 720-hour (30-day) month. The value is rounded.

{% include [usd.md](../_pricing/lockbox/usd-secrets.md) %}


### Price of requests for secrets {#requests}




{% include [usd.md](../_pricing/lockbox/usd-requests.md) %}


### Cost calculation example {#price-example}

Here is an example of calculating the monthly cost of {{ lockbox-name }} for the following configuration:

* Number of secrets: three, five versions each.
* Number of `get` operations with all secrets: 20,000.






{% include [usd-lockbox](../_pricing_examples/lockbox/usd.md) %}
