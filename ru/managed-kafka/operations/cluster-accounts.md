# Управление пользователями Apache Kafka®

Пользователи в {{ KF }}:

* Разграничивают права доступа [производителей и потребителей](../concepts/producers-consumers.md) данных.
    Производитель или потребитель получает доступ только к тем [топикам](../concepts/topics.md), которые разрешены для его пользователя. Вы можете использовать одного и того же пользователя для нескольких производителей или потребителей: первые получат права на запись в определенные топики, а вторые — на чтение.
* [Управляют топиками](./cluster-topics.md#admin-api), если при [создании кластера](./cluster-create.md) была включена настройка **Управление топиками через API**. Подробнее см. в разделе [{#T}](../concepts/topics.md).

После [создания кластера](cluster-create.md) {{ KF }} вы можете:

* [{#T}](#create-user).
* [{#T}](#update-password).
* [{#T}](#update-account).
* [{#T}](#grant-permission).
* [{#T}](#revoke-permission).
* [{#T}](#delete-account).
* [{#T}](#list-accounts).

## Создать пользователя {#create-user}

{% note info %}

Если в кластере {{ mkf-name }} включена настройка **Управление топиками через API**, то для создания пользователя-администратора воспользуйтесь интерфейсами командной строки, API или {{ TF }}.

{% endnote %}

{% list tabs %}

- Консоль управления

  Чтобы создать пользователя для производителя или потребителя в кластере:
  
  1. В [консоли управления]({{ link-console-main }}) перейдите в нужный каталог.
  1. В списке сервисов выберите **{{ mkf-name }}**.
  1. Нажмите на имя нужного кластера и перейдите на вкладку **Пользователи**.
  1. Нажмите кнопку **Добавить**.
  1. Введите имя пользователя и пароль.

      {% include [user-name-and-password-limits](../../_includes/mdb/mkf/note-info-user-name-and-pass-limits.md) %}

  1. [Выдайте права доступа](#grant-permission) к нужным топикам.
  1. Нажмите кнопку **Добавить**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы создать пользователя:

  1. Посмотрите описание команды CLI для создания пользователей:

      ```bash
      {{ yc-mdb-kf }} user create --help
      ```

  1. Создайте пользователя и выдайте права доступа к нужным топикам:

      ```bash
      {{ yc-mdb-kf }} user create <имя пользователя> \
          --cluster-name <имя кластера> \
          --password <пароль длиной не менее 8 символов> \
          --permission topic=<имя топика>,role=<роль пользователя: producer или consumer>
      ```

  Чтобы создать [пользователя-администратора](../concepts/topics.md#management) для управления топиками в кластере с включенной настройкой **Управление топиками через API**:

  1. Посмотрите описание команды CLI для создания пользователя:

      ```bash
      {{ yc-mdb-kf }} user create --help
      ```

  1. Создайте пользователя с ролью `admin`, действующей на все (`*`) топики кластера:

      ```bash
      {{ yc-mdb-kf }} user create <имя пользователя> \
          --cluster-name <имя кластера> \
          --password <пароль длиной не менее 8 символов> \
          --permission topic=*,role=admin
      ```

  {% include [user-name-and-password-limits](../../_includes/mdb/mkf/note-info-user-name-and-pass-limits.md) %}

- {{ TF }}

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

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-link }}/mdb_kafka_cluster).

    {% include [Terraform timeouts](../../_includes/mdb/mkf/terraform/cluster-timeouts.md) %}

{% if api != "noshow" %}

- API

  Воспользуйтесь методом API [create](../api-ref/User/create.md) и передайте в запросе:
  * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
  * Настройки пользователя в параметре `userSpec`:
    * Имя пользователя в параметре `name`.
    * Пароль пользователя в параметре `password`.
    * Права доступа к топикам (один или несколько параметров `permissions`, по одному на каждый топик):
      * Имя топика в параметре `topicName`. Чтобы узнать имя, [получите список топиков в кластере](cluster-topics.md#list-topics).
      * Права доступа к топику в параметре `role`: `ACCESS_ROLE_PRODUCER` для производителя либо `ACCESS_ROLE_CONSUMER` для потребителя.

  Чтобы создать [пользователя-администратора](../concepts/topics.md#management) для управления топиками в кластере с включенной настройкой **Управление топиками через API**, при создании пользователя передайте в параметре `userSpec` блок `permission` со следующими значениями:

  * `topicName`: `*`;
  * `role`: `ACCESS_ROLE_ADMIN`.

  {% include [user-name-and-password-limits](../../_includes/mdb/mkf/note-info-user-name-and-pass-limits.md) %}

{% endif %}

{% endlist %}

## Изменить пароль пользователя {#update-password}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) перейдите в нужный каталог.
  1. В списке сервисов выберите **{{ mkf-name }}**.
  1. Нажмите на имя нужного кластера и перейдите на вкладку **Пользователи**.
  1. Нажмите значок ![image](../../_assets/horizontal-ellipsis.svg) для нужного пользователя и выберите пункт **Изменить пароль**.
  1. Задайте новый пароль и нажмите кнопку **Изменить**.

  {% include [password-limits](../../_includes/mdb/mkf/note-info-password-limits.md) %}

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы изменить пароль пользователя, выполните следующую команду:
  
  ```
  {{ yc-mdb-kf }} user update <имя пользователя> \
    --cluster-name <имя кластера> \
    --password <новый пароль>
  ```

  {% include [password-limits](../../_includes/mdb/mkf/note-info-password-limits.md) %}

- {{ TF }}

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

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-link }}/mdb_kafka_cluster).

    {% include [Terraform timeouts](../../_includes/mdb/mkf/terraform/cluster-timeouts.md) %}

{% if api != "noshow" %}

- API

  Воспользуйтесь методом API [update](../api-ref/User/update.md) и передайте в запросе:
  * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
  * Имя пользователя в параметре `userName`. Чтобы узнать имя, [получите список пользователей в кластере](#list-accounts).
  * Название настройки `password` в параметре `updateMask`. Если не задать этот параметр, метод API сбросит на значения по умолчанию все настройки пользователя, которые не были явно указаны в запросе.
  * Новый пароль пользователя в параметре `password`.

  {% include [password-limits](../../_includes/mdb/mkf/note-info-password-limits.md) %}

{% endif %}

{% endlist %}

## Изменить настройки пользователя {#update-account}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) перейдите в нужный каталог.
  1. В списке сервисов выберите **{{ mkf-name }}**.
  1. Нажмите на имя нужного кластера и перейдите на вкладку **Пользователи**.
  1. Нажмите значок ![image](../../_assets/horizontal-ellipsis.svg) для нужного пользователя и выберите пункт **Настроить**.
  1. [Выдайте](#grant-permission) или [отзовите](#revoke-permission) права доступа к топикам, если это необходимо.
  1. Нажмите кнопку **Сохранить**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  С помощью CLI можно [выдавать](#grant-permission) и [отзывать](#revoke-permission) права на доступ к топикам.

- {{ TF }}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).

    1. В описании кластера {{ mkf-name }} внесите изменения в блок `permission` в блоке `user`, чтобы [выдать](#grant-permission) или [отозвать](#revoke-permission) права на доступ к топикам.
    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-link }}/mdb_kafka_cluster).

    {% include [Terraform timeouts](../../_includes/mdb/mkf/terraform/cluster-timeouts.md) %}

{% if api != "noshow" %}

- API

  Воспользуйтесь методом API [update](../api-ref/User/update.md) и передайте в запросе:
  * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
  * Имя пользователя в параметре `userName`. Чтобы узнать имя, [получите список пользователей в кластере](#list-accounts).
  * Список настроек, которые необходимо изменить, в параметре `updateMask` (одной строкой через запятую). Если не задать этот параметр, метод API сбросит на значения по умолчанию все настройки пользователя, которые не были явно указаны в запросе.
  * Новый набор прав на доступ к топикам (один или несколько параметров `permissions`, по одному на каждый топик).

{% endif %}

{% endlist %}

## Выдать пользователю права {#grant-permission}

{% include [mkf-deleted-topic-permissions-note](../../_includes/mdb/mkf-deleted-topic-permissions-note.md) %}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) перейдите в нужный каталог.
  1. В списке сервисов выберите **{{ mkf-name }}**.
  1. Выберите кластер.
  1. Перейдите на вкладку **Пользователи**.
  1. Нажмите значок ![image](../../_assets/horizontal-ellipsis.svg) для нужного пользователя и выберите пункт **Настроить**.
  1. Найдите нужный топик в списке топиков.

     Если топика нет в списке — добавьте его:
     1. Нажмите кнопку **+ Добавить топик**. Если такой кнопки нет — значит, для этого пользователя добавлены все существующие топики кластера.
     1. Выберите нужный топик из выпадающего списка.

        {% note info %}

         Если при создании кластера была включена настройка **Управление топиками через API**, название топика следует вводить вручную. Чтобы разрешить доступ к любым топикам, укажите в поле **Топик** значение `*`.

         {% endnote %}

  1. Нажмите на значок ![image](../../_assets/plus.svg) в столбце **Роли** для нужного топика и выберите роль:
     * `ACCESS_ROLE_CONSUMER`: потребителям, которые используют этого пользователя, будет разрешен доступ к топику.
     * `ACCESS_ROLE_PRODUCER`: производителям, которые используют этого пользователя, будет разрешен доступ к топику.

     Вы можете выбрать роли `ACCESS_ROLE_CONSUMER` и `ACCESS_ROLE_PRODUCER` одновременно — тогда пользователь будет подходить и производителям, и потребителям.

  1. Чтобы выдать права на другие топики — повторите процедуру.
  1. (опционально) Если права были назначены топику по ошибке — [отзовите их](#revoke-permission).

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы выдать права пользователю:
  
  1. Получите список топиков кластера:

     ```bash
     {{ yc-mdb-kf }} topic list --cluster-name <имя кластера>
     ```

  1. Выдайте права на доступ к нужным топикам, передав параметры `--permission`:

     ```bash
     {{ yc-mdb-kf }} user update <имя пользователя> \
       --cluster-name <имя кластера> \
       --permission topic=<имя топика>,role=<роль пользователя: producer, consumer или admin>
     ```

     Доступны следующие параметры `--permission`:

     * `topic` — имя топика, к которому нужно выдать права доступа.
     * `role` — роль пользователя: `producer`, `consumer` или `admin`.

         Роль `admin` доступна только в кластере с включенным [управлением топиками через Admin API](../concepts/topics.md#management), если выбраны все топики (`topic=*`).

     При изменении прав пользователя, существующие права удаляются и заменяются новыми. То есть в команде всегда нужно передавать полный список прав, которые должны быть у пользователя.

     Например, чтобы выдать права пользователю `test-user` в кластере `kafka-cli` к топику `topic2` с ролью `producer`, при этом сохранить существующий доступ к топику `topic1`, выполните команду:

     ```bash
     {{ yc-mdb-kf }} user update test-user \
       --cluster-name kafka-cli \
       --permission topic=topic1,role=consumer \
       --permission topic=topic2,role=producer
     ```

- {{ TF }}

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

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-link }}/mdb_kafka_cluster).

    {% include [Terraform timeouts](../../_includes/mdb/mkf/terraform/cluster-timeouts.md) %}

{% if api != "noshow" %}

- API

  Воспользуйтесь методом API [grantPermission](../api-ref/User/grantPermission.md) и передайте в запросе:
  * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
  * Имя пользователя в параметре `userName`. Чтобы узнать имя, [получите список пользователей в кластере](#list-accounts).
  * Новое право на доступ к топику в параметре `permission`.

{% endif %}

{% endlist %}

## Отозвать права у пользователя {#revoke-permission}

Если в кластере с включенной настройкой **Управление топиками через API** отозвать у [пользователя-администратора](../concepts/topics.md#management) роль `ACCESS_ROLE_ADMIN`, то будет потеряна возможность управлять топиками. Не отзывайте эту роль или выдайте ее другому пользователю.

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) перейдите в нужный каталог.
  1. В списке сервисов выберите **{{ mkf-name }}**.
  1. Выберите кластер.
  1. Перейдите на вкладку **Пользователи**.
  1. Нажмите значок ![image](../../_assets/horizontal-ellipsis.svg) для нужного пользователя и выберите пункт **Настроить**.
  1. Найдите нужный топик в списке топиков.
  1. Удалите роль, которая больше не нужна: нажмите значок ![image](../../_assets/cross.svg) рядом с именем роли. Если нужно отозвать все права на доступ к топику, удалите его из списка: наведите курсор на имя топика и нажмите значок ![image](../../_assets/cross.svg) в конце строки.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы отозвать права доступа к нужным топикам, передайте обновленный список параметров `--permission`:
  
  ```
  {{ yc-mdb-kf }} user update <имя пользователя> \
    --cluster-name <имя кластера> \
    --permission topic=<имя топика>,role=<роль пользователя: producer, consumer или admin>
  ```
  
  При изменении прав пользователя, существующие права удаляются и заменяются новыми. То есть в команде всегда нужно передавать полный список прав, которые должны быть у пользователя.
  
  Флаг `--permission` должен содержать хотя бы одну пару топик/роль. Чтобы отозвать у пользователя все имеющиеся права доступа, воспользуйтесь консолью или удалите пользователя.

- {{ TF }}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).

    1. В описании кластера {{ mkf-name }} измените или удалите блок `permission` в блоке `user`.
    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-link }}/mdb_kafka_cluster).

    {% include [Terraform timeouts](../../_includes/mdb/mkf/terraform/cluster-timeouts.md) %}

{% if api != "noshow" %}

- API

  Воспользуйтесь методом API [revokePermission](../api-ref/User/revokePermission.md) и передайте в запросе:
  * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
  * Имя пользователя в параметре `userName`. Чтобы узнать имя, [получите список пользователя в кластере](#list-accounts).
  * Право на доступ к топику, которое требуется отозвать, в параметре `permission`.

{% endif %}

{% endlist %}

## Удалить пользователя {#delete-account}

Если в кластере с включенной настройкой **Управление топиками через API** удалить [пользователя-администратора](../concepts/topics.md#management) с ролью `ACCESS_ROLE_ADMIN`, то будет потеряна возможность управлять топиками. Перед удалением выдайте эту роль другому пользователю.

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) перейдите в нужный каталог.
  1. В списке сервисов выберите **{{ mkf-name }}**.
  1. Нажмите на имя нужного кластера и перейдите на вкладку **Пользователи**.
  1. Нажмите значок ![image](../../_assets/horizontal-ellipsis.svg) для нужного пользователя и выберите пункт **Удалить**.
  1. Подтвердите удаление и нажмите кнопку **Удалить**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы удалить пользователя, выполните команду:
  
  ```
  {{ yc-mdb-kf }} user delete <имя пользователя> --cluster-name <имя кластера>
  ```

- {{ TF }}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).

    1. Удалите из описания кластера {{ mkf-name }} блок `user` с описанием нужного пользователя.
    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-link }}/mdb_kafka_cluster).

    {% include [Terraform timeouts](../../_includes/mdb/mkf/terraform/cluster-timeouts.md) %}

{% if api != "noshow" %}

- API

  Воспользуйтесь методом API [delete](../api-ref/User/delete.md) и передайте в запросе:
  * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
  * Имя пользователя, которого требуется удалить, в параметре `userName`. Чтобы узнать имя, [получите список пользователей в кластере](#list-accounts).

{% endif %}

{% endlist %}

## Получить список пользователей в кластере {#list-accounts}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) перейдите в нужный каталог.
  1. В списке сервисов выберите **{{ mkf-name }}**.
  1. Нажмите на имя нужного кластера и перейдите на вкладку **Пользователи**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы получить список пользователей:
  
  1. Чтобы получить список пользователей, выполните команду:

     ```
     {{ yc-mdb-kf }} user list --cluster-name <имя кластера>
     ```
     
  1. Чтобы получить подробную информацию по конкретному пользователю, выполните команду:
  
     ```
     {{ yc-mdb-kf }} user get <имя пользователя> --cluster-name <имя кластера>
     ```

{% if api != "noshow" %}

- API

  Воспользуйтесь методом API [list](../api-ref/User/list.md): передайте значение идентификатора требуемого кластера в параметре `clusterId` запроса.

  Чтобы узнать идентификатор кластера, [получите список кластеров в каталоге](#list-clusters).

{% endif %}

{% endlist %}
