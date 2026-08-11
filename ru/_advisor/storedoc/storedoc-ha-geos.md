### Риск потери данных и недоступности кластера при отказе зоны {#storedoc_ha_geos}

**Описание**

Распределение хостов в кластере не обеспечивает защиту от сбоя в одной зоне доступности. Распределите реплики по разным зонам для обеспечения высокой доступности.

{% include [one-host-cluster](../concept/one-host-cluster.md) %}

**Действие**

Чтобы добавить хост в другую зону:

1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
1. Выберите кластер и перейдите на вкладку **{{ ui-key.yacloud.mdb.cluster.switch_hosts }}**.
1. Нажмите **{{ ui-key.yacloud.mdb.cluster.hosts.action_add-host }}**.
1. В параметрах хоста укажите альтернативную зону доступности.
1. Завершите настройку хоста и нажмите **{{ ui-key.yacloud.redis.hosts.dialog.button_choose }}**.