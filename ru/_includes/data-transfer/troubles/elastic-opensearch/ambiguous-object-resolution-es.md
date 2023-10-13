### Прерывание трансфера с ошибкой {#ambiguous-resolution-es}

Тексты ошибок:

```text
object field starting or ending with a [.] makes object resolution ambiguous <описание_поля>

Index -1 out of bounds for length 0
```

Трансфер прерывается из-за того, что ключи в передаваемых документах невалидны для приемника {{ ES }}. К невалидным относятся пустые ключи, а также ключи:

* состоящие из пробелов;
* состоящие из точек;
* с точкой в начале или конце;
* с точками, стоящими друг за другом;
* с точками, разделенными пробелами.

**Решение:**

В [дополнительных настройках эндпоинта-приемника](../../../../data-transfer/operations/endpoint/target/elasticsearch.md#additional-settings) включите опцию **{{ ui-key.yc-data-transfer.data-transfer.console.form.elasticsearch.console.form.elasticsearch.ElasticSearchTarget.sanitize_doc_keys.title }}** и [активируйте](../../../../data-transfer/operations/transfer.md#activate) трансфер повторно.
