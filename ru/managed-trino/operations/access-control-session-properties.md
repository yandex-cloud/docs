---
title: Назначение правил доступа к системным свойствам сессии в {{ mtr-name }}
description: Правила определяют, могут ли пользователи устанавливать те или иные системные свойства сессии.
---

# Назначение правил доступа к системным свойствам сессии в {{ mtr-name }}

Правила доступа к системным свойствам сессии определяют, могут ли пользователи устанавливать те или иные системные свойства сессии в кластере {{ mtr-name }}.

{% note warning %}

Установите правила для системных свойств сессии, чтобы избежать злоупотребления системными ресурсами со стороны пользователей.

{% endnote %}

Для каждой пары «пользователь–свойство» правила применяются следующим образом:
* Правила проверяются в порядке их объявления. Применяется первое найденное правило, которое соответствует паре «пользователь–свойство».
* Если ни одно из заданных правил не соответствует паре «пользователь–свойство», пользователю запрещается устанавливать это системное свойство сессии.
* Если не задано ни одно правило доступа к системным свойствам сессии, каждый пользователь может устанавливать любые системные свойства сессии.
* Правила доступа к системным свойствам сессии применяются совместно с общими [правилами доступа к объектам каталогов](./access-control-catalogs.md).

## Назначить правила при создании кластера {set-at-create}

Правила доступа к системным свойствам сессии можно назначить одновременно с созданием кластера {{ mtr-name }}.

{% note warning %}
  
Указанные в правилах имена свойств не проверяются на валидность. Ошибка в имени свойства приведет к некорректной работе правила.
  
