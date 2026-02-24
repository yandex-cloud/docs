### Yandex Smart Web Security profile is used {#use-sws}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | high | appsec.use-sws ||
|#

#### Description

{% note tip "**Automatic verification**" %}

This control automatically checks for Yandex Smart Web Security profile configuration.

{% endnote %}

[Yandex Smart Web Security](https://yandex.cloud/en/docs/smartwebsecurity/quickstart) protects you against DDoS attacks, web attacks, and bots at application level L7 of the [OSI model](https://en.wikipedia.org/wiki/OSI_model). Smart Web Security [connects](https://yandex.cloud/en/docs/smartwebsecurity/quickstart) to Yandex Application Load Balancer.

In a nutshell, the service checks the HTTP requests sent to the protected resource against the [rules](https://yandex.cloud/en/docs/smartwebsecurity/concepts/rules) configured in the [security profile](https://yandex.cloud/en/docs/smartwebsecurity/concepts/profiles). Depending on the results of the check, the requests are forwarded to the protected resource, blocked, or sent to [Yandex SmartCaptcha](https://yandex.cloud/en/docs/smartcaptcha/) for additional verification.

{% note warning "**Manual Check**" %}

This rule checks only the built-in information security features in Yandex Cloud. If an applied protection is used, please manually mark the rule as completed.

{% endnote %}

#### Guides and solutions

Guides and solutions to use:

* [Creating a security profile and connecting it to a virtual host of an L7 load balancer](https://yandex.cloud/en/docs/smartwebsecurity/quickstart)