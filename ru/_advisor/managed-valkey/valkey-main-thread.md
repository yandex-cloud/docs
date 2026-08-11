### Риск падения производительности {#valkey_main_thread}

**Описание**

Хост постоянно использует весь ресурс CPU в `main thread`, что может приводить к замедлению обработки запросов. Проверьте [нагрузку](../../managed-valkey/operations/monitoring.md) и оптимизируйте запросы (в том числе с [AI-ассистентом](../../websql/operations/ai-assistant.md)) или увеличьте вычислительные ресурсы кластера.

**Действие**

Чтобы увеличить вычислительные ресурсы кластера:

1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
1. Выберите кластер и нажмите ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}**.
1. В разделе **{{ ui-key.yacloud.mdb.forms.new_section_resource }}** выберите класс хоста с нужным количеством vCPU.
1. Нажмите **{{ ui-key.yacloud.mdb.forms.button_edit }}**.
