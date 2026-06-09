# Удалить транковое подключение

{% note info %}

Для выполнения операции необходима роль [cic.editor](../security/index.md#cic-editor).

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) на панели сверху нажмите ![layout-side-content-left](../../_assets/console-icons/layout-side-content-left.svg) или ![chevron-down](../../_assets/console-icons/chevron-down.svg) и выберите нужный [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Cloud Interconnect**.
  1. На панели слева выберите ![pipeline](../../_assets/console-icons/pipeline.svg) **Транковые подключения**.
  1. В строке с нужным транковым подключением нажмите значок ![ellipsis](../../_assets/console-icons/ellipsis.svg) и выберите ![trash-bin](../../_assets/console-icons/trash-bin.svg) **Удалить**.
  1. В открывшемся окне подтвердите удаление.

- CLI {#cli}

  1. Посмотрите описание команды CLI для удаления [транкового подключения](../concepts/trunk.md):

      ```bash
      yc cic trunk-connection delete --help
      ```

  1. Удалите транковое подключение:

      ```bash
      yc cic trunk-connection delete cf3dcodot14p******** --async
      ```

{% endlist %}