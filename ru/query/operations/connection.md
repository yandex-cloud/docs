# Управление соединениями

[Соединение](../concepts/glossary.md#connection) необходимо для подключения {{ yq-full-name }} к источникам и приемникам данных.

## Создать соединение {#create}

Чтобы создать соединение:

1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно создать соединение.
1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_yq_ru }}**.
1. На панели слева выберите **{{ ui-key.yql.yq-ide-aside.connections.tab-text }}**.
1. Нажмите кнопку ![info](../../_assets/console-icons/plus.svg) **{{ ui-key.yql.yq-connection-form.action_create-new }}**.
1. Введите имя и описание соединения. Требования к имени:

    {% include [name-format](../_includes/connection-name-format.md) %}

1. Выберите тип соединения и укажите **{{ ui-key.yql.yq-connection-form.connection-type-parameters.section-title }}**:

   {% list tabs %}

   - {{ objstorage-short-name }}

     * **{{ ui-key.yql.yq-connection-form.bucket-auth.input-label }}**: `{{ ui-key.yql.yq-connection-form.public.button-text }}` или `{{ ui-key.yql.yq-connection-form.private.button-text }}`.
     * Для публичного бакета введите имя в поле **{{ ui-key.yql.yq-connection-form.bucket.input-label }}**.
       Для приватного бакета выберите:
       * **{{ ui-key.yql.yq-connection-form.cloud.input-label }}**, в котором находится источник данных.
       * Выберите или создайте новый бакет.
       * Выберите или создайте новый [сервисный аккаунт](../../iam/concepts/users/service-accounts.md), от имени которого будет выполняться доступ к данным.

   - {{ yds-short-name }}

     * Выберите **{{ ui-key.yql.yq-connection-form.cloud.input-label }}**, в котором находится источник данных.
     * Выберите или создайте новую [serverless базу данных {{ ydb-name }}](../../ydb/) с [потоком данных](../../data-streams/concepts/index.md) {{ yds-full-name }}.
     * Выберите или создайте новый [сервисный аккаунт](../../iam/concepts/users/service-accounts.md), от имени которого будет выполняться доступ к данным.

   - {{ mpg-name }}

      * **{{ ui-key.yql.yq-connection-form.cluster.input-label }}** — выберите существующий кластер {{ mpg-name }} или создайте новый.
      * **{{ ui-key.yql.yq-connection-form.service-account.input-label }}** — выберите существующий [сервисный аккаунт](../../iam/concepts/users/service-accounts.md) {{ mpg-name }} или создайте новый с ролью [`{{ roles.mpg.viewer }}`](../../managed-postgresql/security/index.md#mpg-viewer), от имени которого будет выполняться подключение к кластерам `{{ mpg-name }}`.
      * **{{ ui-key.yql.yq-connection-form.login.input-label }}**  — имя пользователя, которое будет использоваться для подключения к базам данных {{ PG }}.
      * **{{ ui-key.yql.yq-connection-form.password.input-label }}**  — пароль пользователя, который будет использоваться для подключения к базам данных {{ PG }}.


   - {{ mch-name }}

      * **{{ ui-key.yql.yq-connection-form.cluster.input-label }}** — выберите существующий кластер {{ mch-name }} или создайте новый.
      * **{{ ui-key.yql.yq-connection-form.service-account.input-label }}** — выберите существующий [сервисный аккаунт](../../iam/concepts/users/service-accounts.md) {{ mch-name }} или создайте новый с ролью [`{{ roles.mch.viewer }}`](../../managed-clickhouse/security/index.md#mch-viewer), от имени которого будет выполняться подключение к кластерам `{{ mch-name }}`.
      * **{{ ui-key.yql.yq-connection-form.login.input-label }}**  — имя пользователя, которое будет использоваться для подключения к базам данных {{ CH }}.
      * **{{ ui-key.yql.yq-connection-form.password.input-label }}**  — пароль пользователя, который будет использоваться для подключения к базам данных {{ CH }}.


   - {{ monitoring-short-name }}

     * Выберите **{{ ui-key.yql.yq-connection-form.cloud.input-label }}**, в котором находится источник данных.
     * Выберите или создайте новый [сервисный аккаунт](../../iam/concepts/users/service-accounts.md), от имени которого будет выполняться запись метрик.

   {% endlist %}

1. Нажмите кнопку **{{ ui-key.yql.yq-connection-form.create.button-text }}**.

Далее вы можете [создать привязку](binding.md#create).

## Получить информацию о соединении {#get-info}

Чтобы посмотреть информацию о соединении:

1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором создано соединение.
1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_yq_ru }}**.
1. На панели слева выберите **{{ ui-key.yql.yq-ide-aside.connections.tab-text }}**.
1. В строке с именем нужного соединения нажмите кнопку ![info](../../_assets/console-icons/circle-info.svg). Раздел **{{ ui-key.yql.yq-connection-info.general.section-header }}** содержит информацию об источнике и сервисном аккаунте. В разделе **{{ ui-key.yql.yq-common-meta-section.meta.section-header }}** указаны идентификатор (ID) соединения, время создания и автор.

## Изменить параметры соединения {#update}

Чтобы изменить параметры соединения:

1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором создано соединение.
1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_yq_ru }}**.
1. На панели слева выберите **{{ ui-key.yql.yq-ide-aside.connections.tab-text }}**.
1. В строке с именем нужного соединения нажмите кнопку ![ellipsis](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yql.yq-connection-actions.edit-connection.menu-item-text }}**.
1. Укажите новые параметры соединения. Тип соединения изменить нельзя.
1. Нажмите кнопку **{{ ui-key.yql.yq-connection-form.modify.button-text }}**.

## Удалить соединение {#delete}

Чтобы удалить соединение:

1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором создано соединение.
1. В списке сервисов выберите **{{ yq-full-name }}**.
1. На панели слева выберите **{{ ui-key.yql.yq-ide-aside.connections.tab-text }}**.
1. В строке с именем нужного соединения нажмите кнопку ![ellipsis](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yql.yq-connection-actions.delete-connection.menu-item-text }}**.
1. Подтвердите удаление соединения.

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
