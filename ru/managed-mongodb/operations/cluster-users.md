# Управление пользователями БД

Вы можете добавлять и удалять пользователей, а также управлять их индивидуальными настройками.

## Получить список пользователей {#list-users}

{% list tabs %}

- Консоль управления
  
  1. Перейдите на страницу каталога и выберите сервис **Managed Service for MongoDB**.
  1. Нажмите на имя нужного кластера, затем выберите вкладку **Пользователи**.
  
- CLI
  
  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  Чтобы получить список пользователей кластера, выполните команду:
  
  ```
  $ yc managed-mongodb user list
       --cluster-name <имя кластера>
  ```
  
  Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).
  
{% endlist %}

## Добавить пользователя {#adduser}

{% list tabs %}

- Консоль управления
  
  1. Перейдите на страницу каталога и выберите сервис **Managed Service for MongoDB**.
  1. Нажмите на имя нужного кластера и выберите вкладку **Пользователи**.
  1. Нажмите кнопку **Добавить**.
  1. Введите имя пользователя БД и пароль (от 8 до 128 символов).
  
- CLI
  
  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  Чтобы создать пользователя в кластере:
  
  1. Посмотрите описание команды CLI для создания пользователя:
  
     ```
     $ yc managed-mongodb user create --help
     ```
  
  1. Укажите свойства пользователя в команде создания:
     ```
     $ yc managed-mongodb user create <имя пользователя>
        --cluster-name <имя кластера>
        --password <пароль для пользователя>
        --permission database=<имя БД>,role=<роль>,role=<другая роль>,...
        --permission database=<имя другой БД>,role=<роль>,...
     ```
  
     Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).
  
{% endlist %}

## Изменить пользователя {#updateuser}

{% list tabs %}

- Консоль управления
  
  В консоли управления пока можно изменить только пароль пользователя БД:
  
  1. Перейдите на страницу каталога и выберите сервис **Managed Service for MongoDB**.
  1. Нажмите на имя нужного кластера и выберите вкладку **Пользователи**.
  1. Нажмите значок ![image](../../_assets/vertical-ellipsis.svg) и выберите пункт **Изменить пароль**.
  
- CLI
  
  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  Чтобы изменить пароль пользователя или список доступных ему баз данных:
  
  1. Посмотрите описание команды CLI для изменения пользователя:
  
     ```
     $ yc managed-mongodb user update --help
     ```
  
  1. Укажите свойства пользователя в команде создания:
     ```
     $ yc managed-mongodb user update <имя пользователя>
        --cluster-name <имя кластера>
        --password <пароль для пользователя>
        --permission database=<имя БД>,role=<роль>,role=<другая роль>,...
        --permission database=<имя другой БД>,role=<роль>,...
     ```
  
     Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).
  
{% endlist %}

## Удалить пользователя {#removeuser}

{% list tabs %}

- Консоль управления
  
  1. Перейдите на страницу каталога и выберите сервис **Managed Service for MongoDB**.
  1. Нажмите на имя нужного кластера и выберите вкладку **Пользователи**.
  1. Нажмите значок ![image](../../_assets/vertical-ellipsis.svg) и выберите пункт **Удалить**.
  
- CLI
  
  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  Чтобы удалить пользователя, выполните команду:
  
  ```
  $ yc managed-mongodb user delete <имя пользователя>
       --cluster-name <имя кластера>
  ```
  
  Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).
  
{% endlist %}
