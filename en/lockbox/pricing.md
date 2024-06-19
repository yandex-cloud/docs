---
title: "{{ lockbox-full-name }} pricing policy"
description: "This article describes the {{ lockbox-name }} pricing policy."
editable: false
---

# {{ lockbox-name }} pricing

The cost of using {{ lockbox-name }} is calculated based on:

* Number of secret versions.
* Number of completed [get](api-ref/Payload/get) operations on a secret.


{% note warning %}

The prices are valid as of March 10, 2024.

{% endnote %}



## Prices for Russia {#prices}




### Cost of storing secrets {#secrets}

Billing is hourly. The cost per month is provided for reference only, assuming a 720-hour (30-day) month. The value is rounded.




{% include [usd.md](../_pricing/lockbox/usd-secrets.md) %}


### Cost of requests for secrets {#requests}




{% include [usd.md](../_pricing/lockbox/usd-requests.md) %}
