---
title: CAPTCHA accessibility
description: This article explains how {{ captcha-full-name }} impacts website conversion rates, offering ease of entry for humans while remaining a solid defense against robots.
---

# CAPTCHA accessibility

_Accessibility_ makes a CAPTCHA challenge easy to complete for a human user. Apart from user experience, an accessible CAPTCHA also contributes to your web app's conversion rates. As the last link in the bot detection chain, CAPTCHA should be easy to understand and complete for users of any device, including people with various special needs. At the same time, it must effectively resist automatic sign-in attempts.

{{ captcha-name }} is guided by these two documents for accessibility:

* [GOST R 52872–2019](https://protect.gost.ru/document1.aspx?control=31&id=233736)
* [Web Content Accessibility Guidelines (WCAG) 2.1](https://www.w3.org/TR/WCAG21/)

## Accessibility principles {#principles}

{{ captcha-name }} follows a number of principles to help web apps maintain conversion rates while ensuring robust security:

* **Perceivable content**: CAPTCHA information and UI components are made to be as easy as possible to perceive. This is achieved through easy page customization, increased image contrast, plus the audio CAPTCHA as a readily available alternative.
* **Easy to manage content**: The UI components and navigation must be easy to manage. The CAPTCHA controls are clearly labeled and can be used with a mouse, keyboard, or TV remote.
* **Clear content**: The user must know exactly what actions need to be completed to pass the CAPTCHA test. Text challenges are available in 17 languages; audio challenges are available in Russian and English. The pages provide comprehensive descriptions of each element and feature a button you can use to contact support.
* **Reliable content**: Content must remain the same no matter what device it is processed on. Prior to each update, CAPTCHA gets thoroughly tested on a variety of devices.

According to the {{ yandex-cloud }}'s metrics, about half of all users get through CAPTCHA on their first try. Failure to do so may be caused by bright sunlight, the device not supporting the necessary JavaScript libraries, etc. In which case the user can choose between additional attempts, an audio CAPTCHA, or a request for support (such requests have a higher priority).

You can [vary](captcha-variants.md) CAPTCHA difficulty, type, and rules for different IP addresses, URIs, or headers, as well as analyze its impact on conversion. If your server is under attack, set your CAPTCHA to maximum difficulty for the most thorough traffic filtering.

## Testing {#testing}

To ensure CAPTCHA accessibility, {{ yandex-cloud }} precedes each new feature release with a full-scale audit:

1. Primary audit: Identifying accessibility issues and ways to fix them.
1. Fixing: Issue correction and integration of automated validation and testing tools.
1. Verification of fixes: Further testing to confirm the fixes and identify new issues.
1. Deployment of regular regression tests for the product: Production of designs, autotests, and other tools for further testing.
1. Maintaining accessibility: While the product continues to be refined and tested, its new functionality goes through the same process from the very beginning.

You can test CAPTCHA accessibility yourself using the [Lighthouse](https://developer.chrome.com/docs/lighthouse/overview?page&hl={{ lang }}) tool.