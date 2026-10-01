# Viewing logs

To view cluster logs:

1. Open Grafana at `https://grafana.sys.<cluster_domain>` and log in using **Stackland Auth**.
1. Open the **Explore** section.
1. Select a data source:
   * `stackland-logs`: Logs of platform components from `stackland-*` namespaces.
   * `audit-logs`: Kubernetes API audit logs.

   If the `singleBinary` and `simpleScalable` modes are enabled at the same time, select `stackland-logs-legacy` or `audit-logs-legacy` respectively to view history.
1. Enter a LogQL query and click **Run query**.

To view system logs, you can also open the **Logs** app in Grafana. It uses the `stackland-logs` data source and allows you to filter logs entries by level, container, namespace, and other labels.

By default, only members of the `stackland-cluster-admins` group have access to all log sources. The administrator can update the list of allowed groups under `spec.settings.logStorage.loki.tenantProxy.adminGroups` in the `LoggingConfig` resource.
