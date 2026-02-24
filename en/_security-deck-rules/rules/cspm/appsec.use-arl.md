### Advanced rate limiter is implemented {#use-arl}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | medium | appsec.use-arl ||
|#

#### Description

{% note tip "**Automatic verification**" %}

This control automatically checks for Advanced Rate Limiter configuration.

{% endnote %}

{% note warning "**Manual Check**" %}

This rule checks only the built-in information security features in Yandex Cloud. If an applied protection is used, please manually mark the rule as completed.

{% endnote %}

[Advanced Rate Limiter (ARL)](https://yandex.cloud/en/docs/smartwebsecurity/concepts/arl) is a Yandex Smart Web Security module used to monitor and limit web app loads. It allows you to set a limit on the number of HTTP requests over a certain period of time. All requests above the limit will get blocked. You can set a single limit for all traffic or configure specific limits to segment requests by certain parameters. For the purpose of limits, you can count requests one by one or group them together based on specified property.

You need to connect your ARL profile to the [security profile](https://yandex.cloud/en/docs/smartwebsecurity/concepts/profiles) in Smart Web Security.

#### Guides and solutions

Guides and solutions to use:

* [Creating an ARL profile and connecting it to a security profile in Smart Web Security](https://yandex.cloud/en/docs/smartwebsecurity/quickstart#arl)