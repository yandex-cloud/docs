---
title: Изменить кластер GPU
description: Следуя данной инструкции, вы сможете изменить кластер GPU.
---

# Изменить кластер GPU


После создания [кластера GPU](../../concepts/gpus.md#gpu-clusters) вы можете изменить его имя, описание или метки.

Как добавить [виртуальную машину](../../concepts/vm.md) в кластер GPU, читайте в разделе [{#T}](./gpu-add-to-cluster.md)

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится кластер GPU.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/cpus.svg) **{{ ui-key.yacloud.gpu-cluster.label_title }}**.
  1. В строке с нужным кластером GPU нажмите ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![image](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
  1. В открывшемся окне измените имя, описание или [метки](../../../resource-manager/concepts/labels.md) кластера GPU.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды [CLI](../../../cli/) для обновления параметров кластера GPU:

     ```bash
     yc compute gpu-cluster update --help
     ```

  1. Получите список кластеров GPU в [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder) по умолчанию:

     ```bash
     yc compute gpu-cluster list
     ```

  1. Выберите идентификатор (`ID`) или имя (`NAME`) нужного кластера GPU, например `first-gpu-cluster`.
  1. Измените параметры кластера GPU, например, переименуйте его:

     ```bash
     yc compute instance update first-gpu-cluster \
       --new-name updated-gpu-cluster
     ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Откройте файл конфигурации {{ TF }} и измените фрагмент с описанием кластера GPU:

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

  Проверить изменение кластера GPU можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/):

  ```bash
  yc compute gpu-cluster get <имя_кластера_GPU>
  ```

- API {#api}

  Чтобы изменить кластер GPU, воспользуйтесь методом REST API [update](../../api-ref/GpuCluster/update.md) для ресурса [GpuCluster](../../api-ref/GpuCluster/index.md) или вызовом gRPC API [GpuClusterService/Update](../../api-ref/grpc/GpuCluster/update.md).

{% endlist %}

#### Полезные ссылки {#see-also}

* [{#T}](gpu-cluster-create.md)
* [{#T}](gpu-cluster-delete.md)
* [{#T}](gpu-add-to-cluster.md)
* [{#T}](../../concepts/gpus.md)
* [{#T}](../../concepts/vm-platforms.md)
