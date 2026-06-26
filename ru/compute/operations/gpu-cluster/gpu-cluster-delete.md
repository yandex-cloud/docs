---
title: Удалить кластер GPU
description: Следуя данной инструкции, вы сможете удалить кластер GPU.
---

# Удалить кластер GPU


Перед удалением [кластера GPU](../../concepts/gpus.md#gpu-clusters) удалите из него все [виртуальные машины](../../concepts/vm.md).

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится кластер GPU.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/cpus.svg) **{{ ui-key.yacloud.gpu-cluster.label_title }}**.
  1. В строке с нужным кластером GPU нажмите ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![image](../../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**.
  1. Подтвердите удаление.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды [CLI](../../../cli/) для удаления кластера GPU:

     ```bash
     yc compute gpu-cluster delete --help
     ```

  1. Получите список кластеров GPU в [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder) по умолчанию:

     ```bash
     yc compute gpu-cluster list
     ```

  1. Выберите идентификатор (`ID`) или имя (`NAME`) нужного кластера GPU, например `first-gpu-cluster`.
  1. Удалите кластер GPU:

     ```bash
     yc compute gpu-cluster delete first-gpu-cluster
     ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Откройте файл конфигурации {{ TF }} и удалите фрагмент с описанием кластера GPU:

     {% cut "Пример описания кластера GPU в конфигурации {{ TF }}" %}

     ```hcl
     ...
     resource "yandex_compute_gpu_cluster" "default" {
       name               = "gpu-cluster-name"
       interconnect_type  = "infiniband"
       zone               = "{{ region-id }}-a"

       labels = {
         environment = "test"
       }
     }
     ...
     ```

     {% endcut %}

  1. Примените изменения:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  Проверить удаление кластера GPU можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/):

    ```bash
    yc compute gpu-cluster list
    ```

- API {#api}

  Чтобы удалить кластер GPU, воспользуйтесь методом REST API [delete](../../api-ref/GpuCluster/delete.md) для ресурса [GpuCluster](../../api-ref/GpuCluster/index.md) или вызовом gRPC API [GpuClusterService/Delete](../../api-ref/grpc/GpuCluster/delete.md).

{% endlist %}

#### Полезные ссылки {#see-also}

* [{#T}](gpu-cluster-create.md)
* [{#T}](gpu-cluster-update.md)
* [{#T}](gpu-add-to-cluster.md)
* [{#T}](../../concepts/gpus.md)
* [{#T}](../../concepts/vm-platforms.md)

