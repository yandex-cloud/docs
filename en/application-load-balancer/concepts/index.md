---
title: '{{ alb-full-name }}. Overview'
description: '{{ alb-full-name }} (L7 load balancer, application layer load balancer) is a service for distributing load across services and applications deployed in {{ yandex-cloud }}. {{ alb-name }} runs at Layer 7 of the OSI model and transmits traffic over HTTP and HTTPS to the backends of your applications.'
---

# {{ alb-full-name }} overview

{{ alb-full-name }} (L7 load balancer, an application-level load balancer) is a service that balances the load between services and applications deployed in {{ yandex-cloud }}.

{{ alb-name }} runs at Layer 7 of the OSI model and transmits traffic over HTTP and HTTPS to the backends of your applications. The load is distributed based on the parameters of HTTP requests sent to the balancer, for example, based on the values of Host headers or the URI. {{ alb-name }} also allows you to process TCP traffic, including its TLS decryption.

You can use the L7 load balancer along with [{{ sws-full-name }}](../../smartwebsecurity/concepts/index.md) to protect backends against DDoS attacks and bots, as well as use a [WAF](../../smartwebsecurity/concepts/waf.md) and [reduce the load](../../smartwebsecurity/concepts/arl.md) on the protected resource.

The L7 load balancer infrastructure facilitates development and operation of applications that use the microservice architecture. It establishes secure connections to clients and provides tools for flexible traffic distribution across backends and options to analyze processed requests.

Main components of {{ alb-name }} infrastructure:

* [Load balancer](application-load-balancer.md)
* [HTTP router](http-router.md)
* [Backend group](backend-group.md)
* [Target group](target-group.md)

You can create these components one by one or [use the wizard](../quickstart-wizard.md).

## {{ alb-name }} wizard {#alb-wizard}

The wizard assist you in creating the {{ alb-name }} infrastructure:

* It has all the required configuration on a single page.
* It automatically selects the infrastructure components created at the previous step.
* You can return to the previous step at any time.
* You can skip components you have already created.
* It suggests optimal default values for common scenarios and creates auxiliary elements.
* For custom scenarios, you can use the fine-tune mode enabled with the **{{ ui-key.yacloud.alb.label_detailed-settings }}** switch.

