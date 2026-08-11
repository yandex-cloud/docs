### Риск потери данных и недоступности кластера при отказе зоны доступности {#postgresql_ha_zone}

**Описание**

Все хосты кластера находятся в одной зоне доступности. В случае ее сбоя кластер станет недоступен. Распределите реплики по разным зонам для обеспечения высокой доступности.

{% include [one-host-cluster](../concept/one-host-cluster.md) %}

**Действие**

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