{% note warning %}

Вы можете устанавливать соединения с кластерами управляемых баз данных из облаков и каталогов, которые принадлежат вашей [организации](../../organization/concepts/manage-services.md) {{ yandex-cloud }}. Если вы [перейдете в другую организацию](../../organization/operations/manage-organizations.md#switch-to-another-org), то вам будет доступен набор кластеров из других облаков и каталогов.

{% endnote %}

1. Убедитесь, что в настройках кластера [{{ PG }}](../../managed-postgresql/operations/cluster-create.md), [{{ MY }}](../../managed-mysql/operations/cluster-create.md) или [{{ CH }}](../../managed-clickhouse/operations/cluster-create.md) включена опция **{{ ui-key.yacloud.mdb.forms.additional-field-websql }}**.
1. В сервисе {{ websql-full-name }} перейдите в раздел **Диспетчер соединений** и в правом верхнем углу нажмите ![image](../../_assets/console-icons/square-plus.svg).
1. Заполните параметры подключения:
   * **Облако** — выберите облако.
   * **Каталог** — выберите каталог, в котором создан кластер базы данных.
   * **Кластер** — выберите кластер.
1. Нажмите **Подключиться** для подключения к выбранному кластеру.

Импортированные подключения будут доступны, пока вы работаете в текущей организации {{ yandex-cloud }}.