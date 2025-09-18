---
title: Изменение кластера {{ ytsaurus-name }}
description: После создания кластера {{ ytsaurus-name }} вы можете изменить его основные и дополнительные настройки.
keywords:
  - изменение кластера {{ ytsaurus-name }}
  - кластер {{ ytsaurus-name }}
  - '{{ ytsaurus-name }}'
---

# Изменение кластера {{ ytsaurus-name }}

{% include [preview](../../_includes/managed-ytsaurus/note-preview.md) %}

После создания кластера вы можете изменить его основные и дополнительные настройки.

{% list tabs group=instructions %}

- Консоль управления {#console}

    Чтобы изменить настройки кластера:

    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-ytsaurus }}**.
    1. Выберите кластер и нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** на панели сверху.
    1. В блоке **{{ ui-key.yacloud.mdb.forms.section_base }}**:

        * Измените имя и описание кластера.
        * Удалите или добавьте новые [метки](../../resource-manager/concepts/labels.md).

    1. В блоке **{{ ui-key.yacloud.managed-ytsaurus.clusters.YTSaurusClusterCreatePage.filestore-section_title_tYMR7 }}** измените количество дисков.
    1. В блоке **{{ ui-key.yacloud.managed-ytsaurus.clusters.YTSaurusClusterCreatePage.exec-node-configuration-section_title_mfa54 }}** измените количество exec-нод.
    1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- {{ TF }} {#tf}

    Чтобы изменить настройки кластера:

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        Как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

    1. Задайте настройки для кластера, для этого измените значение нужного поля в конфигурационном файле. В каждой отдельной операции по изменению ресурсов кластера допускается менять только один параметр.

        {% note alert %}

        Не изменяйте имя кластера и идентификатор каталога с помощью {{ TF }}. Это приведет к удалению существующего кластера и созданию нового.

        {% endnote %}

        Пример структуры конфигурационного файла:

        ```hcl
        resource "yandex_ytsaurus_cluster" "my_cluster" {
          description         = "<описание_кластера>"
          name                = "my-ytsaurus-cluster"
          folder_id           = "b1gmioovukmd********"

          labels = {
            <список_меток>
          }
          ...
          spec = {
            ...
            storage = {
              hdd = {
                ...
                "count": "<количество_HDD-дисков>"
              },
              ssd = {
                ...
                "count": "<количество_SSD-дисков>",
              }
            }
            compute = [{
              ...
              scale_policy = {
                fixed = {
                  size = <количество_exec-нод>
                }
              }
            }]
            ...
            odin = {
              checks_ttl = "<частота_проверок_мониторинга_Odin>"
            }
          }
        }
        ```

        Где:

        * `description` — описание кластера.
        * `labels` — список меток. Метки задаются в формате `<ключ> = "<значение>"`.
        * `spec` — конфигурация компонентов кластера {{ ytsaurus-name }}.

            * `storage` — параметры хранилища:

               * `hdd.count` — количество HDD-дисков. Изменить количество можно лишь в сторону увеличения, уменьшить количество дисков нельзя.
               * `ssd.count` — количество SSD-дисков. Изменить количество можно лишь в сторону увеличения, уменьшить количество дисков нельзя.

            * `compute` — конфигурация exec-нод:

               * `scale_policy.fixed.size` — количество exec-нод для фиксированной политики масштабирования. На текущий момент в сервисе {{ ytsaurus-name }} поддерживается только эта политика.

            * `odin.checks_ttl` — частота проверок внутреннего мониторинга Odin. Указывается с единицами измерения: `h` — часы, `m` — минуты, `s` — секунды.

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-ytsaurus }}).

