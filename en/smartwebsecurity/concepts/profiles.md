# Security profiles

_Security profile_ is the main {{ sws-name }} component. A security profile consists of a set of HTTP traffic processing [rules](rules.md). The rules contain filtering [conditions](conditions.md) and [actions](rules.md#rule-action) that apply to your web resource's incoming traffic. Security profiles also allow configuring a [CAPTCHA](https://en.wikipedia.org/wiki/CAPTCHA) and request limits based on various conditions. 

{% include [user-data-to-ml](../../_includes/smartwebsecurity/user-data-to-ml.md)%}

You can create security profiles in different ways:
  * _{{ ui-key.yacloud.smart-web-security.title_default-template }}_. A preset profile includes:
    * [Basic default rule](rules.md#base-rules), enabled for all traffic.
    * [Smart Protection rule](rules.md#smart-protection-rules) enabled for all traffic with the _{{ ui-key.yacloud.smart-web-security.overview.cell_mode-full }}_ action type.
  * _{{ ui-key.yacloud.smart-web-security.title_no-template }}_. This profile includes only the basic default rule enabled for all traffic.

{% include [setting-by-expert](../../_includes/smartwebsecurity/setting-by-expert.md) %}

[Connect a security profile](../operations/host-connect.md) to your resource to enable {{ sws-name }} protection.

{% include [sws-type-resources](../../_includes/smartwebsecurity/sws-type-resources.md) %}

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
