(Опционально) Под блоком **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check }}** нажмите **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.label_edit-health-check }}**. В открывшемся окне задайте параметры [проверки состояния ресурсов](../../network-load-balancer/concepts/health-check.md):

1. **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-name }}**. Требования к имени:

    {% include [name-format](../name-format.md) %}

1. **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-protocol }}** — `{{ ui-key.yacloud.common.label_http }}`, `{{ ui-key.yacloud.common.label_tcp }}`, `{{ ui-key.yacloud.common.label_http2 }}`, `{{ ui-key.yacloud.common.label_https }}` или `{{ ui-key.yacloud.common.label_grpc }}`.
1. **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-path }}** — укажите адрес URL, по которому будут выполняться проверки (для типов `{{ ui-key.yacloud.common.label_http }}`, `{{ ui-key.yacloud.common.label_http2 }}`, `{{ ui-key.yacloud.common.label_https }}`, `{{ ui-key.yacloud.common.label_grpc }}`).
1. **{{ ui-key.yacloud.compute.group.overview.label_host }}** — укажите хост (для типов `{{ ui-key.yacloud.common.label_http2 }}`, `{{ ui-key.yacloud.common.label_https }}`, `{{ ui-key.yacloud.common.label_grpc }}`).
1. **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-port }}** для проверок. Возможные значения: от `1` до `32767`.
1. **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-timeout }}** — время ожидания ответа в секундах. Возможные значения: от `1` до `60`. Интервал должен быть больше времени ожидания минимум на 1 секунду.
1. **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-interval }}** — интервал выполнения проверок состояния в секундах. Возможные значения: от `1` до `60`.
1. **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-healthy-threshold }}** — количество успешных проверок, после которого виртуальная машина будет считаться готовой к приему трафика.
1. **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-unhealthy-threshold }}** — количество проваленных проверок, после которого на виртуальную машину перестанет подаваться трафик.
1. Нажмите **{{ ui-key.yacloud.common.apply }}**.