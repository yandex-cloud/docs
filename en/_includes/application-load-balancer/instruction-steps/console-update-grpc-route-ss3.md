In the **{{ ui-key.yacloud.alb.label_route-action }}** field, select one of the options: `{{ ui-key.yacloud.alb.label_route-action-route }}` or `{{ ui-key.yacloud.alb.label_route-action-statusResponse }}`. Depending on the selected option:

{% list tabs %}

- {{ ui-key.yacloud.alb.label_route-action-route }}

  * {% include [console-create-http-route-choose-bg](./console-create-http-route-choose-bg.md) %}
  * {% include [console-create-http-route-host-rwrite](./console-create-http-route-host-rwrite.md) %}
  * {% include [console-create-http-route-native-rate-limiter](./console-create-http-route-native-rate-limiter.md) %}
  * Optionally, in the **{{ ui-key.yacloud.alb.label_max-timeout }}** field, specify the maximum connection time. You can specify a shorter timeout in the `grpc-timeout` request HTTP header.
  * Optionally, in the **{{ ui-key.yacloud.alb.label_idle-timeout }}** field, specify the connection idle timeout.

- {{ ui-key.yacloud.alb.label_route-action-statusResponse }}

  In the **{{ ui-key.yacloud.alb.label_grpc-status-code }}** field, select the static response code for the load balancer to return:

  * `OK`
  * `INVALID_ARGUMENT`
  * `NOT_FOUND`
  * `PERMISSION_DENIED`
  * `UNAUTHENTICATED`
  * `UNIMPLEMENTED`
  * `INTERNAL`
  * `UNAVAILABLE`

{% endlist %}