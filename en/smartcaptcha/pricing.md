---
title: '{{ captcha-full-name }} pricing policy'
description: This article covers the {{ captcha-name }} pricing policy.
editable: false
---

# {{ captcha-full-name }} pricing policy



{% note tip %}




To calculate the cost of using the service, use [our calculator](https://yandex.cloud/en/prices?state=064c7fd1932b#calculator) on the {{ yandex-cloud }} website or check out the pricing below.


{% endnote %}

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

{% include [vat](../_includes/vat.md) %}

## What goes into the cost of using {{ captcha-full-name }} {#rules}

You pay for [requests to the {{ captcha-name }} API](./quickstart.md#check-answer) made at `https://smartcaptcha.yandexcloud.net/validate`. You only pay for [correct requests](concepts/validation.md#service-response) to which the API returns the `ok` status. Correct requests satisfy the following conditions:

* {{ captcha-name }} has identified the request as one sent by a human, not a bot.
* Correct `secret` and `token` values were provided.
* A unique `token` was issued not more than 10 minutes ago.

{% note info %}

Using {{ captcha-name }} in [restricted mode](concepts/restricted-mode) is free of charge.

{% endnote %}

Examples of {{ captcha-name }} usage cost calculation:

1. The user has passed the CAPTCHA test resulting in a correct `/validate` request from the server. A fee will be charged.

1. The user has sent an empty or incorrect `token` resulting in an incorrect `/validate` request. No fee will be charged.

1. A backend developer has made a mistake and sent an incorrect `secret` or `token` in the response `/validate` request. The API will return an error in the `message` field. No fee will be charged.

1. An intruder has passed the CAPTCHA test, got a `token`, and sent it 10 times during the first minute. The API will return the `ok` status only to the first request, and you will be charged for the first request only.

1. An intruder has passed the CAPTCHA test, got a `token`, and sent it 10 times after 10 minutes. The API will return the `failed` status to all requests. You will not be charged for any of these.

## Prices for the Russia region {#prices}

{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}



{% include [usd](../_pricing/smartcaptcha/usd.md) %}

You pay for the actual number of requests.

{% include [usd-smartcaptcha](../_pricing_examples/smartcaptcha/usd-smartcaptcha.md) %}


