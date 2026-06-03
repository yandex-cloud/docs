---
title: Как переместить транковое подключение {{ interconnect-full-name }} в другой каталог
description: Следуя этой инструкции, вы сможете переместить транковое подключение {{ interconnect-full-name }} в другой каталог.
---

# Переместить транковое подключение в другой каталог

{% include [cic-cr-access](../../_includes/interconnect/cic-cr-access.md) %}

{% note info %}

Для выполнения операции необходима роль [cic.editor](../security/index.md#cic-editor) в текущем и новом каталогах.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) на панели сверху нажмите ![layout-side-content-left](../../_assets/console-icons/layout-side-content-left.svg) или ![chevron-down](../../_assets/console-icons/chevron-down.svg) и выберите нужный [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.ui.constants.label_interconnect_aUMcv }}**.
  1. На панели слева выберите ![pipeline](../../_assets/console-icons/pipeline.svg) **{{ ui-key.yacloud.interconnect.trunk-connection.trunk-connections_kBGNL }}**.
  1. В строке с нужным транковым подключением нажмите значок ![ellipsis](../../_assets/console-icons/ellipsis.svg) и выберите ![folder-arrow-right.svg](../../_assets/console-icons/folder-arrow-right.svg) **{{ ui-key.yacloud.common.move }}**.
  1. В открывшемся окне выберите каталог, в который вы хотите переместить выбранное транковое подключение, и нажмите кнопку **{{ ui-key.yacloud.common.move }}**.

- CLI {#cli}

  1. Посмотрите описание команды CLI для перемещения [транкового подключения](../concepts/trunk.md):

      ```bash
      yc cic trunk-connection move --help
      ```

  1. Переместите транковое подключение в другой каталог, указав идентификатор подключения и имя нового каталога:

      ```bash
      yc cic trunk-connection move cf3dcodot14p******** \
        --destination-folder-name new-folder \
        --async
      ```

{% endlist %}