Labels shared by all {{ sws-name }} metrics:

| Label | Value |
| --- | --- |
| **Common labels** |
| load_balancer | [L7 load balancer](../../../application-load-balancer/concepts/application-load-balancer.md) name |
| http_router | [HTTP router](../../../application-load-balancer/concepts/http-router.md) name |
| virtual_host | [Virtual host](../../../application-load-balancer/concepts/http-router.md#virtual-host) name |
| **Special labels** |
| security_profile | [Security profile](../../../smartwebsecurity/concepts/profiles.md) ID |
| rule_name | [Security rule](../../../smartwebsecurity/concepts/rules.md) name |

| Name<br>Type, units | Description |
| --- | --- |
| `load_balancer.smart_web_security.`<br/>`requests_per_second`<br/>`DGAUGE`, requests per second | Number of requests sent to the protected resource per second.<br/>Common labels:<ul><li>`route`: [Route](../../../application-load-balancer/concepts/http-router.md#routes) name.</li><li>`zone`: [Availability zone](../../../overview/concepts/geo-scope.md).</li><li>`backend`: Backend name.</li><li>`backend_group`: [Backend group](../../../application-load-balancer/concepts/backend-group.md) name.</li></ul><br/>This metric features the `antirobot_verdict` special label containing the action to take on the request based on validation results. The possible values are:<ul><li>`allow`: Request sent to a virtual host.</li><li>`captcha`: Request sent to [{{ captcha-full-name }}](../../../smartcaptcha/) for additional verification.</li><li>`deny`: Request blocked.</li></ul></li></ul> |
| `load_balancer.smart_web_security.`<br/>`arl_requests_per_second`<br/>`DGAUGE`, requests per second | Number of requests sent to the protected resource through [Advanced Rate Limiter](../../../smartwebsecurity/concepts/arl.md) per second.<br/>This metric features the `folderId` common label containing the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) ID.<br/><br/>Special labels:<ul><li>`arl_profile`: Advanced Rate Limiter profile ID.</li><li>`arl_verdict`: Action to take on the request based on validation results. The possible values are:<ul><li>`allow`: Request sent to a virtual host.</li><li>`deny`: Request blocked.</li></ul></li></ul> |