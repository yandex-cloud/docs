Common labels for all {{ sws-name }} metrics:

| Label | Value |
| --- | --- |
| **Common labels** |
| load_balancer | [L7 load balancer](../../../application-load-balancer/concepts/application-load-balancer.md) name |
| http_router | [HTTP router](../../../application-load-balancer/concepts/http-router.md) name |
| virtual_host | Name of the [virtual host](../../../application-load-balancer/concepts/http-router.md#virtual-host) |
| **Special labels** |
| security_profile | [Security profile](../../../smartwebsecurity/concepts/profiles.md) ID |
| rule_name | [Security rule](../../../smartwebsecurity/concepts/rules.md) name |

| First name<br>Type, units | Description |
| --- | --- |
| `load_balancer.smart_web_security.`<br/>`requests_per_second`<br/>`DGAUGE`, requests per second | Number of requests to the protected resource per second.<br/>Common labels:<ul><li>`route`: [Route](../../../application-load-balancer/concepts/http-router.md#routes) name.</li><li>`zone`: [Availability zone](../../../overview/concepts/geo-scope.md).</li><li>`backend`: Backend name.</li><li>`backend_group`: [Backend group](../../../application-load-balancer/concepts/backend-group.md) name.</li></ul><br/>`antirobot_verdict` special label: Action with a request based on the results of checks. Possible values:<ul><li>`allow`: Request sent to a virtual host.</li><li>`captcha`: Request sent to [{{ captcha-full-name }}](../../../smartcaptcha/) for additional verification.</li><li>`deny`: Request blocked.</li></ul></li></ul> |
| `load_balancer.smart_web_security.`<br/>`arl_requests_per_second`<br/>`DGAUGE`, requests per second | Number of requests per second to the protected resource passed through the [Advanced Rate Limiter](../../../smartwebsecurity/concepts/arl.md) module.<br/>`folderId` common label: [Folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) ID.<br/><br/>Special labels:<ul><li>`arl_profile`: Advanced Rate Limiter profile ID.</li><li>`arl_verdict`: Action with a request based on the results of checks. Possible values:<ul><li>`allow`: Request sent to a virtual host.</li><li>`deny`: Request blocked.</li></ul></li></ul> |