### Application DDoS protection is enabled (L7) {#l7}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | high | appsec.ddos-protection.l7 ||
|#

#### Description

{% note tip "**Automatic verification**" %}

This control automatically checks Smart Web Security security profiles for ALB.

{% endnote %}

{% note warning "**Manual verification**" %}

If an external DDoS protection software is used, please change the status manually.

{% endnote %}

Yandex Cloud provides basic and advanced DDoS protection as well as protection at the application level with Yandex Smart Web Security. Make sure to use at least basic protection.

[Yandex Smart Web Security](https://yandex.cloud/en/docs/smartwebsecurity/quickstart) is a service for protection against DDoS attacks and bots at application level L7 of the [OSI model](https://en.wikipedia.org/wiki/OSI_model). Smart Web Security [connects](https://yandex.cloud/en/docs/smartwebsecurity/quickstart) to Yandex Application Load Balancer. In a nutshell, the service checks the HTTP requests sent to the protected resource against the [rules](https://yandex.cloud/en/docs/smartwebsecurity/concepts/rules) configured in the [security profile](https://yandex.cloud/en/docs/smartwebsecurity/concepts/profiles). Depending on the results of the check, the requests are forwarded to the protected resource, blocked, or sent to [Yandex SmartCaptcha](https://yandex.cloud/en/docs/smartcaptcha/) for additional verification.

[Yandex DDoS Protection](https://yandex.cloud/en/docs/vpc/ddos-protection/) is a Virtual Private Cloud component that safeguards cloud resources from DDoS attacks. DDoS Protection is provided in partnership with Curator. You can enable it yourself for an [external IP address](https://yandex.cloud/en/docs/vpc/concepts/address) through cloud administration tools. Supported up to OSI L4.

[Advanced](https://yandex.cloud/en/services/ddos-protection) DDoS protection is available at OSI layers 3, 4, and 7. You can also track load and attack metrics and enable Solidwall WAF in your Curator account. To enable advanced protection, contact your manager or technical support.

#### Guides and solutions

Guides and solutions to use:

* [How to create a security profile in Smart Web Security](https://yandex.cloud/en/docs/smartwebsecurity/operations/profile-create)
* [Webinar: DDoS Protection in Yandex Cloud](https://youtu.be/KWGbLQTth5U)