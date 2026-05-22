1. Если у вас еще нет кластера {{ managed-k8s-name }}:
    1. [Создайте](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) кластер.

        {% note tip %}

        Чтобы использовать контроллер DaemonSet `yc-metadata-server` на узлах для автоматического обмена токенов сервисного аккаунта {{ k8s }} на IAM-токен, создайте кластер в [релизном канале](../../managed-kubernetes/concepts/release-channels-and-updates.md) `RAPID`.

        Для остальных релизных каналов доступен [ручной обмен токенов](../../managed-kubernetes/tutorials/wlif-managed-k8s-integration.md#manual-token-exchange) сервисного аккаунта {{ k8s }} на IAM-токен.

        {% endnote %}

    1. [Создайте](../../managed-kubernetes/operations/node-group/node-group-create.md) группу узлов.
    1. [Настройте](../../managed-kubernetes/operations/connect/security-groups.md) группы безопасности для кластера и группы узлов.
1. Для доступа к API {{ yandex-cloud }} у узлов кластера должен быть доступ в интернет. Убедитесь, что узлам кластера назначены публичные IP-адреса, или в подсети, где размещаются узлы, настроен [NAT-шлюз](../../vpc/concepts/gateways.md#nat-gateway) или [NAT-инстанс](../../tutorials/routing/nat-instance/index.md). Также убедитесь, что правилами группы безопасности разрешен весь исходящий трафик для узлов кластера.
1. Настройте интеграцию с федерацией сервисных аккаунтов для кластера и группы узлов:

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором размещен кластер.
      1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
      1. Напротив кластера нажмите ![image](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.edit }}**.
      1. В поле **{{ ui-key.yacloud.k8s.IAMService.section-title_4Cx2E }}** включите федерацию сервисных аккаунтов.
      1. Нажмите **{{ ui-key.yacloud.common.save }}**.
      1. На обзорной странице кластера в блоке **{{ ui-key.yacloud.k8s.IAMService.section-title_4Cx2E }}** скопируйте значения параметров **{{ ui-key.yacloud.k8s.IAMService.ClusterIAMSection.iam-issuer_iKJcv }}** и **{{ ui-key.yacloud.k8s.IAMService.ClusterIAMSection.iam-jwks-uri_x2AJJ }}**. Они понадобятся для дальнейшей интеграции.
      1. Перейдите на вкладку **{{ ui-key.yacloud.k8s.nodes.label_node-groups }}**.
      1. Напротив группы узлов нажмите ![image](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.edit }}**.
      1. В поле **{{ ui-key.yacloud.k8s.IAMService.section-title_4Cx2E }}** включите федерацию сервисных аккаунтов.
      1. Нажмите **{{ ui-key.yacloud.common.save }}**.

    - CLI {#cli}

      {% include [cli-install](../cli-install.md) %}

      {% include [default-catalogue](../default-catalogue.md) %}

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

      {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

      {% include [terraform-install](../terraform-install.md) %}

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

          {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

      1. Подтвердите изменение ресурсов.

          {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      1. Получите URL эмитента (`issuer`) и URL набора ключей JWKS (`jwks_uri`) для настройки федерации сервисных аккаунтов с помощью источника данных {{ TF }} [yandex_kubernetes_cluster]({{ tf-provider-datasources-link }}/kubernetes_cluster).

          Также вы можете [узнать](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-list.md#get) эти параметры в [консоли управления]({{ link-console-main }}), с помощью CLI или API.

    - API {#api}

      1. Воспользуйтесь методом REST API [update](../../managed-kubernetes/managed-kubernetes/api-ref/Cluster/update.md) для ресурса [Cluster](../../managed-kubernetes/managed-kubernetes/api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Update](../../managed-kubernetes/managed-kubernetes/api-ref/grpc/Cluster/update.md).

          {% include [api-parameters-case](../../_includes/managed-kubernetes/api-parameters-case.md) %}

          Передайте в запросе:
          * Идентификатор кластера в параметре `clusterId`.
          * Параметр `updateMask` со значением `workloadIdentityFederation.enabled`.

            {% include [Note API updateMask](../note-api-updatemask.md) %}

          * Параметр `workloadIdentityFederation` со значением `"enabled": "true"`.

          Скопируйте из ответа значения параметров `workloadIdentityFederation.issuer` и `workloadIdentityFederation.jwksUri`. Они понадобятся в дальнейшем.

      1. Воспользуйтесь методом REST API [update](../../managed-kubernetes/managed-kubernetes/api-ref/NodeGroup/update.md) для ресурса [NodeGroup](../../managed-kubernetes/managed-kubernetes/api-ref/NodeGroup/index.md) или вызовом gRPC API [NodeGroupService/Update](../../managed-kubernetes/managed-kubernetes/api-ref/grpc/NodeGroup/update.md).

          Передайте в запросе:
          * Идентификатор группы узлов в параметре `nodeGroupId`.
          * Параметр `updateMask` со значением `workloadIdentityFederation.enabled`.
          * Параметр `workloadIdentityFederation` со значением `"enabled": "true"`.

    {% endlist %}