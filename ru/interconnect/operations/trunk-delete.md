---
title: Как удалить транковое подключение в {{ interconnect-name }}
description: Следуя этой инструкции, вы сможете удалить транковое подключение в {{ interconnect-name }}.
---

# Удалить транковое подключение

Перед удалением транкового подключения:

1. [Удалите](priv-con-delete.md) все приватные соединения из транкового подключения.
1. [Удалите](pub-con-delete.md) все публичные соединения из транкового подключения.
1. Если для транкового подключения включена защита от удаления, [отключите ее](trunk-update.md).

{% note info %}

Для выполнения операции необходима роль [cic.editor](../security/index.md#cic-editor).

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) на панели сверху нажмите ![layout-side-content-left](../../_assets/console-icons/layout-side-content-left.svg) или ![chevron-down](../../_assets/console-icons/chevron-down.svg) и выберите нужный [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. [Перейдите]({{ link-console-main }}/link/interconnect) в сервис **{{ ui-key.yacloud.ui.constants.label_interconnect_aUMcv }}**.
  1. На панели слева выберите ![pipeline](../../_assets/console-icons/pipeline.svg) **{{ ui-key.yacloud.interconnect.trunk-connection.trunk-connections_kBGNL }}**.
  1. В строке с нужным транковым подключением нажмите значок ![ellipsis](../../_assets/console-icons/ellipsis.svg) и выберите ![trash-bin](../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**.
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
