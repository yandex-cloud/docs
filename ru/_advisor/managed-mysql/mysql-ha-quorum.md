### Риск потери данных и недоступности кластера при отказе зоны (кворум) {#mysql_ha_quorum}

**Описание**

Количество хостов, которые нужны для подтверждения транзакции, меньше максимального числа хостов в одной зоне доступности. Чтобы не потерять данные при отказе зоны, измените [значение](../../managed-mysql/concepts/settings-list.md#setting-rpl-wait-slave-count) `Rpl semi sync master wait for slave count` на значение, большее числа хостов в одной зоне доступности, либо перенесите часть хостов в другие зоны доступности.

**Действие**

Чтобы перенести хосты из одной зоны в другую:

1. [Создайте подсеть](../../vpc/operations/subnet-create.md) в зоне доступности, в которую вы переносите хосты.
1. Добавьте хост в кластер: [перейдите]({{ link-console-main }}/link/managed-mysql) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
1. Нажмите на имя нужного кластера и перейдите на вкладку **{{ ui-key.yacloud.mysql.cluster.switch_hosts }}**.
1. Нажмите кнопку ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.mdb.cluster.hosts.action_add-host }}**.
1. Укажите параметры хоста:

    * Зону доступности, куда переносятся хосты.
    * Новую подсеть.
    * Выберите опцию **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}**, если хост должен быть доступен извне {{ yandex-cloud }}.

1. Нажмите **{{ ui-key.yacloud.mdb.hosts.dialog.button_choose }}**.
1. Удалите хосты в первоначальной зоне доступности.

Чтобы изменить [значение](../../managed-mysql/concepts/settings-list.md#setting-rpl-wait-slave-count) `Rpl semi sync master wait for slave count`:

1. [Перейдите]({{ link-console-main }}/link/managed-mysql) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
1. Выберите кластер и нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** на панели сверху.
1. Измените настройку, нажав на кнопку **{{ ui-key.yacloud.mdb.forms.button_configure-settings }}** в блоке **{{ ui-key.yacloud.mdb.forms.section_settings }}**.
1. Сохраните изменения.

Подробнее о настройке кворума в разделе [Настройки {{ MY }}](../../managed-mysql/concepts/settings-list.md#setting-rpl-wait-slave-count).