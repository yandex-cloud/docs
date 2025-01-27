# Lists

{% include [lists-preview](../../_includes/smartwebsecurity/lists-preview.md) %}

With lists, you can create traffic filtering rules for IP address groups. You can add a list as a [condition](conditions.md) when creating [rules in the security profile](../operations/rule-add.md), [WAF](../operations/exclusion-rule-add.md), or [ARL](../operations/arl-rule-add.md). Thus, you can block some traffic, allow it through, or direct it to {{ captcha-name }} at the IP check step.

There are two types of lists:

* [Provided by {{ yandex-cloud }}](#yc-rules).
* [Custom](#user-rules).

## {{ yandex-cloud }} lists {#yc-rules}

{{ yandex-cloud }} lists are preset groups of IP addresses selected based on a particular attribute. These lists are regularly updated and provided as a part of the {{ sws-name }} feature set. Their purpose is to create an individual security strategy and automatically block potentially malicious traffic.

Description of preset lists:

* `is_ddoser`: IP addresses used in DDoS attacks. This list is based on data provided by different research organizations and security departments.
* `is_hosting`: IP addresses of hosting providers.
* `is_hosting`: IP addresses of mobile providers.
* `is_tor`: IP addresses of the Tor network used for traffic anonymization.
* `is_proxy`: IP addresses of public proxy servers. Access via a proxy can be used to hide the real IP address and potentially malicious activities.
* `is_vpn`: IP addresses of VPN providers. VPN is used for private access and spoofing IP addresses.
* `is_ml_vpn`: VPN provider IP addresses detected using machine learning algorithms.
* `is_anonimous`: IP addresses of anonymous networks. People often use such networks to hide their identity.

You cannot change or delete the preset lists.

## Custom lists {#user-rules}

In addition to preset lists, you can create your custom IP lists.

We recommend grouping them into these categories:

* **IP blacklist**: IP addresses used for attacks against your infrastructure or other undesirable actions, e.g., spam. You can block queries from these IP addresses automatically without applying the {{ sws-name }} rules to them.

* **IP whitelist**: IP addresses that are trusted within your organization. For example, branch office, partner, or contractor addresses. Queries you get from these can be let through automatically without additional checks on the {{ sws-name }} side.

{{ sws-name }} allows creating IP lists manually or by uploading ready-made files in `txt` or `csv` formats.

#### See also {#see-also}

* [{#T}](../operations/list-create.md)
* [{#T}](conditions.md)