- REST API {#api}

    Чтобы изменить настройки кластера:

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. В каждой отдельной операции по изменению кластера допускается менять только один параметр. Создайте файл `body.json` и добавьте в него нужный параметр из показанных в следующем примере. Пример содержит только изменяемые параметры, все доступные параметры описаны в [документации API](../api-ref/Cluster/update.md#yandex.cloud.ytsaurus.v1.UpdateClusterRequest).

        ```json
        {
          "clusterId": "<идентификатор_кластера>",
          "updateMask": "<имя_изменяемого_параметра>",
          "name": "<имя_кластера>",
          "description": "<описание_кластера>",
          "labels": { <список_меток> },
          "spec": {
            "storage": {
              "hdd": {
                "count": "<количество_HDD-дисков>"
              },
              "ssd": {
                "count": "<количество_SSD-дисков>"
              }
            },
            "compute": [
              {
                "scalePolicy": {
                  "fixed": {
                    "size": "<количество_exec-нод>"
                  }
                }
              }
            ],
            "odin": {
              "checksTtl": "<частота_проверок_мониторинга_Odin>"
            }
          }
        }
        ```

        Где:

        * `clusterId` — идентификатор кластера. Его можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).
        * `updateMask` — имя изменяемого параметра.
        * `name` — имя кластера.
        * `description` — описание кластера.
        * `labels` — список меток. Метки задаются в формате `"<ключ>": "<значение>"`.
        * `spec` — конфигурация компонентов кластера {{ ytsaurus-name }}.

            * `storage` — параметры хранилища:

               * `hdd.count` — количество HDD-дисков. Изменить количество можно лишь в сторону увеличения, уменьшить количество дисков нельзя.
               * `ssd.count` — количество SSD-дисков. Изменить количество можно лишь в сторону увеличения, уменьшить количество дисков нельзя.

            * `compute` — конфигурация exec-нод.

               * `scalePolicy.fixed.size` — количество exec-нод для фиксированной политики масштабирования. На текущий момент в сервисе {{ ytsaurus-name }} поддерживается только эта политика.

            * `odin.checksTtl` — частота проверок внутреннего мониторинга Odin. Указывается с единицами измерения `s` (секунды).

    1. Воспользуйтесь методом [Cluster.Update](../api-ref/Cluster/update.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request PATCH \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://{{ api-host-ytsaurus }}/ytsaurus/v1/clusters'
            --data '@body.json'
        ```

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

    Чтобы изменить настройки кластера:

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. В каждой отдельной операции по изменению кластера допускается менять только один параметр. Создайте файл `body.json` и добавьте в него нужный параметр из показанных в следующем примере. Пример содержит только изменяемые параметры, все доступные параметры описаны в [документации API](../api-ref/Cluster/update.md#yandex.cloud.ytsaurus.v1.UpdateClusterRequest).

        ```json
        {
          "cluster_id": "<идентификатор_кластера>",
          "update_mask": "<имя_изменяемого_параметра>",
          "name": "<имя_кластера>",
          "description": "<описание_кластера>",
          "labels": { <список_меток> },
          "spec": {
            "storage": {
              "hdd": {
                "count": "<количество_HDD-дисков>"
              },
              "ssd": {
                "count": "<количество_SSD-дисков>"
              }
            },
            "compute": [
              {
                "scale_policy": {
                  "fixed": {
                    "size": "<количество_exec-нод>"
                  }
                }
              }
            ],
            "odin": {
              "checks_ttl": "<частота_проверок_мониторинга_Odin>"
            }
          }
        }
        ```

        Где:

        * `cluster_id` — идентификатор кластера. Его можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).
        * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

            В данном случае массив состоит только из одного элемента.

            {% cut "Формат перечисления настроек" %}

            ```yaml
            "update_mask": {
                "paths": [
                    "<имя_изменяемого_параметра>"
                ]
            }
            ```

            {% endcut %}

        * `name` — имя кластера.
        * `description` — описание кластера.
        * `labels` — список меток. Метки задаются в формате `"<ключ>": "<значение>"`.
        * `spec` — конфигурация компонентов кластера {{ ytsaurus-name }}.

            * `storage` — параметры хранилища:

               * `hdd.count` — количество HDD-дисков. Изменить количество можно лишь в сторону увеличения, уменьшить количество дисков нельзя.
               * `ssd.count` — количество SSD-дисков. Изменить количество можно лишь в сторону увеличения, уменьшить количество дисков нельзя.

            * `compute` — конфигурация exec-нод.

               * `scale_policy.fixed.size` — количество exec-нод для фиксированной политики масштабирования. На текущий момент в сервисе {{ ytsaurus-name }} поддерживается только эта политика.

            * `odin.checks_ttl` — частота проверок внутреннего мониторинга Odin. Указывается с единицами измерения `s` (секунды).

    1. Воспользуйтесь вызовом [ClusterService/Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/ytsaurus/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d @ \
            {{ api-host-ytsaurus }}:{{ port-https }} \
            yandex.cloud.ytsaurus.v1.ClusterService.Update \
            < body.json
        ```

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}
