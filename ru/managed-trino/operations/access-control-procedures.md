---
title: Управление доступом к процедурам в {{ mtr-name }}
description: Правила определяют, какие действия пользователи могут совершать над пользовательскими процедурами.
---

# Управление доступом к процедурам в {{ mtr-name }}

Правила доступа к процедурам определяют, какие действия пользователи могут совершать над пользовательскими процедурами в кластере {{ mtr-name }}.

{% note info %}

Нельзя ограничить выполнение процедур, вызываемых через схему `system` (системных процедур {{ TR }}).

{% endnote %}

Для каждой пары «пользователь–процедура» правила применяются следующим образом:
* Правила проверяются в порядке их объявления. Применяется первое найденное правило, которое соответствует паре «пользователь–процедура».
* Если ни одно из заданных правил не соответствует паре «пользователь–процедура», пользователю запрещаются любые действия над процедурой.
* Если не задано ни одно правило доступа к процедурам, каждый пользователь может выполнять только системные процедуры.
* Правила доступа к процедурам применяются совместно с общими [правилами доступа к объектам каталогов](./access-control-catalogs.md).

## Назначить правила при создании кластера {#set-at-create}

Правила доступа к процедурам можно назначить одновременно с созданием кластера {{ mtr-name }}.

{% note warning %}
  
Указанные в правилах имена процедур и схем не проверяются на валидность. Ошибка в имени процедуры или схемы приведет к некорректной работе правила.
  
