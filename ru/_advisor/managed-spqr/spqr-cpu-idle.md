### Обнаружена высокая загрузка CPU {#spqr_cpu_idle}

**Описание**

Хост постоянно использует весь ресурс CPU, что может приводить к замедлению обработки запросов. Проверьте [нагрузку](../../storedoc/operations/performance-diagnostics.md) и оптимизируйте запросы (в том числе с [AI-ассистентом](../../websql/operations/ai-assistant.md) в {{ websql-name }}) или увеличьте вычислительные ресурсы кластера.

**Действие**

Чтобы увеличить вычислительные ресурсы кластера:

1. [Перейдите]({{ link-console-main }}/link/managed-spqr) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spqr }}**.
1. Выберите кластер и нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** на панели сверху.
1. В разделе **{{ ui-key.yacloud.spqr.section_infra }}** выберите класс хоста с нужным количеством vCPU.
1. Нажмите **{{ ui-key.yacloud.mdb.forms.button_edit }}**.
