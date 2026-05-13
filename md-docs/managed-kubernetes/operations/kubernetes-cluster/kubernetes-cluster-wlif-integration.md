# Включение поддержки федерации сервисных аккаунтов Yandex Identity and Access Management в кластере Yandex Managed Service for Kubernetes

В Managed Service for Kubernetes реализована интеграция с _федерациями сервисных аккаунтов_ Identity and Access Management.

[Федерации сервисных аккаунтов](../../../iam/concepts/workload-identity.md) (Workload Identity Federation) позволяют настроить связь между внешними системами и Yandex Cloud по протоколу [OpenID Connect](https://openid.net/developers/how-connect-works/) (OIDC). За счет этого внешние системы могут выполнять действия с ресурсами Yandex Cloud от имени [сервисных аккаунтов](../../../iam/concepts/users/service-accounts.md) IAM без использования [авторизованных ключей](../../../iam/concepts/authorization/key.md). Это более безопасный способ, минимизирующий риск утечки учетных данных и возможность несанкционированного доступа.

При включении опции Managed Service for Kubernetes автоматически создает для конкретного кластера OIDC-провайдер и предоставляет следующие параметры для интеграции с федерациями сервисных аккаунтов:
* `URL эмитента`.
* `URL набора ключей JWKS`.

{% note tip %}

В инструкции описана настройка кластера и групп узлов Managed Service for Kubernetes, полное руководство по интеграции с федерациями сервисных аккаунтов Identity and Access Management см. на странице [Доступ к API Yandex Cloud из кластера Managed Service for Kubernetes с помощью федерации сервисных аккаунтов Identity and Access Management](../../tutorials/wlif-managed-k8s-integration.md).

{% endnote %}

1. Если у вас еще нет кластера Managed Service for Kubernetes:
    1. [Создайте](kubernetes-cluster-create.md) кластер.

        {% note tip %}

        Чтобы использовать контроллер DaemonSet `yc-metadata-server` на узлах для автоматического обмена токенов сервисного аккаунта Kubernetes на IAM-токен, создайте кластер в [релизном канале](../../concepts/release-channels-and-updates.md) `RAPID`.

        Для остальных релизных каналов доступен [ручной обмен токенов](../../tutorials/wlif-managed-k8s-integration.md#manual-token-exchange) сервисного аккаунта Kubernetes на IAM-токен.

        {% endnote %}

    1. [Создайте](../node-group/node-group-create.md) группу узлов.
    1. [Настройте](../connect/security-groups.md) группы безопасности для кластера и группы узлов.
1. Для доступа к API Yandex Cloud у узлов кластера должен быть доступ в интернет. Убедитесь, что узлам кластера назначены публичные IP-адреса, или в подсети, где размещаются узлы, настроен [NAT-шлюз](../../../vpc/concepts/gateways.md#nat-gateway) или [NAT-инстанс](../../../tutorials/routing/nat-instance/index.md). Также убедитесь, что правилами группы безопасности разрешен весь исходящий трафик для узлов кластера.
1. Настройте интеграцию с федерацией сервисных аккаунтов для кластера и группы узлов:

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором размещен кластер.
      1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **Managed Service for&nbsp;Kubernetes**.
      1. Напротив кластера нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **Редактировать**.
      1. В поле **Управление идентификацией и доступом** включите федерацию сервисных аккаунтов.
      1. Нажмите **Сохранить**.
      1. На обзорной странице кластера в блоке **Управление идентификацией и доступом** скопируйте значения параметров **URL эмитента** и **URL набора ключей JWKS**. Они понадобятся для дальнейшей интеграции.
      1. Перейдите на вкладку **Группы узлов**.
      1. Напротив группы узлов нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **Редактировать**.
      1. В поле **Управление идентификацией и доступом** включите федерацию сервисных аккаунтов.
      1. Нажмите **Сохранить**.

    - CLI {#cli}

      Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

      По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

      1. Включите поддержку интеграции с федерацией сервисных аккаунтов в кластере:

          ```bash
          yc managed-kubernetes cluster update \
            --id <идентификатор_кластера> \
            --enable-workload-identity-federation
          ```

          Результат:

          ```text
          done (3s)
          ...
          workload_identity_federation:
            enabled: true
            issuer: https://storage.yandexcloud.net/mk8s-oidc/v1/clusters/catc7433801j********
            jwks_uri: https://storage.yandexcloud.net/mk8s-oidc/v1/clusters/catc7433801j********/jwks.json
          ```

          Скопируйте значения параметров `workload_identity_federation.issuer` и `workload_identity_federation.jwks_uri`. Они понадобятся для дальнейшей интеграции.

      1. Включите поддержку интеграции с федерацией сервисных аккаунтов в группе узлов:

          ```bash
          yc managed-kubernetes node-group update \
            --id <идентификатор_группы_узлов> \
            --enable-workload-identity-federation
          ```

          Результат:

          ```text
          done (12s)
          ...
          workload_identity_federation:
            enabled: true
          ```

    - Terraform {#tf}

      [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
      
      Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
      
      Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).

      Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

      1. В конфигурационном файле Terraform добавьте в манифест кластера блок `workload_identity_federation`:

          ```hcl
          resource "yandex_kubernetes_cluster" "my_cluster" {
          ...
            workload_identity_federation {
              enabled = true
            }
          }
          ```

      1. В конфигурационном файле Terraform добавьте в манифест группы узлов блок `workload_identity_federation`:

          ```hcl
          resource "yandex_kubernetes_node_group" "my_node_group" {
          ...
            workload_identity_federation {
              enabled = true
            }
          }
          ```

      1. Проверьте корректность конфигурационных файлов.

          1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы Terraform с планом инфраструктуры.
          1. Выполните команду:
          
             ```bash
             terraform validate
             ```
          
             Если в файлах конфигурации есть ошибки, Terraform на них укажет.

      1. Подтвердите изменение ресурсов.

          1. Выполните команду для просмотра планируемых изменений:
          
             ```bash
             terraform plan
             ```
          
             Если конфигурации ресурсов описаны верно, в терминале отобразится список изменяемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут изменены.
          
          1. Если вас устраивают планируемые изменения, внесите их:
             1. Выполните команду:
          
                ```bash
                terraform apply
                ```
          
             1. Подтвердите изменение ресурсов.
             1. Дождитесь завершения операции.

      1. Получите URL эмитента (`issuer`) и URL набора ключей JWKS (`jwks_uri`) для настройки федерации сервисных аккаунтов с помощью источника данных Terraform [yandex_kubernetes_cluster](../../../terraform/data-sources/kubernetes_cluster.md).

          Также вы можете [узнать](kubernetes-cluster-list.md#get) эти параметры в [консоли управления](https://console.yandex.cloud), с помощью CLI или API.

    - API {#api}

      1. Воспользуйтесь методом REST API [update](../../managed-kubernetes/api-ref/Cluster/update.md) для ресурса [Cluster](../../managed-kubernetes/api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Update](../../managed-kubernetes/api-ref/grpc/Cluster/update.md).

          {% note info %}
          
          Ниже перечислены параметры для тела запроса к REST API. Чтобы указать параметр в вызове gRPC API, преобразуйте его имя из [lowerCamelCase](https://ru.wikipedia.org/wiki/CamelCase) в [snake_case](https://ru.wikipedia.org/wiki/Snake_case). Например, параметр `minResourcePresetId` преобразуется в `min_resource_preset_id`.
          
          {% endnote %}

          Передайте в запросе:
          * Идентификатор кластера в параметре `clusterId`.
          * Параметр `updateMask` со значением `workloadIdentityFederation.enabled`.

            {% note warning %}
            
            Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask` (одной строкой через запятую).
            
            {% endnote %}

          * Параметр `workloadIdentityFederation` со значением `"enabled": "true"`.

          Скопируйте из ответа значения параметров `workloadIdentityFederation.issuer` и `workloadIdentityFederation.jwksUri`. Они понадобятся в дальнейшем.

      1. Воспользуйтесь методом REST API [update](../../managed-kubernetes/api-ref/NodeGroup/update.md) для ресурса [NodeGroup](../../managed-kubernetes/api-ref/NodeGroup/index.md) или вызовом gRPC API [NodeGroupService/Update](../../managed-kubernetes/api-ref/grpc/NodeGroup/update.md).

          Передайте в запросе:
          * Идентификатор группы узлов в параметре `nodeGroupId`.
          * Параметр `updateMask` со значением `workloadIdentityFederation.enabled`.
          * Параметр `workloadIdentityFederation` со значением `"enabled": "true"`.

    {% endlist %}

### См. также {#see-also}

* [Федерации сервисных аккаунтов](../../../iam/concepts/workload-identity.md)
* [Доступ к API Yandex Cloud из кластера Managed Service for Kubernetes с помощью федерации сервисных аккаунтов Identity and Access Management](../../tutorials/wlif-managed-k8s-integration.md)