---
title: '{{ postbox-full-name }} pricing policy'
description: This article covers the {{ postbox-name }} pricing policy.
editable: false
---

# {{ postbox-name }} pricing policy


{% note tip %}




To calculate the cost of using the service, use the [calculator](https://yandex.cloud/en/prices?state=d41eb2e392e8#calculator) on the {{ yandex-cloud }} website or check the pricing data in this section.


{% endnote %}




{{ postbox-name }} cost depends on the number of sent emails per month. All emails accepted for sending are charged, regardless of whether they have been actually delivered. If one email is sent to multiple recipients, the number of outbound emails is the same as the number of such recipients.

{% note info %}

By default, {{ postbox-name }} has quotas (e.g., on the number of emails you send), which you can increase by requesting support. For more information, see [{#T}](concepts/limits.md).

{% endnote %}

{% include [not-charged-postbox.md](../_includes/pricing/price-formula/not-charged-postbox.md) %}

{% include [free-tier.md](../_includes/pricing/price-formula/free-tier.md) %}

## Cost calculation example {#price-example}

Calculating cost of 65,500 emails per month:



{% include [usd](../_pricing_examples/postbox/usd.md) %}


## Prices for the Russia region {#prices}

{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}



{% include [usd.md](../_pricing/postbox/usd.md) %}


{% note info %}

If you want to send over 500,000 emails per month, contact [support]({{ link-console-support }}) or your account manager for special terms.

{% endnote %}

