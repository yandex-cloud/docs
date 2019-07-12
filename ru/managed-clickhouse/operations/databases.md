# Управление базами данных

Вы можете добавлять и удалять базы данных, а также просматривать информацию о них.

## Получить список баз данных в кластере {#list-db}

{% list tabs %}

- Консоль управления
  
  1. Перейдите на страницу каталога и выберите сервис **Managed Service for ClickHouse**.
  1. Нажмите на имя нужного кластера, затем выберите вкладку **Базы данных**.
  
  
- CLI
  
  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  Чтобы получить список баз данных в кластере, выполните команду:
  
  ```
  $ yc managed-clickhouse database list
       --cluster-name=<имя кластера>
  ```
  
  Имя кластера можно запросить со [списком кластеров в каталоге](#list-clusters).
  
  
- API
  
  Получить список баз данных кластера можно с помощью метода [list](../api-ref/Database/list.md).
  
{% endlist %}

## Создать базу данных {#add-db}

Количество баз данных в кластере неограниченно.

{% list tabs %}

- Консоль управления
  
  1. Перейдите на страницу каталога и выберите сервис **Managed Service for ClickHouse**.
  1. Нажмите на имя нужного кластера.
  1. Выберите вкладку **Базы данных**.
  1. Нажмите кнопку **Добавить**.
  1. Введите имя для базы данных и нажмите кнопку **Добавить**.
  
  
- CLI
  
  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  Выполните команду создания БД, задав имя новой базы:
  
  ```
  $ yc managed-clickhouse database create <имя базы данных>
      --cluster-name <имя кластера>
  ```
  
  Managed Service for ClickHouse запустит операцию создания базы данных.
  
  Имя кластера можно запросить со [списком кластеров в каталоге](#list-clusters).
  
  
- API
  
  Создать новую базу данных в кластере можно с помощью метода [create](../api-ref/Database/create.md).
  
{% endlist %}

## Удалить базу данных {#remove-db}

{% list tabs %}

- Консоль управления
  
  1. Перейдите на страницу каталога и выберите сервис **Managed Service for ClickHouse**.
  1. Нажмите на имя нужного кластера и выберите вкладку **Базы данных**.
  1. Нажмите значок ![image](../../_assets/vertical-ellipsis.svg) в строке нужной БД и выберите пункт **Удалить**.
  
  
- CLI
  
  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  Чтобы удалить базу данных, выполните команду:
  
  ```
  $ yc managed-clickhouse database delete <имя базы данных>
       --cluster-name=<имя кластера>
  ```
  
  Имя кластера можно запросить со [списком кластеров в каталоге](#list-clusters).
  
  
- API
  
  Удалить базу данных можно с помощью метода [delete](../api-ref/Database/delete.md).
  
{% endlist %}
