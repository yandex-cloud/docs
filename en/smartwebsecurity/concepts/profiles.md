# Security profiles

_Security profile_ is the main component in {{ sws-name }}. The profile consists of a set of [rules](rules.md), each including [conditions](conditions.md) for [actions](rules.md#rule-action) applied to HTTP requests received by the resource being protected.

You can create a profile:
* _From a preset template_. Preset profiles include:
   * [Basic default rule](rules.md#base-rules) enabled for all traffic.
   * [Smart Protection rule](rules.md#smart-protection-rules) enabled for all traffic, with the _Full protection_ type.
* _From scratch_. This profile includes only the basic default rule enabled for all traffic.

You can connect a security profile to the [{{ alb-full-name }}](../../application-load-balancer/) L7 load balancer's [virtual hosts](../../application-load-balancer/concepts/http-router.md#virtual-host). For more details, see [Managing virtual host connections](../operations/#hosts).

For details on working with profiles, see [Managing security profiles](../operations/#profiles).
