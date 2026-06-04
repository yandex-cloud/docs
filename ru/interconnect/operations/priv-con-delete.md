---
title: Как удалить приватное соединение в транковом подключении {{ interconnect-name }}
description: Следуя этой инструкции, вы сможете удалить приватное соединение в транковом подключении {{ interconnect-name }}.
---

# Удалить приватное соединение

{% note info %}

Для выполнения операции необходима роль [cic.editor](../security/index.md#cic-editor).

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) на панели сверху нажмите ![layout-side-content-left](../../_assets/console-icons/layout-side-content-left.svg) или ![chevron-down](../../_assets/console-icons/chevron-down.svg) и выберите нужный [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.ui.constants.label_interconnect_aUMcv }}**.
  1. На панели слева выберите ![nodes-left](../../_assets/console-icons/nodes-left.svg) **{{ ui-key.yacloud.interconnect.private-connection.private-connections_daeaR }}**.
  1. В строке с нужным приватным соединением нажмите значок ![ellipsis](../../_assets/console-icons/ellipsis.svg) и выберите ![trash-bin](../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**.
  1. В открывшемся окне подтвердите удаление.

- CLI {#cli}

  1. Посмотрите описание команды CLI для удаления [приватного соединения](../concepts/priv-con.md):

      ```bash
      yc cic private-connection delete --help
      ```

  1. Удалите приватное соединение:

      ```bash
      yc cic private-connection delete cf3dcodot14p******** --async
      ```

{% endlist %}
