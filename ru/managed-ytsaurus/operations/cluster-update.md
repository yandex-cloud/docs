---
title: Изменение кластера {{ ytsaurus-name }}
description: После создания кластера {{ ytsaurus-name }} вы можете изменить его основные и дополнительные настройки.
keywords:
  - изменение кластера {{ ytsaurus-name }}
  - кластер {{ ytsaurus-name }}
  - '{{ ytsaurus-name }}'
---

# Изменение кластера {{ ytsaurus-name }}

После создания кластера вы можете изменить его основные и дополнительные настройки.

{% list tabs group=instructions %}

- Консоль управления {#console}

    Чтобы изменить настройки кластера:

    1. В [консоли управления]({{ link-console-main }}) выберите каталог.
    1. [Перейдите]({{ link-console-main }}/link/managed-ytsaurus) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-ytsaurus }}**.
    1. Выберите кластер и нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** на панели сверху.
    1. В блоке **{{ ui-key.yacloud.mdb.forms.section_base }}**:

        * Измените имя и описание кластера.
        * Удалите или добавьте новые [метки](../../resource-manager/concepts/labels.md).

    1. В блоке **{{ ui-key.yacloud.managed-ytsaurus.clusters.YTSaurusClusterCreatePage.net-settings-section_title_wo42X }}** измените список разрешенных диапазонов IPv4-адресов в формате CIDR, например `203.0.113.0/24`, в поле **{{ ui-key.yacloud.managed-ytsaurus.clusters.NetworkSettingsForm.field_cidr-blocks-whitelist_label_hL9Hc }}**. Чтобы снять ограничения доступа из интернета, удалите все значения из поля.

        {% include [cidr-blocks-whitelist-description](../../_includes/managed-ytsaurus/cidr-blocks-whitelist-description.md) %}

    1. В блоке **{{ ui-key.yacloud.managed-ytsaurus.clusters.YTSaurusClusterCreatePage.filestore-section_title_tYMR7 }}** измените количество дисков.
    1. В блоке **{{ ui-key.yacloud.managed-ytsaurus.clusters.YTSaurusClusterCreatePage.exec-node-configuration-section_title_mfa54 }}** измените количество exec-нод.
    1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- {{ TF }} {#tf}

    Чтобы изменить настройки кластера:

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        Создание файла описано в разделе [Создание кластера](cluster-create.md).

    1. Чтобы изменить настройки кластера, задайте новое значение нужного поля в конфигурационном файле. В каждой отдельной операции по изменению ресурсов кластера допускается менять только один параметр.

        {% note alert %}

        Не изменяйте имя кластера и идентификатор каталога с помощью {{ TF }}. Это приведет к удалению существующего кластера и созданию нового.

        {% endnote %}

        Пример структуры конфигурационного файла:

        ```hcl
        resource "yandex_ytsaurus_cluster" "my_cluster" {
          description         = "<описание_кластера>"
          name                = "my-ytsaurus-cluster"
          folder_id           = "b1gmioovukmd********"

          cidr_blocks_whitelist = {
            v4_cidr_blocks = ["<разрешенный_диапазон>"]
          }

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
        * `cidr_blocks_whitelist.v4_cidr_blocks` — список разрешенных диапазонов IPv4-адресов в формате CIDR для доступа к кластеру из интернета, например `203.0.113.0/24`. Чтобы снять ограничения, передайте пустой список `[]`.

            {% include [cidr-blocks-whitelist-description](../../_includes/managed-ytsaurus/cidr-blocks-whitelist-description.md) %}

        * `spec` — конфигурация компонентов кластера {{ ytsaurus-name }}:

            * `storage` — параметры хранилища:

                * `hdd.count` — количество HDD-дисков. Количество дисков можно только увеличить.
                * `ssd.count` — количество SSD-дисков. Количество дисков можно только увеличить.

            * `compute` — конфигурация exec-нод:

                * `scale_policy.fixed.size` — количество exec-нод для фиксированной политики масштабирования. В {{ myt-name }} поддерживается только эта политика.

            * `odin.checks_ttl` — частота проверок внутреннего мониторинга Odin. Указывается с единицами измерения: `h` — часы, `m` — минуты, `s` — секунды.

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее в [документации провайдера {{ TF }}]({{ tf-provider-ytsaurus }}).

- REST API {#api}

    Чтобы изменить настройки кластера:

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. В каждой отдельной операции по изменению кластера допускается менять только один параметр. Создайте файл `body.json` и добавьте в него нужный параметр из показанных в следующем примере. Пример содержит только изменяемые параметры. Все доступные параметры описаны в [документации API](../api-ref/Cluster/update.md#yandex.cloud.ytsaurus.v1.UpdateClusterRequest).

        ```json
        {
          "clusterId": "<идентификатор_кластера>",
          "updateMask": "<имя_изменяемого_параметра>",
          "name": "<имя_кластера>",
          "description": "<описание_кластера>",
          "labels": { <список_меток> },
          "cidrBlocksWhitelist": {
            "v4CidrBlocks": ["<разрешенный_диапазон>"]
          },
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
        * `updateMask` — имя изменяемого параметра. Чтобы изменить список разрешенных диапазонов IP-адресов, укажите `cidrBlocksWhitelist`.
        * `name` — имя кластера.
        * `description` — описание кластера.
        * `labels` — список меток. Метки задаются в формате `"<ключ>": "<значение>"`.
        * `cidrBlocksWhitelist.v4CidrBlocks` — список разрешенных диапазонов IPv4-адресов в формате CIDR для доступа к кластеру из интернета, например `203.0.113.0/24`. Чтобы снять ограничения, передайте пустой список `[]`.

            {% include [cidr-blocks-whitelist-description](../../_includes/managed-ytsaurus/cidr-blocks-whitelist-description.md) %}

        * `spec` — конфигурация компонентов кластера {{ ytsaurus-name }}:

            * `storage` — параметры хранилища:

                * `hdd.count` — количество HDD-дисков. Количество дисков можно только увеличить.
                * `ssd.count` — количество SSD-дисков. Количество дисков можно только увеличить.

            * `compute` — конфигурация exec-нод:

                * `scalePolicy.fixed.size` — количество exec-нод для фиксированной политики масштабирования. В {{ myt-name }} поддерживается только эта политика.

            * `odin.checksTtl` — частота проверок внутреннего мониторинга Odin. Указывается в секундах (`s`).

    1. Воспользуйтесь методом [update](../api-ref/Cluster/update.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request PATCH \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://{{ api-host-ytsaurus }}/ytsaurus/v1/clusters' \
            --data '@body.json'
        ```

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

    Чтобы изменить настройки кластера:

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. В каждой отдельной операции по изменению кластера допускается менять только один параметр. Создайте файл `body.json` и добавьте в него нужный параметр из показанных в следующем примере. Пример содержит только изменяемые параметры. Все доступные параметры описаны в [документации API](../api-ref/grpc/Cluster/update.md#yandex.cloud.ytsaurus.v1.UpdateClusterRequest).

        ```json
        {
          "cluster_id": "<идентификатор_кластера>",
          "update_mask": "<имя_изменяемого_параметра>",
          "name": "<имя_кластера>",
          "description": "<описание_кластера>",
          "labels": { <список_меток> },
          "cidr_blocks_whitelist": {
            "v4_cidr_blocks": ["<разрешенный_диапазон>"]
          },
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
        * `update_mask` — имя изменяемого параметра. В JSON-формате указывается строкой в нотации `lowerCamelCase`. Чтобы изменить список разрешенных диапазонов IP-адресов, укажите `cidrBlocksWhitelist`.
        * `name` — имя кластера.
        * `description` — описание кластера.
        * `labels` — список меток. Метки задаются в формате `"<ключ>": "<значение>"`.
        * `cidr_blocks_whitelist.v4_cidr_blocks` — список разрешенных диапазонов IPv4-адресов в формате CIDR для доступа к кластеру из интернета, например `203.0.113.0/24`. Чтобы снять ограничения, передайте пустой список `[]`.

            {% include [cidr-blocks-whitelist-description](../../_includes/managed-ytsaurus/cidr-blocks-whitelist-description.md) %}

        * `spec` — конфигурация компонентов кластера {{ ytsaurus-name }}:

            * `storage` — параметры хранилища:

                * `hdd.count` — количество HDD-дисков. Количество дисков можно только увеличить.
                * `ssd.count` — количество SSD-дисков. Количество дисков можно только увеличить.

            * `compute` — конфигурация exec-нод:

                * `scale_policy.fixed.size` — количество exec-нод для фиксированной политики масштабирования. В {{ myt-name }} поддерживается только эта политика.

            * `odin.checks_ttl` — частота проверок внутреннего мониторинга Odin. Указывается в секундах (`s`).

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
