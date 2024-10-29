{% note warning %}

При ручной (`OPPORTUNISTIC`) [стратегии остановки](../../compute/concepts/instance-groups/policies/deploy-policy.md#strategy) ВМ {{ ig-name }} будет запускать перезагрузку или пересоздание ВМ только при одном из условий:
* пользователь [остановил](../../compute/operations/vm-control/vm-stop-and-start.md#stop) ВМ в сервисе {{ compute-name }};
* приложение или пользователь остановили ВМ изнутри;
* ВМ не прошла [проверку](../../compute/concepts/instance-groups/autohealing.md#functional-healthcheck) состояния приложения.

{% endnote %}
