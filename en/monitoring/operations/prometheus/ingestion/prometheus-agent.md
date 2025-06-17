---
title: How to install a {{ prometheus-name }} metric collection agent
description: In this guide, you will learn how to install a {{ prometheus-name }} metric collection agent when creating a VM and how to view the collected metrics.
---

# {{ prometheus-name }} metric collection agent

To transfer metrics from the VM to {{ managed-prometheus-name }}, you need a metric collection agent. You can install any agent supporting metrics transfer or use the {{ unified-agent-short-name }} which can transfer {{ prometheus-name }} metrics. 

This section describes how to install an agent when creating a VM. For other installation options, see [{#T}](../../../concepts/data-collection/unified-agent/installation.md).

{% include [agent-version](../../../../_includes/monitoring/agent-version.md) %}

## List of supported operating systems {#supported-os}

- Ubuntu 14.04 or higher
- Debian 9 or higher

## Before you begin installation {#before-you-begin}

1. [Create a service account](../../../../iam/operations/sa/create.md) in the folder you want to write metrics to and [assign it](../../../../iam/operations/sa/assign-role-for-sa.md) the `{{ roles-monitoring-editor }}` role.

1. Set up agent authorization in the {{ monitoring-full-name }} API. To do this, [link your service account](../../../../compute/operations/vm-connect/auth-inside-vm.md#link-sa-with-instance) to the VM. This way, the agent will automatically get the service account IAM token from the metadata service.

## Installation and setup {#setup}

You can install a metric collection agent when creating a VM with the help of the management console, CLI, API, or {{ TF }}.

{% list tabs group=instructions %}

- Management console {#console}
  
  1. In the [management console]({{ link-console-main }}), start [creating your VM](../../../../compute/operations/vm-create/create-linux-vm.md).
  1. Expand **{{ ui-key.yacloud.compute.instances.create.section_additional }}** ⟶ **{{ ui-key.yacloud.compute.instances.create.section_monitoring }}**.
  1. Enable **{{ ui-key.yacloud.compute.instances.create.unified-agent }}** and select **{{ managed-prometheus-name }}**.
  1. [Create](../index.md#access) a workspace or select an existing one.
  1. Optionally, specify the delivery parameters for your custom metrics, in JSON format.

      It no parameters are specified, the agent will only deliver Linux system metrics. You can add or change the delivery of your custom metrics later, in [user metadata](../../../../compute/concepts/vm-metadata.md#how-to-send-metadata).
    
      Metrics description format:

      ```json
      {
        "jobs": [
          {
            "job_name": <name>,
            "scrape_interval": "15s",
            "scrape_timeout": "5s",
            "metrics_path": "/metrics",
            "targets": [
              {
                "host": <host_FQDN>, //this is an optional field
                "port": 42
              }
            ]
          }
        ]
      }
      ```

      Where:
      - `job_name`: Random name for the set of metrics to collect.
      - `scrape_interval`: How often the agent will collect metrics.
      - `scrape_timeout`: Time the agent will have to collect metrics.
      - `metrics_path`: Path to the service metrics location.
      - `targets`: Parameters of the host to collect metrics from:
        - `host`: Full domain name, such as `my.example.com`. This is an optional setting.
        - `port`: Metric collection port.

- CLI, API {#cli}
  
    To install the agent, provide the following string in the [user metadata](../../../../compute/concepts/vm-metadata.md#how-to-send-metadata) (`user-data`):

    
      ```text
      #cloud-config\nruncmd:\n  - wget -O - https://monitoring.{{ api-host }}/monitoring/v2/unifiedAgent/config/install.sh | bash
      ```



- {{ TF }} {#tf}

  To install the agent:
  
  1. Specify the following in the VM creation configuration:

      ```hcl
      resource "yandex_compute_instance" "my-vm" {
        ...
        service_account_id = "ajehka*************"
        metadata    = {
          monitoring_workspaceid = "mon618clr**************"
          user-data = "${file("<path_to_configuration_file>")}"
        }
        ...
      }

      ```

      Where:
      * `monitoring_workspaceid`: ID of the workspace to which you want to write metrics.
      * `service_account_id`: ID of the service account with the `monitoring.editor` role.

  1. In the configuration file (`user-data`), specify the following line:

      
      ```text
      #cloud-config\nruncmd:\n  - wget -O - https://monitoring.{{ api-host }}/monitoring/v2/unifiedAgent/config/install.sh | bash
      ```



{% endlist %}

To install the agent and send metrics, make sure the VM has access to the internet.

## Configuration {#configuration}

The agent has two configuration files: `config.yml` and `prometheus.yml`.

The `config.yml` file is located at `/etc/yc/unified_agent/config.yml`. When the agent is installed in {{ prometheus-name }} metric collection mode, the file does not contain the metric collection parameters.

{% cut "Sample config.yml file" %}

```yaml
status:
  port: "16241"

import:
  - /etc/yc/unified_agent/conf.d/*.yml
  - /etc/yc/unified_agent/generated_conf.d/*.yml
```

{% endcut %}

The `prometheus.yml` file is located at `/etc/yc/unified_agent/generated_conf.d/prometheus.yml`. By default, it is configured to collect metrics in {{ prometheus-name }} format. If you specified your own metric collection settings when installing the agent, they will be added to this file.

{% cut "Sample prometheus.yml file" %}

```yaml
storages:
  - name: __prometheus_metrics_storage
    plugin: fs
    config:
      directory: /var/lib/yc/unified_agent/__prometheus_metrics_storage
      max_partition_size: 100mb
      max_segment_size: 10mb
channels:
  - name: __remote_write
    channel:
      pipe:
        - storage_ref:
            name: __prometheus_metrics_storage
      output:
        plugin: metrics
        config:
          url: "https://{{ api-host-monitoring-1 }}/prometheus/workspaces/workspace_id/api/v1/write"
          set_host_label: null
          iam:
            cloud_meta: { }
routes:
  - input:
      id: linux_metrics_input
      plugin: linux_metrics
      config:
        poll_period: 60s
        namespace: sys
        prometheus_config:
          job_name: linux_metrics
    channel:
      channel_ref:
        name: __remote_write
```

{% endcut %}


Once the VM is deployed, the agent will start automatically and will be sending metrics to {{ managed-prometheus-name }}.

You will be [charged](../../../pricing.md) for metric delivery.


## Overview of VM metrics {#view-metrics}

To view metrics your agent transfers to {{ managed-prometheus-name }}:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where the VM is located.
  1. In the list of services, select **{{ monitoring-short-name }}**.
  1. Navigate to **{{ prometheus-name }}**.
  1. Select the workspace to which your VM metrics are written.
  1. Open the **{{ ui-key.yacloud_monitoring.prometheus.approved.tab.explore }}** tab and enter a **{{ ui-key.yacloud_monitoring.prometheus.query.label }}** to view:
     
     * Linux system metrics: `{job="linux_metrics", instance="<VM_name>", __name__="<metric_name>"}`.

        Example: `{job="linux_metrics", instance="my_vm", __name__="sys_cpu_CpuCores"}`.

        For the list of metrics transferred by the {{ prometheus-name }} agent, see [{#T}](../../../metrics-ref/unifiedagent-ref.md).
     
     * Custom metrics if the agent has been configured to transfer them: `{job="metrics_totality_name", instance="<VM_name>:<port>", __name__="<metric_name>"}`.

        Where:
         * `job`: Name of the set of metrics specified when configuring the agent.
         * `instance`: VM name and port used by your application.
         * `name`: Name of the metric your application transfers.

         Example: `{job="web_server", instance="my_server:9100", __name__="http_requests_total"}`.
  1. Click **{{ ui-key.yacloud_monitoring.prometheus.query.action_execute }}**.

{% endlist %}