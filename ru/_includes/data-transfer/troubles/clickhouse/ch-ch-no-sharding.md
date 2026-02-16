### Не работает шардирование при трансфере из {{ CH }} в {{ CH }} {#ch-ch-no-sharding}

Для трансферов из {{ CH }} в {{ CH }} шардирование не поддерживается.

**Решение:**

Возможный обходной путь: создайте на кластере-приемнике распределенную таблицу и выполните трансфер в нее, выбрав политику очистки `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.CleanupPolicy.TRUNCATE.title }}` или `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.CleanupPolicy.DISABLED.title }}`.
