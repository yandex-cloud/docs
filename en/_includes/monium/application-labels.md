* `project = <project_ID>`: Select the project specified in `x-monium-project` of the application's telemetry transmission configuration.

    This may be a cloud (`cloud__<cloud_ID>`) project, folder (`folder__<folder_ID>`) project, or another [project](../../monium/collector/project.md#project-create).

* `cluster = <cluster_name>`: Select the name of the installation that runs your application. If no cluster is specified, `cluster = default` is used.

* `service = <service_name>`: Name of your application or service. You can use the `OTEL_SERVICE_NAME` environment variable to provide it.

  If you do not see the required labels in the suggestions, you can enter them manually. However, the system most likely has not received data with these labels. See [{#T}](../../monium/collector/troubleshooting.md) for possible solutions.
