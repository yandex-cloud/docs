---
title: Назначение правил доступа к запросам в {{ mtr-name }}
description: Правила определяют, какие действия пользователи могут совершать над SQL-запросами.
---

# Назначение правил доступа к запросам в {{ mtr-name }}

Правила доступа к запросам определяют, какие действия пользователи могут совершать над SQL-запросами в кластере {{ mtr-name }}.

Для каждой пары «пользователь–запрос» правила применяются следующим образом:
* Правила проверяются в порядке их объявления. Применяется первое найденное правило, которое соответствует паре «пользователь–запрос».
* Если ни одно из заданных правил не соответствует паре «пользователь–запрос», пользователю запрещаются любые действия над запросом.
* Если не задано ни одно правило доступа к запросам, каждый пользователь может выполнять любые действия над всеми запросами.
* Правила доступа к запросам применяются совместно с общими [правилами доступа к объектам каталогов](./access-control-catalogs.md).

{% note warning %}

При отсутствии правил доступа к запросам пользователи могут просматривать и отменять запросы друг друга.

{% endnote %}

## Назначить правила при создании кластера {#set-at-create}

Правила доступа к запросам можно назначить одновременно с созданием кластера {{ mtr-name }}.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно создать кластер {{ mtr-name }}.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-trino }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_create }}** и задайте параметры кластера.
  1. В блоке **{{ ui-key.yacloud.trino.section_rbac }}** нажмите на значок ![image](../../_assets/console-icons/chevron-down.svg).
  1. В поле **{{ ui-key.yacloud.trino.label_rbac-query }}** нажмите кнопку **{{ ui-key.yacloud.trino.label_rbac-add-rule }}**.
  1. В открывшемся окне задайте параметры правила:

     1. {% include [description-console](../../_includes/managed-trino/description-console.md) %}

     1. {% include [users-console](../../_includes/managed-trino/users-console.md) %}

     1. {% include [groups-console](../../_includes/managed-trino/groups-console.md) %}

     1. (Опционально) В поле **{{ ui-key.yacloud.trino.label_rbac-query-privileges }}** выберите разрешенные действия над запросами:
        * `VIEW` — просмотр информации о запросе.
        * `KILL` — отмена запроса.
        * `EXECUTE` — исполнение запроса.

        Если не выбрано ни одно действие, правило запрещает выполнение любых действий над запросами.

        {% note warning %}

        Нельзя создать правило с разрешенным действием `EXECUTE`, если в поле **{{ ui-key.yacloud.trino.ClusterForm.label_query-owners_a81zm }}** выбран хотя бы один пользователь.

        {% endnote %}

     1. (Опционально) В поле **{{ ui-key.yacloud.trino.ClusterForm.label_query-owners_a81zm }}** выберите пользователей, на запросы которых распространяется правило:
        1. Нажмите кнопку **{{ ui-key.yacloud.trino.ClusterForm.button_add_1EfQa }}**.
        1. В открывшемся списке выберите нужных пользователей. Чтобы найти пользователя, используйте строку поиска над списком.
        1. Чтобы удалить пользователя, выбранного по ошибке, повторно нажмите на него в списке.

        Если в поле **{{ ui-key.yacloud.trino.ClusterForm.label_query-owners_a81zm }}** не выбран ни один пользователь, правило распространяется на запросы всех пользователей.

  1. При необходимости добавьте другие правила аналогичным образом.
  1. Чтобы удалить правило, добавленное по ошибке, в строке этого правила нажмите на значок ![trash-bin](../../_assets/console-icons/trash-bin.svg).
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}
  
  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы задать правила доступа к запросам:

  1. Создайте файл `access_control.yaml` и добавьте в него следующее содержимое:

     ```yaml
     queries:
       # Правило 1
       - privileges: [<список_разрешений>]
         query_owners: [<список_владельцев_запросов>]
         groups: [<список_идентификаторов_групп>]
         users: [<список_идентификаторов_пользователей>]
         description: <описание_правила>
       # Правило 2
       - <Параметры_правила_2>
       ...
       # Правило N
       - <Параметры_правила_N>
     ```

     Где:

     * `queries` — список правил для запросов. Все параметры правила являются опциональными: `privileges`, `query_owners`, `groups`, `users` и `description`.

     * `privileges` — список разрешенных действий над запросами:
       * `VIEW` — просмотр информации о запросе.
       * `KILL` — отмена запроса.
       * `EXECUTE` — исполнение запроса.
        
       {% include notitle [queries-privileges](../../_includes/managed-trino/access-control-src.md#queries-privileges) %}

     * `query_owners` — список идентификаторов владельцев запросов. Правило распространяется на запросы, владельцы которых перечислены в параметре `query_owners`. Если параметр не указан, правило распространяется на запросы всех пользователей.

     {% include [groups-users-description](../../_includes/managed-trino/groups-users-description.md) %}

  2. Посмотрите описание команды CLI для создания кластера:

     ```bash
     {{ yc-mdb-tr }} cluster create --help
     ```

  3. Выполните команду:

     ```bash
     {{ yc-mdb-tr }} cluster create \
       ...
       --access-control-from-file access_control.yaml
     ```

     Доступные параметры кластера и их описания см. в [инструкции](cluster-create.md#create-cluster).

- {{ TF }} {#tf}

  1. Создайте конфигурационный файл {{ TF }} с [планом инфраструктуры](cluster-create.md).
  
  1. Добавьте в конфигурационный файл ресурс `yandex_trino_access_control`, содержащий список правил `queries`.
 
     ```hcl
     resource "yandex_trino_cluster" "<имя_кластера>" {
       ...
     }

     resource "yandex_trino_access_control" "trino_access_control" {
       ...
       cluster_id  = yandex_trino_cluster.<имя_кластера>.id
       queries = [
         # Правило 1
         {
           privileges    = ["<список_разрешений>"]
           query_owners  = ["<список_владельцев_запросов>"]
           users         = ["<список_идентификаторов_пользователей>"]
           groups        = ["<список_идентификаторов_групп>"]
           description   = "<описание_правила>"
         },
         # Правило 2
         {
           ... 
         },
         ...
         # Правило N
         {
           ... 
         }
       ]
       ...
     }
     ```

     Где:

     * `queries` — список блоков правил для запросов. Все параметры правила являются опциональными: `privileges`, `query_owners`, `groups`, `users` и `description`.

     * `privileges` — список разрешенных действий над запросами:
       * `VIEW` — просмотр информации о запросе.
       * `KILL` — отмена запроса.
       * `EXECUTE` — исполнение запроса.
        
       {% include notitle [queries-privileges](../../_includes/managed-trino/access-control-src.md#queries-privileges) %}

     * `query_owners` — список идентификаторов владельцев запросов. Правило распространяется на запросы, владельцы которых перечислены в параметре `query_owners`. Если параметр не указан, правило распространяется на запросы всех пользователей.

     {% include [groups-users-description](../../_includes/managed-trino/groups-users-description.md) %}

  2. Проверьте корректность настроек.
  
      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}
  
  3. Подтвердите изменение ресурсов.
  
      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}
 
  Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-mtr-access }}).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  2. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

  3. Создайте файл `body.json` и добавьте в него следующее содержимое:

      ```json
      {
        <Параметры_кластера>
        ...
        "trino": {
          "access_control": {
            "queries": [
              {
                "privileges": [
                  "<список_разрешений>"
                ],
                "query_owners": [
                  "<список_владельцев_запросов>"
                ],
                "users": [
                  "<список_идентификаторов_пользователей>"
                ],
                "groups": [
                  "<список_идентификаторов_групп>"
                ],
                "description": "<описание_правила>"
              },
              {
                <Блок_правила_2>
              },
              ...
              {
                <Блок_правила_N>
              }
            ]
          }
        }
      }
      ```

      Где:

      * `access_control` — конфигурация прав доступа в рамках кластера.

      * `queries` — список блоков правил для запросов. Все параметры правила являются опциональными: `privileges`, `query_owners`, `groups`, `users` и `description`.

      * `privileges` — список разрешенных действий над запросами:
        * `VIEW` — просмотр информации о запросе.
        * `KILL` — отмена запроса.
        * `EXECUTE` — исполнение запроса.
        
        {% include notitle [queries-privileges](../../_includes/managed-trino/access-control-src.md#queries-privileges) %}

      * `query_owners` — список идентификаторов владельцев запросов. Правило распространяется на запросы, владельцы которых перечислены в параметре `query_owners`. Если параметр не указан, правило распространяется на запросы всех пользователей.

      {% include [groups-users-description](../../_includes/managed-trino/groups-users-description.md) %}

      Доступные параметры кластера и их описания см. в [инструкции](cluster-create.md#create-cluster).

  4. Воспользуйтесь вызовом [ClusterService/Create](../api-ref/grpc/Cluster/create.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

      ```bash
      grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/trino/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d @ \
          {{ api-host-trino }}:{{ port-https }} \
          yandex.cloud.trino.v1.ClusterService.Create \
          < body.json
      ```

  5. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation).

{% endlist %}

## Назначить правила для существующего кластера {#set-at-update}

Правила доступа к запросам можно назначить или обновить в уже существующем кластере {{ mtr-name }}.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в нужный каталог.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-trino }}**.
  1. Нажмите на имя нужного кластера.
  1. Перейдите в блок **{{ ui-key.yacloud.trino.ClusterView.RBACView.label_rbac-settings_o2F64 }}** → **{{ ui-key.yacloud.trino.label_rbac-query }}**.
  1. Чтобы добавить правило, нажмите кнопку **{{ ui-key.yacloud.trino.label_rbac-add-rule }}** и в открывшемся окне задайте параметры правила:

     1. {% include [description-console](../../_includes/managed-trino/description-console.md) %}

     1. {% include [users-console](../../_includes/managed-trino/users-console.md) %}

     1. {% include [groups-console](../../_includes/managed-trino/groups-console.md) %}

     1. (Опционально) В поле **{{ ui-key.yacloud.trino.label_rbac-query-privileges }}** выберите разрешенные действия над запросами:
        * `VIEW` — просмотр информации о запросе.
        * `KILL` — отмена запроса.
        * `EXECUTE` — исполнение запроса.

        Если не выбрано ни одно действие, правило запрещает выполнение любых действий над запросами.

        {% note warning %}

        Нельзя создать правило с разрешенным действием `EXECUTE`, если в поле **{{ ui-key.yacloud.trino.ClusterForm.label_query-owners_a81zm }}** выбран хотя бы один пользователь.

        {% endnote %}

     1. (Опционально) В поле **{{ ui-key.yacloud.trino.ClusterForm.label_query-owners_a81zm }}** выберите пользователей, на запросы которых распространяется правило:
        1. Нажмите кнопку **{{ ui-key.yacloud.trino.ClusterForm.button_add_1EfQa }}**.
        1. В открывшемся списке выберите нужных пользователей. Чтобы найти пользователя, используйте строку поиска над списком.
        1. Чтобы удалить пользователя, выбранного по ошибке, повторно нажмите на него в списке.

        Если в поле **{{ ui-key.yacloud.trino.ClusterForm.label_query-owners_a81zm }}** не выбран ни один пользователь, правило распространяется на запросы всех пользователей.

  1. При необходимости добавьте другие правила аналогичным образом.
  1. Чтобы отредактировать правило:
     1. В строке этого правила нажмите на значок ![trash-bin](../../_assets/console-icons/pencil.svg).
     1. Измените параметры правила и нажмите кнопку **{{ ui-key.yacloud.common.update }}**.
  1. Чтобы удалить ненужное правило, в строке этого правила нажмите на значок ![trash-bin](../../_assets/console-icons/trash-bin.svg).
  1. Нажмите кнопку **{{ ui-key.yacloud.common.save-changes }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы задать правила доступа к запросам:

  1. Если правила доступа еще не заданы, создайте файл `access_control.yaml` и добавьте в него следующее содержимое:

     ```yaml
     queries:
       # Правило 1
       - privileges: [<список_разрешений>]
         query_owners: [<список_владельцев_запросов>]
         groups: [<список_идентификаторов_групп>]
         users: [<список_идентификаторов_пользователей>]
         description: <описание_правила>
       # Правило 2
       - <Параметры_правила_2>
       ...
       # Правило N
       - <Параметры_правила_N>
     ```

     Где:

     * `queries` — список правил для запросов. Все параметры правила являются опциональными: `privileges`, `query_owners`, `groups`, `users` и `description`.

     * `privileges` — список разрешенных действий над запросами:
       * `VIEW` — просмотр информации о запросе.
       * `KILL` — отмена запроса.
       * `EXECUTE` — исполнение запроса.
        
       {% include notitle [queries-privileges](../../_includes/managed-trino/access-control-src.md#queries-privileges) %}

     * `query_owners` — список идентификаторов владельцев запросов. Правило распространяется на запросы, владельцы которых перечислены в параметре `query_owners`. Если параметр не указан, правило распространяется на запросы всех пользователей.

     {% include [groups-users-description](../../_includes/managed-trino/groups-users-description.md) %}

  1. Если правила доступа уже заданы, откройте файл `access_control.yaml` и внесите в него изменения. Вы можете:

     * добавить новые правила;
     * изменить параметры существующих правил;
     * удалить ненужные правила.

  2. Выполните команду:

     ```bash
     {{ yc-mdb-tr }} cluster set-access-control <имя_или_идентификатор_кластера> \
       --from-file access_control.yaml
     ```

     Идентификатор и имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.
  
      О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).
  
  1. Если правила доступа еще не заданы, добавьте ресурс `yandex_trino_access_control`, содержащий список правил `queries`.

     ```hcl
     resource "yandex_trino_cluster" "<имя_кластера>" {
       ...
     }

     resource "yandex_trino_access_control" "trino_access_control" {
       ...
       cluster_id  = yandex_trino_cluster.<имя_кластера>.id
       queries = [
         # Правило 1
         {
           privileges    = ["<список_разрешений>"]
           query_owners  = ["<список_владельцев_запросов>"]
           users         = ["<список_идентификаторов_пользователей>"]
           groups        = ["<список_идентификаторов_групп>"]
           description   = "<описание_правила>"
         },
         # Правило 2
         {
           ... 
         },
         ...
         # Правило N
         {
           ... 
         }
       ]
       ...
     }
     ```

     Где:

     * `queries` — список блоков правил для запросов. Все параметры правила являются опциональными: `privileges`, `query_owners`, `groups`, `users` и `description`.

     * `privileges` — список разрешенных действий над запросами:
       * `VIEW` — просмотр информации о запросе.
       * `KILL` — отмена запроса.
       * `EXECUTE` — исполнение запроса.
        
       {% include notitle [queries-privileges](../../_includes/managed-trino/access-control-src.md#queries-privileges) %}

     * `query_owners` — список идентификаторов владельцев запросов. Правило распространяется на запросы, владельцы которых перечислены в параметре `query_owners`. Если параметр не указан, правило распространяется на запросы всех пользователей.

     {% include [groups-users-description](../../_includes/managed-trino/groups-users-description.md) %}

  2. Если правила доступа уже заданы, внесите правки в описание ресурса `yandex_trino_access_control`. Вы можете:

     * добавить новые правила;
     * изменить параметры существующих правил;
     * удалить ненужные правила.

  3. Проверьте корректность настроек.
  
      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}
  
  4. Подтвердите изменение ресурсов.
  
      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}
 
  Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-mtr-access }}).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

  1. Если правила доступа еще не заданы, создайте файл `body.json` и добавьте в него следующее содержимое:

      ```json
      {
        "cluster_id": "<идентификатор_кластера>",
        "update_mask": {
          "paths": [
            "trino.access_control.queries"
          ]
        },
        "trino": {
          "access_control": {
            "queries": [
              {
                "privileges": [
                  "<список_разрешений>"
                ],
                "query_owners": [
                  "<список_владельцев_запросов>"
                ],
                "users": [
                  "<список_идентификаторов_пользователей>"
                ],
                "groups": [
                  "<список_идентификаторов_групп>"
                ],
                "description": "<описание_правила>"
              },
              {
                <Блок_правила_2>
              },
              ...
              {
                <Блок_правила_N>
              }
            ]
          }
        }
      }
      ```

      Где:

      * `cluster_id` — идентификатор кластера.
          
          Идентификатор кластера можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.

      * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

          {% cut "Формат перечисления настроек" %}

          ```yaml
          "update_mask": {
            "paths": [
              "<настройка_1>",
              "<настройка_2>",
              ...
              "<настройка_N>"
            ]
          }
          ```

          {% endcut %}

          {% note warning %}

          При изменении кластера все параметры изменяемого объекта, которые не были явно переданы в запросе, будут переопределены на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `update_mask`.

          {% endnote %}

      * `access_control` — конфигурация прав доступа в рамках кластера.

      * `queries` — список блоков правил для запросов. Все параметры правила являются опциональными: `privileges`, `query_owners`, `groups`, `users` и `description`.

      * `privileges` — список разрешенных действий над запросами:
        * `VIEW` — просмотр информации о запросе.
        * `KILL` — отмена запроса.
        * `EXECUTE` — исполнение запроса.
        
        {% include notitle [queries-privileges](../../_includes/managed-trino/access-control-src.md#queries-privileges) %}

      * `query_owners` — список идентификаторов владельцев запросов. Правило распространяется на запросы, владельцы которых перечислены в параметре `query_owners`. Если параметр не указан, правило распространяется на запросы всех пользователей.

      {% include [groups-users-description](../../_includes/managed-trino/groups-users-description.md) %}

  2. Если правила уже заданы, откройте существующий файл `body.json` с правилами и внесите в него правки. Вы можете:

     * добавить новые правила;
     * изменить параметры существующих правил;
     * удалить ненужные правила.

  3. Воспользуйтесь вызовом [ClusterService.Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

      ```bash
      grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/trino/v1/cluster_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d @ \
        {{ api-host-trino }}:{{ port-https }} \
        yandex.cloud.trino.v1.ClusterService.Update \
        < body.json
      ```

  4. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation).

{% endlist %}

## Пример назначения правил доступа к запросам {#example}

Допустим, вам нужно настроить правила доступа к запросам:
1. Разрешить пользователям, входящим в группу с идентификатором `admins_group_id`, выполнять любые действия над запросами.
1. Разрешить пользователям из группы с идентификатором `security_group_id` просматривать и удалять запросы, владельцем которых является пользователь с идентификатором `suspicious_user_id`.
1. Всем остальным пользователям разрешить только исполнять запросы.

{% list tabs group=instructions %}

- CLI {#cli}

  Файл `access_control.yaml` для такого набора правил выглядит так:

  ```yaml
  queries:
    - groups:
        - admins_group_id
      privileges:
        - VIEW
        - KILL
        - EXECUTE

    - groups: 
        - security_group_id
      query_owners:
        - suspicious_user_id
      privileges:
        - VIEW
        - KILL

    - privileges:
        - EXECUTE
  ```

- {{ TF }} {#tf}

  Конфигурационный файл для такого набора правил выглядит так:

  ```hcl
  resource "yandex_trino_access_control" "trino_access_control" {
    ...
    cluster_id  = <идентификатор_кластера>
    queries = [
      {
        privileges    = ["VIEW", "KILL", "EXECUTE"]
        groups        = ["admins_group_id"]
      },
      {
        privileges    = ["VIEW", "KILL"]
        groups        = ["security_group_id"]
        query_owners  = ["suspicious_user_id"]
      },
      {
        privileges    = ["EXECUTE"]
      }
    ]
    ...
  }
  ```

- gRPC API {#grpc-api}

  Файл `body.json` для такого набора правил выглядит так:

  ```json
  {
    "cluster_id": "<идентификатор_кластера>",
    "update_mask": {
      "paths": [
        "trino.access_control.queries"
      ]
    },
    "trino": {
      "access_control": {
        "queries": [
          {
            "privileges": [
              "VIEW",
              "KILL",
              "EXECUTE"              
            ],
            "groups": [
              "admins_group_id"
            ]
          },
          {
            "privileges": [
              "VIEW",
              "KILL"
            ],
            "query_owners": [
              "suspicious_user_id"
            ],
            "groups": [
              "security_group_id"
            ]
          },
          {
            "privileges": [
              "EXECUTE"
            ]
          }
        ]
      }
    }
  }
  ```

{% endlist %}
