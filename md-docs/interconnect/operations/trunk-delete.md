# Удалить транковое подключение

{% note warning %}

Чтобы запросить доступ к данной функции, обратитесь в [техническую поддержку](https://center.yandex.cloud/support).

{% endnote %}

{% note info %}

Для выполнения операции необходима роль [cic.editor](../security/index.md#cic-editor).

{% endnote %}

{% list tabs group=instructions %}

- CLI {#cli}

  1. Посмотрите описание команды CLI для удаления [транкового подключения](../concepts/trunk.md):

      ```bash
      yc cic trunk-connection delete --help
      ```

  1. Удалите транковое подключение:

      ```bash
      yc cic trunk-connection delete cf3td**********nufvr --async
      ```

{% endlist %}