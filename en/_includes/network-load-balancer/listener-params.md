In the window that opens, specify these listener settings:

* **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.field_listener-name }}**.
* **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.field_listener-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}` or `{{ ui-key.yacloud.common.label_udp }}`.

  {% note info %}

  By default, the listener uses TCP. To use UDP, [contact technical support]({{ link-console-support }}).

  {% endnote %}

* **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.field_listener-port }}** where the listener will listen for incoming traffic. The possible values range from `1` to `32767`.
* **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.field_listener-target-port }}** to which the load balancer will redirect traffic. The possible values range from `1` to `32767`.