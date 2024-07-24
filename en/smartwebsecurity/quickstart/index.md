# Getting started with {{ sws-full-name }}

{{ sws-name }} protects your infrastructure from DDoS attacks and bots at the [OSI model's](https://en.wikipedia.org/wiki/OSI_model) application layer L7.

In a nutshell, the service checks the HTTP requests sent to the protected resource via a {{ alb-full-name }} [virtual host](../../application-load-balancer/concepts/http-router.md#virtual-host) against the [rules](../concepts/rules.md) configured in the [security profile](../concepts/profiles.md).

{% include [realized-waf-concept](../../_includes/smartwebsecurity/realized-waf-concept.md) %}

{% include [realized-arl-concept](../../_includes/smartwebsecurity/realized-arl-concept.md) %}

{% include [note-preview-waf-arl](../../_includes/smartwebsecurity/note-preview-waf-arl.md) %}

Depending on the results of the check, the requests are routed to the virtual host, blocked, or sent to [{{ captcha-full-name }}](../../smartcaptcha/) for additional verification.

To get started with the service:
* [Create a security profile and connect it to an existing virtual host of an L7 load balancer](../quickstart.md).
* [Create a WAF profile and connect it to an existing security profile](quickstart-waf.md).
* [Create an ARL profile and connect it to an existing security profile](quickstart-arl.md).
