#### Quotas {#quotas}

#|
|| Type of limit | Value ||
|| Number of [security profiles](../smartwebsecurity/concepts/profiles.md) per [cloud](../resource-manager/concepts/resources-hierarchy.md#cloud)
`smart-web-security.securityProfiles.count` | 5 ||
|| Number of [ARL profiles](../smartwebsecurity/concepts/arl.md) per cloud
`smart-web-security.advancedRateLimiterProfiles.count` | 5 ||
|| Number of [WAF profiles](../smartwebsecurity/concepts/waf.md) per cloud
`smart-web-security.wafProfiles.count` | 10 ||
|| Total number of [security profile rules](../smartwebsecurity/concepts/rules.md) per cloud
`smart-web-security.securityProfileRules.count` | 250 ||
|| Total number of [WAF exclusion rules](../smartwebsecurity/concepts/waf.md#exclusion-rules) per cloud
`smart-web-security.wafProfileExclusionRules.count` | 250 ||
|| Total number of [ARL profile rules](../smartwebsecurity/concepts/rules.md#arl-rules) per cloud
`smart-web-security.advancedRateLimiterProfileRules.count` | 250 ||
|| Total number of IP address mapping [conditions](../smartwebsecurity/concepts/conditions.md) per cloud
`smart-web-security.ipMatchers.count` | 2,500 ||
|| Number of IP address lists per cloud
`smart-web-security.ipMatchLists.count` | 20 ||
|| Number of ASN lists per cloud
`smart-web-security.asnMatchLists.count` | 20 ||
|| Number of string lists per cloud
`smart-web-security.strMatchLists.count` | 20 ||
|| Number of regular expression lists per cloud
`smart-web-security.regExpMatchLists.count` | 2 ||
|| Number of unique IP address lists per profile
`smart-web-security.uniqueIPMatchListsPerProfile.count` | 40 ||
|| Total number of IP address lists per profile (including repetitions)
`smart-web-security.ipMatchListsPerProfile.count` | 100 ||
|| Number of unique ASN lists per profile
`smart-web-security.uniqueAsnMatchListsPerProfile.count` | 40 ||
|| Total number of ASN lists per profile (including repetitions)
`smart-web-security.asnMatchListsPerProfile.count` | 100 ||
|| Number of unique string lists per profile
`smart-web-security.uniqueStrMatchListsPerProfile.count` | 40 ||
|| Total number of string lists per profile (including repetitions)
`smart-web-security.strMatchListsPerProfile.count` | 100 ||
|| Number of unique regular expression lists per profile
`smart-web-security.uniqueRegExpMatchListsPerProfile.count` | 10 ||
|| Total number of regular expression lists per profile (including repetitions)
`smart-web-security.regExpMatchListsPerProfile.count` | 10 ||
|| Number of items per IP address list
`smart-web-security.ipMatchListItems.count` | 10,000 ||
|| Number of items per ASN list
`smart-web-security.asnMatchListItems.count` | 200 ||
|| Number of items per string list
`smart-web-security.strMatchListItems.count` | 100 ||
|| Number of items per regular expression list
`smart-web-security.regExpMatchListItems.count` | 10 ||
|| Total number of [proxy servers](../smartwebsecurity/concepts/domain-protect.md#proxy) per cloud 
`smart-web-security.loadBalancers.count` | 1 ||
|| Total number of [domains](../smartwebsecurity/concepts/domain-protect.md#domain) per cloud 
`smart-web-security.loadBalancerDomains.count` | 10 ||
|| Total number of [response templates](../smartwebsecurity/concepts/response-templates.md) per cloud
`smart-web-security.customPages.count` | 20 ||
|#

#### Limits {#limits}

**Type of limit** | **Value**
----- | -----
Number of `HTTP header` conditions per rule | 20
Number of `Query Match` conditions per rule | 20
Number of IP addresses, prefixes, or IP address ranges per condition | 10,000
Number of `HTTP method` conditions per rule | 20
Number of `Host` conditions per rule | 20
Regular expression string length | 255 characters
Number of requests per second (RPS) in total for all load balancer [virtual hosts](../application-load-balancer/concepts/http-router.md#virtual-host)<br/> connected to the same security profile^1^ | 20,000
Number of domains per proxy server | 20
Number of target IP addresses per domain | 20
Number of items per IP address list | 100,000
Number of items per ASN list | 2,000
Number of items per string list | 2,000
Number of items per regular expression list | 100

^1^ If you expect more requests per second, contact your {{ yandex-cloud }} account manager.
