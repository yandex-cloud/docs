### Высокая загрузка CPU на хосте {#clickhouse_cpu_idle}

**Описание**

Хост постоянно использует весь ресурс CPU, что может приводить к замедлению обработки запросов. Проверьте [нагрузку](../../managed-clickhouse/operations/performance-diagnostics.md) и оптимизируйте запросы (в том числе с [AI-ассистентом](../../websql/operations/ai-assistant.md) в {{ websql-name }}) или увеличьте вычислительные ресурсы кластера.

**Действие**

Чтобы увеличить вычислительные ресурсы кластера:

1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
1. Выберите кластер и нажмите ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}**.
1. В разделе **{{ ui-key.yacloud.mdb.forms.new_section_resource }}** выберите класс хоста с нужным количеством vCPU.
1. Нажмите **{{ ui-key.yacloud.mdb.forms.button_edit }}**.