{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно создать кластер {{ mtr-name }}.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-trino }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_create }}** и задайте параметры кластера.
  1. В блоке **{{ ui-key.yacloud.trino.section_rbac }}** нажмите на значок ![image](../../_assets/console-icons/chevron-down.svg).
  1. В поле **{{ ui-key.yacloud.trino.ClusterForm.label_system-session-property_grCye }}** нажмите кнопку **{{ ui-key.yacloud.trino.label_rbac-add-rule }}**.
  1. В открывшемся окне задайте параметры правила:

     1. {% include [description-console](../../_includes/managed-trino/description-console.md) %}

     1. {% include [users-console](../../_includes/managed-trino/users-console.md) %}

     1. {% include [groups-console](../../_includes/managed-trino/groups-console.md) %}

     1. В поле **{{ ui-key.yacloud.trino.ClusterForm.label_allow_4botu }}** укажите, разрешено ли пользователю устанавливать свойство:
        * `No` — запрещено,
        * `Yes` — разрешено.

     1. (Опционально) В поле **{{ ui-key.yacloud.trino.ClusterForm.label_session-property_cyTHR }}** укажите, на какие свойства распространяется правило:
        * **{{ ui-key.yacloud.trino.rbac-catalog-match-by-name }}** — выберите имена свойств.
        * **{{ ui-key.yacloud.trino.rbac-catalog-match-by-name-regexp }}** — введите регулярное выражение. Правило распространяется на свойства, имена которых соответствуют регулярному выражению.
        * **{{ ui-key.yacloud.trino.rbac-catalog-match-by-empty }}** — правило распространяется на все свойства.

  1. При необходимости добавьте другие правила аналогичным образом.
  1. Чтобы удалить правило, добавленное по ошибке, в строке этого правила нажмите на значок ![trash-bin](../../_assets/console-icons/trash-bin.svg).
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}
  
  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы задать правила доступа к системным свойствам сессии:

  1. Создайте файл `access_control.yaml` и добавьте в него следующее содержимое:

     ```yaml
     system_session_properties:
       # Правило 1
       - allow: <право_установить_свойство>
         property:
           names:
             any: [<список_имен_свойств>]
           name_regexp: <регулярное_выражение>
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

     * `system_session_properties` — список правил для системных свойств сессии. Каждое правило включает в себя обязательный параметр `allow`, а также опциональные параметры: `property`, `groups`, `users` и `description`.

     * `allow` — право установить свойство:
       * `YES` — пользователю разрешено установить свойство.
       * `NO` — пользователю запрещено установить свойство.

     * `property` — свойства, на которые распространяется правило. Если параметр `property` не указан, правило распространяется на все свойства.
       * `names` — список имен свойств.
       * `name_regexp` — регулярное выражение. Правило распространяется на свойства, имена которых соответствуют регулярному выражению.

       Вы можете указать только один из параметров: `names` или `name_regexp`.

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
  
  1. Добавьте в конфигурационный файл ресурс `yandex_trino_access_control`, содержащий список правил `system_session_properties`.
 
     ```hcl
     resource "yandex_trino_cluster" "<имя_кластера>" {
       ...
     }

     resource "yandex_trino_access_control" "trino_access_control" {
       ...
       cluster_id  = yandex_trino_cluster.<имя_кластера>.id
       system_session_properties = [
         # Правило 1
         {
           allow         = "<право_установить_свойство>"
           property      = {
             names       = ["<список_имен_свойств>"]
             name_regexp = "<регулярное_выражение>"
           }
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

     * `system_session_properties` — список блоков правил для системных свойств сессии. Каждое правило включает в себя обязательный параметр `allow`, а также опциональные параметры: `property`, `groups`, `users` и `description`.

     * `allow` — право установить свойство:
       * `YES` — пользователю разрешено установить свойство.
       * `NO` — пользователю запрещено установить свойство.

     * `property` — свойства, на которые распространяется правило. Если блок `property` не указан, правило распространяется на все свойства.
       * `names` — список имен свойств.
       * `name_regexp` — регулярное выражение. Правило распространяется на свойства, имена которых соответствуют регулярному выражению.

       Вы можете указать только один из параметров: `names` или `name_regexp`.

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
            "system_session_properties": [
              {
                "allow": "<право_установить_свойство>",
                "property": {
                  "names": {
                    "any": [
                      "<список_имен_свойств>"
                    ]
                  },
                  "name_regexp": "<регулярное_выражение>"
                },
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

      * `system_session_properties` — список блоков правил для системных свойств сессии. Каждое правило включает в себя обязательный параметр `allow`, а также опциональные параметры: `property`, `groups`, `users` и `description`.

      * `allow` — право установить свойство:
        * `YES` — пользователю разрешено установить свойство.
        * `NO` — пользователю запрещено установить свойство.

      * `property` — свойства, на которые распространяется правило. Если блок `property` не указан, правило распространяется на все свойства.
        * `names` — список имен свойств.
        * `name_regexp` — регулярное выражение. Правило распространяется на свойства, имена которых соответствуют регулярному выражению.

        Блок `property` должен содержать либо вложенный блок `names`, либо параметр `name_regexp`.

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

Правила доступа к системным свойствам сессии можно назначить или обновить в уже существующем кластере {{ mtr-name }}.

{% note warning %}
  
Указанные в правилах имена свойств не проверяются на валидность. Ошибка в имени свойства приведет к некорректной работе правила.
  
{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в нужный каталог.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-trino }}**.
  1. Нажмите на имя нужного кластера.
  1. Перейдите в блок **{{ ui-key.yacloud.trino.ClusterView.RBACView.label_rbac-settings_o2F64 }}** → **{{ ui-key.yacloud.trino.ClusterForm.label_system-session-property_grCye }}**.
  1. Чтобы добавить правило, нажмите кнопку **{{ ui-key.yacloud.trino.label_rbac-add-rule }}** и в открывшемся окне задайте параметры правила:

     1. {% include [description-console](../../_includes/managed-trino/description-console.md) %}

     1. {% include [users-console](../../_includes/managed-trino/users-console.md) %}

     1. {% include [groups-console](../../_includes/managed-trino/groups-console.md) %}

     1. В поле **{{ ui-key.yacloud.trino.ClusterForm.label_allow_4botu }}** укажите, разрешено ли пользователю устанавливать свойство:
        * `No` — запрещено,
        * `Yes` — разрешено.

     1. (Опционально) В поле **{{ ui-key.yacloud.trino.ClusterForm.label_session-property_cyTHR }}** укажите, на какие свойства распространяется правило:
        * **{{ ui-key.yacloud.trino.rbac-catalog-match-by-name }}** — выберите имена свойств.
        * **{{ ui-key.yacloud.trino.rbac-catalog-match-by-name-regexp }}** — введите регулярное выражение. Правило распространяется на свойства, имена которых соответствуют регулярному выражению.
        * **{{ ui-key.yacloud.trino.rbac-catalog-match-by-empty }}** — правило распространяется на все свойства.

  1. При необходимости добавьте другие правила аналогичным образом.
  1. Чтобы отредактировать правило:
     1. В строке этого правила нажмите на значок ![trash-bin](../../_assets/console-icons/pencil.svg).
     1. Измените параметры правила и нажмите кнопку **{{ ui-key.yacloud.common.update }}**.
  1. Чтобы удалить ненужное правило, в строке этого правила нажмите на значок ![trash-bin](../../_assets/console-icons/trash-bin.svg).
  1. Нажмите кнопку **{{ ui-key.yacloud.common.save-changes }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы задать правила доступа к системным свойствам сессии:

  1. Если правила доступа еще не заданы, создайте файл `access_control.yaml` и добавьте в него следующее содержимое:

     ```yaml
     system_session_properties:
       # Правило 1
       - allow: <право_установить_свойство>
         property:
           names:
             any: [<список_имен_свойств>]
           name_regexp: <регулярное_выражение>
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

     * `system_session_properties` — список правил для системных свойств сессии. Каждое правило включает в себя обязательный параметр `allow`, а также опциональные параметры: `property`, `groups`, `users` и `description`.

     * `allow` — право установить свойство:
       * `YES` — пользователю разрешено установить свойство.
       * `NO` — пользователю запрещено установить свойство.

     * `property` — свойства, на которые распространяется правило. Если параметр `property` не указан, правило распространяется на все свойства.
       * `names` — список имен свойств.
       * `name_regexp` — регулярное выражение. Правило распространяется на свойства, имена которых соответствуют регулярному выражению.

       Вы можете указать только один из параметров: `names` или `name_regexp`.

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
  
  1. Если правила доступа еще не заданы, добавьте ресурс `yandex_trino_access_control`, содержащий список правил `system_session_properties`.

     ```hcl
     resource "yandex_trino_cluster" "<имя_кластера>" {
       ...
     }

     resource "yandex_trino_access_control" "trino_access_control" {
       ...
       cluster_id  = yandex_trino_cluster.<имя_кластера>.id
       system_session_properties = [
         # Правило 1
         {
           allow         = "<право_установить_свойство>"
           property      = {
             names       = ["<список_имен_свойств>"]
             name_regexp = "<регулярное_выражение>"
           }
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

     * `system_session_properties` — список блоков правил для системных свойств сессии. Каждое правило включает в себя обязательный параметр `allow`, а также опциональные параметры: `property`, `groups`, `users` и `description`.

     * `allow` — право установить свойство:
       * `YES` — пользователю разрешено установить свойство.
       * `NO` — пользователю запрещено установить свойство.

     * `property` — свойства, на которые распространяется правило. Если блок `property` не указан, правило распространяется на все свойства.
       * `names` — список имен свойств.
       * `name_regexp` — регулярное выражение. Правило распространяется на свойства, имена которых соответствуют регулярному выражению.

       Вы можете указать только один из параметров: `names` или `name_regexp`.

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
            "trino.access_control.system_session_properties"
          ]
        },
        "trino": {
          "access_control": {
            "system_session_properties": [
              {
                "allow": "<право_установить_свойство>",
                "property": {
                  "names": {
                    "any": [
                      "<список_имен_свойств>"
                    ]
                  },
                  "name_regexp": "<регулярное_выражение>"
                },
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

      * `system_session_properties` — список блоков правил для системных свойств сессии. Каждое правило включает в себя обязательный параметр `allow`, а также опциональные параметры: `property`, `groups`, `users` и `description`.

      * `allow` — право установить свойство:
        * `YES` — пользователю разрешено установить свойство.
        * `NO` — пользователю запрещено установить свойство.

      * `property` — свойства, на которые распространяется правило. Если блок `property` не указан, правило распространяется на все свойства.
        * `names` — список имен свойств.
        * `name_regexp` — регулярное выражение. Правило распространяется на свойства, имена которых соответствуют регулярному выражению.

        Блок `property` должен содержать либо вложенный блок `names`, либо параметр `name_regexp`.

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

## Пример назначения правил доступа к системным свойствам сессии {#example}

Допустим, вам нужно настроить правила доступа к системным свойствам сессии:
1. Разрешить устанавливать любые свойства пользователям, входящим в группу с идентификатором `admins_group_id`.
1. Разрешить пользователям из группы с идентификатором `analytics_group_id` устанавливать свойства с именами вида `query_.*`.
1. Всем остальным пользователям запретить устанавливать свойства.

{% list tabs group=instructions %}

- CLI {#cli}

  Файл `access_control.yaml` для такого набора правил выглядит так:

  ```yaml
  system_session_properties:
    - groups: 
        - admins_group_id
      allow: YES

    - groups: 
        - data_engineers_group_id
      property:
        name_regexp: "query_.*"
      allow: YES
  ```

- {{ TF }} {#tf}

  Конфигурационный файл для такого набора правил выглядит так:

  ```hcl
  resource "yandex_trino_access_control" "trino_access_control" {
    ...
    cluster_id  = <идентификатор_кластера>
    system_session_properties = [
      {
        groups        = ["admins_group_id"]
        allow         = "YES"
      },
      {
        groups        = ["data_engineers_group_id"]
        property      = {
          name_regexp = "query_.*"
        }
        allow         = "YES"
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
        "trino.access_control.system_session_properties"
      ]
    },
    "trino": {
      "access_control": {
        "system_session_properties": [
          {
            "groups": [
              "admins_group_id"
            ],
            "allow": "YES"
          },
          {
            "groups": [
              "data_engineers_group_id"
            ],
            "property": {
              "name_regexp": "query_.*"
            },
            "allow": "YES"
          }
        ]
      }
    }
  }
  ```

{% endlist %}
