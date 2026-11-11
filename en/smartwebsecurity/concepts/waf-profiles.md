---
title: WAF profiles in {{ sws-full-name }}
description: 'WAF profile types in {{ sws-name }}: Cloud WAF and SolidWall WAF.'
---

# WAF profiles

A _WAF profile_ defines parameters for protecting web applications against application-layer attacks. {{ sws-name }} offers two profile types:

* [Cloud WAF](waf.md): Analysis of individual HTTP requests using rule sets and machine learning methods. The user configures the rules and exceptions themselves.
* [SolidWall WAF](solidwall-waf.md): Protection that is configured and maintained by our analytics team. Depending on your service plan, the system analyzes individual requests (or requests, responses, and sessions) given the application’s business logic.

Cloud WAF and SolidWall WAF operate independently of each other. You can connect them both to a single domain, or use them for different domains. For more details on how the protection products are different from each other, see [this article](solidwall-waf.md#features).
