---
title: Yandex Application Load Balancer. Service overview
description: 'Yandex Application Load Balancer (L7-balancer, application layer load balancer) is a service for load balancing services and applications deployed in Yandex.Cloud. Application Load Balancer operates at the 7th level of the OSI model and transmits traffic over protocols HTTP and HTTPS to the backends of your applications.'
---

# Service overview

{{ alb-full-name }} (L7 load balancer, an application-level load balancer) is a service that balances the load between services and applications deployed in {{ yandex-cloud }}.

{{ alb-name }} runs at Layer 7 of the OSI model and transmits traffic over HTTP and HTTPS to the backends of your applications. The load is distributed based on the parameters of HTTP requests sent to the balancer, for example, based on the values of Host headers or the URI.

The L7 load balancer infrastructure facilitates development and operation of applications that use the microservice architecture. It establishes secure connections to clients and provides tools for flexible traffic distribution across backends and options to analyze processed requests.

Main components of the application load balancer:

* [Load balancer](application-load-balancer.md)
* [HTTP router](http-router.md)
* [Backend group](backend-group.md)
* [Target group](target-group.md)

