# Управление базами данных


## Посмотреть список баз данных {#db-list}

{% list tabs %}

- Консоль управления

   1. В [консоли управления](https://console.cloud.yandex.ru) выберите каталог, для которого нужно получить список баз данных.
   1. В списке сервисов выберите **{{ ydb-name }}**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   Чтобы получить список баз данных в каталоге по умолчанию, выполните команду:

   ```
   $ {{ yc-ydb }} database list
   ```

{% endlist %}

## Создать базу данных {#create-db}

{% include [create-db-via-console](../_includes/create-db-via-console.md) %}

## Изменить настройки базы данных {#change-db-params}

{% note warning %}

Вы можете изменить только настройки баз данных, которые работают конфигурации с выделенными серверами.

{% endnote %}

{% list tabs %}

- Консоль управления

   1. В [консоли управления](https://console.cloud.yandex.ru) выберите каталог, в котором нужно изменить настройки базы данных.
   1. В списке сервисов выберите **{{ ydb-name }}**.
   1. Нажмите значок  ![image](../../_assets/horizontal-ellipsis.svg)  в строке нужной БД и выберите пункт **Изменить**.
   1. Настройте параметры БД:
      1. В блоке **Вычислительные ресурсы** выберите тип и количество [вычислительных ресурсов](../concepts/databases.md#compute-units).
      1. В блоке **Группы хранения** выберите тип диска и количество [групп хранения](../concepts/databases.md#storage-groups), определяющее суммарный объем хранилища.
   1. Нажмите кнопку **Изменить базу данных**.

- CLI

   
   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   Чтобы изменить параметры базы данных:

   1. Посмотрите описание команды CLI для изменения параметров БД:

      ```
      $ {{ yc-ydb }} database update --help
      ```

   1. Выполните команду вида:
   
      ```
      $ {{ yc-ydb }} database update <имя БД> \
                     --new-name <новое имя БД> \
                     --description <новое описание БД> \
                     --resource-preset <ID класса> \
                     --storage groups=<число групп хранения>                     
                     ...
      ```

{% endlist %}


## Удалить базу данных {#delete-db}

{% list tabs %}

- Консоль управления

   1. В [консоли управления](https://console.cloud.yandex.ru) выберите каталог, в котором нужно удалить базу данных.
   1. В списке сервисов выберите **{{ ydb-name }}**.
   1. Нажмите значок  ![image](../../_assets/horizontal-ellipsis.svg)  в строке нужной БД и выберите пункт **Удалить**.
   1. Подтвердите удаление.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   Чтобы удалить базу данных, выполните команду:

   ```
   $ {{ yc-ydb }} database delete <имя базы данных>
   ```

{% endlist %}

