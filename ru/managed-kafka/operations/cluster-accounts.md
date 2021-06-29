# Управление учетными записями Apache Kafka®

Учетные записи в {{ KF }} разграничивают права доступа [производителей и потребителей](../concepts/producers-consumers.md) данных. Производитель или потребитель получает доступ только к тем [топикам](../concepts/topics.md), которые разрешены для его учетной записи.

Вы можете использовать одну и ту же учетную запись для нескольких производителей или потребителей: первые получат права на запись в определенные топики, а вторые — на чтение.

После [создания кластера](cluster-create.md) {{ KF }} вы можете:
- [Создать учетную запись](#create-account).
- [Изменить пароль учетной записи](#update-password).
- [Изменить настройки учетной записи](#update-account).
- [Выдать права учетной записи](#grant-permission).
- [Отозвать права у учетной записи](#revoke-permission).
- [Удалить учетную запись](#delete-account).
- [Получить список учетных записей в кластере](#list-accounts).

## Создать учетную запись {#create-account}

{% list tabs %}

- Консоль управления

  Чтобы создать учетную запись в кластере:
  1. Перейдите на страницу каталога и выберите сервис **{{ mkf-name }}**.
  1. Нажмите на имя нужного кластера и перейдите на вкладку **Пользователи**.
  1. Нажмите кнопку **Добавить**.
  1. Введите имя учетной записи (имя пользователя) и пароль.

      {% include [user-name-and-password-limits](../../_includes/mdb/mkf/note-info-user-name-and-pass-limits.md) %}

  1. [Выдайте права доступа](#grant-permission) к нужным топикам.
  1. Нажмите кнопку **Добавить**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы создать учетную запись:
  
  1. Посмотрите описание команды CLI для создания учетных записей:

     ```
     {{ yc-mdb-kf }} user create --help
     ```
     
  1. Создайте учетную запись и выдайте права доступа к нужным топикам:
  
     ```
     {{ yc-mdb-kf }} user create <имя пользователя> \
     --cluster-name <имя кластера> \
     --password <пароль пользователя> \
     --permission topic=<имя топика>,role=<роль пользователя: producer или consumer>
     ```

      {% include [user-name-and-password-limits](../../_includes/mdb/mkf/note-info-user-name-and-pass-limits.md) %}

- Terraform

    Чтобы создать учетную запись:

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).

    1. В описании кластера {{ mkf-name }} добавьте блок `user`:

        ```hcl
        resource "yandex_mdb_kafka_cluster" "<имя кластера>" {
           user {
             name     = "<имя пользователя>"
             password = "<пароль>"
             ...
           }
           ...
        }
        ```

        {% include [user-name-and-password-limits](../../_includes/mdb/mkf/note-info-user-name-and-pass-limits.md) %}

    1. [Выдайте права доступа](#grant-permission) к нужным топикам.
    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера {{ TF }}](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/mdb_kafka_cluster).

{% if api != "noshow" %}

- API

  Воспользуйтесь методом API [create](../api-ref/User/create.md) и передайте в запросе:
  - Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
  - Настройки учетной записи в параметре `userSpec`:
    - Имя учетной записи в параметре `name`.
    - Пароль учетной записи в параметре `password`.
    - Права доступа к топикам (один или несколько параметров `permissions`, по одному на каждый топик):
      - Имя топика в параметре `topicName`. Чтобы узнать имя, [получите список топиков в кластере](cluster-topics.md#list-topics).
      - Права доступа к топику в параметре `role`: `ACCESS_ROLE_PRODUCER` для производителя либо `ACCESS_ROLE_CONSUMER` для потребителя.

  {% include [user-name-and-password-limits](../../_includes/mdb/mkf/note-info-user-name-and-pass-limits.md) %}

{% endif %}

{% endlist %}

## Изменить пароль учетной записи {#update-password}

{% list tabs %}

- Консоль управления

  Чтобы изменить пароль учетной записи:
  1. Перейдите на страницу каталога и выберите сервис **{{ mkf-name }}**.
  1. Нажмите на имя нужного кластера и перейдите на вкладку **Пользователи**.
  1. Нажмите значок ![image](../../_assets/horizontal-ellipsis.svg) для нужной учетной записи и выберите пункт **Изменить пароль**.
  1. Задайте новый пароль и нажмите кнопку **Изменить**.

  {% include [password-limits](../../_includes/mdb/mkf/note-info-password-limits.md) %}

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы изменить пароль учетной записи, выполните следующую команду:
  
  ```
  {{ yc-mdb-kf }} user update <имя пользователя> \
  --cluster-name <имя кластера> \
  --password <новый пароль>
  ```

  {% include [password-limits](../../_includes/mdb/mkf/note-info-password-limits.md) %}

- Terraform

    Чтобы изменить пароль учетной записи:

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).

    1. Найдите в описании кластера {{ mkf-name }}  блок `user` для нужного пользователя.
    1. Измените значение поля `password`:

        ```hcl
        resource "yandex_mdb_kafka_cluster" "<имя кластера>" {
           user {
             ...
             password = "<пароль>"
           }
           ...
        }
        ```

        {% include [password-limits](../../_includes/mdb/mkf/note-info-password-limits.md) %}

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера {{ TF }}](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/mdb_kafka_cluster).

{% if api != "noshow" %}  

- API

  Воспользуйтесь методом API [update](../api-ref/User/update.md) и передайте в запросе:
  - Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
  - Имя учетной записи в параметре `userName`. Чтобы узнать имя, [получите список учетных записей в кластере](#list-accounts).
  - Название настройки `password` в параметре `updateMask`. Если не задать этот параметр, метод API сбросит на значения по умолчанию все настройки учетной записи, которые не были явно указаны в запросе.
  - Новый пароль учетной записи в параметре `password`.

  {% include [password-limits](../../_includes/mdb/mkf/note-info-password-limits.md) %}

{% endif %}

{% endlist %}

## Изменить настройки учетной записи {#update-account}

{% list tabs %}

- Консоль управления

  Чтобы изменить настройки учетной записи в кластере:
  1. Перейдите на страницу каталога и выберите сервис **{{ mkf-name }}**.
  1. Нажмите на имя нужного кластера и перейдите на вкладку **Пользователи**.
  1. Нажмите значок ![image](../../_assets/horizontal-ellipsis.svg) для нужной учетной записи и выберите пункт **Настроить**.
  1. [Выдайте](#grant-permission) или [отзовите](#revoke-permission) права доступа к топикам, если это необходимо.
  1. Нажмите кнопку **Сохранить**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  С помощью CLI можно [выдавать](#grant-permission) и [отзывать](#revoke-permission) права на доступ к топикам.

- Terraform

    Чтобы изменить настройки учетной записи:

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).

    1. В описании кластера {{ mkf-name }} внесите изменения в блок `permission` в блоке `user`, чтобы [выдать](#grant-permission) или [отозвать](#revoke-permission) права на доступ к топикам.
    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера {{ TF }}](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/mdb_kafka_cluster).

{% if api != "noshow" %}

- API

  Воспользуйтесь методом API [update](../api-ref/User/update.md) и передайте в запросе:
  - Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
  - Имя учетной записи в параметре `userName`. Чтобы узнать имя, [получите список учетных записей в кластере](#list-accounts).
  - Список настроек, которые необходимо изменить, в параметре `updateMask` (одной строкой через запятую). Если не задать этот параметр, метод API сбросит на значения по умолчанию все настройки учетной записи, которые не были явно указаны в запросе.
  - Новый набор прав на доступ к топикам (один или несколько параметров `permissions`, по одному на каждый топик).

{% endif %}

{% endlist %}

## Выдать права учетной записи {#grant-permission}

{% include [mkf-deleted-topic-permissions-note](../../_includes/mdb/mkf-deleted-topic-permissions-note.md) %}

{% list tabs %}

- Консоль управления

  При [создании](#create-account) или [изменении](#update-account) учетной записи можно выдавать права на доступ к нужным топикам.

  Чтобы выдать права на доступ к топику:
  1. Найдите нужный топик в списке топиков.

     Если топика нет в списке — добавьте его:
     1. Нажмите кнопку **+ Добавить топик**. Если такой кнопки нет — значит, для этой учетной записи добавлены все существующие топики кластера.
     1. Выберите нужный топик из выпадающего списка.

  1. Нажмите на значок ![image](../../_assets/plus.svg) в столбце **Роли** для нужного топика и выберите роль:
     - `ACCESS_ROLE_CONSUMER`: потребителям, которые используют эту учетную запись, будет разрешен доступ к топику.
     - `ACCESS_ROLE_PRODUCER`: производителям, которые используют эту учетную запись, будет разрешен доступ к топику.

     Вы можете выбрать обе роли одновременно — тогда учетная запись будет подходить и производителям и потребителям.

  1. Чтобы выдать права на другие топики — повторите процедуру.
  1. (опционально) Если права были назначены топику по ошибке — [отзовите их](#revoke-permission).

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы выдать права учетной записи:
  
  1. Получите список топиков кластера:
  
     ```
     {{ yc-mdb-kf }} topic list --cluster-name <имя кластера>
     ```
     
  1. Выдайте права на доступ к нужным топикам, передав параметры `--permission`:
  
     ```
     {{ yc-mdb-kf }} user update <имя пользователя> \
     --cluster-name <имя кластера> \
     --permission topic=<имя топика>,role=<роль пользователя: producer или consumer>
     ```
  
     Доступны следующие параметры `--permission`:
     - **`topic`** — имя топика, к которому нужно выдать права доступа.
     - **`role`** — роль пользователя: producer или consumer.
  
     При изменении прав учетной записи, существующие права удаляются и заменяются новыми. То есть в команде всегда нужно передавать полный список прав, которые должны быть у учетной записи.
     
     Например, чтобы выдать права пользователю `test-user` в кластере `kafka-cli` к топику `topic2` с ролью `producer`, при этом сохранить существующий доступ к топику `topic1`, выполните команду:
     
     ```
     {{ yc-mdb-kf }} user update test-user \
     --cluster-name kafka-cli \
     --permission topic=topic1,role=consumer \
     --permission topic=topic2,role=producer
     ```

- Terraform

    Чтобы выдать права доступа учетной записи:

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).

    1. В описании кластера {{ mkf-name }} добавьте блок `permission` в блок `user`:

        ```hcl
        resource "yandex_mdb_kafka_cluster" "<имя кластера>" {
           user {
             name     = "<имя пользователя>"
             password = "<пароль>"
             permission {
               topic_name = "<имя топика>"
               role       = "<роль пользователя: ACCESS_ROLE_CONSUMER, ACCESS_ROLE_PRODUCER или ACCESS_ROLE_ADMIN>"
             }
           }
           ...
        }
        ```

        Роль `ACCESS_ROLE_ADMIN` доступна только в кластере с включенным [управлением топиками через Admin API](../concepts/topics.md) и если выбраны все топики (`topic_name = "*"`).

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера {{ TF }}](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/mdb_kafka_cluster).

{% if api != "noshow" %}

- API

  Воспользуйтесь методом API [grantPermission](../api-ref/User/grantPermission.md) и передайте в запросе:
  - Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
  - Имя учетной записи в параметре `userName`. Чтобы узнать имя, [получите список учетных записей в кластере](#list-accounts).
  - Новое право на доступ к топику в параметре `permission`.

{% endif %}

{% endlist %}

## Отозвать права у учетной записи {#revoke-permission}

{% list tabs %}

- Консоль управления

  При [создании](#create-account) или [изменении](#update-account) учетной записи можно отзывать права на доступ к нужным топикам.

  Чтобы отозвать права на доступ к топику:
  1. Найдите нужный топик в списке топиков.
  1. Удалите роль, которая больше не нужна, нажав значок ![image](../../_assets/cross.svg) рядом с именем роли. Если нужно отозвать все права на доступ к топику, удалите его из списка: наведите курсор на имя топика и нажмите значок ![image](../../_assets/cross.svg) в конце строки.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы отозвать права доступа к нужным топикам, передайте обновленный список параметров `--permission`:
  
  ```
  {{ yc-mdb-kf }} user update <имя пользователя> \
  --cluster-name <имя кластера> \
  --permission topic=<имя топика>,role=<роль пользователя: producer или consumer>
  ```
  
  При изменении прав учетной записи, существующие права удаляются и заменяются новыми. То есть в команде всегда нужно передавать полный список прав, которые должны быть у учетной записи.
  
  Флаг `--permission` должен содержать хотя бы одну пару топик/роль. Чтобы отозвать у учетной записи все имеющиеся права доступа, воспользуйтесь консолью или удалите учетную запись.

- Terraform

    Чтобы отозвать права доступа учетной записи:

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).

    1. В описании кластера {{ mkf-name }} измените или удалите блок `permission` в блоке `user`.
    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера {{ TF }}](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/mdb_kafka_cluster).

{% if api != "noshow" %}

- API

  Воспользуйтесь методом API [revokePermission](../api-ref/User/revokePermission.md) и передайте в запросе:
  - Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
  - Имя учетной записи в параметре `userName`. Чтобы узнать имя, [получите список учетных записей в кластере](#list-accounts).
  - Право на доступ к топику, которое требуется отозвать, в параметре `permission`.

{% endif %}  

{% endlist %}

## Удалить учетную запись {#delete-account}

{% list tabs %}

- Консоль управления

  Чтобы удалить учетную запись:
  1. Перейдите на страницу каталога и выберите сервис **{{ mkf-name }}**.
  1. Нажмите на имя нужного кластера и перейдите на вкладку **Пользователи**.
  1. Нажмите значок ![image](../../_assets/horizontal-ellipsis.svg) для нужной учетной записи и выберите пункт **Удалить**.
  1. Подтвердите удаление и нажмите кнопку **Удалить**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы удалить учетную запись, выполните команду:
  
  ```
  {{ yc-mdb-kf }} user delete <имя пользователя> --cluster-name <имя кластера>
  ```

- Terraform

    Чтобы удалить учетную запись:

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).

    1. Удалите из описания кластера {{ mkf-name }} блок `user` с описанием нужного пользователя.
    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера {{ TF }}](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/mdb_kafka_cluster).

{% if api != "noshow" %}

- API

  Воспользуйтесь методом API [delete](../api-ref/User/delete.md) и передайте в запросе:
  - Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
  - Имя учетной записи, которую требуется удалить, в параметре `userName`. Чтобы узнать имя, [получите список учетных записей в кластере](#list-accounts).

{% endif %}

{% endlist %}

## Получить список учетных записей в кластере {#list-accounts}

{% list tabs %}

- Консоль управления

  Чтобы получить список учетных записей:
  1. Перейдите на страницу каталога и выберите сервис **{{ mkf-name }}**.
  1. Нажмите на имя нужного кластера и перейдите на вкладку **Пользователи**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы получить список учетных записей:
  
  1. Чтобы получить список учетных записей, выполните команду:

     ```
     {{ yc-mdb-kf }} user list --cluster-name <имя кластера>
     ```
     
  1. Чтобы получить подробную информацию по конкретной учетной записи, выполните команду:
  
     ```
     {{ yc-mdb-kf }} user get <имя пользователя> --cluster-name <имя кластера>
     ```

{% if api != "noshow" %}

- API

  Воспользуйтесь методом API [list](../api-ref/User/list.md): передайте значение идентификатора требуемого кластера в параметре `clusterId` запроса.

  Чтобы узнать идентификатор кластера, [получите список кластеров в каталоге](#list-clusters).

{% endif %}

{% endlist %}
