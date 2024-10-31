---
title: '{{ captcha-full-name }} release notes'
description: This section contains {{ captcha-name }} release notes.
---

# {{ captcha-full-name }} release notes

## Q3 2024 {#q3-2024}

* Added [various CAPTCHA options](./concepts/captcha-variants.md) you can show depending on the basic properties of incoming requests. To flexibly split requests, you can use different combinations of [traffic conditions](./concepts/captcha-variants.md#traffic-conditions).
   
* Implemented CAPTCHA accessibility criteria in accordance with [GOST R 52 872-2019](https://protect.gost.ru/document1.aspx?control=31&id=233736). In particular, now:
  * CAPTCHA is compatible with screen access programs.
  * You can control it with a keyboard or on-screen buttons (relevant for SmartTV).
  * It contains more explanatory elements.

## Q2 2024 {#q2-2024}

For {{ captcha-name }}, added the maximum [difficulty level](concepts/tasks.md#task-difficulty). This level requires completing an additional high difficulty challenge.