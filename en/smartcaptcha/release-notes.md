---
title: '{{ captcha-full-name }} release notes'
description: This section contains the {{ captcha-name }} release notes.
---

# {{ captcha-full-name }} release notes

<!-- Changelog begin -->

{% changelog %}
```
date: 2025-12
index: 2
```

### Adding metadata

We updated {{ captcha-name }} to let you provide additional context for verification. You can provide any frontend metadata that will help the algorithm understand the operation context and tell real users from bots with more precision.

For example, you can provide:
* User data: ID, trust level, activity history.
* Request variables: cart value, target action.
* Internal check results: risk score from your anti-fraud system, suspicious behavior flags.

This makes the verification process more flexible and intelligent, reducing stress for legitimate users while strengthening protection in suspicious cases.

{% endchangelog %}

{% changelog %}
```
date: 2025-01
index: 1
```

### 152-FZ , GOST R 57580, and PCI DSS certificates

{{ captcha-name }} is certified for compliance with the following security standards: [152-FZ, GOST R 57580, and PCI DSS](https://yandex.cloud/en/security/standards).

{% endchangelog %}

<!-- Changelog end -->

## December 2025 {#dec-2025}

Added support for including frontend [metadata](concepts/captcha-variants.md#metadata), e.g., user data or [anti-fraud](https://en.wikipedia.org/wiki/Fraud_deterrence) system results, into CAPTCHA requests.

## January 2025 {#jan-2025}

{{ captcha-name }} was certified for compliance with [152-FZ, GOST R 57580, and PCI DSS](https://yandex.cloud/ru/security/standards).

## Q4 2024 {#q4-2024}

{{ captcha-name }} has successfully completed an external audit for 152-FZ, GOST R 57580, and PCI DSS compliance.

## Q3 2024 {#q3-2024}

* Added [CAPTCHA challenge options](./concepts/captcha-variants.md) that can be displayed based on request parameters. You can use combinations of [traffic rules](./concepts/captcha-variants.md#traffic-conditions) for flexible request segmentation.
   
* Implemented CAPTCHA accessibility criteria in accordance with [GOST R 52 872-2019](https://protect.gost.ru/document1.aspx?control=31&id=233736). In particular, the CAPTCHA now:
  * Compatible with screen access software.
  * Can be operated using a keyboard or on-screen buttons (relevant for SmartTV).
  * Contains more visual cues and instructions.

## Q2 2024 {#q2-2024}

A maximum [difficulty level](concepts/tasks.md#task-difficulty) has been added to {{ captcha-name }}. This level requires completing an additional high-difficulty challenge.