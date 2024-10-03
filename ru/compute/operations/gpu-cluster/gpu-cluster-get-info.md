---
title: Как получить информацию о кластере GPU в {{ compute-full-name }}
---

# Получить информацию о кластере GPU


{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится [кластер GPU](../../concepts/gpus.md#gpu-clusters).
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/cpus.svg) **{{ ui-key.yacloud.compute.gpu_clusters }}**.
  1. Выберите нужный кластер.
  1. На странице **{{ ui-key.yacloud.common.overview }}** отобразится подробная информация о кластере GPU.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для получения информации о [кластере GPU](../../concepts/gpus.md#gpu-clusters):

      ```bash
      yc compute gpu-cluster get --help
      ```

  1. Получите информацию о кластере GPU, указав его имя или идентификатор:

      ```bash
      yc compute gpu-cluster get <имя_кластера_GPU>
      ```

      Результат:

      ```text
      id: fhm6cnc4kpp8********
      folder_id: b1gqs1teo2q2********
      created_at: "2024-02-14T15:10:21Z"
      name: test-cluster
      status: READY
      zone_id: {{ region-id }}-a
      interconnect_type: INFINIBAND
      ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  Чтобы получить информацию о [кластере GPU](../../concepts/gpus.md#gpu-clusters) с помощью {{ TF }}:

  1. Добавьте в конфигурационный файл {{ TF }} блоки `data` и `output`:

      ```hcl
      data "yandex_compute_gpu_cluster" "my_gpu_cluster" {
        gpu_cluster_id = "<идентификатор_кластера_GPU>"
      }

      output "gpu_cluster" {
        value = data.yandex_compute_gpu_cluster.my_gpu_cluster.zone
      }
      ```

      Где:

      * `data "yandex_compute_gpu_cluster"` — описание кластера GPU в качестве источника данных:
        * `gpu_cluster_id` — идентификатор кластера GPU.
      * `output "gpu_cluster"` — выходная переменная, которая содержит информацию о зоне доступности кластера GPU:
        * `value` — возвращаемое значение.

     Вместо `zone` вы можете выбрать любой другой параметр для получения информации. Более подробно о параметрах источника данных `yandex_compute_gpu_cluster` см. в [документации провайдера]({{ tf-provider-datasources-link }}/datasource_compute_gpu_cluster).

  1. Создайте ресурсы:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} создаст все требуемые ресурсы и отобразит значения выходных переменных в терминале. Чтобы проверить результат, выполните команду:

      ```bash
      terraform output
      ```

      Результат:

      ```text
      zone = {{ region-id }}-a
      ```

- API {#api}

  Чтобы получить подробную информацию о [кластере GPU](../../concepts/gpus.md#gpu-clusters), воспользуйтесь методом REST API [get](../../api-ref/GpuCluster/get.md) для ресурса [GpuCluster](../../api-ref/GpuCluster/index.md), или вызовом gRPC API [GpuClusterService/Get](../../api-ref/grpc/gpu_cluster_service.md#Get).

{% endlist %}
