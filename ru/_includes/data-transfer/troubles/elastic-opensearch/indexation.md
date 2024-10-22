### Прерывание трансфера с ошибкой can't index document {#indexation}

Текст ошибки:

```text
Push failed: can't index document: got an indexation error
```

В аудитных логах разных сервисов поле `details` может содержать данные разных типов. В целевое поле `details` в {{ OS }} записываются данные только того типа, который пришел первым. Остальные данные не принимаются из-за несовместимости типов, поэтому трансфер прерывается.

**Решение:** разделите поток, чтобы данные из разных сервисов попадали в разные индексы.

Для этого при создании трансфера в блоке **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.Transfer.transformation.title }}**:

  * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.Transformer.title }}** — выберите **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.Transformer.table_splitter.title }}**.
  * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.ToStringTransformer.columns.title }}** — введите `event_source`.