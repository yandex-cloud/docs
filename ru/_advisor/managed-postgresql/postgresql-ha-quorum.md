### Риск потери данных и недоступности кластера при отказе зоны (кворум) {#postgresql_ha_quorum}

**Описание**

Текущая конфигурация позволяет достичь кворума репликации в пределах одной зоны. Если эта зона станет недоступна, возможна потеря данных. Необходимо увеличить число хостов в других зонах или настроить кворум так, чтобы он был больше, чем число хостов в одной зоне.

**Действие**

Чтобы добавить хост в другую зону:

1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
1. Выберите кластер и перейдите на вкладку **{{ ui-key.yacloud.postgresql.cluster.switch_hosts }}**.
1. Нажмите **{{ ui-key.yacloud.mdb.cluster.hosts.action_add-host }}**.
1. В параметрах хоста укажите альтернативную зону доступности.
1. Завершите настройку хоста и нажмите **{{ ui-key.yacloud.postgresql.hosts.dialog.button_choose }}**.

Чтобы перенести хост в другую зону доступности:

1. [Создайте подсеть](../../vpc/operations/subnet-create.md) в зоне доступности, в которую вы переносите хост.
1. Добавьте хост в кластер: [перейдите]({{ link-console-main }}/link/managed-postgresql) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
1. Нажмите на имя нужного кластера и перейдите на вкладку **{{ ui-key.yacloud.postgresql.cluster.switch_hosts }}**.
1. Нажмите кнопку ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.mdb.cluster.hosts.action_add-host }}**.
1. Укажите параметры хоста:

    * Зону доступности, куда переносятся хосты.
    * Новую подсеть.
    * Выберите опцию **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}**, если хост должен быть доступен извне {{ yandex-cloud }}.

1. Нажмите **{{ ui-key.yacloud.mdb.hosts.dialog.button_choose }}**.

Подробнее про кворум репликации в разделе [Репликация в {{ mpg-name }}](../../managed-postgresql/concepts/replication.md).