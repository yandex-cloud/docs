In the **{{ ui-key.yacloud.alb.label_route-action }}** field, select one of the options: `{{ ui-key.yacloud.alb.label_route-action-route }}`, `{{ ui-key.yacloud.alb.label_route-action-redirect }}`, or `{{ ui-key.yacloud.alb.label_route-action-statusResponse }}`. Depending on the selected option:

{% list tabs %}

- {{ ui-key.yacloud.alb.label_route-action-route }}

  * {% include [console-create-http-route-choose-bg](./console-create-http-route-choose-bg.md) %}
  * Optionally, in the **{{ ui-key.yacloud.alb.label_prefix-rewrite }}** field, specify the path the HTTP router should redirect traffic to. If you select `{{ ui-key.yacloud.alb.label_match-exact }}` in the **{{ ui-key.yacloud.alb.label_path }}** field, the path will be completely replaced. If you select `{{ ui-key.yacloud.alb.label_match-prefix }}`, only the prefix will be changed.
  * {% include [console-create-http-route-host-rwrite](./console-create-http-route-host-rwrite.md) %}
  * {% include [console-create-http-route-native-rate-limiter](./console-create-http-route-native-rate-limiter.md) %}
  * Optionally, in the **{{ ui-key.yacloud.alb.label_timeout }}** field, specify the maximum connection time.
  * Optionally, in the **{{ ui-key.yacloud.alb.label_idle-timeout }}** field, specify the maximum connection idle timeout (keep-alive time).
  * Optionally, in the **{{ ui-key.yacloud.alb.label_upgrade-types }}** field:

      * Optionally, list the protocols the backend group can switch to within a TCP connection on client's request. To add more protocols, click **{{ ui-key.yacloud_billing.alb.button_add-upgrade-type }}**.
      * Optionally, enable **{{ ui-key.yacloud.alb.label_web-socket }}** if you want to use the [WebSocket](https://en.wikipedia.org/wiki/WebSocket) protocol.

- {{ ui-key.yacloud.alb.label_route-action-redirect }}

  * In the **{{ ui-key.yacloud.alb.label_http-status-code }}** field, select the HTTP forwarding status code:

      * `301 Moved Permanently`
      * `302 Found`
      * `303 See Other`
      * `307 Temporary Redirect`
      * `308 Permanent Redirect`
  * Optionally, enable **{{ ui-key.yacloud.alb.label_replace }}** and specify the modification type of the path the HTTP router should redirect traffic to:

      * `{{ ui-key.yacloud.alb.label_replace-exact }}`: To completely replace the request path with the value set in the field on the right.
      * `{{ ui-key.yacloud.alb.label_replace-prefix }}`: To replace the request path prefix with the value set in the field on the right.

      {% note info %}

      If you select `{{ ui-key.yacloud.alb.label_match-exact }}` in the **{{ ui-key.yacloud.alb.label_path }}** field above, the path will be completely replaced, even with `{{ ui-key.yacloud.alb.label_replace-prefix }}` selected in the **{{ ui-key.yacloud.alb.label_replace }}** field.

      {% endnote %}

  * Optionally, enable **{{ ui-key.yacloud.alb.label_strict-query }}** to remove all query parameters from requests.
  * Optionally, enable **{{ ui-key.yacloud.alb.label_replace-scheme }}** to replace the scheme found in requests with the one specified in the field on the right.

      If the original URI uses the `http` (`https`) scheme and port `80` (`443`), changing the scheme will delete the port.
  * Optionally, enable **{{ ui-key.yacloud.alb.label_replace-host }}** and specify the new host in the field on the right.
  * Optionally, enable **{{ ui-key.yacloud.alb.label_replace-port }}** and specify the new port in the field on the right.

- {{ ui-key.yacloud.alb.label_route-action-statusResponse }}

  * In the **{{ ui-key.yacloud.alb.label_http-status-code }}** field, select the static response code to return.
  * In the **{{ ui-key.yacloud.alb.label_body }}** field, set the static response body to return. To do this, click **{{ ui-key.yacloud.alb.button_select }}** and in the window that opens:

      * In the **{{ ui-key.yacloud.component.file-content-dialog.field_method }}** field, select:

          * `{{ ui-key.yacloud.component.file-content-dialog.value_upload }}`: To select a text file containing the response body.
          * `{{ ui-key.yacloud.component.file-content-dialog.value_manual }}`: To enter the response text in the relevant text box.
          * Click **{{ ui-key.yacloud.component.file-content-dialog.button_submit }}**.

{% endlist %}