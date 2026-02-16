* {% include [Field Database Name](../../fields/ydb/ui/database-name.md) %}


* {% include [Field Service Account](../../fields/ydb/ui/service-account.md) %}
    
* {% include [YDB UI](../../../../_includes/data-transfer/fields/ydb/ui/security-groups.md) %}


* **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbTarget.cleanup_policy.title }}** — выберите способ очистки данных в базе-приемнике перед переносом:

    * `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.CleanupPolicy.DROP.title }}` — полное удаление таблиц, участвующих в трансфере (вариант по умолчанию).

        Используйте эту опцию, чтобы при любой активации трансфера в базу-приемник всегда передавалась самая последняя версия схемы таблиц из источника.

    * `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.CleanupPolicy.DISABLED.title }}` — не очищать.

        Выберите эту опцию, если будет производиться только репликация без копирования данных.
