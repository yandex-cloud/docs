[Документация Yandex Cloud](../../index.md) > [Yandex Cloud Interconnect](../index.md) > [Пошаговые инструкции](index.md) > Переместить приватное соединение в другой каталог

# Переместить приватное соединение в другой каталог

{% note info %}

Для выполнения операции необходима роль [cic.editor](../security/index.md#cic-editor) в текущем и новом каталогах.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) на панели сверху нажмите ![layout-side-content-left](../../_assets/console-icons/layout-side-content-left.svg) или ![chevron-down](../../_assets/console-icons/chevron-down.svg) и выберите нужный [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Cloud Interconnect**.
  1. На панели слева выберите ![nodes-left](../../_assets/console-icons/nodes-left.svg) **Приватные соединения**.
  1. В строке с нужным приватным соединением нажмите значок ![ellipsis](../../_assets/console-icons/ellipsis.svg) и выберите ![folder-arrow-right.svg](../../_assets/console-icons/folder-arrow-right.svg) **Переместить**.
  1. В открывшемся окне выберите каталог, в который вы хотите переместить выбранное приватное соединение, и нажмите кнопку **Переместить**.

- CLI {#cli}

  1. Посмотрите описание команды CLI для перемещения [приватного соединения](../concepts/priv-con.md):

      ```bash
      yc cic private-connection move --help
      ```

  1. Переместите приватное соединение в другой каталог, указав идентификатор соединения и имя нового каталога:

      ```bash
      yc cic private-connection move cf3dcodot14p******** \
        --destination-folder-name new-folder \
        --async
      ```

{% endlist %}