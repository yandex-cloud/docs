* In the **{{ ui-key.yacloud.alb.label_modification-type }}** field, select where you want to modify the header:
    * `{{ ui-key.yacloud.alb.label_header-request }}`: To modify incoming request headers, from client to load balancer.
    * `{{ ui-key.yacloud.alb.label_header-response }}`: To modify outgoing response headers, from backend to external client.
* In the **{{ ui-key.yacloud.alb.label_modification-header }}** field, give the header a name, e.g., `Host`, `User-Agent`, `X-Forwarded-For`, `Strict-Transport-Security`, etc.
* In the **{{ ui-key.yacloud.alb.label_modification-operation }}** field, select an action:
    * `append`: To add a string to the header value. Specify the string in the field on the right.
    * `replace`: To completely replace the header value. Specify the new header value in the field on the right.
    * `remove`: To delete the header. Both the header value and the header itself will be removed.
    * `rename`: To change the header name. Specify the new header name in the field on the right. The header value will not change.

If required, click **{{ ui-key.yacloud_billing.alb.button_add-modification }}** to add new rows if you need to modify multiple headers at once.