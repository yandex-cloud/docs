### Риск недоступности из-за размещения сервиса координации на хостах {#clickhouse_ha_embedded_keeper}

**Описание**

Конфигурация, в которой {{ CH }} и {{ CK }} размещены на одних хостах, не является высокодоступной. Разместите {{ CK }} на отдельных хостах.


{% include [one-host-cluster](../concept/one-host-cluster.md) %}

**Действие**

Чтобы изменить настройки {{ CK }}:

1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
1. Выберите кластер и нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** на панели сверху.
1. Для сервиса координации **{{ ui-key.yacloud.clickhouse.cluster.value_coordination-service-separated-clickhouse-keeper }}** в блоке **{{ ui-key.yacloud.clickhouse.cluster.section_clickhouse-keeper-resource }}** выберите платформу, тип виртуальной машины и [класс хоста](../../managed-clickhouse/concepts/instance-types.md).