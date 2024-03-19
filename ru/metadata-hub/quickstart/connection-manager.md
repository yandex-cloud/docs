# Начало работы с {{ connection-manager-name }}

{% include notitle [preview](../../_includes/note-preview.md) %}

Управляйте подключениями к базам данных {{ PG }}, {{ MY }} и {{ CH }} с {{ connection-manager-full-name }}.

## Управлять подключениями к кластерам управляемых баз данных в {{ yandex-cloud }} {#managed-cluster}

{% note warning %}

После подтверждения доступа к {{ connection-manager-full-name }}, подключения для кластеров управляемых баз данных будут создаваться автоматически.

{% endnote %}

1. Создайте кластер [{{ mpg-short-name }}](../../managed-postgresql/operations/cluster-create.md).
1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно проверить подключение.
1. Выберите сервис **{{ metadata-hub-name }}**.
1. На панели слева выберите ![image](../../_assets/console-icons/plug-connection.svg) **{{ connection-manager-name }}** / **Подключения**.

В списке подключений вы можете просмотреть подключения, созданные для ваших кластеров, и [настроить доступ](../operations/connection-access.md) к ним.

## Управлять подключениями к пользовательским инсталляциям баз данных {#on-premise}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно создать подключение.
  1. Выберите сервис **{{ metadata-hub-name }}**.
  1. Hа панели слева выберите ![image](../../_assets/console-icons/plug-connection.svg) **{{ connection-manager-name }}** / **Подключения**.
  1. Нажмите кнопку **Создать подключение**.
  1. Укажите имя подключения и тип базы данных.
  1. Опционально добавьте описание подключения и [метку](../../resource-manager/concepts/labels.md).
  1. Укажите [параметры подключения](../operations/create-connection.md) в зависимости от выбранной базы данных.
  1. Нажмите кнопку **Создать**. 

{% endlist %}

После того как подключение будет создано, вы можете [просмотреть его настройки](../operations/update-connection.md#list-connections) в списке подключений, [изменить их](../operations/update-connection.md#update-connections) и [управлять доступом](../operations/connection-access.md) к этому подключению.

## Что дальше {#what-is-next}

* [{#T}](../operations/view-connection.md)
* [{#T}](../operations/update-connection.md)
* [{#T}](../operations/delete-connection.md)
* [{#T}](../operations/connection-access.md)

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}