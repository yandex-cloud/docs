# Включение поддержки федерации сервисных аккаунтов {{ iam-full-name }} в кластере {{ managed-k8s-full-name }}

В {{ managed-k8s-name }} реализована интеграция с _федерациями сервисных аккаунтов_ {{ iam-name }}.

[Федерации сервисных аккаунтов](../../../iam/concepts/workload-identity.md) (Workload Identity Federation) позволяют настроить связь между внешними системами и {{ yandex-cloud }} по протоколу [OpenID Connect](https://openid.net/developers/how-connect-works/) (OIDC). За счет этого внешние системы могут выполнять действия с ресурсами {{ yandex-cloud }} от имени [сервисных аккаунтов](../../../iam/concepts/users/service-accounts.md) {{ iam-short-name }} без использования [авторизованных ключей](../../../iam/concepts/authorization/key.md). Это более безопасный способ, минимизирующий риск утечки учетных данных и возможность несанкционированного доступа.

При включении опции {{ managed-k8s-name }} автоматически создает для конкретного кластера OIDC-провайдер и предоставляет следующие параметры для интеграции с федерациями сервисных аккаунтов:
* `{{ ui-key.yacloud.k8s.IAMService.ClusterIAMSection.iam-issuer_iKJcv }}`.
* `{{ ui-key.yacloud.k8s.IAMService.ClusterIAMSection.iam-jwks-uri_x2AJJ }}`.

{% note tip %}

В инструкции описана настройка кластера и групп узлов {{ managed-k8s-name }}, полное руководство по интеграции с федерациями сервисных аккаунтов {{ iam-name }} см. на странице [{#T}](../../tutorials/wlif-managed-k8s-integration.md).

{% endnote %}

1. Если у вас еще нет кластера {{ managed-k8s-name }}:
    1. [Создайте](kubernetes-cluster-create.md) кластер.

    1. [Создайте](../node-group/node-group-create.md) группу узлов.
    1. [Настройте](../connect/security-groups.md) группы безопасности для кластера и группы узлов.
1. Для доступа к API {{ yandex-cloud }} у узлов кластера должен быть доступ в интернет. Убедитесь, что узлам кластера назначены публичные IP-адреса, или в подсети, где размещаются узлы, настроен [NAT-шлюз](../../../vpc/concepts/gateways.md#nat-gateway) или [NAT-инстанс](../../../tutorials/routing/nat-instance/index.md). Также убедитесь, что правилами группы безопасности разрешен весь исходящий трафик для узлов кластера.
1. Настройте интеграцию с федерацией сервисных аккаунтов для кластера и группы узлов:

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором размещен кластер.
      1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
      1. Напротив кластера нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.edit }}**.
      1. В поле **{{ ui-key.yacloud.k8s.IAMService.section-title_4Cx2E }}** включите федерацию сервисных аккаунтов.
      1. Нажмите **{{ ui-key.yacloud.common.save }}**.
      1. На обзорной странице кластера в блоке **{{ ui-key.yacloud.k8s.IAMService.section-title_4Cx2E }}** скопируйте значения параметров **{{ ui-key.yacloud.k8s.IAMService.ClusterIAMSection.iam-issuer_iKJcv }}** и **{{ ui-key.yacloud.k8s.IAMService.ClusterIAMSection.iam-jwks-uri_x2AJJ }}**. Они понадобятся для дальнейшей интеграции.
      1. Перейдите на вкладку **{{ ui-key.yacloud.k8s.nodes.label_node-groups }}**.
      1. Напротив группы узлов нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.edit }}**.
      1. В поле **{{ ui-key.yacloud.k8s.IAMService.section-title_4Cx2E }}** включите федерацию сервисных аккаунтов.
      1. Нажмите **{{ ui-key.yacloud.common.save }}**.

    - CLI {#cli}

      Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

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
            issuer: https://{{ s3-storage-host }}/mk8s-oidc/v1/clusters/catc7433801j********
            jwks_uri: https://{{ s3-storage-host }}/mk8s-oidc/v1/clusters/catc7433801j********/jwks.json
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

    - {{ TF }} {#tf}

      [{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
      
      {{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
      
      Подробную информацию о ресурсах провайдера смотрите в документации на сайте [{{ TF }}](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале]({{ tf-docs-link }}).

      Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
      
      
      Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

      1. В конфигурационном файле {{ TF }} добавьте в манифест кластера блок `workload_identity_federation`:

          ```hcl
          resource "yandex_kubernetes_cluster" "my_cluster" {
          ...
            workload_identity_federation {
              enabled = true
            }
          }
          ```

      1. В конфигурационном файле {{ TF }} добавьте в манифест группы узлов блок `workload_identity_federation`:

          ```hcl
          resource "yandex_kubernetes_node_group" "my_node_group" {
          ...
            workload_identity_federation {
              enabled = true
            }
          }
          ```

      1. Проверьте корректность конфигурационных файлов.

          1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы {{ TF }} с планом инфраструктуры.
          1. Выполните команду:
          
             ```bash
             terraform validate
             ```
          
             Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

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

      1. Получите URL эмитента (`issuer`) и URL набора ключей JWKS (`jwks_uri`) для настройки федерации сервисных аккаунтов с помощью источника данных {{ TF }} [yandex_kubernetes_cluster]({{ tf-provider-datasources-link }}/kubernetes_cluster).

          Также вы можете [узнать](kubernetes-cluster-list.md#get) эти параметры в [консоли управления]({{ link-console-main }}), с помощью CLI или API.

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

* [{#T}](../../../iam/concepts/workload-identity.md)
* [{#T}](../../tutorials/wlif-managed-k8s-integration.md)