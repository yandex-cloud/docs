### Нехватка оперативной памяти {#opensearch_oom}

**Описание**

Кластер использует всю доступную оперативную память, что приводит к замедлению работы или аварийным остановкам. Увеличьте объем оперативной памяти для кластера.

**Действие**

Чтобы увеличить объем оперативной памяти:

1. [Перейдите]({{ link-console-main }}/link/managed-opensearch) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
1. Нажмите на имя нужного кластера, затем выберите вкладку **{{ ui-key.yacloud.opensearch.cluster.node-groups.title_node-groups }}**.
1. Нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) в строке нужной группы и выберите пункт **{{ ui-key.yacloud.opensearch.cluster.node-groups.action_edit }}**.
1. Выберите класс хоста с необходимым объемом памяти.
1. Нажмите **{{ ui-key.yacloud.mdb.forms.button_edit }}**.
