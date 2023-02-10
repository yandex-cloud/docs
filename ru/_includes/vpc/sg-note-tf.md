{% note info %}

В конфигурационном файле используются [группы безопасности](../../vpc/concepts/security-groups.md), они находятся на {% if audience != "internal" %}[стадии Preview](../../overview/concepts/launch-stages.md){% else %}стадии Preview{% endif %}. [Запросите в технической поддержке]({{ link-console-support }}/create-ticket) доступ к этой функции или удалите в конфигурационном файле блоки ресурсов `yandex_vpc_security_group` и строки с параметрами `security_group_ids`.

{% endnote %}
