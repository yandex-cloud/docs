В открывшемся окне задайте параметры обработчика:

* **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.field_listener-name }}**.
* **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.field_listener-protocol }}** — `{{ ui-key.yacloud.common.label_tcp }}` или `{{ ui-key.yacloud.common.label_udp }}`.

  {% note info %}

  По умолчанию обработчик работает по протоколу TCP. Чтобы использовать протокол UDP, [запросите в технической поддержке]({{ link-console-support }}) эту возможность.

  {% endnote %}

* **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.field_listener-port }}**, на котором обработчик будет принимать входящий трафик. Возможные значения: от `1` до `32767`.
* **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.field_listener-target-port }}**, куда балансировщик будет направлять трафик. Возможные значения: от `1` до `32767`.