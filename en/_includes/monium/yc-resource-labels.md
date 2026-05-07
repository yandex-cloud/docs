* `project = folder__<folder_ID>`: ID of the folder the {{ yandex-cloud }} resource resides in.
* `service = <log_group>`: Name or ID of the log group that receives logs, e.g., `default`.
* `resource_type = <resource_type>`: Type of the {{ yandex-cloud }} resource that sends logs, e.g., `managed-airflow.cluster`, `k8s.cluster`, or `alb.loadBalancer`.
* `resource_id = <resource_ID>`: ID of the {{ yandex-cloud }} resource that sends logs, e.g., cluster ID.

  If you skip the resource type, all logs in the log group will be shown. If you skip the resource ID, all logs for the selected resource type will be shown.