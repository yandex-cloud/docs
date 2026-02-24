### Yandex SmartCaptcha is used {#use-smartcaptcha}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | low | appsec.use-smartcaptcha ||
|#

#### Description

{% note tip "**Automatic verification**" %}

This control automatically checks for Yandex SmartCaptcha usage in applications.

{% endnote %}

To mitigate the risks associated with automated attacks on applications, we recommend using [Yandex SmartCaptcha](https://yandex.cloud/en/services/smartcaptcha). The service checks user requests with its ML algorithms and only shows challenges to those users whose requests it considers suspicious. You do not have to place the "I'm not a robot" button on the page.

#### Guides and solutions

Guides and solutions to use:

* [Yandex SmartCaptcha service](https://yandex.cloud/en/services/smartcaptcha)