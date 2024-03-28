# Best practices for using the agent

This section offers recommendations for using {{unified-agent-full-name}}.

## One agent per host {#one-agent-per-host}

Avoid running more than one {{unified-agent-short-name}} instance on the same host with the same configuration files since that might cause problems with the agent.

## Agent monitoring {#agent_metrics}

When using {{unified-agent-short-name}}, we recommend that you enable collecting health metrics for the agent.

To do so, add to the agent configuration a [delivery route](index.md#routes) with the `agent_metrics` input. Sample configuration:

```yaml
status:
  port: 16241

routes:
  - input:
      plugin: agent_metrics
      config:
        namespace: ua
    channel:
      pipe:
        - filter:
            plugin: filter_metrics
            config:
              match: "{scope=health}"
      output:
        plugin: yc_metrics
        config:
          folder_id: "$FOLDER_ID"
          iam:
            cloud_meta: {}
```

See also [{#T}](configuration.md#agent_metrics_input).

## Using storage {#storage}

Use a storage to reliably deliver metrics to {{ monitoring-full-name }} with {{unified-agent-short-name}}. It will let you temporarily store messages sent over a [pipe](index.md#pipes) before being passed on to the channel output.

Using a storage can help you avoid data loss if the agent fails to write the data to the specified output (including repeat attempts). That might happen because of network issues or destination API unavailability.

Sample agent configuration with a storage:

```yaml
status:
  port: 16241

storages:
  - name: main
    plugin: fs
    config:
      directory: /var/lib/yandex/unified_agent/main
      max_partition_size: 1gb
      max_segment_size: 500mb

channels:
  - name: cloud_monitoring
    channel:
      pipe:
        - storage_ref:
            name: main
      output:
        plugin: yc_metrics
        config:
          folder_id: <folder_ID>
          iam:
            cloud_meta: {}

routes:
  - input:
      plugin: linux_metrics
      config:
        poll_period: 15s
        namespace: sys
    channel:
      channel_ref:
        name: cloud_monitoring
```

See also [{#T}](configuration.md#storages).
