---
title: Lists for creating traffic filtering rules
description: What preset and custom lists are available in {{ sws-name }} and how to use them under traffic filtering conditions.
---

# Lists

{% include [lists-preview](../../_includes/smartwebsecurity/lists-preview.md) %}

Lists help you create traffic filtering rules based on groups of IP addresses, [ASNs](https://en.wikipedia.org/wiki/Autonomous_system_(Internet)), [regular expressions](conditions.md#regular-expressions), and string values. You can add a list as a [condition](conditions.md) when creating [rules in the security profile](../operations/rule-add.md), [WAF](../operations/exclusion-rule-add.md), or [ARL](../operations/arl-rule-add.md). Thus, you can block some traffic, let it through, or direct it to {{ captcha-name }} at the early stages of request processing.

There are two types of lists:

* [Provided by {{ yandex-cloud }}](#yc-rules).
* [Custom](#user-rules).

## {{ yandex-cloud }} lists {#yc-rules}

{{ yandex-cloud }} lists are preset groups of values selected based on a particular attribute. These lists are regularly updated and provided as a part of the {{ sws-name }} feature set. Their purpose is to create an individual security strategy and automatically block potentially malicious traffic.

{{ sws-name }} provides several types of lists: IP addresses, [bots](botes.md#legitimate-bots), and [bot categories](botes.md#bot-categories).

Description of preset IP address lists:

* `is_ddoser`: IP addresses used in DDoS attacks. This list is based on data provided by different research organizations and security departments.
* `is_hosting`: IP addresses of hosting providers.
* `is_mobile`: IP addresses of mobile providers.
* `is_tor`: IP addresses of the Tor network used for traffic anonymization.
* `is_proxy`: IP addresses of public proxy servers. Access via a proxy can be used to hide the real IP address and potentially malicious activities.
* `is_vpn`: IP addresses of VPN providers. VPN is used for private access and spoofing IP addresses.
* `is_ml_vpn`: VPN provider IP addresses detected using machine learning algorithms.
* `is_anonymous`: IP addresses of anonymous networks. People often use such networks to hide their identity.

You cannot change or delete the preset lists.

## Custom lists {#user-rules}

In addition to preset lists, you can create your custom value sets.

There is a dedicated list for each value type: IP addresses, ASNs, string values, or regular expressions. You can group multiple values of the same type into a single list and reference that list across one or more rules.

Regular expression lists allow you to combine several values, e.g., request paths or HTTP header values, into a single filtering condition. You can use the following in expressions:

* `|`: Selects an option: `(v1|v2)` is the same as `v1` or `v2`.
* `?`: Makes the preceding element optional: `/promo/?` is the same as `/promo` and `/promo/`.
* `.*`: Sequence of characters, including an empty one: `/assets/.*` is the same as any path starting with `/assets/`.
* `\`: Escapes special characters: `logo\.svg`.

The `^` and `$` anchors are not supported in regular expressions. Read more about [regular expression syntax](conditions.md#regular-expressions).

To filter by path, connect a list of strings or regular expressions to the `Request URI` condition. For example, a string list can contain `/login`, `/checkout`, and `/api/v1/users`. Specify paths without the schema, domain, or query parameters. To filter by domain, add the `Host` condition and combine it with `Request URI` using the _AND_ operator.

We recommend grouping them into one of these categories:

* **Blacklist**: Values used in attacks against your infrastructure or other undesirable actions, e.g., spamming. You can block queries with such values automatically without applying the {{ sws-name }} rules to them.

* **Whitelist**: Values that are trusted within your organization. For example, branch office, partner, or contractor IP addresses. Queries with these values can be let through automatically without additional checks on the {{ sws-name }} side.

In {{ sws-name }}, you can create lists manually or upload ready-made `txt` or `csv` list files.

#### Useful links {#see-also}

* [{#T}](../operations/list-create.md)
* [{#T}](conditions.md)
