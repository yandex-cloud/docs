# Изменить кластер GPU


После создания [кластера GPU](../../concepts/gpus.md#gpu-clusters) вы можете изменить его имя, описание или метки.

Как добавить [виртуальную машину](../../concepts/vm.md) в кластер GPU, читайте в разделе [{#T}](./gpu-add-to-cluster.md)

{% list tabs group=instructions %}

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

{% endlist %}