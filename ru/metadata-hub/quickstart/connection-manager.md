# Начало работы с Connection manager

{% include notitle [preview](../../_includes/note-preview.md) %}

Управляйте подключениями к базам данных {{ PG }}, {{ MY }} и {{ CH }} с {{ connection-manager-full-name }}.

## Интеграция с сервисами управляемых баз данных {#mdb-integration}

{% note warning %}

Когда доступ к {{ connection-manager-full-name }} будет подтвержден, подключения для кластеров с управляемыми базами данных будут создаваться автоматически.

{% endnote %}

1. Создайте кластер [{{ mpg-short-name }}](../../managed-postgresql/operations/cluster-create.md) или [{{ mmy-short-name }}](../../managed-mysql/operations/cluster-create.md).
1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно проверить подключение.
1. Выберите сервис **{{ metadata-hub-name }}**.
1. На панели слева выберите ![image](../../_assets/console-icons/plug-connection.svg) **Connection manager**.

В списке подключений вы можете просмотреть подключения, созданные для ваших кластеров, и [настроить доступ](../operations/connection-access.md) к ним.

## Управление подключениями к базам данных {#database-connections}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно создать подключение.
  1. Выберите сервис **{{ metadata-hub-name }}**.
  1. Hа панели слева выберите ![image](../../_assets/console-icons/plug-connection.svg) **Connection manager**.
  1. Нажмите кнопку **Создание подключения**.
  1. Укажите имя подключения и тип базы данных.
  1. Опционально добавьте описание подключения и [метку](../../resource-manager/concepts/labels.md).
  1. Укажите параметры подключения в зависимости от выбранной базы данных:
     * [подключение к управляемой базе данных в кластере](../operations/create-connection.md#mdb-connection);
     * [подключение к пользовательской инсталляции базы данных](../operations/create-connection.md#on-premise-connection).
  1. Укажите данные для аутентификации подключения.
  1. Нажмите кнопку **Создать**.

{% endlist %}

После того как подключение будет создано, вы можете [просмотреть его настройки](../operations/update-connection.md#list-connections) в списке подключений, [изменить их](../operations/update-connection.md#update-connections) и [управлять доступом](../operations/connection-access.md) к этому подключению.


## Что дальше {#what-is-next}

* [Просмотрите информацию о подключении](../operations/view-connection.md).
* [Измените настройки подключения](../operations/update-connection.md).
* [Настройте права доступа к подключению](../operations/connection-access.md).
* [Удалите ненужное подключение](../operations/delete-connection.md).


{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
