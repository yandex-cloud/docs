### Нехватка ресурсов {#insufficiency-resources}

Текст ошибки:

```text
Warn(Activate): Snapshot loading failed:
snapshot tasks failed: main uploader failed:
errors detected on secondary workers: secondary worker #3 failed:
pod instance restarted 5h41m39.092446028s ago
```

**Решение:** 

Если причиной ошибки `pod instance restarted` стала нехватка оперативной памяти (OOM) на ВМ трансфера, то возможны следующие решения:

* Снизить количество потоков на воркер в [настройках трансфера](../../../data-transfer/operations/transfer.md#update-copy-repl). Количество воркеров при этом можно увеличить, чтобы сохранить общий уровень [шардирования](../../../data-transfer/concepts/sharded.md) (параллельной загрузки) на стадии копирования. Т.к. потоки делят ресурсы воркера между собой, уменьшение числа потоков на воркер увеличит количество ресурсов, доступных каждому потоку. Эта мера позволит снизить вероятность ООМ потока.

* Для [трансферов в стадии GA](../../../data-transfer/transfer-matrix.md) можно увеличить вычислительные ресурсы в [настройке трансфера](../../../data-transfer/operations/transfer.md#update) **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.Transfer.runtime.title }}**. Такие трансферы [тарифицируются](../../../data-transfer/pricing.md), поэтому увеличение вычислительных ресурсов приведет к увеличению стоимости передачи данных.

* Для [трансферов в стадии Preview](../../../data-transfer/transfer-matrix.md) самостоятельно изменить вычислительные ресурсы нельзя: обратитесь в [техническую поддержку]({{ link-console-support }}) или к вашему аккаунт-менеджеру.

Если причиной ошибки `pod instance restarted` не является OOM, обратитесь в [техническую поддержку]({{ link-console-support }}).
