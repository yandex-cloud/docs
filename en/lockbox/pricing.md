---
title: "{{ lockbox-full-name }} pricing policy"
description: "This article describes the {{ lockbox-name }} pricing policy."
editable: false
---

# {{ lockbox-name }} pricing

The cost of {{ lockbox-name }} usage is based on:

* Number of secret versions.
* Number of completed [get](api-ref/Payload/get) operations on a secret.


{% note warning %}

The prices are valid as of March 10, 2024.

{% endnote %}


## Cost of storing secrets {#secrets}





{% include [usd.md](../_pricing/lockbox/usd-secrets.md) %}



## Cost of requests for secrets {#requests}





{% include [usd.md](../_pricing/lockbox/usd-requests.md) %}


