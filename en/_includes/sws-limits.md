#### Quotas {#quotas}

| **Type of limit** | **Value** |
----- | -----
| Maximum number of [security profiles](../smartwebsecurity/concepts/profiles.md) per [cloud](../resource-manager/concepts/resources-hierarchy.md#cloud) | 5 |
| Maximum number of [ARL profiles](../smartwebsecurity/concepts/arl.md) per cloud | 5 |
| Maximum number of [WAF profiles](../smartwebsecurity/concepts/waf.md) per cloud | 10 |
| Maximum total number of [security profile rules](../smartwebsecurity/concepts/rules.md) per cloud | 250 |
| Maximum total number of [WAF exclusion rules](../smartwebsecurity/concepts/waf.md#exclusion-rules) per cloud | 250 |
| Maximum total number of [ARL profile rules](../smartwebsecurity/concepts/rules.md#arl-rules) per cloud | 250 |
| Maximum total number of IP address mapping [conditions](../smartwebsecurity/concepts/conditions.md) per cloud | 2,500 |

#### Limits {#limits}

| **Type of limit** | **Value** |
----- | -----
| Maximum number of `HTTP header` conditions per rule | 20 |
| Maximum number of `Query Match` conditions per rule | 20 |
| Maximum number of IP addresses, prefixes, or IP address ranges per condition | 10,000 |
| Maximum number of `HTTP method` conditions per rule | 20 |
| Maximum number of `Host` conditions per rule | 20 |
| Maximum length of a string in a regular expression | 255 characters |
| Maximum number of requests per second (RPS) in total for all load balancer [virtual hosts](../application-load-balancer/concepts/http-router.md#virtual-host)<br/> connected to the same security profile^1^ | 20,000 |

^1^ If you expect more requests per second, contact your {{ yandex-cloud }} account manager.