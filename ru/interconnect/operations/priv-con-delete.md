---
title: Как удалить приватное соединение в транковом подключении {{ interconnect-name }}
description: Следуя этой инструкции, вы сможете удалить приватное соединение в транковом подключении {{ interconnect-name }}.
---

# Удалить приватное соединение

{% include [cic-cr-access](../../_includes/interconnect/cic-cr-access.md) %}

{% note info %}

Для выполнения операции необходима роль [cic.editor](../security/index.md#cic-editor).

{% endnote %}

{% list tabs group=instructions %}

- CLI {#cli}

  1. Посмотрите описание команды CLI для удаления [приватного соединения](../concepts/priv-con.md):

      ```bash
      yc cic private-connection delete --help
      ```

  1. Удалите приватное соединение:

      ```bash
      yc cic private-connection delete cf3td**********nufvr --async
      ```

{% endlist %}

