---
title: "{{ captcha-full-name }} pricing policy"
description: "This article describes the {{ captcha-name }} pricing policy."
editable: false
---

# {{ captcha-full-name }} pricing

{% include [use-calculator](../_includes/pricing/use-calculator.md) %}

## What goes into the cost of using {{ captcha-full-name }} {#rules}

You are charged for [{{ captcha-name }} API requests](./quickstart.md#check-answer) at `https://smartcaptcha.yandexcloud.net/validate`. You are only charged for [correct requests](concepts/validation.md#service-response) to which the API returns the `ok` status. These requests must meet the following conditions:

* {{ captcha-name }} identifies a request as one sent by a human and not a bot.
* The correct `secret` and `token` values are provided.
* The unique `token` was issued no more than 10 minutes ago.

{% note info %}

Using {{ captcha-name }} in [restricted mode](concepts/restricted-mode) is free of charge.

{% endnote %}

Examples of {{ captcha-name }} usage cost calculation:

1. You are charged if the user passed a CAPTCHA test, which resulted in a correct `/validate` request from the server.

1. You are not charged if the user sent an empty or incorrect `token`, which resulted in an incorrect `/validate` request.

1. A backend developer made a mistake and sent an incorrect `secret` or `token` in a response `/validate` request. The API returns an error in the `message` field. You are not charged in this case.

1. A hacker passed the CAPTCHA test, obtained the `token`, and sent it 10 times during the first minute. The API will only return the `ok` status to the first request and you will only be charged for the first request.

1. A hacker passed the CAPTCHA test, obtained the `token`, and sent it 10 times after 10 minutes. The API will return the `failed` status to all requests. You will not be charged for any of them.

## Pricing {#prices}





{% include notitle [usd.md](../_pricing/smartcaptcha/usd.md) %}

