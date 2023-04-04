# Изменить кластер GPU

После создания кластера вы можете изменить его имя, описание или метки.

Как добавить ВМ в кластер, читайте в разделе [{#T}](./gpu-add-to-cluster.md)

{% list tabs %}

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для обновления параметров кластера GPU:

     ```bash
     yc compute gpu-cluster update --help
     ```

  1. Получите список кластеров GPU в каталоге по умолчанию:

      ```bash
      yc compute gpu-cluster list
      ```

  1. Выберите идентификатор (`ID`) или имя (`NAME`) нужного кластера, например `first-gpu-cluster`.
  1. Измените параметры кластера, например, переименуйте его:

      ```bash
      yc compute instance update first-gpu-cluster \
      --new-name updated-gpu-cluster
      ```

{% endlist %}