---
title: How to start and stop {{ unified-agent-full-name }}
description: In this tutorial, you will learn how to start and stop {{ unified-agent-full-name }}.
---

# Starting and stopping {{ unified-agent-full-name }}

## Starting {#run}

[Install](installation.md#setup) {{ unified-agent-full-name }} and start it using one of the following methods:

{% list tabs group=unified_agent %}

- Docker image {#docker}

  The agent's configuration file is located at `/etc/yandex/unified_agent/config.yml` and parameterized by environment variables. For more information about starting a Docker container, see [below](#configure-docker).

  To start a container with the agent, run the following command:



  Where `FOLDER_ID` is the ID of the folder to write metrics to.

  To start a container with its own configuration file, add the `-v` parameter to the container start command and specify the _full path_ to the configuration file. Before you start a container, delete the following lines from the configuration file:

  ```yaml
  import:
  - /etc/yandex/unified_agent/conf.d/*.yml
  ```

  Example of container start command with a custom configuration file:



  By default, the [status](services.md#status) section of the agent's configuration file specifies `host: null`. Please keep this in mind if you are using your own configuration file.

  {% note warning %}

  To monitor secondary disks attached to the host, specify the paths to their mount points using the `-v` parameter of the `docker run` command. For more information, see [{#T}](./inputs.md#linux_metrics_input).

  {% endnote %}

  For more information about agent configuration, see [{#T}](./configuration.md).

- deb package {#deb}

  Edit the `/etc/yandex/unified_agent/config.yml` configuration file, e.g., by setting up the agent to [deliver Linux system metrics](../../../operations/unified-agent/linux_metrics.md). For more information about agent configuration, see [{#T}](configuration.md).


  To make sure {{ unified-agent-short-name }} is successfully installed and started, run this command:

  ```bash
  systemctl status unified-agent
  ```

  Result:

  ```bash
  ● unified-agent.service - Yandex Unified Agent service
     Loaded: loaded (/lib/systemd/system/unified-agent.service; enabled; vendor preset: enabled)
     Active: active (running) since Tue 2021-02-09 15:57:08 UTC; 2 weeks 2 days ago
   Main PID: 141403 (unified_agent)
      Tasks: 8 (limit: 507)
     Memory: 9.4M
     CGroup: /system.slice/unified-agent.service
             └─141403 /usr/bin/unified_agent --config /etc/yandex/unified_agent/config.yml --log-priority NOTICE
  ```

- Binary file {#binary}

  Create a configuration file, e.g., with settings for [delivering Linux system metrics](../../../operations/unified-agent/linux_metrics.md). For more information about agent configuration, see [{#T}](configuration.md).


  To start the agent, run the following command:

  ```bash
  ./unified_agent --config unified_agent.yml
  ```

- When creating a VM {#vm}

  Once the VM is deployed, {{ unified-agent-short-name }} will be started automatically and begin delivering basic VM metrics to {{ monitoring-full-name }}.

  You are responsible for updating and maintaining the agent.

  The agent is installed with a default configuration file located at `/etc/yc/unified_agent/config.yml`. You can also [configure](./configuration.md) the delivery of custom metrics or [logs to {{ cloud-logging-name }}](./outputs.md#yc_logs_output).

  The configuration file is set up to send [basic virtual machine metrics](./inputs.md#linux_metrics_input) and [agent health metrics](./inputs.md#agent_metrics_input). You will be [charged](../../../pricing.md) for metric delivery.


  To start the agent manually, run the following command:

  ```bash
  ./unified_agent --config unified_agent.yml
  ```

{% endlist %}


## Stopping {#stop}

Stop {{ unified-agent-short-name }} using one of the following methods:

{% list tabs group=unified_agent %}

- Docker image {#docker}

  To create a container, run this command:

  ```bash
  sudo docker stop ua
  ```

- Deb package {#deb}

  **Ubuntu 14.04**

  To stop the agent, run this command:

  ```bash
  sudo service unified-agent stop
  ```

  To restart the agent, run the following command:

  ```bash
  sudo service unified-agent restart
  ```

  **Ubuntu 14.04 or higher**

  To stop the agent, run this command:

  ```bash
  sudo systemctl stop unified-agent
  ```

  To restart the agent, run the following command:

  ```bash
  sudo systemctl
  ```

- Binary file {#binary}

  {% include [agent-stop-binary](../../../../_includes/monitoring/agent-stop-binary.md) %}

- When creating a VM {#vm}

  {% include [agent-stop-binary](../../../../_includes/monitoring/agent-stop-binary.md) %}

{% endlist %}

The process of stopping {{ unified-agent-short-name }} may take some time to complete the delivery of accumulated data. It usually takes two seconds or less.


## Parameters for starting a Docker container with {{ unified-agent-short-name }} {#configure-docker}

If you install {{ unified-agent-short-name }} using Docker, you can configure the agent using environment variables. In that case, you will not need to edit the configuration file located at `/etc/yandex/unified_agent/config.yml`. The environment variables are listed in the table below.

Environment variable | Default value | Description
-------------------- | --------------------- | --------
`UA_STATUS_PORT` | `16241` | Port where the [agent status](./services.md#status) will be available.
`UA_LOG_PRIORITY` | `NOTICE` | [Agent's logging](./services.md#agent_log) level.
`FOLDER_ID` | No | ID of the folder to write metrics to (a required parameter).
`PROC_DIRECTORY` | `/proc` | Directory with mounted [procfs](https://ru.wikipedia.org/wiki/Procfs) from where the agent will get [Linux system metrics](./inputs.md#linux_metrics_input).
`SYS_DIRECTORY` | `/sys` | Directory with mounted [sysfs](https://ru.wikipedia.org/wiki/Sysfs) from where the agent will get [Linux system metrics](./inputs.md#linux_metrics_input).
`UA_LINUX_RESOURCE_CPU`<br/>`UA_LINUX_RESOURCE_MEMORY`<br/>`UA_LINUX_RESOURCE_NETWORK`</br>`UA_LINUX_RESOURCE_STORAGE`<br/>`UA_LINUX_RESOURCE_IO`<br/>`UA_LINUX_RESOURCE_KERNEL` | `basic` | Level of detail of [system metrics](./inputs.md#linux_metrics_input): CPU, network, disks, I/O system, and Linux kernel.


#### What's next {#what-is-next}

- [Read about {{ unified-agent-short-name }} concepts](./index.md).
- [Learn more about configuring {{ unified-agent-short-name }}](./configuration.md).
- [Read the {{ unified-agent-short-name }} operating guidelines](./best-practices.md).