{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно создать кластер {{ mtr-name }}.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-trino }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_create }}** и задайте параметры кластера.
  1. В блоке **{{ ui-key.yacloud.trino.section_rbac }}** нажмите на значок ![image](../../_assets/console-icons/chevron-down.svg).
  1. В поле **{{ ui-key.yacloud.trino.label_rbac-procedure }}** нажмите кнопку **{{ ui-key.yacloud.trino.label_rbac-add-rule }}**.
  1. В открывшемся окне задайте параметры правила:

     1. {% include [description-console](../../_includes/managed-trino/description-console.md) %}

     1. {% include [users-console](../../_includes/managed-trino/users-console.md) %}

     1. {% include [groups-console](../../_includes/managed-trino/groups-console.md) %}

     1. (Опционально) В поле **{{ ui-key.yacloud.trino.label_rbac-procedure-privileges }}** выберите `EXECUTE`, чтобы разрешить вызов процедуры. Если привилегии не выбраны, правило запрещает выполнение любых действий над процедурами.

     1. {% include [calatogs-description-console](../../_includes/managed-trino/calatogs-description-console.md) %}

     1. {% include [schemas-description-console](../../_includes/managed-trino/schemas-description-console.md) %}

     1. (Опционально) В поле **{{ ui-key.yacloud.trino.label_rbac-procedure-access }}** укажите, на какие процедуры распространяется правило:
        * **{{ ui-key.yacloud.trino.rbac-catalog-match-by-name }}** — выберите имена процедур.
        * **{{ ui-key.yacloud.trino.rbac-catalog-match-by-name-regexp }}** — введите регулярное выражение. Правило распространяется на процедуры, имена которых соответствуют регулярному выражению.
        * **{{ ui-key.yacloud.trino.rbac-catalog-match-by-empty }}** — правило распространяется на все процедуры.
  1. При необходимости добавьте другие правила аналогичным образом.
  1. Чтобы удалить правило, добавленное по ошибке, в строке этого правила нажмите на значок ![trash-bin](../../_assets/console-icons/trash-bin.svg).
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы задать правила доступа к процедурам:

  1. Создайте файл `access_control.yaml` и добавьте в него следующее содержимое:

     ```yaml
     procedures:
       # Правило 1
       - privileges: [<список_разрешений>]
         procedure:
           names:
             any: [<список_имен_процедур>]
           name_regexp: <регулярное_выражение>
         schema:
           names:
             any: [<список_имен_схем>]
           name_regexp: <регулярное_выражение>
         catalog:
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

     * `procedures` — список правил для процедур. Все параметры правила являются опциональными: `privileges`, `procedure`, `schema`, `catalog`, `groups`, `users` и `description`.

     * `privileges` — разрешенные действия над процедурами:
       * `EXECUTE` — разрешен вызов процедуры.

       {% include notitle [procedures-privileges](../../_includes/managed-trino/access-control-src.md#procedures-privileges) %}

     * `procedure` — процедуры, на которые распространяется правило. Если параметр `procedure` не указан, правило распространяется на все процедуры.
       * `names` — список имен процедур.
       * `name_regexp` — регулярное выражение. Правило распространяется на процедуры, имена которых соответствуют регулярному выражению.

       Вы можете указать только один из параметров: `names` или `name_regexp`.

     * `schema` — схемы, на которые распространяется правило. Если параметр `schema` не указан, правило распространяется на все схемы.
       * `names` — список имен схем.
       * `name_regexp` — регулярное выражение. Правило распространяется на схемы, имена которых соответствуют регулярному выражению.

       Вы можете указать только один из параметров: `names` или `name_regexp`.

     * `catalog` — каталоги кластера, на которые распространяется правило. Если параметр `catalog` не указан, правило распространяется на все каталоги кластера.
       * `name_regexp` — регулярное выражение. Правило распространяется на каталоги, имена которых соответствуют регулярному выражению.

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
  
  1. Добавьте в конфигурационный файл ресурс `yandex_trino_access_control`, содержащий список правил `procedures`.
 
     ```hcl
     resource "yandex_trino_cluster" "<имя_кластера>" {
       ...
     }

     resource "yandex_trino_catalog" "<имя_каталога_1>" {
       ...
     }

     resource "yandex_trino_catalog" "<имя_каталога_2>" {
       ...
     }

     ...

     resource "yandex_trino_catalog" "<имя_каталога_N>" {
       ...
     }

     resource "yandex_trino_access_control" "trino_access_control" {
       ...
       cluster_id  = yandex_trino_cluster.<имя_кластера>.id
       procedures = [
         # Правило 1
         {
           privileges    = ["<список_разрешений>"]
           procedure     = {
             names       = ["<список_имен_процедур>"]
             name_regexp = "<регулярное_выражение>"
           }
           schema        = {
             names       = ["<список_имен_схем>"]
             name_regexp = "<регулярное_выражение>"
           }
           catalog       = {
             ids         = [
               yandex_trino_catalog.<имя_каталога_1>.id,
               yandex_trino_catalog.<имя_каталога_2>.id,
               ... 
               yandex_trino_catalog.<имя_каталога_N>.id
             ]
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

     * `procedures` — список блоков правил для процедур. Все параметры правила являются опциональными: `privileges`, `procedure`, `schema`, `catalog`, `groups`, `users` и `description`.

     * `privileges` — разрешенные действия над процедурами:
       * `EXECUTE` — разрешен вызов процедуры.

       {% include notitle [procedures-privileges](../../_includes/managed-trino/access-control-src.md#procedures-privileges) %}

     * `procedure` — процедуры, на которые распространяется правило. Если блок `procedure` не указан, правило распространяется на все процедуры.
       * `names` — список имен процедур.
       * `name_regexp` — регулярное выражение. Правило распространяется на процедуры, имена которых соответствуют регулярному выражению.

       Вы можете указать только один из параметров: `names` или `name_regexp`.

     * `schema` — схемы, на которые распространяется правило. Если блок `schema` не указан, правило распространяется на все схемы.
       * `names` — список имен схем.
       * `name_regexp` — регулярное выражение. Правило распространяется на схемы, имена которых соответствуют регулярному выражению.

       Вы можете указать только один из параметров: `names` или `name_regexp`.

     * `catalog` — каталоги кластера, на которые распространяется правило. Если блок `catalog` не указан, правило распространяется на все каталоги кластера.
       * `ids` — список идентификаторов каталогов. Указанные каталоги должны создаваться в том же манифесте.
       * `name_regexp` — регулярное выражение. Правило распространяется на каталоги, имена которых соответствуют регулярному выражению.

       Вы можете указать только один из параметров: `ids` или `name_regexp`.

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
          "catalogs": [
            {
              "name": "имя_каталога_1",
              ...
            },
            {
              "name": "имя_каталога_2",
              ...
            },
            ...
            {
              "name": "имя_каталога_N",
              ...
            }
          ]
          ...
          "access_control": {
            "procedures": [
              {
                "privileges": [
                  "<список_разрешений>"
                ],
                "procedure": {
                  "names": {
                    "any": [
                      "<список_имен_процедур>"
                    ]
                  },
                  "name_regexp": "<регулярное_выражение>"
                },
                "schema": {
                  "names": {
                    "any": [
                      "<список_имен_схем>"
                    ]
                  },
                  "name_regexp": "<регулярное_выражение>"
                },
                "catalog": {
                  "names": {
                    "any": [
                      "<имя_каталога_1>",
                      "<имя_каталога_2>",
                      ...
                      "<имя_каталога_N>"
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

      * `procedures` — список блоков правил для процедур. Все параметры правила являются опциональными: `privileges`, `procedure`, `schema`, `catalog`, `groups`, `users` и `description`.

      * `privileges` — разрешенные действия над процедурами:
        * `EXECUTE` — разрешен вызов процедуры.

        {% include notitle [procedures-privileges](../../_includes/managed-trino/access-control-src.md#procedures-privileges) %}

      * `procedure` — процедуры, на которые распространяется правило. Если блок `procedure` не указан, правило распространяется на все процедуры.
        * `names` — список имен процедур.
        * `name_regexp` — регулярное выражение. Правило распространяется на процедуры, имена которых соответствуют регулярному выражению.

        Блок `procedure` должен содержать либо вложенный блок `names`, либо параметр `name_regexp`.

      * `schema` — схемы, на которые распространяется правило. Если блок `schema` не указан, правило распространяется на все схемы.
        * `names` — список имен схем.
        * `name_regexp` — регулярное выражение. Правило распространяется на схемы, имена которых соответствуют регулярному выражению.

        Блок `schema` должен содержать либо вложенный блок `names`, либо параметр `name_regexp`.

      * `catalog` — каталоги, на которые распространяется правило. Если блок `catalog` не указан, правило распространяется на все каталоги кластера.
        * `names` — список имен каталогов. Каталоги должны создаваться в этом же вызове [ClusterService/Create](../api-ref/grpc/Cluster/create.md).
        * `name_regexp` — регулярное выражение. Правило распространяется на каталоги, имена которых соответствуют регулярному выражению.

        Блок `catalog` должен содержать либо вложенный блок `names`, либо параметр `name_regexp`.

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

Правила доступа к процедурам можно назначить или обновить в уже существующем кластере {{ mtr-name }}.

{% note warning %}
  
Указанные в правилах имена процедур и схем не проверяются на валидность. Ошибка в имени процедуры или схемы приведет к некорректной работе правила.
  
{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в нужный каталог.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-trino }}**.
  1. Нажмите на имя нужного кластера.
  1. Перейдите в блок **{{ ui-key.yacloud.trino.ClusterView.RBACView.label_rbac-settings_o2F64 }}** → **{{ ui-key.yacloud.trino.label_rbac-procedure }}**.
  1. Чтобы добавить правило, нажмите кнопку **{{ ui-key.yacloud.trino.label_rbac-add-rule }}** и в открывшемся окне задайте параметры правила:

     1. {% include [description-console](../../_includes/managed-trino/description-console.md) %}

     1. {% include [users-console](../../_includes/managed-trino/users-console.md) %}

     1. {% include [groups-console](../../_includes/managed-trino/groups-console.md) %}

     1. (Опционально) В поле **{{ ui-key.yacloud.trino.label_rbac-procedure-privileges }}** выберите `EXECUTE`, чтобы разрешить вызов процедуры. Если привилегии не выбраны, правило запрещает выполнение любых действий над процедурами.

     1. {% include [calatogs-description-ID-console](../../_includes/managed-trino/calatogs-description-ID-console.md) %}

     1. {% include [schemas-description-console](../../_includes/managed-trino/schemas-description-console.md) %}

     1. (Опционально) В поле **{{ ui-key.yacloud.trino.label_rbac-procedure-access }}** укажите, на какие процедуры распространяется правило:
        * **{{ ui-key.yacloud.trino.rbac-catalog-match-by-name }}** — выберите имена процедур.
        * **{{ ui-key.yacloud.trino.rbac-catalog-match-by-name-regexp }}** — введите регулярное выражение. Правило распространяется на процедуры, имена которых соответствуют регулярному выражению.
        * **{{ ui-key.yacloud.trino.rbac-catalog-match-by-empty }}** — правило распространяется на все процедуры.
  1. При необходимости добавьте другие правила аналогичным образом.
  1. Чтобы отредактировать правило:
     1. В строке этого правила нажмите на значок ![trash-bin](../../_assets/console-icons/pencil.svg).
     1. Измените параметры правила и нажмите кнопку **{{ ui-key.yacloud.common.update }}**.
  1. Чтобы удалить ненужное правило, в строке этого правила нажмите на значок ![trash-bin](../../_assets/console-icons/trash-bin.svg).
  1. Нажмите кнопку **{{ ui-key.yacloud.common.save-changes }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы задать правила доступа к процедурам:

  1. Если правила доступа еще не заданы, создайте файл `access_control.yaml` и добавьте в него следующее содержимое:

     ```yaml
     procedures:
       # Правило 1
       - privileges: [<список_разрешений>]
         procedure:
           names:
             any: [<список_имен_процедур>]
           name_regexp: <регулярное_выражение>
         schema:
           names:
             any: [<список_имен_схем>]
           name_regexp: <регулярное_выражение>
         catalog:
           ids:
             any: [<список_идентификаторов_каталогов>]
           names:
             any: [<список_имен_каталогов>]
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

     * `procedures` — список правил для процедур. Все параметры правила являются опциональными: `privileges`, `procedure`, `schema`, `catalog`, `groups`, `users` и `description`.

     * `privileges` — разрешенные действия над процедурами:
       * `EXECUTE` — разрешен вызов процедуры.

       {% include notitle [procedures-privileges](../../_includes/managed-trino/access-control-src.md#procedures-privileges) %}

     * `procedure` — процедуры, на которые распространяется правило. Если параметр `procedure` не указан, правило распространяется на все процедуры.
       * `names` — список имен процедур.
       * `name_regexp` — регулярное выражение. Правило распространяется на процедуры, имена которых соответствуют регулярному выражению.

       Вы можете указать только один из параметров: `names` или `name_regexp`.

     * `schema` — схемы, на которые распространяется правило. Если параметр `schema` не указан, правило распространяется на все схемы.
       * `names` — список имен схем.
       * `name_regexp` — регулярное выражение. Правило распространяется на схемы, имена которых соответствуют регулярному выражению.

       Вы можете указать только один из параметров: `names` или `name_regexp`.

     * `catalog` — каталоги, на которые распространяется правило. Если параметр `catalog` не указан, правило распространяется на все каталоги кластера.
       * `ids` — список идентификаторов каталогов. Указанные каталоги должны существовать.
       * `names` — список имен каталогов. Указанные каталоги должны существовать.
       * `name_regexp` — регулярное выражение. Правило распространяется на каталоги, имена которых соответствуют регулярному выражению.

       Укажите только один из параметров: `ids`, `names` или `name_regexp`.

     {% include [groups-users-description](../../_includes/managed-trino/groups-users-description.md) %}

  2. Если правила доступа уже заданы, откройте файл `access_control.yaml` и внесите в него изменения. Вы можете:

     * добавить новые правила;
     * изменить параметры существующих правил;
     * удалить ненужные правила.

  3. Выполните команду:

     ```bash
     {{ yc-mdb-tr }} cluster set-access-control <имя_или_идентификатор_кластера> \
       --from-file access_control.yaml
     ```

     Идентификатор и имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.
  
      О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).
  
  1. Если правила доступа еще не заданы, добавьте ресурс `yandex_trino_access_control`, содержащий список правил `procedures`.

     ```hcl
     resource "yandex_trino_cluster" "<имя_кластера>" {
       ...
     }

     resource "yandex_trino_catalog" "<имя_каталога_1>" {
       ...
     }

     resource "yandex_trino_catalog" "<имя_каталога_2>" {
       ...
     }

     ...

     resource "yandex_trino_catalog" "<имя_каталога_N>" {
       ...
     }

     resource "yandex_trino_access_control" "trino_access_control" {
       ...
       cluster_id  = yandex_trino_cluster.<имя_кластера>.id
       procedures = [
         # Правило 1
         {
           privileges    = ["<список_разрешений>"]
           procedure     = {
             names       = ["<список_имен_процедур>"]
             name_regexp = "<регулярное_выражение>"
           }
           schema        = {
             names       = ["<список_имен_схем>"]
             name_regexp = "<регулярное_выражение>"
           }
           catalog       = {
             ids         = [
               yandex_trino_catalog.<имя_каталога_1>.id,
               yandex_trino_catalog.<имя_каталога_2>.id,
               ... 
               yandex_trino_catalog.<имя_каталога_N>.id
             ]
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

     * `procedures` — список блоков правил для процедур. Все параметры правила являются опциональными: `privileges`, `procedure`, `schema`, `catalog`, `groups`, `users` и `description`.

     * `privileges` — разрешенные действия над процедурами:
       * `EXECUTE` — разрешен вызов процедуры.

       {% include notitle [procedures-privileges](../../_includes/managed-trino/access-control-src.md#procedures-privileges) %}

     * `procedure` — процедуры, на которые распространяется правило. Если блок `procedure` не указан, правило распространяется на все процедуры.
       * `names` — список имен процедур.
       * `name_regexp` — регулярное выражение. Правило распространяется на процедуры, имена которых соответствуют регулярному выражению.

       Вы можете указать только один из параметров: `names` или `name_regexp`.

     * `schema` — схемы, на которые распространяется правило. Если блок `schema` не указан, правило распространяется на все схемы.
       * `names` — список имен схем.
       * `name_regexp` — регулярное выражение. Правило распространяется на схемы, имена которых соответствуют регулярному выражению.

       Вы можете указать только один из параметров: `names` или `name_regexp`.

     * `catalog` — каталоги кластера, на которые распространяется правило. Если блок `catalog` не указан, правило распространяется на все каталоги кластера.
       * `ids` — список идентификаторов каталогов. Указанные каталоги должны существовать или создаваться в том же манифесте.
       * `name_regexp` — регулярное выражение. Правило распространяется на каталоги, имена которых соответствуют регулярному выражению.

       Вы можете указать только один из параметров: `ids` или `name_regexp`.

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
            "trino.access_control.procedures"
          ]
        },
        "trino": {
          "access_control": {
            "procedures": [
              {
                "privileges": [
                  "<список_разрешений>"
                ],
                "procedure": {
                  "names": {
                    "any": [
                      "<список_имен_процедур>"
                    ]
                  },
                  "name_regexp": "<регулярное_выражение>"
                },
                "schema": {
                  "names": {
                    "any": [
                      "<список_имен_схем>"
                    ]
                  },
                  "name_regexp": "<регулярное_выражение>"
                },
                "catalog": {
                  "ids": {
                    "any": [
                      "<список_идентификаторов_каталогов>"
                    ]
                  },
                  "names": {
                    "any": [
                      "<список_имен_каталогов>"
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

      * `procedures` — список блоков правил для процедур. Все параметры правила являются опциональными: `privileges`, `procedure`, `schema`, `catalog`, `groups`, `users` и `description`.

      * `privileges` — разрешенные действия над процедурами:
        * `EXECUTE` — разрешен вызов процедуры.

        {% include notitle [procedures-privileges](../../_includes/managed-trino/access-control-src.md#procedures-privileges) %}

      * `procedure` — процедуры, на которые распространяется правило. Если блок `procedure` не указан, правило распространяется на все процедуры.
        * `names` — список имен процедур.
        * `name_regexp` — регулярное выражение. Правило распространяется на процедуры, имена которых соответствуют регулярному выражению.

        Блок `procedure` должен содержать либо вложенный блок `names`, либо параметр `name_regexp`.

      * `schema` — схемы, на которые распространяется правило. Если блок `schema` не указан, правило распространяется на все схемы.
        * `names` — список имен схем.
        * `name_regexp` — регулярное выражение. Правило распространяется на схемы, имена которых соответствуют регулярному выражению.

        Блок `schema` должен содержать либо вложенный блок `names`, либо параметр `name_regexp`.

      * `catalog` — каталоги, на которые распространяется правило. Если блок `catalog` не указан, правило распространяется на все каталоги кластера.
        * `ids` — список идентификаторов каталогов. Указанные каталоги должны существовать.
        * `names` — список имен каталогов. Указанные каталоги должны существовать.
        * `name_regexp` — регулярное выражение. Правило распространяется на каталоги, имена которых соответствуют регулярному выражению.

        Блок `catalog` должен содержать либо один из вложенных блоков `ids` или `names`, либо параметр `name_regexp`.

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

## Пример назначения правил доступа к процедурам {#example}

Допустим, вам нужно настроить правила доступа к пользовательским процедурам в кластере {{ TR }}:
1. Запретить любые действия над процедурами пользователю с идентификатором `banned_user_id`.
1. Разрешить пользователям из группы с идентификатором `admins_group_id` вызывать процедуры.
1. Запретить любые действия над процедурами всем остальным пользователям.

{% list tabs group=instructions %}

- CLI {#cli}

  Файл `access_control.yaml` для такого набора правил выглядит так:

  ```yaml
  procedures:
    - users:
        - banned_user_id

    - groups:
        - admins_group_id
      privileges:
        - EXECUTE
  ```

- {{ TF }} {#tf}

  Конфигурационный файл для такого набора правил выглядит так:

  ```hcl
  resource "yandex_trino_access_control" "trino_access_control" {
    ...
    cluster_id  = <идентификатор_кластера>
    procedures = [
      {
        users         = ["banned_user_id"]
      },
      {
        groups        = ["admins_group_id"]
        privileges    = ["EXECUTE"]
      },
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
        "trino.access_control.procedures"
      ]
    },
    "trino": {
      "access_control": {
        "procedures": [
          {
            "users": [
              "banned_user_id"
            ]
          },
          {
            "groups": [
              "admins_group_id"
            ],
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
