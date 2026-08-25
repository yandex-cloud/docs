### Риск потери данных {#storedoc_replication_lag}

**Описание**

Хост имеет высокий лаг репликации, что может привести к потере данных. Проверьте нагрузку на мастер‑узел и реплики, оптимизируйте запросы или увеличьте вычислительные ресурсы кластера.

**Действие**

Чтобы увеличить вычислительные ресурсы кластера:

1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
1. Выберите кластер и нажмите ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}**.
1. В разделе **{{ ui-key.yacloud.mongodb.ClusterForm.ClusterFormBase.section_resources_5RLrK }}** выберите класс хоста с нужным количеством vCPU.
1. Нажмите **{{ ui-key.yacloud.mdb.forms.button_edit }}**.