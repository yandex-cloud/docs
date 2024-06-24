### Ошибка на стадии копирования данных {#history-lost}

Трансфер типа _{{ dt-type-copy-repl }}_ на стадии копирования завершается с ошибкой:

```text
encountered non-recoverable resume token error. Sync cannot be resumed from this state and must be terminated and re-enabled to continue functioning: (ChangeStreamHistoryLost) Resume of change stream was not possible, as the resume point may no longer be in the oplog.
```

Ошибка `ChangeStreamHistoryLost` возникает, когда общее время копирования данных кластера-источника {{ MG }} превышает размер временного окна журнала операций (oplog). Текущий размер временного окна можно проверить в Консоли управления на графике **Oplog window** [страницы мониторинга кластера](../../../../managed-mongodb/operations/monitoring.md).

Подробнее об oplog читайте в [документации {{ MG }}]({{ mg.docs.comd }}/core/replica-set-oplog).

**Решение:**

* Увеличьте размер oplog (по умолчанию 10 % от размера диска кластера). Чтобы увеличить размер oplog в кластере-источнике {{ mmg-name }}, обратитесь в [техническую поддержку]({{ link-console-support }}). Чтобы изменить размер oplog в случае пользовательской инсталляции источника, см. [документацию {{ MG }}]({{ mg.docs.comd }}/tutorial/change-oplog-size).
* Включите [параллельное копирование данных](../../../../data-transfer/concepts/sharded.md) для ускорения стадии копирования.
* Ограничьте список объектов для переноса в [настройках трансфера](../../../../data-transfer/operations/transfer.md#create).

После этого [активируйте](../../../../data-transfer/operations/transfer.md#activate) трансфер повторно.
