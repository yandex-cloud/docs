**{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferTypeIncrement.increment_settings.title }}** → **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.IncrementSettings.parallel_settings.title }}** — укажите количество воркеров для организации параллельной репликации. Настройка доступна для источников {{ ydb-short-name }}, {{ KF }} и {{ DS }}. Если запущено несколько процессов репликации, они поделят между собой партиции реплицируемого топика. 

{% note info %}

Для {{ ydb-short-name }} рекомендуется выставлять количество воркеров, не превышающее суммарное количество партиций по таблицам — иначе часть ресурсов будет простаивать. В случае, если пользовательский поток изменений не указан, трансфер при активации создаст поток изменений, число партиций которого будет равно количеству таблеток таблицы {{ ydb-short-name }} на момент последней активации.

{% endnote %}