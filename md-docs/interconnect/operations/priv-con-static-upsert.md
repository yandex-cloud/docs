# Добавить статические маршруты в приватное соединение (VPC Stitching)

{% note warning %}

Чтобы запросить доступ к данной функции, обратитесь в [техническую поддержку](https://center.yandex.cloud/support).

{% endnote %}

{% note info %}

Для выполнения операции необходима роль [cic.editor](../security/index.md#cic-editor).

{% endnote %}

{% list tabs group=instructions %}

- CLI {#cli}

  1. Посмотрите описание команды CLI для добавления статических маршрутов в [приватное соединение](../concepts/priv-con.md):

      ```bash
      yc cic private-connection upsert-static-routes --help
      ```

  1. Добавьте статические маршруты в приватное соединение:

      ```bash
      yc cic private-connection upsert-static-routes cf3td**********nufvr \ 
        --ipv4-static-routes=10.0.0.0/8,10.0.1.0/8" \
        --async
      ```

{% endlist %}