# Управление пользователями ClickHouse

{{ mch-name }} позволяет управлять пользователями и их индивидуальными настройками двумя способами:

- С помощью стандартных интерфейсов {{ yandex-cloud }} (CLI, API, консоль управления). Способ подходит, если вы хотите воспользоваться всеми возможностями managed-сервиса {{ yandex-cloud }}.
- С помощью SQL-запросов к кластеру. Способ подходит, если вы хотите использовать уже существующее у вас решение для создания и управления пользователями или если вам требуется поддержка [RBAC](https://ru.wikipedia.org/wiki/Управление_доступом_на_основе_ролей).

## Управление пользователями через SQL {#sql-user-management}

Чтобы управлять пользователями через SQL, [создайте кластер](cluster-create.md) с включенной настройкой **Управление пользователями через SQL**.

В кластере с включенным управлением пользователями через SQL:

- Пользователями можно управлять только через SQL.
- Невозможно включить управление пользователями с помощью стандартных интерфейсов {{ yandex-cloud }} (CLI, API, консоль управления).
- Управление пользователями осуществляется с помощью учетной записи `admin`. Пароль для нее задается при создании кластера.

{% include [sql-db-and-users-alers](../../_includes/mdb/mch-sql-db-and-users-alert.md) %}

Подробнее об управлении пользователями через SQL см. в [документации {{ CH }}](https://clickhouse.tech/docs/ru/operations/access-rights).

## Получить список пользователей {#list-users}

{% list tabs %}

- Консоль управления
  
  1. Перейдите на страницу каталога и выберите сервис **{{ mch-name }}**.
  1. Нажмите на имя нужного кластера, затем выберите вкладку **Пользователи**.
  
- CLI
  
  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  Чтобы получить список пользователей кластера, выполните команду:
  
  ```
  $ {{ yc-mdb-ch }} user list
       --cluster-name=<имя кластера>
  ```
  
  Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- SQL

  1. [Подключитесь](connect.md) к кластеру, используя [учетную запись `admin`](#sql-user-management).
  1. Получите список пользователей:

      ```sql
      SHOW USERS;
      ```

{% endlist %}

## Добавить пользователя {#adduser}

{% list tabs %}

- Консоль управления
  
  Чтобы создать пользователя в кластере:
  1. Перейдите на страницу каталога и выберите сервис **{{ mch-name }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **Пользователи**.
  1. Нажмите кнопку **Добавить**.
  1. Введите имя пользователя базы данных и пароль.

      {% include [user-name-and-password-limits](../../_includes/mdb/mch/note-info-user-name-and-pass-limits.md) %}

  1. Выберите одну или несколько баз данных, к которым должен иметь доступ пользователь:
     1. Выберите базу данных из выпадающего списка **База данных**.
     1. Нажмите кнопку **Добавить** справа от выпадающего списка.
     1. Повторите два предыдущих шага, пока не будут выбраны все требуемые базы данных.
     1. Чтобы удалить базу, добавленную по ошибке, нажмите значок ![image](../../_assets/cross.svg) справа от имени базы в перечне **Права**.
  1. Задайте [дополнительные настройки](../concepts/settings-list.md) для пользователя:
     1. Настройте [квоты](../concepts/settings-list.md#quota-settings) в разделе **Дополнительные настройки → Quotas**:
        1. Чтобы добавить квоту, нажмите значок ![image](../../_assets/plus.svg) или кнопку **+ Quotas**. Вы можете добавить несколько квот, которые будут действовать одновременно.
        1. Чтобы удалить квоту, нажмите значок ![image](../../_assets/vertical-ellipsis.svg) справа от имени квоты и выберите пункт **Удалить**.
        1. Чтобы изменить квоту, задайте требуемые значения настроек для нее.
     1. Настройте [{{ CH }}](../concepts/settings-list.md#user-level-settings) в разделе **Дополнительные настройки → Settings**.
  1. Нажмите кнопку **Добавить**.
  
  См. также: [пример создания пользователя с правами «только чтение»](#example-create-readonly-user).
     
- CLI
  
  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  Чтобы создать пользователя в кластере, выполните команду:
  
  ```
  $ {{ yc-mdb-ch }} user create <имя пользователя>
       --cluster-name=<имя кластера>
       --password=<пароль пользователя>
       --permissions=<список баз, к которым пользователь должен иметь доступ>
       --quota=<список настроек одной квоты для пользователя>
       --settings=<список настроек {{ CH }} для пользователя>
  ```

  {% include [user-name-and-password-limits](../../_includes/mdb/mch/note-info-user-name-and-pass-limits.md) %}

  Подробнее о [квотах](../concepts/settings-list.md#quota-settings) и [настройках {{ CH }}](../concepts/settings-list.md#user-level-settings) читайте в разделе [{#T}](../concepts/settings-list.md).
  
  Чтобы задать несколько квот, перечислите их, используя требуемое количество параметров `--quota` в команде:
  
  ```
  $ {{ yc-mdb-ch }} user create <имя пользователя>
      ...
      --quota="<настройки квоты 0>"
      --quota="<настройки квоты 1>"
      ...
  ```
  
  Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).
  
  См. также: [пример создания пользователя с правами «только чтение»](#example-create-readonly-user).

- Terraform

    Чтобы создать пользователя в кластере:

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).

    1. Добавьте к описанию кластера {{ mch-name }} блок `user`:

        ```hcl
        resource "yandex_mdb_clickhouse_cluster" "<имя кластера>" {
          ...
          user {
            name     = "<имя пользователя>"
            password = "<пароль>"
            ...
          }
        }
        ```

        {% include [user-name-and-password-limits](../../_includes/mdb/mch/note-info-user-name-and-pass-limits.md) %}

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера {{ TF }}](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/mdb_clickhouse_cluster).

- SQL

  1. [Подключитесь](connect.md) к кластеру, используя [учетную запись `admin`](#sql-user-management).
  1. Создайте пользователя:

      ```sql
      CREATE USER <имя пользователя> IDENTIFIED WITH sha256_password BY '<пароль пользователя>';
      ```

      {% include [user-name-and-password-limits](../../_includes/mdb/mch/note-info-user-name-and-pass-limits.md) %}

  Подробнее о создании пользователей см. [в документации {{ CH }}](https://clickhouse.tech/docs/ru/sql-reference/statements/create/user/).

{% endlist %}

## Изменить пароль {#updateuser}

{% list tabs %}

- Консоль управления

  Чтобы изменить пароль пользователя:
  1. Перейдите на страницу каталога и выберите сервис **{{ mch-name }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **Пользователи**.
  1. Нажмите значок ![image](../../_assets/vertical-ellipsis.svg) и выберите пункт **Изменить пароль**.
  1. Задайте новый пароль и нажмите кнопку **Изменить**.

  {% include [password-limits](../../_includes/mdb/mch/note-info-password-limits.md) %}
  
- CLI
  
  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
   
  Чтобы изменить пароль пользователя, выполните команду:

  ```
  $ {{ yc-mdb-ch }} user update <имя пользователя>
       --cluster-name=<имя кластера>
       --password=<новый пароль>
  ```

  {% include [password-limits](../../_includes/mdb/mch/note-info-password-limits.md) %}

  Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- Terraform

    Чтобы изменить пароль пользователя:

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).

    1. Найдите в описании кластера {{ mch-name }} блок `user` для нужного пользователя.

    1. Измените значение поля `password`:

        ```hcl
        resource "yandex_mdb_clickhouse_cluster" "<имя кластера>" {
          ...
          user {
            name     = "<имя пользователя>"
            password = "<новый пароль>"
            ...
          }
        }
        ```

        {% include [password-limits](../../_includes/mdb/mch/note-info-password-limits.md) %}

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера {{ TF }}](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/mdb_clickhouse_cluster).

- SQL

  1. [Подключитесь](connect.md) к кластеру, используя [учетную запись `admin`](#sql-user-management).
  1. Измените пароль пользователя:

      ```sql
      ALTER USER <имя пользователя> IDENTIFIED BY '<новый пароль>';
      ```

      {% include [password-limits](../../_includes/mdb/mch/note-info-password-limits.md) %}

  Подробнее об изменении пользователей см. [в документации {{ CH }}](https://clickhouse.tech/docs/ru/sql-reference/statements/alter/user/).

{% endlist %}

## Изменить настройки пользователя {#update-settings}

{% list tabs %}

- Консоль управления
  
  Чтобы изменить настройки пользователя:
  1. Перейдите на страницу каталога и выберите сервис **{{ mch-name }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **Пользователи**.
  1. Нажмите значок ![image](../../_assets/vertical-ellipsis.svg) и выберите пункт **Настройки**.
  1. Настройте права пользователя на доступ к определенным базам данных:
     1. Чтобы предоставить доступ к требуемым базам данных:
        1. Выберите базу данных из выпадающего списка **База данных**.
        1. Нажмите кнопку **Добавить** справа от выпадающего списка.
        1. Повторите два предыдущих шага, пока не будут выбраны все требуемые базы данных.
     1. Чтобы отозвать доступ к определенной базе, удалите ее из перечня **Права**, нажав значок ![image](../../_assets/cross.svg) справа от имени базы.
  1. Настройте [квоты](../concepts/settings-list.md#quota-settings) для пользователя в разделе **Дополнительные настройки → Quotas**:
     1. Чтобы добавить квоту, нажмите значок ![image](../../_assets/plus.svg) или кнопку **+ Quotas**. Вы можете добавить несколько квот, которые будут действовать одновременно.
     1. Чтобы удалить квоту, нажмите значок ![image](../../_assets/vertical-ellipsis.svg) справа от имени квоты и выберите пункт **Удалить**.
     1. Чтобы изменить квоту, задайте требуемые значения настроек для нее.
  1. Измените [настройки {{ CH }}](../concepts/settings-list.md#dbms-user-settings) для пользователя в разделе **Дополнительные настройки → Settings**.   
  1. Нажмите кнопку **Сохранить**.
  
- CLI
  
  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  Из интерфейса командной строки можно изменить настройки пользователя:
  1. Чтобы настроить права пользователя на доступ к определенным базам данных, выполните команду, перечислив список имен баз данных с помощью параметра `--permissions`:
  
     ```
     $ {{ yc-mdb-ch }} user update <имя пользователя>
          --cluster-name=<имя кластера>
          --permissions=<список баз, к которым пользователь должен иметь доступ>
     ```
  
     Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).
     
     Эта команда предоставляет пользователю доступ к базам данных, указанным в списке.
  
     Чтобы отозвать доступ к определенной базе, исключите ее имя из списка и передайте команде обновленный список.
  
  1. Чтобы изменить [настройки квот](../concepts/settings-list.md#quota-settings) для пользователя, выполните команду, перечислив список всех квот, с помощью параметров `--quota` (один параметр на каждую квоту):
  
     ```
     $ {{ yc-mdb-ch }} user update <имя пользователя>
          --cluster-name=<имя кластера>
          --quota=<настройки квоты 0 (без изменений)>
          --quota=<настройки квоты 1 (без изменений)>
          --quota=<настройки квоты 2 (с изменениями)>
          --quota=<настройки квоты 3 (без изменений)>
          --quota=<настройки квоты 4 (с изменениями)>
          --quota=<настройки квоты 5 (новая квота)>       
         ...
     ```
     
     Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).
     
     Эта команда перезаписывает все существующие настройки квот пользователя новыми настройками, набор которых был передан команде. 
     Перед выполнением команды убедитесь, что вы включили в этот набор как настройки новых и измененных квот, так и настройки существующих квот, которые не изменялись.
  
     Чтобы удалить одну или несколько квот пользователя, исключите настройки этих квот из набора и передайте команде обновленный набор параметров `--quota`.
     
     При задании интервала для квоты допустимо использовать запись с указанием единиц измерения: часов (`h`), минут (`m`), секунд (`s`) и миллисекунд (`ms`). Пример такой записи: `3h20m10s7000ms` (итоговое значение представляется по-прежнему в миллисекундах: `12017000`). Значение интервала должно быть кратно 1000 миллисекунд (значение вида `1s500ms` является некорректным). 
    
  1. Чтобы изменить [настройки {{ CH }}](../concepts/settings-list.md#dbms-user-settings) для пользователя, выполните команду, перечислив измененные настройки с помощью параметра `--settings`:
  
     ```
     $ {{ yc-mdb-ch }} user update <имя пользователя>
          --cluster-name=<имя кластера>
          --settings=<список настроек {{ CH }}>    
     ```
     
     Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).
     
     Команда изменит только те настройки, которые явно указаны в параметре `--settings`. Например, команда с параметром `--settings="readonly=1"` изменит только настройку `readonly` и не сбросит значения остальных. Этим изменение настроек {{ CH }} отличается от изменения настроек квот.
     
     С помощью этой команды невозможно удалить сделанную настройку, допустимо только явно присвоить ей значение по умолчанию (оно указано для [каждой настройки](#clickhouse-settings)).

- Terraform

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).

    1. Чтобы настроить права пользователя на доступ к определенным базам данных, добавьте необходимое количество блоков `permission` к описанию пользователя кластера — по одному на каждую базу:

        ```hcl
        resource "yandex_mdb_clickhouse_cluster" "<имя кластера>" {
          ...
          user {
            name     = "<имя пользователя>"
            password = "<пароль>"
            permission {
              database_name = "<база данных 1>"
            }
            ...
            permission {
              database_name = "<база данных N>"
            }
          }
        }
        ```

        В поле `database_name` укажите имя базы данных, к которой нужно предоставить доступ.

    1. Чтобы изменить [настройки квот](../concepts/settings-list.md#quota-settings) для пользователя, добавьте необходимое количество блоков `quota` к его описанию.

        При описании квот обязательным является только поле `interval_duration`.

        ```hcl
        resource "yandex_mdb_clickhouse_cluster" "<имя кластера>" {
          ...
          user {
            name     = "<имя пользователя>"
            password = "<пароль>"
            ...
            quota {
              interval_duration = <длительность интервала в миллисекундах>
              ...
            }
          }
        }
        ```

    1. Чтобы изменить [настройки {{ CH }}](../concepts/settings-list.md#dbms-user-settings) для пользователя, добавьте блок `settings` к его описанию.

        ```hcl
        resource "yandex_mdb_clickhouse_cluster" "<имя кластера>" {
          ...
          user {
            name     = "<имя пользователя>"
            password = "<пароль>"
            ...
            settings {
              <настройки СУБД для отдельного пользователя>
            }
          }
        }
        ```

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера {{ TF }}](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/mdb_clickhouse_cluster).

- SQL

  1. [Подключитесь](connect.md) к кластеру, используя [учетную запись `admin`](#sql-user-management).
  1. Чтобы изменить набор привилегий и ролей пользователя, используйте запросы [GRANT](https://clickhouse.tech/docs/ru/sql-reference/statements/grant/) и [REVOKE](https://clickhouse.tech/docs/ru/sql-reference/statements/revoke/). Например, выдайте пользователю права на чтение всех объектов в определенной базе данных:

      ```sql
      GRANT SELECT ON <имя базы данных>.* TO <имя пользователя>;
      ```

  1. Чтобы изменить [настройки квот](../concepts/settings-list.md#quota-settings) для пользователя, используйте запросы [CREATE QUOTA](https://clickhouse.tech/docs/en/sql-reference/statements/create/quota/#create-quota-statement), [ALTER QUOTA](https://clickhouse.tech/docs/en/sql-reference/statements/alter/quota/#alter-quota-statement) и [DROP QUOTA](https://clickhouse.tech/docs/en/sql-reference/statements/drop/#drop-quota-statement). Например, ограничьте суммарное количество запросов пользователя за период 15 месяцев:

      ```sql
      CREATE QUOTA <название квоты> FOR INTERVAL 15 MONTH MAX QUERIES 100 TO <имя пользователя>;
      ```

  1. Чтобы изменить учетную запись пользователя, используйте запрос [ALTER USER](https://clickhouse.tech/docs/ru/sql-reference/statements/alter/user/). Например для изменения [настроек {{ CH }}](../concepts/settings-list.md#dbms-user-settings) выполните следующую команду, перечислив настройки подлежащие изменению:

      ```sql
      ALTER USER <имя пользователя> SETTINGS <список настроек {{ CH }}>;
      ```

{% endlist %}

## Удалить пользователя {#removeuser}

{% list tabs %}

- Консоль управления
  
  1. Перейдите на страницу каталога и выберите сервис **{{ mch-name }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **Пользователи**.
  1. Нажмите значок ![image](../../_assets/vertical-ellipsis.svg) и выберите пункт **Удалить**.
  
- CLI
  
  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  Чтобы удалить пользователя, выполните команду:
  
  ```
  $ {{ yc-mdb-ch }} user delete <имя пользователя>
       --cluster-name=<имя кластера>
  ```
  
  Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- Terraform

    Чтобы удалить пользователя:

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).

    1. Удалите из описания кластера {{ mch-name  }} блок `user` с описанием нужного пользователя.

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера {{ TF }}](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/mdb_clickhouse_cluster).

- SQL

  1. [Подключитесь](connect.md) к кластеру, используя [учетную запись `admin`](#sql-user-management).
  1. Удалите пользователя:

      ```sql
      DROP USER <имя пользователя>;
      ```

  Подробнее об удалении объектов см. [в документации {{ CH }}](https://clickhouse.tech/docs/ru/sql-reference/statements/drop/).

{% endlist %}

## Примеры {#examples}

### Создание пользователя с настройкой «только чтение» {#example-create-readonly-user}

Допустим, нужно добавить в существующий кластер с именем `mych` нового пользователя `ro-user` с паролем `Passw0rd`, причем:
- пользователь должен иметь доступ к базе данных `db1` кластера;
- доступ должен осуществляться в режиме «только чтение» (readonly), без возможности изменения настроек.

{% list tabs %}

- Консоль управления
 
  1. Перейдите на страницу каталога и выберите сервис **{{ mch-name }}**.
  1. Нажмите на кластер с именем `mych` и выберите вкладку **Пользователи**.
  1. Нажмите кнопку **Добавить**.
  1. Введите имя пользователя базы данных `ro-user` и пароль `Passw0rd`.
  1. Выберите базу данных `db1` из выпадающего списка **База данных** и нажмите кнопку **Добавить** справа от выпадающего списка.
  1. Выберите **Дополнительные настройки → Settings → Readonly**.
  1. В поле **Readonly** укажите значение `1`.
  1. Нажмите кнопку **Добавить**.

- CLI

  Запустите следующую команду:

  ```
  $ {{ yc-mdb-ch }} user create "ro-user" \
       --cluster-name="mych" \
       --password="Passw0rd" \
       --permissions="db1" \
       --settings="readonly=1"
  ```
  
    После создания пользователя проверьте, что он действительно работает в режиме «только чтение»:
    1. [Подключитесь к кластеру {{ CH }}](connect.md) `mych`, используя созданного пользователя `ro-user`.
    1. Попытайтесь изменить какую-нибудь настройку, например, попытайтесь отключить режим «только чтение»:
       
       ```
       SET readonly=0
       ```
       
       В результате выполнения команды должно отобразиться сообщение о невозможности изменения настройки в режиме «только чтение»:
       
       ```
       DB::Exception: Cannot modify 'readonly' setting in readonly mode.
       ```

- Terraform

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).

    1. Добавьте к описанию кластера блок `user`.

        ```hcl
        resource "yandex_mdb_clickhouse_cluster" "mych" {
          name = "mych"

          database {
            name = "db1"
          }

          user {
            name     = "ro-user"
            password = "Passw0rd"
            permission {
              database_name = "db1"
            }
            settings {
              readonly = 1
            }
          }
          ...
        }
        ```

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- SQL

  1. [Подключитесь](connect.md) к кластеру `mych`, используя [учетную запись `admin`](#sql-user-management).
  1. Создайте пользователя:

      ```sql
      CREATE USER ro-user IDENTIFIED WITH sha256_password BY 'Passw0rd';
      ```

  1. Выдайте пользователю права на чтение всех объектов базы данных `db1`:

      ```sql
      GRANT SELECT ON db1.* TO ro-user;
      ```

{% endlist %}
