---
title: Создание кластера {{ ytsaurus-name }}
description: Каждый кластер {{ mtr-name }} состоит из набора компонентов {{ ytsaurus-name }}, каждый из которых может быть представлен в нескольких экземплярах. Экземпляры могут находиться в разных зонах доступности.
keywords:
  - создание кластера {{ ytsaurus-name }}
  - кластер {{ ytsaurus-name }}
  - '{{ ytsaurus-name }}'
---

# Создание кластера {{ ytsaurus-name }}

{% include [preview](../../_includes/managed-ytsaurus/note-preview.md) %}

Каждый [кластер](../../glossary/cluster.md) {{ myt-name }} состоит из набора компонентов {{ ytsaurus-name }}.

Компоненты, доступные для настройки:
* exec- и tablet-ноды;
* хранилища;
* HTTP- и RPC-прокси.

Служебные компоненты, недоступные для настройки:
* master-ноды;
* storage-ноды;
* system-ноды.

## Роли для создания кластера {#roles}

Для создания кластера {{ myt-name }} вашему аккаунту в {{ yandex-cloud }} нужны роли:

* [managed-ytsaurus.editor](../security/index.md#managed-ytsaurus-editor) — чтобы создать кластер;
* [{{ roles-vpc-user }}](../../vpc/security/index.md#vpc-user) — чтобы работать с [сетью](../../vpc/concepts/network.md#network) кластера.

О назначении ролей читайте в [документации {{ iam-full-name }}](../../iam/operations/roles/grant.md).

## Создать кластер {#create-cluster}

{% note info %}

Создание кластера {{ ytsaurus-name }} занимает длительное время. В зависимости от выбранной конфигурации время создания может занимать от одного часа.

{% endnote %}

В {{ myt-name }} можно создать [{{ ui-key.yacloud.managed-ytsaurus.clusters.YTSaurusClusterCreatePage.cluster-kind-card_demo_title_4B7zu }}](#demo-cluster) с минимальной рабочей конфигурацией для ознакомления с сервисом или [{{ ui-key.yacloud.managed-ytsaurus.clusters.YTSaurusClusterCreatePage.cluster-kind-card_production_title_dVEmq }}](#production-cluster) с ручной настройкой конфигурации кластера. 

### Demo-кластер {#demo-cluster}

{% list tabs group=instructions %}

- Консоль управления {#console}

    {% include notitle [demo-cluster-create](../../_includes/managed-ytsaurus/demo-cluster-create.md) %}

- {{ TF }} {#tf}

    {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

    {% include [terraform-install](../../_includes/terraform-install.md) %}

    Чтобы создать кластер {{ myt-name }}:

    1. Опишите в конфигурационном файле создаваемые ресурсы:

        * Кластер {{ myt-name }} — описание кластера.

        * {% include [Terraform network description](../../_includes/mdb/terraform/network.md) %}

        * {% include [Terraform subnet description](../../_includes/mdb/terraform/subnet.md) %}

        Пример структуры конфигурационного файла:

        ```hcl
        resource "yandex_ytsaurus_cluster" "<имя_кластера>" {

          description        = "<описание_кластера>"
          name               = "<имя_кластера>"
          zone_id            = yandex_vpc_subnet.<имя_подсети>.zone
          subnet_id          = yandex_vpc_subnet.<имя_подсети>.id
          security_group_ids = [<список_идентификаторов_групп_безопасности>]

          spec = {
            storage = {
              hdd = {
                size_gb = 2048
                count   = 3
              }
              ssd = {
                size_gb = 465
                type    = "network-ssd-nonreplicated"
                count   = 3
              }
            }
            compute = [
              {
                preset = "c8-m32"
                disks = [
                  {
                    size_gb   = 93
                    type      = "network-ssd-nonreplicated"
                  }
                ]
                scale_policy = {
                  fixed = {
                    size = 3
                  }
                }
              }
            ]
            tablet = {
              preset = "c8-m16"
              count  = 3
            }
            proxy = {
              http = {
                count = 2
              }
              rpc = {
                count = 2
              }
            }
          }
        }

        resource "yandex_vpc_network" "<имя_сети>" { name = "<имя_сети>" }

        resource "yandex_vpc_subnet" "<имя_подсети>" {
          name           = "<имя_подсети>"
          zone           = "<зона_доступности>"
          network_id     = yandex_vpc_network.<имя_сети>.id
          v4_cidr_blocks = ["<диапазон>"]
        }
        ```

        Где:

        * `description` — описание кластера.
        * `name` — имя кластера.
        * `zone_id` — [зона доступности](../../overview/concepts/geo-scope.md).
        * `subnet_id` — [идентификатор подсети](../../vpc/concepts/network.md#subnet).
        * `security_group_ids` — список идентификаторов [групп безопасности](../../vpc/concepts/security-groups).

            {% note warning %}

            Сетевые настройки нельзя изменить после создания кластера.

            {% endnote %}

        * `spec` — конфигурация компонентов кластера {{ ytsaurus-name }}:

            * `storage` — параметры хранилища:

                * `hdd` — параметры HDD-дисков:

                    * `size_gb` — размер диска в ГБ.
                    * `count` — количество дисков.

                * `ssd` — параметры SSD-дисков:

                    * `size_gb` — размер диска в ГБ.
                    * `type` — тип диска.
                    * `count` — количество дисков.

                {% note warning %}

                Тип и размер диска для кластера {{ ytsaurus-name }} нельзя изменить после создания.

                {% endnote %}

            * `compute` — конфигурация exec-нод:

                * `preset` — [конфигурация вычислительных ресурсов](../concepts/component-types.md#exec-node).
                * `disks` — параметры хранилища, которое будет использоваться для выполнения заданий.

                    * `size_gb` — размер диска в ГБ.
                    * `type` — тип диска.

                * `scale_policy.fixed.size` — количество exec-нод для фиксированной политики масштабирования.

            * `tablet` — конфигурация tablet-нод:

                * `preset` — [конфигурация вычислительных ресурсов](../concepts/component-types.md#tablet-node).
                * `count` — количество tablet-нод.

                Для использования tablet-нод должны быть указаны параметры SSD-хранилища (`spec.storage.ssd`).

                {% note warning %}

                Количество tablet-нод нельзя изменить после создания кластера.

                {% endnote %}

            * `proxy` — параметры прокси:

                * `http.count` — количество HTTP-прокси.
                * `rpc.count` — количество RPC-прокси.

        Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, см. в [документации провайдера]({{ tf-provider-ytsaurus }}).

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Создайте кластер {{ myt-name }}.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}).

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Создайте файл `body.json` и добавьте в него следующее содержимое:

        ```json
        {
          "folderId": "<идентификатор_каталога>",
          "name": "<имя_кластера>",
          "description": "<описание_кластера>",
          "zoneId": "<зона_доступности>",
          "subnetId": "<идентификатор_подсети>",
          "securityGroupIds": [ <список_идентификаторов_групп_безопасности> ],
          "spec": {
            "storage": {
              "hdd": {
                "sizeGb": "2048",
                "count": "3"
              },
              "ssd": {
                "sizeGb": "465",
                "type": "network-ssd-nonreplicated",
                "count": "3"
              }
            },
            "compute": [
              {
                "preset": "c8-m32",
                "disks": [
                  {
                    "type": "network-ssd-nonreplicated",
                    "sizeGb": "93"
                  }
                ],
                "scalePolicy": {
                  "fixed": {
                    "size": "3"
                  }
                }
              }
            ],
            "tablet": {
              "preset": "c8-m16",
              "count": "3"
            },
            "proxy": {
              "http": {
                "count": "2"
              },
              "rpc": {
                "count": "2"
              }
            }
          }
        }
        ```

        Где:

        * `folderId` — идентификатор каталога. Его можно запросить со [списком каталогов в облаке](../../resource-manager/operations/folder/get-id.md).
        * `name` — имя кластера.
        * `description` — описание кластера.
        * `zoneId` — [зона доступности](../../overview/concepts/geo-scope.md).
        * `subnetId` — [идентификатор подсети](../../vpc/concepts/network.md#subnet).
        * `securityGroupIds` — список идентификаторов [групп безопасности](../../vpc/concepts/security-groups).

            {% note warning %}

            Сетевые настройки нельзя изменить после создания кластера.

            {% endnote %}

        * `spec` — конфигурация компонентов кластера {{ ytsaurus-name }}:

            * `storage` — параметры хранилища:

                * `hdd` — параметры HDD-дисков:

                    * `sizeGb` — размер диска в ГБ.
                    * `count` — количество дисков.

                * `ssd` — параметры SSD-дисков:

                    * `sizeGb` — размер диска в ГБ.
                    * `type` — тип диска.
                    * `count` — количество дисков.

                {% note warning %}

                Тип и размер диска для кластера {{ ytsaurus-name }} нельзя изменить после создания.

                {% endnote %}

            * `compute` — конфигурация exec-нод:

                * `preset` — [конфигурация вычислительных ресурсов](../concepts/component-types.md#exec-node).
                * `disks` — параметры хранилища, которое будет использоваться для выполнения заданий.

                    * `type` — тип диска.
                    * `sizeGb` — размер диска в ГБ.

                * `scalePolicy.fixed.size` — количество exec-нод для фиксированной политики масштабирования.

            * `tablet` — конфигурация tablet-нод:

                * `preset` — [конфигурация вычислительных ресурсов](../concepts/component-types.md#tablet-node).
                * `count` — количество tablet-нод.

                Для использования tablet-нод должны быть указаны параметры SSD-хранилища (`spec.storage.ssd`).

                {% note warning %}

                Количество tablet-нод нельзя изменить после создания кластера.

                {% endnote %}

            * `proxy` — параметры прокси:

                * `http.count` — количество HTTP-прокси.
                * `rpc.count` — количество RPC-прокси.

    1. Воспользуйтесь методом [Cluster.Create](../api-ref/Cluster/create.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request POST \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://{{ api-host-ytsaurus }}/ytsaurus/v1/clusters'
            --data '@body.json'
        ```

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/create.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Создайте файл `body.json` и добавьте в него следующее содержимое:

        ```json
        {
          "folder_id": "<идентификатор_каталога>",
          "name": "<имя_кластера>",
          "description": "<описание_кластера>",
          "zone_id": "<зона_доступности>",
          "subnet_id": "<идентификатор_подсети>",
          "security_group_ids": [ <список_идентификаторов_групп_безопасности> ],
          "spec": {
            "storage": {
              "hdd": {
                "size_gb": "2048",
                "count": "3"
              },
              "ssd": {
                "size_gb": "465",
                "type": "network-ssd-nonreplicated",
                "count": "3"
              }
            },
            "compute": [
              {
                "preset": "c8-m32",
                "disks": [
                  {
                    "type": "network-ssd-nonreplicated",
                    "size_gb": "93"
                  }
                ],
                "scale_policy": {
                  "fixed": {
                    "size": "3"
                  }
                }
              }
            ],
            "tablet": {
              "preset": "c8-m16",
              "count": "3"
            },
            "proxy": {
              "http": {
                "count": "2"
              },
              "rpc": {
                "count": "2"
              }
            }
          }
        }
        ```

        Где:

        * `folder_id` — идентификатор каталога. Его можно запросить со [списком каталогов в облаке](../../resource-manager/operations/folder/get-id.md).
        * `name` — имя кластера.
        * `description` — описание кластера.
        * `zone_id` — [зона доступности](../../overview/concepts/geo-scope.md).
        * `subnet_id` — [идентификатор подсети](../../vpc/concepts/network.md#subnet).
        * `security_group_ids` — список идентификаторов [групп безопасности](../../vpc/concepts/security-groups).

            {% note warning %}

            Сетевые настройки нельзя изменить после создания кластера.

            {% endnote %}

        * `spec` — конфигурация компонентов кластера {{ ytsaurus-name }}:

            * `storage` — параметры хранилища:

                * `hdd` — параметры HDD-дисков:

                    * `size_gb` — размер диска в ГБ.
                    * `count` — количество дисков.

                * `ssd` — параметры SSD-дисков:

                    * `size_gb` — размер диска в ГБ.
                    * `type` — тип диска.
                    * `count` — количество дисков.

                {% note warning %}

                Тип и размер диска для кластера {{ ytsaurus-name }} нельзя изменить после создания.

                {% endnote %}

            * `compute` — конфигурация exec-нод:

                * `preset` — [конфигурация вычислительных ресурсов](../concepts/component-types.md#exec-node).
                * `disks` — параметры хранилища, которое будет использоваться для выполнения заданий.

                    * `type` — тип диска.
                    * `size_gb` — размер диска в ГБ.

                * `scale_policy.fixed.size` — количество exec-нод для фиксированной политики масштабирования.

            * `tablet` — конфигурация tablet-нод:

                * `preset` — [конфигурация вычислительных ресурсов](../concepts/component-types.md#tablet-node).
                * `count` — количество tablet-нод.

                Для использования tablet-нод должны быть указаны параметры SSD-хранилища (`spec.storage.ssd`).

                {% note warning %}

                Количество tablet-нод нельзя изменить после создания кластера.

                {% endnote %}

            * `proxy` — параметры прокси:

                * `http.count` — количество HTTP-прокси.
                * `rpc.count` — количество RPC-прокси.

    1. Воспользуйтесь вызовом [ClusterService.Create](../api-ref/grpc/Cluster/create.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/ytsaurus/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d @ \
            {{ api-host-ytsaurus }}:{{ port-https }} \
            yandex.cloud.ytsaurus.v1.ClusterService.Create \
            < body.json
        ```

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation).

{% endlist %}

### Production-кластер {#production-cluster}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно создать кластер {{ myt-name }}.
    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-ytsaurus }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
    1. Выберите **{{ ui-key.yacloud.managed-ytsaurus.clusters.YTSaurusClusterCreatePage.cluster-kind-card_production_title_dVEmq }}** для создания кластера с ручной настройкой конфигурации.
    1. В блоке **{{ ui-key.yacloud.managed-ytsaurus.clusters.YTSaurusClusterCreatePage.base-params-section_title_nfKo2 }}**:
        1. Задайте имя кластера. Имя должно быть уникальным в рамках каталога.
        1. (Опционально) Введите описание кластера.
        1. (Опционально) Создайте [метки](../../resource-manager/concepts/labels.md):
            1. Нажмите кнопку **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
            1. Введите метку в формате `ключ: значение`.
            1. Нажмите **Enter**.

    1. В блоке **{{ ui-key.yacloud.managed-ytsaurus.clusters.YTSaurusClusterCreatePage.net-settings-section_title_wo42X }}** выберите:
       * [Зону доступности](../../overview/concepts/geo-scope.md) для размещения кластера.
       * [Подсеть](../../vpc/operations/subnet-create.md).
       * (Опционально) [Группу безопасности](../../vpc/concepts/security-groups.md) для сетевого трафика кластера.

       {% note warning %}
       
       Сетевые настройки нельзя изменить после создания кластера.
       
       {% endnote %}

    1. В блоке **{{ ui-key.yacloud.managed-ytsaurus.clusters.YTSaurusClusterCreatePage.filestore-section_title_tYMR7 }}** нажмите кнопку **{{ ui-key.yacloud.common.add }}** и выберите тип, размер, количество дисков.

       От выбранного типа зависит, с каким шагом можно будет изменить размер диска:
          * Сетевые HDD- и SSD-диски — с шагом 1 ГБ.
          * Нереплицируемые SSD-диски — с шагом 93 ГБ.

       Хранилище с типом `HDD` является обязательным и добавлено по умолчанию. При необходимости отредактируйте количество и размер дисков.

       {% note warning %}
       
       Тип и размер диска для кластера {{ ytsaurus-name }} нельзя изменить после создания.
       
       {% endnote %}
    
    1. В блоке **{{ ui-key.yacloud.managed-ytsaurus.clusters.YTSaurusClusterCreatePage.exec-node-configuration-section_title_mfa54 }}** задайте:
       * количество нод;
       * [конфигурацию вычислительных ресурсов](../concepts/component-types.md#exec-node);
       * тип и размер хранилища, которое будет использоваться для выполнения заданий.

    1. В блоке **{{ ui-key.yacloud.managed-ytsaurus.clusters.YTSaurusClusterCreatePage.tablet-node-configuration-section_title_fHZeX }}** задайте:
       * количество нод;
       * [конфигурацию вычислительных ресурсов](../concepts/component-types.md#tablet-node).

       Для использования tablet-нод необходимо добавить хранилище с типом `SSD` или `Нереплицируемый SSD`.

       {% note warning %}
       
       Количество tablet-нод нельзя изменить после создания кластера.
       
       {% endnote %}
    
    1. В блоках **{{ ui-key.yacloud.managed-ytsaurus.clusters.YTSaurusClusterCreatePage.http-config-section_title_kMdci }}** и **{{ ui-key.yacloud.managed-ytsaurus.clusters.YTSaurusClusterCreatePage.rpc-config-section_title_tGACF }}** задайте количество прокси.

       {% note warning %}
       
       Количество proxy-нод нельзя изменить после создания кластера.
       
       {% endnote %}

    1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.
    1. Дождитесь, когда кластер будет готов к работе: его статус на панели {{ myt-name }} сменится на **Running**. Это может занять продолжительное время.

- {{ TF }} {#tf}

    {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

    {% include [terraform-install](../../_includes/terraform-install.md) %}

    Чтобы создать кластер {{ myt-name }}:

    1. Опишите в конфигурационном файле создаваемые ресурсы:

        * Кластер {{ myt-name }} — описание кластера.

        * {% include [Terraform network description](../../_includes/mdb/terraform/network.md) %}

        * {% include [Terraform subnet description](../../_includes/mdb/terraform/subnet.md) %}

        Пример структуры конфигурационного файла:

        ```hcl
        resource "yandex_ytsaurus_cluster" "<имя_кластера>" {

          description        = "<описание_кластера>"
          name               = "<имя_кластера>"
          zone_id            = yandex_vpc_subnet.<имя_подсети>.zone
          subnet_id          = yandex_vpc_subnet.<имя_подсети>.id
          security_group_ids = [<список_идентификаторов_групп_безопасности>]

          labels = {
            <список_меток>
          }

          spec = {
            storage = {
              hdd = {
                size_gb = <размер_диска_в_ГБ>
                count   = <количество_дисков>
              }
              ssd = {
                size_gb = <размер_диска_в_ГБ>
                type    = "<тип_диска>"
                count   = <количество_дисков>
              }
            }
            compute = [
              {
                preset = "<конфигурация_вычислительных_ресурсов>"
                disks = [
                  {
                    size_gb   = <размер_диска_в_ГБ>
                    type      = "<тип_диска>"
                  }
                ]
                scale_policy = {
                  fixed = {
                    size = <количество_exec-нод>
                  }
                }
                name = "default"
              }
            ]
            tablet = {
              preset = "<конфигурация_вычислительных_ресурсов>"
              count  = <количество_tablet-нод>
            }
            proxy = {
              http = {
                count = <количество_HTTP-прокси>
              }
              rpc = {
                count = <количество_RPC-прокси>
              }
            },
            odin = {
              checks_ttl = "<частота_проверок>"
            }
          }
        }

        resource "yandex_vpc_network" "<имя_сети>" { name = "<имя_сети>" }

        resource "yandex_vpc_subnet" "<имя_подсети>" {
          name           = "<имя_подсети>"
          zone           = "<зона_доступности>"
          network_id     = yandex_vpc_network.<имя_сети>.id
          v4_cidr_blocks = ["<диапазон>"]
        }
        ```

        Где:

        * `description` — описание кластера.
        * `name` — имя кластера.
        * `zone_id` — [зона доступности](../../overview/concepts/geo-scope.md).
        * `subnet_id` — [идентификатор подсети](../../vpc/concepts/network.md#subnet).
        * `security_group_ids` — список идентификаторов [групп безопасности](../../vpc/concepts/security-groups).

            {% note warning %}

            Сетевые настройки нельзя изменить после создания кластера.

            {% endnote %}

        * `labels` — список меток. Метки задаются в формате `<ключ> = "<значение>"`.
        * `spec` — конфигурация компонентов кластера {{ ytsaurus-name }}:

            * `storage` — параметры хранилища:

                * `hdd` — параметры HDD-дисков:

                    * `size_gb` — размер диска в ГБ.
                    * `count` — количество дисков.

                * `ssd` — параметры SSD-дисков:

                    * `size_gb` — размер диска в ГБ.
                    * `type` — тип диска: `network-ssd` или `network-ssd-nonreplicated`.
                    * `count` — количество дисков.

                От выбранного типа зависит, с каким шагом можно задавать размер диска при создании кластера:

                * Сетевые HDD- и SSD-диски — с шагом 1 ГБ.
                * Нереплицируемые SSD-диски — с шагом 93 ГБ.

                Наличие HDD-диска является обязательным.

                {% note warning %}

                Тип и размер диска для кластера {{ ytsaurus-name }} нельзя изменить после создания.

                {% endnote %}

            * `compute` — конфигурация exec-нод:

                * `preset` — [конфигурация вычислительных ресурсов](../concepts/component-types.md#exec-node).
                * `disks` — параметры хранилища, которое будет использоваться для выполнения заданий.

                    * `size_gb` — размер диска в ГБ.
                    * `type` — тип диска: `network-hdd`, `network-ssd` или `network-ssd-nonreplicated`.

                    От выбранного типа зависит, с каким шагом можно задавать размер диска при создании кластера:

                    * Сетевые HDD- и SSD-диски — с шагом 1 ГБ.
                    * Нереплицируемые SSD-диски — с шагом 93 ГБ.

                * `scale_policy.fixed.size` — количество exec-нод для фиксированной политики масштабирования.
                * `name` — имя exec-пула.

            * `tablet` — конфигурация tablet-нод:

                * `preset` — [конфигурация вычислительных ресурсов](../concepts/component-types.md#tablet-node).
                * `count` — количество tablet-нод.

                Для использования tablet-нод должны быть указаны параметры SSD-хранилища (`spec.storage.ssd`).

                {% note warning %}

                Количество tablet-нод нельзя изменить после создания кластера.

                {% endnote %}

            * `proxy` — параметры прокси:

                * `http.count` — количество HTTP-прокси.
                * `rpc.count` — количество RPC-прокси.

            * `odin.checks_ttl` — частота проверок внутреннего мониторинга Odin. Указывается с единицами измерения: `h` — часы, `m` — минуты, `s` — секунды. Например: `336h0m0s` (2 недели).

        Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, см. в [документации провайдера]({{ tf-provider-ytsaurus }}).

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Создайте кластер {{ myt-name }}.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}).

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Создайте файл `body.json` и добавьте в него следующее содержимое:

        ```json
        {
          "folderId": "<идентификатор_каталога>",
          "name": "<имя_кластера>",
          "description": "<описание_кластера>",
          "labels": { <список_меток> },
          "zoneId": "<зона_доступности>",
          "subnetId": "<идентификатор_подсети>",
          "securityGroupIds": [ <список_идентификаторов_групп_безопасности> ],
          "spec": {
            "storage": {
              "hdd": {
                "sizeGb": "<размер_диска_в_ГБ>",
                "count": "<количество_дисков>"
              },
              "ssd": {
                "sizeGb": "<размер_диска_в_ГБ>",
                "type": "<тип_диска>",
                "count": "<количество_дисков>"
              }
            },
            "compute": [
              {
                "preset": "<конфигурация_вычислительных_ресурсов>",
                "disks": [
                  {
                    "type": "<тип_диска>",
                    "sizeGb": "<размер_диска_в_ГБ>"
                  }
                ],
                "scalePolicy": {
                  "fixed": {
                    "size": "<количество_exec-нод>"
                  }
                },
                "name": "default"
              }
            ],
            "tablet": {
              "preset": "<конфигурация_вычислительных_ресурсов>",
              "count": "<количество_tablet-нод>"
            },
            "proxy": {
              "http": {
                "count": "<количество_HTTP-прокси>"
              },
              "rpc": {
                "count": "<количество_RPC-прокси>"
              }
            },
            "odin": {
              "checksTtl": "<частота_проверок_в_секундах>"
            }
          }
        }
        ```

        Где:

        * `folderId` — идентификатор каталога. Его можно запросить со [списком каталогов в облаке](../../resource-manager/operations/folder/get-id.md).
        * `name` — имя кластера.
        * `description` — описание кластера.
        * `labels` — список меток. Метки задаются в формате `"<ключ>": "<значение>"`.
        * `zoneId` — [зона доступности](../../overview/concepts/geo-scope.md).
        * `subnetId` — [идентификатор подсети](../../vpc/concepts/network.md#subnet).
        * `securityGroupIds` — список идентификаторов [групп безопасности](../../vpc/concepts/security-groups).

            {% note warning %}

            Сетевые настройки нельзя изменить после создания кластера.

            {% endnote %}

        * `spec` — конфигурация компонентов кластера {{ ytsaurus-name }}:

            * `storage` — параметры хранилища:

                * `hdd` — параметры HDD-дисков:

                    * `sizeGb` — размер диска в ГБ.
                    * `count` — количество дисков.

                * `ssd` — параметры SSD-дисков:

                    * `sizeGb` — размер диска в ГБ.
                    * `type` — тип диска: `network-ssd` или `network-ssd-nonreplicated`.
                    * `count` — количество дисков.

                От выбранного типа зависит, с каким шагом можно задавать размер диска при создании кластера:

                * Сетевые HDD- и SSD-диски — с шагом 1 ГБ.
                * Нереплицируемые SSD-диски — с шагом 93 ГБ.

                Наличие HDD-диска является обязательным.

                {% note warning %}

                Тип и размер диска для кластера {{ ytsaurus-name }} нельзя изменить после создания.

                {% endnote %}

            * `compute` — конфигурация exec-нод:

                * `preset` — [конфигурация вычислительных ресурсов](../concepts/component-types.md#exec-node).
                * `disks` — параметры хранилища, которое будет использоваться для выполнения заданий.

                    * `type` — тип диска: `network-hdd`, `network-ssd` или `network-ssd-nonreplicated`.
                    * `sizeGb` — размер диска в ГБ.

                    От выбранного типа зависит, с каким шагом можно задавать размер диска при создании кластера:

                    * Сетевые HDD- и SSD-диски — с шагом 1 ГБ.
                    * Нереплицируемые SSD-диски — с шагом 93 ГБ.

                * `scalePolicy.fixed.size` — количество exec-нод для фиксированной политики масштабирования.
                * `name` — имя exec-пула.

            * `tablet` — конфигурация tablet-нод:

                * `preset` — [конфигурация вычислительных ресурсов](../concepts/component-types.md#tablet-node).
                * `count` — количество tablet-нод.

                Для использования tablet-нод должны быть указаны параметры SSD-хранилища (`spec.storage.ssd`).

                {% note warning %}

                Количество tablet-нод нельзя изменить после создания кластера.

                {% endnote %}

            * `proxy` — параметры прокси:

                * `http.count` — количество HTTP-прокси.
                * `rpc.count` — количество RPC-прокси.

            * `odin.checksTtl` — частота проверок внутреннего мониторинга Odin. Указывается в секундах (`s`). Например: `1209600s` (2 недели).

    1. Воспользуйтесь методом [Cluster.Create](../api-ref/Cluster/create.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request POST \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://{{ api-host-ytsaurus }}/ytsaurus/v1/clusters' \
            --data '@body.json'
        ```

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/create.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Создайте файл `body.json` и добавьте в него следующее содержимое:

        ```json
        {
          "folder_id": "<идентификатор_каталога>",
          "name": "<имя_кластера>",
          "description": "<описание_кластера>",
          "labels": { <список_меток> },
          "zone_id": "<зона_доступности>",
          "subnet_id": "<идентификатор_подсети>",
          "security_group_ids": [ <список_идентификаторов_групп_безопасности> ],
          "spec": {
            "storage": {
              "hdd": {
                "size_gb": "<размер_диска_в_ГБ>",
                "count": "<количество_дисков>"
              },
              "ssd": {
                "size_gb": "<размер_диска_в_ГБ>",
                "type": "<тип_диска>",
                "count": "<количество_дисков>"
              }
            },
            "compute": [
              {
                "preset": "<конфигурация_вычислительных_ресурсов>",
                "disks": [
                  {
                    "type": "<тип_диска>",
                    "size_gb": "<размер_диска_в_ГБ>"
                  }
                ],
                "scale_policy": {
                  "fixed": {
                    "size": "<количество_exec-нод>"
                  }
                },
                "name": "default"
              }
            ],
            "tablet": {
              "preset": "<конфигурация_вычислительных_ресурсов>",
              "count": "<количество_tablet-нод>"
            },
            "proxy": {
              "http": {
                "count": "<количество_HTTP-прокси>"
              },
              "rpc": {
                "count": "<количество_RPC-прокси>"
              }
            },
            "odin": {
              "checks_ttl": "<частота_проверок_в_секундах>"
            }
          }
        }
        ```

        Где:

        * `folderId` — идентификатор каталога. Его можно запросить со [списком каталогов в облаке](../../resource-manager/operations/folder/get-id.md).
        * `name` — имя кластера.
        * `description` — описание кластера.
        * `labels` — список меток. Метки задаются в формате `"<ключ>": "<значение>"`.
        * `zone_id` — [зона доступности](../../overview/concepts/geo-scope.md).
        * `subnet_id` — [идентификатор подсети](../../vpc/concepts/network.md#subnet).
        * `security_group_ids` — список идентификаторов [групп безопасности](../../vpc/concepts/security-groups).

            {% note warning %}

            Сетевые настройки нельзя изменить после создания кластера.

            {% endnote %}

        * `spec` — конфигурация компонентов кластера {{ ytsaurus-name }}:

            * `storage` — параметры хранилища:

                * `hdd` — параметры HDD-дисков:

                    * `size_gb` — размер диска в ГБ.
                    * `count` — количество дисков.

                * `ssd` — параметры SSD-дисков:

                    * `size_gb` — размер диска в ГБ.
                    * `type` — тип диска: `network-ssd` или `network-ssd-nonreplicated`.
                    * `count` — количество дисков.

                От выбранного типа зависит, с каким шагом можно задавать размер диска при создании кластера:

                * Сетевые HDD- и SSD-диски — с шагом 1 ГБ.
                * Нереплицируемые SSD-диски — с шагом 93 ГБ.

                Наличие HDD-диска является обязательным.

                {% note warning %}

                Тип и размер диска для кластера {{ ytsaurus-name }} нельзя изменить после создания.

                {% endnote %}

            * `compute` — конфигурация exec-нод:

                * `preset` — [конфигурация вычислительных ресурсов](../concepts/component-types.md#exec-node).
                * `disks` — параметры хранилища, которое будет использоваться для выполнения заданий.

                    * `type` — тип диска: `network-hdd`, `network-ssd` или `network-ssd-nonreplicated`.
                    * `size_gb` — размер диска в ГБ.

                    От выбранного типа зависит, с каким шагом можно задавать размер диска при создании кластера:

                    * Сетевые HDD- и SSD-диски — с шагом 1 ГБ.
                    * Нереплицируемые SSD-диски — с шагом 93 ГБ.

                * `scale_policy.fixed.size` — количество exec-нод для фиксированной политики масштабирования.
                * `name` — имя exec-пула.

            * `tablet` — конфигурация tablet-нод:

                * `preset` — [конфигурация вычислительных ресурсов](../concepts/component-types.md#tablet-node).
                * `count` — количество tablet-нод.

                Для использования tablet-нод должны быть указаны параметры SSD-хранилища (`spec.storage.ssd`).

                {% note warning %}

                Количество tablet-нод нельзя изменить после создания кластера.

                {% endnote %}

            * `proxy` — параметры прокси:

                * `http.count` — количество HTTP-прокси.
                * `rpc.count` — количество RPC-прокси.

            * `odin.checks_ttl` — частота проверок внутреннего мониторинга Odin. Указывается в секундах (`s`). Например: `1209600s` (2 недели).

    1. Воспользуйтесь вызовом [ClusterService.Create](../api-ref/grpc/Cluster/create.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/ytsaurus/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d @ \
            {{ api-host-ytsaurus }}:{{ port-https }} \
            yandex.cloud.ytsaurus.v1.ClusterService.Create \
            < body.json
        ```

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation).

{% endlist %}

## Примеры {#examples}

{% list tabs group=instructions %}

- {{ TF }} {#tf}

    Создайте кластер {{ myt-name }} и сеть для него с тестовыми характеристиками:

    * Имя — `my-ytsaurus-cluster`.
    * Сеть — `my-network`.
    * Подсеть — `my-subnet`. Зона доступности подсети — `ru-central1-a`, диапазон — `10.1.0.0/16`.
    * Хранилище:

        * `4` HDD-диска, размер — `4096` ГБ.
        * `3` SSD-диска с типом `network-ssd`, размер — `512` ГБ.

    * Exec-ноды:

        * Количество нод — `5`.
        * [Конфигурация вычислительных ресурсов](../concepts/component-types.md#exec-node) — `c8-m32`.
        * Тип диска — `network-ssd`, размер — `512` ГБ.

    * Tablet-ноды:

        * Количество нод — `3`.
        * [Конфигурация вычислительных ресурсов](../concepts/component-types.md#tablet-node) — `c8-m16`.

    * По `5` HTTP-прокси и RPC-прокси.

    Конфигурационный файл для такого кластера выглядит так:

    ```hcl
    resource "yandex_ytsaurus_cluster" "my-ytsaurus-cluster" {

      name               = "my-ytsaurus-cluster"
      zone_id            = yandex_vpc_subnet.my-subnet.zone
      subnet_id          = yandex_vpc_subnet.my-subnet.id

      spec = {
        storage = {
          hdd = {
            size_gb = 4096
            count   = 4
          }
          ssd = {
            size_gb = 512
            type    = "network-ssd"
            count   = 3
          }
        }
        compute = [
          {
            preset = "c8-m32"
            disks = [
              {
                size_gb   = 512
                type      = "network-ssd"
              }
            ]
            scale_policy = {
              fixed = {
                size = 5
              }
            }
          }
        ]
        tablet = {
          preset = "c8-m16"
          count  = 3
        }
        proxy = {
          http = {
            count = 5
          }
          rpc = {
            count = 5
          }
        }
      }
    }

    resource "yandex_vpc_network" "my-network" { name = "my-network" }

    resource "yandex_vpc_subnet" "my-subnet" {
      name           = "my-subnet"
      zone           = "ru-central1-a"
      network_id     = yandex_vpc_network.my-network.id
      v4_cidr_blocks = ["10.1.0.0/16"]
    }
    ```

{% endlist %}
