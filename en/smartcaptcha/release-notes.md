---
title: '{{ captcha-full-name }} release notes'
description: This section contains {{ captcha-name }} release notes.
---

# {{ captcha-full-name }} release notes

## January 2025 {#jan-2025}

{{ captcha-name }} got certificates of compliance with [152-FZ, GOST R 57580, and PCI DSS](https://yandex.cloud/ru/security/standards).

## Q4 2024 {#q4-2024}

{{ captcha-name }} has successfully passed an external audit for 152-FZ, GOST R 57580, and PCI DSS compliance.

## Q3 2024 {#q3-2024}

* Added [various CAPTCHAs](./concepts/captcha-variants.md) you can show depending on the basic properties of incoming requests. To flexibly split requests, you can use different combinations of [traffic conditions](./concepts/captcha-variants.md#traffic-conditions).
   
* Implemented CAPTCHA accessibility criteria in accordance with [GOST R 52 872-2019](https://protect.gost.ru/document1.aspx?control=31&id=233736). In particular, CAPTCHA is now:
  * Compatible with screen access programs.
  * Controlled by keyboard or on-screen buttons (relevant for SmartTV).
  * Contains more explanatory elements.

## Q2 2024 {#q2-2024}

For {{ captcha-name }}, the maximum [difficulty level](concepts/tasks.md#task-difficulty) was added. This level requires completing an additional high difficulty challenge.