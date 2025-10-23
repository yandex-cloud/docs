The {{ unified-agent-short-name }} installation involves the following steps:

* Installing the `unified_agent` executable.

* Installing the main configuration file. The configuration file is set up to send [basic VM metrics](../../monitoring/concepts/data-collection/unified-agent/inputs.md#linux_metrics_input) and [agent health metrics](../../monitoring/concepts/data-collection/unified-agent/inputs.md#agent_metrics_input). You will be [charged](../../monitoring/pricing.md) for metric delivery.

    You can also [configure](../../monitoring/concepts/data-collection/unified-agent/configuration.md) the delivery of custom metrics or [logs to {{ cloud-logging-name }}](../../monitoring/concepts/data-collection/unified-agent/outputs.md#yc_logs_output).

* Configuring the initialization system and adding the new `unified-agent` service. This service runs at system startup.

* Creating the `unified_agent` user with uid `1515` and a group with the same name and gid `1515`.

    If these uid and gid are not available (already in use), the user and group are created without explicitly specifying any uid and gid.

* Creating and configuring access to the `/etc/yandex/unified_agent/conf.d` custom configuration directory.

* Creating and configuring access to the `/var/lib/yandex/unified_agent` custom storage directory.