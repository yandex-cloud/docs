# Удалить кластер GPU

Перед удалением кластера удалите из него все ВМ.

{% list tabs %}

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для удаления кластера GPU:

     ```bash
     yc compute gpu-cluster delete --help
     ```

  1. Получите список кластеров GPU в каталоге по умолчанию:

     ```bash
     yc compute gpu-cluster list
     ```

  1. Выберите идентификатор (`ID`) или имя (`NAME`) нужного кластера, например `first-gpu-cluster`.
  1. Удалите кластер:

     ```bash
     yc compute gpu-cluster delete first-gpu-cluster
     ```

- {{ TF }}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Откройте файл конфигурации {{ TF }} и удалите фрагмент с описанием GPU кластера:

     {% cut "Пример описания GPU кластера в конфигурации {{ TF }}" %}

     ```
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

      {% include [terraform-validate-plan-apply](../../../_tutorials/terraform-validate-plan-apply.md) %}

  Проверить удаление кластера можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/quickstart.md):

    ```bash
    yc compute gpu-cluster list
    ```

{% endlist %}