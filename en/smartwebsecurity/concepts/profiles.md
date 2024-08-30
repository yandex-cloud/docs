# Security profiles

_Security profile_ is the main component in {{ sws-name }}. The profile consists of [rules](rules.md), each including [conditions](conditions.md) for applying certain [actions](rules.md#rule-action) to HTTP requests received via the [virtual host](../../application-load-balancer/concepts/http-router.md#virtual-host) of the [{{ alb-full-name }}](../../application-load-balancer/concepts/index.md) L7 load balancer by the resource being protected.

You can create a profile:
* _{{ ui-key.yacloud.smart-web-security.title_default-template }}_​. A preset profile includes:
   * [Basic default rule](rules.md#base-rules) enabled for all traffic.
   * [Smart Protection rule](rules.md#smart-protection-rules) enabled for all traffic with the _{{ ui-key.yacloud.smart-web-security.overview.cell_mode-full }}_ action type.
* _{{ ui-key.yacloud.smart-web-security.title_no-template }}_​. This profile includes only the basic default rule enabled for all traffic.

To activate {{ sws-name }}, [connect the security profile](../operations/host-connect.md) to the virtual host of the L7 load balancer from which the traffic is distributed to the resources being protected. When an {{ alb-name }} [Ingress controller](../../application-load-balancer/tools/k8s-ingress-controller/index.md) manages the load balancer, connect the security profile using an [Ingress resource annotation](../../application-load-balancer/k8s-ref/ingress.md).

#### See also {#see-also}

* [Managing security profiles](../operations/index.md#profiles)
* [{#T}](../../managed-kubernetes/tutorials/alb-ingress-controller.md#create-ingress-and-apps)
