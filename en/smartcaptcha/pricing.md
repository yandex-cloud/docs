---
editable: false
---

# Pricing for {{ captcha-full-name }}

## What goes into the cost of using {{ captcha-full-name }} {#rules}

You are charged for [{{ captcha-name }} API requests](./quickstart.md#check-answer) at `https://smartcaptcha.yandexcloud.net/validate`. You are charged for [correct requests](concepts/validation.md#service-response) that meet the following conditions:

1. The correct `secret` and `token` values are provided.
1. The correct `token` was issued no more than 10 minutes ago.

{% note info %}

Using {{ captcha-name }} in [restricted mode](concepts/restricted-mode) is free of charge.

{% endnote %}

Examples of {{ captcha-name }} usage cost calculation:

1. You are charged if the user passed a CAPTCHA test, which resulted in a correct `/validate` request from the server.

1. You are not charged if the user sent an empty or incorrect `token`, which resulted in an incorrect `/validate` request.

1. A backend developer made a mistake and sent an incorrect `secret` or `token` in a `/validate` response. The API returns an error in the `message` field. You are not charged in this case.

1. A malicious user passed the CAPTCHA test, obtained the `token`, and sent it 10 times during the first minute. Each of the 10 requests is charged, but the API only returns the `OK` status to the first request.

1. A malicious user passed the CAPTCHA test, obtained the `token`, and sent it 10 times after 10 minutes. You are not charged in this case.

## Pricing {#prices}




{% include notitle [usd.md](../_pricing/smartcaptcha/usd.md) %}

