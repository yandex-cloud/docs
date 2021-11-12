# Управление базами данных в {{ ydb-name }}

В этом разделе описано, как:

* [{#T}](#create-db).
* [{#T}](#db-list).
* [{#T}](#change-db-params).
* [{#T}](#delete-db).

## Создать базу данных {#create-db}

Вы можете создать базу данных в бессерверной (Serverless) конфигурации или с выделенными серверами (Dedicated). Подробнее о различиях в конфигурациях читайте в разделе [{#T}](../concepts/serverless_and_dedicated.md).

{% include [create-db-via-console](../_includes/create-db-via-console.md) %}

## Посмотреть список баз данных {#db-list}

{% list tabs %}

* Консоль управления

   1. В [консоли управления]({{ link-console-main }}) выберите каталог, для которого нужно получить список баз данных.
   1. В списке сервисов выберите **{{ ydb-name }}**.

* CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. Посмотрите описание команды CLI для получения списка БД:

      ```bash
      {{ yc-ydb }} database list --help
      ```

   1. Чтобы получить список баз данных в каталоге по умолчанию, выполните команду:

      ```bash
      {{ yc-ydb }} database list
      ```

{% endlist %}

## Изменить настройки базы данных {#change-db-params}

{% note warning %}

Вы можете изменить только настройки баз данных, которые работают в конфигурации с выделенными серверами.

{% endnote %}

{% list tabs %}

* Консоль управления

   1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно изменить настройки базы данных.
   1. В списке сервисов выберите **{{ ydb-name }}**.
   1. Нажмите значок ![horizontal-ellipsis](../_assets/horizontal-ellipsis.svg) в строке нужной БД и выберите пункт **Изменить**.
   1. Настройте параметры БД:
      1. В блоке **Вычислительные ресурсы** выберите тип и количество [вычислительных ресурсов](../concepts/databases.md#compute-units).
      1. В блоке **Группы хранения** выберите тип диска и количество [групп хранения](../concepts/databases.md#storage-groups), определяющее суммарный объем хранилища.
   1. Нажмите кнопку **Изменить базу данных**.

* CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   Чтобы изменить параметры базы данных:

   1. Посмотрите описание команды CLI для изменения параметров БД:

      ```bash
      {{ yc-ydb }} database update --help
      ```

   1. Выполните команду вида:

      ```bash
      {{ yc-ydb }} database update <имя БД> \
                     --new-name <новое имя БД> \
                     --description <новое описание БД> \
                     --resource-preset <ID класса> \
                     --storage type=<ID типа накопителя>,groups=<число групп хранения>
                     ...
      ```

{% endlist %}

## Удалить базу данных {#delete-db}

{% list tabs %}

* Консоль управления

   1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно удалить базу данных.
   1. В списке сервисов выберите **{{ ydb-name }}**.
   1. Нажмите значок ![horizontal-ellipsis](../_assets/horizontal-ellipsis.svg) в строке нужной БД и выберите пункт **Удалить**.
   1. Подтвердите удаление.

* CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. Посмотрите описание команды CLI для удаления БД:

      ```bash
      {{ yc-ydb }} database delete --help
      ```

   1. Чтобы удалить базу данных, выполните команду:

      ```bash
      {{ yc-ydb }} database delete <имя базы данных>
      ```

{% endlist %}
