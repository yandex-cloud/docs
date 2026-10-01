{% note info %}

В примерах установки используется IPv4-адресация. {{ objstorage-onprem-name }} также поддерживает IPv6.

Для использования IPv6 укажите IPv6-адреса и подсети в [конфигурации стенда](../install/setup-install-params.md). В файле `group_vars/<имя_стенда>/main.yaml` задайте `ip_type: IPv6`, а в блоке `bootstrap.values_object` — `ipType: ipv6`. Для параметра `k8s.block_size` рекомендуется значение `122`.

При использовании IPv6 отключите автоматическую настройку VXLAN: задайте `vxlan.enabled: false` и настройте сеть вручную до запуска установки.

{% endnote %}
