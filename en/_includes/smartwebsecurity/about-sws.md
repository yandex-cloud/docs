{{ sws-name }} protects your infrastructure from cybersecurity threats at OSI application level (L7). These may include DDoS attacks, bots, and SQL injections. In addition, you can enable DDoS protection at levels L3 and L4 using [{{ ddos-protection-full-name }}](../../vpc/ddos-protection/index.md).

{{ sws-name }} is a toolkit to protect infrastructures of various complexity and scale. Protection is achieved by cleaning malicious traffic from the incoming traffic flow. The traffic is checked against filtering rules in a security profile. You can additionally process the cleaned traffic with ARL profile rules to reduce the load on your application.

A security profile may include:

* Basic rules for simple traffic filtering based on specified conditions.
* Smart Protection rules for automatic protection against DDoS attacks with machine learning and behavior analysis algorithms.
* WAF profile rules for protection from application vulnerability exploits. Currently, you can connect the [OWASP Core Rule Set](https://owasp.org/www-project-modsecurity-core-rule-set/) (CRS) that blocks many known threats, such as SQL and command injections, cross-site scripting, and others.
* Built-in [{{ captcha-full-name }}](../smartcaptcha) to run [CAPTCHA](https://en.wikipedia.org/wiki/CAPTCHA) checks against bots and spam.
* IP address filtering lists to allow or block requests from specified IP addresses.

An ARL profile contains rules for limiting the number of requests to the protected resource based on various conditions.

You can connect a security profile to various types of resources:

* [Virtual host](../../application-load-balancer/concepts/http-router.md#virtual-host) or [Ingress controller](../../application-load-balancer/tools/k8s-ingress-controller/index.md#smart-web-security) to protect resources that use {{ alb-full-name }}. 
* [API Gateway](../../api-gateway/concepts/index.md) to protect the APIs of your applications.
* [Domain](../../smartwebsecurity/concepts/domain-protect.md) to protect your website or web application hosted in {{ yandex-cloud }} or other platforms.