### Риск падения производительности {#opensearch_cpu_idle}

**Описание**

Хост постоянно использует весь ресурс CPU, что может приводить к замедлению обработки запросов. Проверьте [нагрузку](../../managed-opensearch/operations/monitoring.md) и оптимизируйте запросы (в том числе с [AI-ассистентом](../../websql/operations/ai-assistant.md) в {{ websql-name }}) или увеличьте вычислительные ресурсы кластера.

**Действие**

Чтобы увеличить вычислительные ресурсы кластера:

1. [Перейдите]({{ link-console-main }}/link/managed-opensearch) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
1. Нажмите на имя нужного кластера, затем выберите вкладку **{{ ui-key.yacloud.opensearch.cluster.node-groups.title_node-groups }}**.
1. Нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) в строке нужной группы и выберите пункт **{{ ui-key.yacloud.opensearch.cluster.node-groups.action_edit }}**.
1. Выберите класс хоста с нужным количеством vCPU.
1. Нажмите **{{ ui-key.yacloud.mdb.forms.button_edit }}**.
