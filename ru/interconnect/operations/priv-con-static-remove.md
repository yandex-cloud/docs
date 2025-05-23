---
title: Как удалить статические маршруты из приватного соединения {{ interconnect-name }}
description: Следуя этой инструкции, вы сможете удалить статические маршруты из приватного соединения {{ interconnect-name }}.
---

# Удалить статические маршруты из приватного соединения

{% include [cic-cr-access](../../_includes/interconnect/cic-cr-access.md) %}

{% note info %}

Для выполнения операции необходима роль [cic.editor](../security/index.md#cic-editor).

{% endnote %}

{% list tabs group=instructions %}

- CLI {#cli}

  1. Посмотрите описание команды CLI для удаления статических маршрутов из [приватного соединения](../concepts/priv-con.md):

      ```bash
      yc cic private-connection remove-static-routes --help
      ```
  1. Удалите статические маршруты из приватного соединения:

      ```bash
      yc cic private-connection remove-static-routes cf3td**********nufvr \
        --ipv4-static-routes=10.0.0.0/8,10.0.1.0/8" \
        --async
      ```

{% endlist %}

