---
title: Как изменить версию кластера в {{ mgp-full-name }}
description: Следуя данной инструкции, вы сможете изменить версию кластера {{ GP }}.
---

# Обновление версии в {{ mgp-full-name }}

Вы можете изменить версию базы данных, которую использует кластер в {{ mgp-name }}.

{% note info %}

Поддерживается обновление версии {{ GP }} с 6.28 до 6.29.

Не поддерживается:

* Обновление между patch-версиями {{ GP }} вручную, например с 6.29.1 до 6.29.2. Такие обновления выполняются автоматически в рамках технического обслуживания.
* Обновление версии {{ CB }}.
* Миграция между {{ GP }} и {{ CB }}.

{% endnote %}

Об обновлениях в рамках одной версии и обслуживании хостов в разделе [Техническое обслуживание](../concepts/maintenance.md).


## Узнать доступные версии {#versions-list}

{% list tabs group=instructions %}

- Консоль управления {#console}

  В [консоли управления]({{ link-console-main }}) откройте страницу [создания](cluster-create.md) или [изменения кластера](update.md) {{ mgp-name }}. Список доступен в поле **{{ ui-key.yacloud.mdb.forms.base_field_version }}**.

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [Versions.List](../api-ref/Versions/list.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

      ```bash
      curl \
          --request GET \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --url 'https://{{ api-host-mdb }}/managed-greenplum/v1/versions'
      ```

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Versions/list.md#responses).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

  1. Воспользуйтесь вызовом [VersionsService.List](../api-ref/grpc/Versions/list.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

      ```bash
      grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/greenplum/v1/versions_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.greenplum.v1.VersionsService.List
      ```

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Versions/list.md#yandex.cloud.mdb.greenplum.v1.ListVersionsResponse).

{% endlist %}


## Перед обновлением версии {#before-update}

Убедитесь, что это не нарушит работу ваших приложений:

1. Посмотрите, как обновления могут повлиять на работу ваших приложений:

    * [История изменений {{ GP }}](https://github.com/open-gpdb/gpdb/releases).
    * [История изменений {{ CB }}](https://cloudberry.apache.org/blog/announce-apache-cloudberry-2.1.0/).

1. Попробуйте обновить версию на тестовом кластере. Его можно [развернуть из резервной копии](cluster-backups.md#restore) основного кластера, если версия базы данных в резервной копии [поддерживается](#version-supported) в {{ mgp-name }}.
1. [Создайте резервную копию](cluster-backups.md#create-backup) основного кластера непосредственно перед обновлением версии.


## Обновить кластер {#start-update}

{% note alert %}

После обновления версии базы данных вернуть кластер к предыдущей версии невозможно.

{% endnote %}


{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в нужный каталог.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
  1. В строке с нужным кластером нажмите ![image](../../_assets/console-icons/ellipsis.svg), затем выберите **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}**.
  1. В поле **{{ ui-key.yacloud.mdb.forms.base_field_version }}** выберите номер новой версии.
  1. Нажмите **{{ ui-key.yacloud.common.save }}**.

- {{ TF }} {#tf}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

      Как создать такой файл, описано в разделе [{#T}](cluster-create.md).

  1. Добавьте в блок `config` нужного кластера {{ mgp-name }} поле `version` (версия базы данных) или измените его значение, если оно уже существует:

      ```hcl
      resource "yandex_mdb_greenplum_cluster" "<имя_кластера>" {
        ...
        version = "<версия>"
      }
      ```

  1. Проверьте корректность настроек.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  Подробнее в [документации провайдера {{ TF }}]({{ tf-provider-mgp }}).

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [Cluster.update](../api-ref/Cluster/update.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

      {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

      ```bash
      curl \
          --request PATCH \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --header "Content-Type: application/json" \
          -url 'https://{{ api-host-mdb }}/managed-greenplum/v1/clusters/<идентификатор_кластера>' \
          --data '{
                    "updateMask": "config.version",
                    "config": {
                      "version": "<версия>"
                    }
                  }'
      ```

      Где:

      * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

          В данном случае указан только один параметр: `config.version`.

      * `config.version` — версия базы данных, до которой нужно обновиться.

      Идентификатор кластера можно запросить со [списком кластеров в каталоге](./cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

  1. Воспользуйтесь вызовом [ClusterService/Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

      {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

      ```bash
      grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/greenplum/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "cluster_id": "<идентификатор_кластера>",
                "update_mask": {
                  "paths": [
                    "config.version"
                  ]
                },
                "config": {
                  "version": "<версия>"
                }
              }' \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.greenplum.v1.ClusterService.Update
      ```

      Где:

      * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

          В данном случае указан только один параметр: `config.version`.

      * `config.version` — версия базы данных, до которой нужно обновиться.

      Идентификатор кластера можно запросить со [списком кластеров в каталоге](./cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}
