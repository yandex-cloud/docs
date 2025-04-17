# Security profiles

_Security profile_ is the main component in {{ sws-name }}. The profile consists of [rules](rules.md), each including [conditions](conditions.md) for applying certain [actions](rules.md#rule-action) to HTTP requests received via the [virtual host](../../application-load-balancer/concepts/http-router.md#virtual-host) of the [{{ alb-full-name }}](../../application-load-balancer/concepts/index.md) L7 load balancer by the resource being protected.

{% include [user-data-to-ml](../../_includes/smartwebsecurity/user-data-to-ml.md)%}

You can create a profile:
  * _{{ ui-key.yacloud.smart-web-security.title_default-template }}_. A preset profile includes:
    * [Basic default rule](rules.md#base-rules), enabled for all traffic.
    * [Smart Protection rule](rules.md#smart-protection-rules) enabled for all traffic with the _{{ ui-key.yacloud.smart-web-security.overview.cell_mode-full }}_ action type.
  * _{{ ui-key.yacloud.smart-web-security.title_no-template }}_. This profile includes only the basic default rule enabled for all traffic.

To activate {{ sws-name }}, [connect the security profile](../operations/host-connect.md) to the virtual host of the L7 load balancer from which the traffic is distributed to the resources being protected. When an {{ alb-name }} [Ingress controller](../../application-load-balancer/tools/k8s-ingress-controller/index.md) manages the load balancer, connect the security profile using an [Ingress resource annotation](../../application-load-balancer/k8s-ref/ingress.md).

## Request body analysis {#analyze-request-body}

In the security profile, you can enable request body inspection to improve the web application's performance and security. Limiting the maximum request body size prevents excessive resource consumption and mitigates the effects of DoS/DDoS attacks, where attackers submit large requests in order to exhaust the server's resources.

When you configure a security profile, you can select an action for when the maximum request body size is exceeded:

* `{{ ui-key.yacloud.smart-web-security.waf.label_analyze-request-body-action-ignore }}`: Use it when a legitimate application frequently sends large requests.
* `{{ ui-key.yacloud.smart-web-security.waf.label_analyze-request-body-action-deny }}`: This is a universal and secure approach. {{ sws-name }} blocks any requests exceeding the 8 KB limit, reducing the risk of attacks. If a request is blocked, {{ sws-name }} returns a `403` error.

## Profiles and rules diagram {#profile-rules-schema}

The diagram below illustrates the relationship between {{ sws-name }} profiles and rules. Security profile is the main {{ sws-name }} component you can use to set up basic rules and Smart Protection. You can additionally connect a WAF profile (through a WAF rule), an ARL profile, and {{ captcha-name }}.

![profiles-rules](../../_assets/smartwebsecurity/profiles-rules.svg)

#### See also {#see-also}

* [Managing security profiles](../operations/index.md#profiles)
* [Setting up an Ingress controller and test applications](../../managed-kubernetes/tutorials/alb-ingress-controller.md#create-ingress-and-apps)
