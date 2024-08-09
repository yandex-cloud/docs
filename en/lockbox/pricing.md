---
title: "{{ lockbox-full-name }} pricing policy"
description: "This article describes the {{ lockbox-name }} pricing policy."
editable: false
---

# {{ lockbox-name }} pricing policy

The cost of using {{ lockbox-name }} is calculated based on:

* Number of secret versions.
* Number of completed [get](api-ref/Payload/get) operations on a secret.


{% note warning %}

The prices are valid as of March 10, 2024.

{% endnote %}



## Prices for the Russia region {#prices}





### Secret storage price {#secrets}

Billed hourly. The price per month is provided for reference only based on 720 hours (30 days) per month. The value is rounded. Secrets that are [deactivated](operations/secret-activation-manage.md) but not deleted are charged as active ones.




Billing is hourly. The price per month is provided for reference only based on 720 hours (30 days) per month. The value is rounded.

{% include [usd.md](../_pricing/lockbox/usd-secrets.md) %}


### Price of requests for secrets {#requests}




{% include [usd.md](../_pricing/lockbox/usd-requests.md) %}

