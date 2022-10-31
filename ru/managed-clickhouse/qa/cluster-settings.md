# Настройки параметров {{ CH }}-кластера

{% if product == "yandex-cloud" %}

#### Как создать пользователя для доступа из {{ datalens-name }} с правами только на чтение? {#datalens-readonly}

Воспользуйтесь [инструкцией](../operations/cluster-users.md#example-create-readonly-user), чтобы создать пользователя с правами только на чтение. Если в настройках кластера [включена опция](../operations/update.md#change-additional-settings) **Доступ из {{ datalens-name }}**, сервис сможет [подключаться](../operations/datalens-connect.md#create-connector) к кластеру с помощью этого пользователя.

{% endif %}


#### Как дать пользователю права на создание и удаление таблиц или БД? {#create-delete-role}

Включите в настройках кластера опцию [{#T}](../operations/cluster-users.md#sql-user-management) и выдайте пользователю нужные права [с помощью выражения]({{ ch.docs }}/sql-reference/statements/grant/) `GRANT`.

#### Как узнать значение настройки internal_replication? {#internal-replication}

Информация о настройке `internal_replication` недоступна ни в интерфейсах {{ yandex-cloud }}, ни в системных таблицах {{ CH }}. Значение настройки по умолчанию — `true`.
