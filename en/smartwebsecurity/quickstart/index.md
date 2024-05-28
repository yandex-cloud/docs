# Getting started with {{ sws-full-name }}

{{ sws-name }} protects your infrastructure from DDoS attacs and bots at the [OSI model's](https://en.wikipedia.org/wiki/OSI_model) application layer L7.

In a nutshell, the service checks the HTTP requests sent to the protected resource via the {{ alb-full-name }} [virtual host](../../application-load-balancer/concepts/http-router.md#virtual-host) against the [rules](../concepts/rules.md) configured in the [security profile](../concepts/profiles.md).

To protect your web apps from external threats, {{ sws-name }} also implements a [Web Application Firewall (WAF)](../concepts/waf.md).

{% include [note-preview-waf](../../_includes/smartwebsecurity/note-preview-waf.md) %}

Depending on the check results, the requests are routed to the virtual host, denied, or sent to [{{ captcha-full-name }}](../../smartcaptcha/) for additional verification.

To get started with the service:
* [Create a security profile and connect it to an existing virtual host of an L7 loan balancer](../quickstart.md).
* [Create a WAF profile and connect it to an existing security profile](quickstart-waf.md).
