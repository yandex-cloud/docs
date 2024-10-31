# {{ sws-full-name }} overview

{{ sws-full-name }} is a service for protection against DDoS attacks and bots at application level L7 of the [OSI model](https://en.wikipedia.org/wiki/OSI_model).

You can connect the service to [{{ alb-full-name }}](../../application-load-balancer/) [virtual hosts](../../application-load-balancer/concepts/http-router.md#virtual-host).

In a nutshell, the service checks the HTTP requests sent to the protected resource via the virtual host of the L7 load balancer against the [rules](rules.md) configured in the [security profile](profiles.md). Depending on the results of the check, the requests are routed to the virtual host, blocked, or sent to [{{ captcha-full-name }}](../../smartcaptcha/) for additional verification.

![schema](../../_assets/smartwebsecurity/schema.svg)

{% include [realized-waf-concept](../../_includes/smartwebsecurity/realized-waf-concept.md) %}

{% include [realized-arl-concept](../../_includes/smartwebsecurity/realized-arl-concept.md) %}

{{ sws-name }} logs are sent to [{{ cloud-logging-full-name }}](../../logging/).

{{ sws-name }} metrics are sent to [{{ monitoring-full-name }}](../../monitoring/).

{{ sws-name }} audit logs are sent to [{{ at-full-name }}](../../audit-trails/).

## {{ alb-name }} coniguration recommendations {#alb-settings-recommendation}

To enhance DDoS protection of your applications, follow these additional recommendations:

* Configure [autoscaling](../../application-load-balancer/concepts/application-load-balancer.md#lcu-scaling). This will allow you to dynamically adapt to the increased load and optimize traffic redistribution.

* Place resource units in multiple [availability zones](../../overview/concepts/geo-scope.md).

* Use the secure HTTPS protocol: [set up a listener](../../application-load-balancer/concepts/application-load-balancer.md#listener) to automatically redirect requests from HTTP to HTTPS.

* Establish protection at the lower OSI model level: [enable](../tutorials/alb-with-ddos-protection/console.md) basic DDOS protection at levels L3 and L4 to prevent part of attacks at an earlier stage.

These measures in addition to setting up {{ sws-name }} will increase the resilience of your services to potential threats and ensure secure operation of applications.
