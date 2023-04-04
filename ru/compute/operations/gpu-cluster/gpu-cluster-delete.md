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


{% endlist %}