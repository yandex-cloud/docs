---
title: Перепаковка данных в {{ mpg-full-name }}
description: Следуя данной инструкции, вы сможете выполнять перепаковку таблиц и индексов в {{ mpg-name }}.
---

# Перепаковка данных в {{ mpg-name }}

{% note info %}

Прежде чем выполнять операции, связанные с перепаковкой таблиц и индексов, убедитесь, что в кластере включена возможность перепаковки. При необходимости [включите](./update.md#change-additional-settings) эту опцию в настройках кластера.

{% endnote %}

Перепаковка таблиц и индексов устраняет _раздувание данных_ (bloat).


Получить информацию о состоянии таблиц и индексов можно в [консоли управления]({{ link-console-main }}) на вкладке **{{ ui-key.yacloud.mdb.cluster.switch_monitoring }}** страницы управления кластером или в сервисе [{{ monitoring-full-name }}](../../monitoring/index.yaml).

[Подробнее о мониторинге состояния кластера {{ PG }}](monitoring.md).

## Получить список рекомендуемых к перепаковке объектов {#recomendations-repack}

Получить список рекомендуемых к перепаковке объектов можно только с помощью консоли управления.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Перейдите]({{ link-console-main }}/link/managed-postgresql) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.postgresql.cluster.switch_data-repack }}**.
  1. На открывшейся странице перейдите на вкладку **{{ ui-key.yacloud.postgresql.DataRepack.DataRepackPageContent.title_recomendations_vRLWf }}**.
    
      На вкладке отображаются рекомендуемые к перепаковке объекты с наибольшим уровнем раздутия.

      Для каждой базы данных отображается не более 10 объектов, а для всего кластера — не более 1000 объектов. В список включены только объекты, у которых процент раздутия выше 5% или размер раздутия больше 1 ГБ. Вы также можете [выполнить перепаковку объектов, которых нет в списке рекомендуемых](#start-repack-not-recommended).

{% endlist %}

### Отсортировать список рекомендуемых к перепаковке объектов {#sort-recomendations-repack}

Чтобы отсортировать рекомендуемые к перепаковке объекты, на вкладке **{{ ui-key.yacloud.postgresql.DataRepack.DataRepackPageContent.title_recomendations_vRLWf }}** выберите:

* В поле **Тип объекта** — тип отображаемого объекта. Доступные варианты: **Таблица**, **Индекс** или **Все** объекты.
* В поле **Топ по** — метрику, по которой отбираются объекты. Доступные варианты: **Размер** раздутых данных (в байтах) или **Процент** раздутых данных от общего размера объекта.
* В поле **База данных** — базу данных, которой принадлежат объекты.

## Получить список активных перепаковок {#active-repack}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Перейдите]({{ link-console-main }}/link/managed-postgresql) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.postgresql.cluster.switch_data-repack }}**.
  1. На открывшейся странице перейдите на вкладку **{{ ui-key.yacloud.postgresql.DataRepack.DataRepackPageContent.title_active-repacks_hjUWj }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы получить список активных перепаковок, выполните команду:

  ```bash
  yc managed-postgresql repack list-running \
    --cluster-name=<имя_кластера>
  ```

  Где `--cluster-name` — имя кластера {{ mpg-full-name }}. Вместо имени кластера вы можете передать его идентификатор в параметре `--cluster-id`.

  Имя и идентификатор кластера вы можете получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [ManagedRepack.ListRunningRepacks](../api-ref/ManagedRepack/listRunningRepacks.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

      ```bash
      curl \
        --request GET \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/<идентификатор_кластера>:managedRepack_list_running'
      ```

      Идентификатор кластера вы можете получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).
  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/ManagedRepack/listRunningRepacks.md#yandex.cloud.mdb.postgresql.v1.ListRunningRepacksResponse).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Воспользуйтесь вызовом [ManagedRepackService.ListRunningRepacks](../api-ref/grpc/ManagedRepack/listRunningRepacks.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

      ```bash
      grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/managed_repack_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
              "cluster_id": "<идентификатор_кластера>"
            }' \
        {{ api-host-mdb }}:{{ port-https }} \
        yandex.cloud.mdb.postgresql.v1.ManagedRepackService.ListRunningRepacks
      ```
     
      Идентификатор кластера вы можете получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/ManagedRepack/listRunningRepacks.md#yandex.cloud.mdb.postgresql.v1.ListRunningRepacksResponse).

{% endlist %}

## Запустить перепаковку рекомендуемого объекта {#start-repack}

Вы можете запустить перепаковку одного или нескольких объектов. Если объектов несколько, они должны быть одного типа.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Перейдите]({{ link-console-main }}/link/managed-postgresql) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.postgresql.cluster.switch_data-repack }}**.
  1. На открывшейся странице перейдите на вкладку **{{ ui-key.yacloud.postgresql.DataRepack.DataRepackPageContent.title_recomendations_vRLWf }}**.
  1. Выберите один или несколько объектов для перепаковки и внизу экрана нажмите **{{ ui-key.yacloud.postgresql.DataRepack.TopBloatObjects.action_start-repack_7ccLM }}**.
  1. Подтвердите запуск перепаковки.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. [Получите](#recomendations-repack) список рекомендуемых к перепаковке объектов.
  1. {% include [repack-cli-step](../../_includes/mdb/mpg/repack-cli-step.md) %}

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. [Получите](#recomendations-repack) список рекомендуемых к перепаковке объектов.
  1. {% include [repack-rest-step](../../_includes/mdb/mpg/repack-rest-step.md) %}  
  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/ManagedRepack/launchRepack.md#yandex.cloud.mdb.postgresql.v1.LaunchRepackResponse).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. [Получите](#recomendations-repack) список рекомендуемых к перепаковке объектов.
  1. {% include [repack-grpc-step](../../_includes/mdb/mpg/repack-grpc-step.md) %}
  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/ManagedRepack/launchRepack.md#yandex.cloud.mdb.postgresql.v1.LaunchRepackResponse).

{% endlist %}

## Запустить перепаковку объекта, которого нет в списке рекомендуемых {#start-repack-not-recommended}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Перейдите]({{ link-console-main }}/link/managed-postgresql) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.postgresql.cluster.switch_data-repack }}**.
  1. В правом верхнем углу страницы нажмите кнопку **{{ ui-key.yacloud.postgresql.DataRepack.StartRepackFormDialog.action_start-repack_tnJdP }}**.
  1. Выберите тип объекта для перепаковки и укажите одно или несколько имен объектов.
  1. Нажмите кнопку **{{ ui-key.yacloud.postgresql.DataRepack.StartRepackFormDialog.action_start-repack_tnJdP }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  {% include [repack-cli-step](../../_includes/mdb/mpg/repack-cli-step.md) %}

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. [Получите](#recomendations-repack) список рекомендуемых к перепаковке объектов.
  1. {% include [repack-rest-step](../../_includes/mdb/mpg/repack-rest-step.md) %}  
  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/ManagedRepack/launchRepack.md#yandex.cloud.mdb.postgresql.v1.LaunchRepackResponse).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. [Получите](#recomendations-repack) список рекомендуемых к перепаковке объектов.
  1. {% include [repack-grpc-step](../../_includes/mdb/mpg/repack-grpc-step.md) %}  
  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/ManagedRepack/launchRepack.md#yandex.cloud.mdb.postgresql.v1.LaunchRepackResponse).

{% endlist %}

## Остановить перепаковку {#cancel-repack}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Перейдите]({{ link-console-main }}/link/managed-postgresql) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.postgresql.cluster.switch_data-repack }}**.
  1. На открывшейся странице перейдите на вкладку **{{ ui-key.yacloud.postgresql.DataRepack.DataRepackPageContent.title_active-repacks_hjUWj }}**.
  1. В строке нужной перепаковки нажмите на значок ![icon](../../_assets/console-icons/ellipsis.svg) и выберите пункт **{{ ui-key.yacloud.postgresql.DataRepack.StartRepackFormDialog.action_cancel_4wAmZ }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. [Получите](#active-repack) список активных перепаковок.
  1. Выполните команду:

      ```bash
      yc managed-postgresql repack terminate \
        --cluster-name <имя_кластера> \
        --launch-id <идентификатор_запуска>
      ```

      Где:
      * `--cluster-name` — имя кластера {{ mpg-full-name }}. Вместо имени кластера вы можете передать его идентификатор в параметре `--cluster-id`.
            
          Имя и идентификатор кластера вы можете получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).
      * `--launch-id` — [идентификатор](#active-repack) запуска перепаковки, которую вы хотите остановить.

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. [Получите](#active-repack) список активных перепаковок.
  1. Воспользуйтесь методом [ManagedRepack.TerminateRepack](../api-ref/ManagedRepack/terminateRepack.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

      ```bash
      curl \
        --request POST \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/<идентификатор_кластера>:managedRepack_terminate' \
        --data '{
                  "launchId": "<идентификатор_запуска>"
                }'
      ```

      Где:
      * `<идентификатор_кластера>` — идентификатор кластера, вы можете получить его со [списком кластеров в каталоге](cluster-list.md#list-clusters).
      * `launchId` — [идентификатор](#active-repack) запуска перепаковки, которую вы хотите остановить.
  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/ManagedRepack/terminateRepack.md#google.protobuf.Empty).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. [Получите](#active-repack) список активных перепаковок.
  1. Воспользуйтесь вызовом [ManagedRepackService.TerminateRepack](../api-ref/grpc/ManagedRepack/terminateRepack.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

      ```bash
      grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/managed_repack_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
              "cluster_id": "<идентификатор_кластера>",
              "launch_id": "<идентификатор_запуска>"
            }' \
        {{ api-host-mdb }}:{{ port-https }} \
        yandex.cloud.mdb.postgresql.v1.ManagedRepackService.TerminateRepack
      ```

      Где:
      * `cluster_id` — идентификатор кластера, вы можете получить его со [списком кластеров в каталоге](cluster-list.md#list-clusters).
      * `launch_id` — [идентификатор](#active-repack) запуска перепаковки, которую вы хотите остановить.
  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/ManagedRepack/terminateRepack.md#google.protobuf.Empty).

{% endlist %}

## Посмотреть логи активной перепаковки {#log-repack}

Посмотреть логи активной перепаковки можно только с помощью консоли управления.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Перейдите]({{ link-console-main }}/link/managed-postgresql) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.postgresql.cluster.switch_data-repack }}**.
  1. На открывшейся странице перейдите на вкладку **{{ ui-key.yacloud.postgresql.DataRepack.DataRepackPageContent.title_active-repacks_hjUWj }}**.
  1. В строке нужной перепаковки нажмите на значок ![icon](../../_assets/console-icons/ellipsis.svg) и выберите пункт **{{ ui-key.yacloud.postgresql.DataRepack.RunningRepacks.action_goto-logs_5Ng11 }}**.

      На открывшейся странице будут отображены логи `REPACK` за период времени с начала перепаковки до текущего времени. Чтобы посмотреть подробную информацию о событии, нажмите на интересующую запись в списке.

{% endlist %}

Чтобы посмотреть логи завершенных перепаковок, воспользуйтесь инструкцией [{#T}](cluster-logs.md).