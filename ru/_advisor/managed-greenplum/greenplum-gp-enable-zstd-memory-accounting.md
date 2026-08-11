### Риск превышения лимитов памяти ресурсного менеджера {#greenplum_gp_enable_zstd_memory_accounting}

**Описание**

Параметр `gp_enable_zstd_memory_accounting` контролирует выделение памяти для алгоритма ZSTD. Его включение предотвращает превышение лимитов памяти ресурсного менеджера, выделяя ZSTD в отдельный `zstd_context`, что значительно снижает риск выхода из строя кластера из-за OOM. Рекомендуется включить этот параметр.

**Действие**

Чтобы включить параметр `gp_enable_zstd_memory_accounting`:

1. Перейдите **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
1. Выберите кластер и нажмите ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}**.
1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_configure-settings }}** в блоке **{{ ui-key.yacloud.mdb.forms.section_settings }}** и включите настройку `gp_enable_zstd_memory_accounting`.
