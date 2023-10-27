# Security profiles

_Security profile_ is the main component in {{ sws-name }}. The profile consists of a set of [rules](rules.md), each including [conditions](conditions.md) for [actions](rules.md#rule-action) applied to HTTP requests received by the resource being protected.

You can create a profile:
* _{{ ui-key.yacloud.smart-web-security.title_default-template }}_. Preconfigured profiles include:
   * [Basic default rule](rules.md#base-rules) enabled for all traffic.
   * [Smart Protection rule](rules.md#smart-protection-rules) enabled for all traffic with the _{{ ui-key.yacloud.smart-web-security.overview.cell_mode-full }}_ action type.
* _{{ ui-key.yacloud.smart-web-security.title_no-template }}_. This profile includes only the basic default rule enabled for all traffic.

You can connect a security profile to the [{{ alb-full-name }}](../../application-load-balancer/) L7 load balancer's [virtual hosts](../../application-load-balancer/concepts/http-router.md#virtual-host). For more information, see [Managing virtual host connections](../operations/#hosts).

For details on working with profiles, see [Managing security profiles](../operations/#profiles).
