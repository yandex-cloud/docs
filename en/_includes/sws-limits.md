#### Quotas {#quotas}

| **Type of limit** | **Value** |
----- | -----
| Maximum number of security profiles per cloud | 5 |
| Maximum total number of rules per cloud | 250 |
| Maximum total number of IP address mapping conditions per cloud | 2,500 |

#### Limits {#limits}

| **Type of limit** | **Value** |
----- | -----
| Maximum number of `HTTP header` conditions per rule | 20 |
| Maximum number of `Query Match` conditions per rule | 20 |
| Maximum number of IP addresses, prefixes, or IP address ranges per condition | 10,000 |
| Maximum number of `HTTP method` conditions per rule | 20 |
| Maximum number of `Host` conditions per rule | 20 |
| Maximum length of a string in a regular expression | 255 characters |
| Maximum number of requests per second (RPS) in total for all load balancer <br/>virtual hosts connected to the same security profile^1^ | 20,000 |

^1^ If you expect more requests per second, contact your {{ yandex-cloud }} account manager.