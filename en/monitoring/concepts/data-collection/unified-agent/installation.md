---
title: "How to install and start up {{ unified-agent-full-name }}"
description: "In this tutorial, you will learn about installing and starting up {{ unified-agent-full-name }}."
---

# {{ unified-agent-full-name }} installation and startup

## List of supported operating systems {#supported-os}

{{ unified-agent-short-name }} is supported by the following operating systems:

- Ubuntu 14.04 or higher (it can be [installed using any method](#setup))
- Debian 9 or higher (Docker image, deb package, or binary file)
- CentOS 7 or higher (Docker image)
- Fedora 32 or higher (Docker image)
- Fedora CoreOS (Docker image)

## Before you begin installation {#before-you-begin}

Prior to installing {{ unified-agent-full-name }}, follow these steps:

1. Create a VM in {{ yandex-cloud }} or a host outside {{ yandex-cloud }} on one of the [supported operating systems](#supported-os), for example, Ubuntu 14.04 or older.

1. (Optional) [Install Docker](https://docs.docker.com/install/) if you want to use Docker to run {{ unified-agent-short-name }}. Docker is pre-installed in Fedora CoreOS.
   - Set up a public IPv4 address (recommended).
   - [Configure Docker to work with IPv6](https://docs.docker.com/config/daemon/ipv6) and [enable network address translation](https://medium.com/@skleeschulte/how-to-enable-ipv6-for-docker-containers-on-ubuntu-18-04-c68394a219a2) if you cannot use a public IPv4 address.

1. [Create a service account](../../../../iam/operations/sa/create.md) in the folder you want to write metrics to and [assign it](../../../../iam/operations/sa/assign-role-for-sa.md) the `{{ roles-monitoring-editor }}` role.

1. Set up agent authorization in the {{ monitoring-full-name }} API:
   - If the agent is installed on a VM in {{ yandex-cloud }}, [link the service account you created](../../../../compute/operations/vm-connect/auth-inside-vm.md#link-sa-with-instance) to the VM. In that case, the agent will automatically receive the service account IAM token from the metadata service.
   - If the agent is installed on a host outside {{ yandex-cloud }}, [create an authorized key](../../../../iam/operations/authorized-key/create.md) for service accounts. For more information about delivering metrics from hosts outside {{ yandex-cloud }}, see [{#T}](../../../operations/unified-agent/non-yc.md).

## Installation {#setup}

Install {{ unified-agent-short-name }} using one of the following methods:

{% list tabs group=unified_agent %}

- Docker image {#docker}

   {{ unified-agent-short-name }} is distributed as a Docker image. The image is published in the `{{ registry }}/yc` repository with the `unified_agent` name and `latest` tag. The image includes a binary file with the agent and a configuration file used to set up the agent [for Linux system metric delivery](../../../operations/unified-agent/linux_metrics.md) in {{ monitoring-full-name }}.

   {% note warning %}

   To monitor secondary disks attached to the host, specify the paths to their mount points in the `-v` parameter of the `docker run` command. For more information, see [{#T}](./inputs.md#linux_metrics_input).

   {% endnote %}

   The agent's configuration file is located at `/etc/yandex/unified_agent/config.yml` and parameterized by environment variables. For more information about starting a Docker container, see [below](#configure-docker).

   To start a container with the agent, run the following command:

   ```bash
     sudo docker run \
       -p 16241:16241 -it --detach --uts=host \
       --name=ua \
       -v /proc:/ua_proc \
       -e PROC_DIRECTORY=/ua_proc \
       -e FOLDER_ID=a1bs81qpemb4******** \
       {{ registry }}/yc/unified-agent
   ```

   Where `FOLDER_ID` is the ID of the folder to write metrics to.

   To launch a container with its own configuration file, add `-v` to the container start command and specify the _full path_ to the configuration file. Before running a container, delete the following lines from the configuration file:

   ```yaml
   import:
   - /etc/yandex/unified_agent/conf.d/*.yml
   ```

   Sample run container command using a custom configuration file:

   ```bash
     docker run \
       -p 16241:16241 -it --detach --uts=host \
       --name=ua \
       -v /proc:/ua_proc \
       -v `pwd`/config.yml:/etc/yandex/unified_agent/conf.d/config.yml \
       --entrypoint="" \
       -e PROC_DIRECTORY=/ua_proc \
       -e FOLDER_ID=a1bs81qpemb4******** \
       {{ registry }}/yc/unified-agent
   ```

   By default, the [status](services.md#status) section of the agent's configuration file specifies `host: null`. Please keep this in mind if you are using your own configuration file.

   For more information about agent configuration, see [{#T}](./configuration.md).

- deb package {#deb}

   {{ unified-agent-short-name }} is distributed as a deb package for Ubuntu 14.04 or higher. The package contains a binary file with the agent and an empty configuration file located at `/etc/yandex/unified_agent/config.yml`.

   To download the latest version of the agent's deb package, run:

   ```bash
   ubuntu_name="ubuntu-14.04-trusty" ua_version=$(curl -s https://{{ s3-storage-host }}/yc-unified-agent/latest-version) bash -c 'curl -s -O https://{{ s3-storage-host }}/yc-unified-agent/releases/${ua_version}/deb/${ubuntu_name}/yandex-unified-agent_${ua_version}_amd64.deb'
   ```

   Supported values for the `ubuntu_name` parameter:
   * `ubuntu-14.04-trusty`
   * `ubuntu-16.04-xenial`
   * `ubuntu-18.04-bionic`
   * `ubuntu-20.04-focal`
   * `ubuntu-22.04-jammy`, starting with version `23.03.02`

   To find out all the available versions of the agent, run this command:
   ```(bash)
   curl -s https://{{ s3-storage-host }}/yc-unified-agent/all-versions
   ```

   To install the deb package, run this command:

   ```bash
   sudo dpkg -i yandex-unified-agent_21.02.03_amd64.deb
   ```

   To make sure {{ unified-agent-short-name }} is successfully installed and running, run the `systemctl status unified-agent` command. Command output example:

   ```bash
   user@my-vm:~$ systemctl status unified-agent
   ● unified-agent.service - Yandex Unified Agent service
      Loaded: loaded (/lib/systemd/system/unified-agent.service; enabled; vendor preset: enabled)
      Active: active (running) since Tue 2021-02-09 15:57:08 UTC; 2 weeks 2 days ago
    Main PID: 141403 (unified_agent)
       Tasks: 8 (limit: 507)
      Memory: 9.4M
      CGroup: /system.slice/unified-agent.service
              └─141403 /usr/bin/unified_agent --config /etc/yandex/unified_agent/config.yml --log-priority NOTICE
   ```

   After installing the package, edit the `/etc/yandex/unified_agent/config.yml` configuration file, e.g., by setting up the agent for [delivering Linux system metrics](../../../operations/unified-agent/linux_metrics.md). For more information about agent configuration, see [{#T}](./configuration.md).

- Binary file {#binary}

   {{ unified-agent-short-name }} is distributed as a binary file built for the x86-64/amd64 architecture for Ubuntu 14.04 or higher.

   To download the latest version of the agent's binary file, run:

   ```bash
   ua_version=$(curl -s https://{{ s3-storage-host }}/yc-unified-agent/latest-version) bash -c 'curl -s -O https://{{ s3-storage-host }}/yc-unified-agent/releases/$ua_version/unified_agent && chmod +x ./unified_agent'
   ```

   To find out all the available versions of the agent, run this command:
   ```(bash)
   curl -s https://{{ s3-storage-host }}/yc-unified-agent/all-versions
   ```

   Download the agent's executable file and then create a configuration file, for example, with the settings for [delivering Linux system metrics](../../../operations/unified-agent/linux_metrics.md). For more information about agent configuration, see [{#T}](./configuration.md).

   To run the agent, run the following command:

   ```bash
   ./unified_agent --config unified_agent.yml
   ```

   Where `--config` is the path to the configuration file.

- When creating a VM {#vm}

   You can install {{ unified-agent-short-name }} when creating a VM through the management console, CLI, API, or {{ TF }}.

   To install the agent from the [management console]({{ link-console-main }}), enable **{{ ui-key.yacloud.compute.instances.create.unified-agent }}** under **{{ ui-key.yacloud.compute.instances.create.section_monitoring }}**.

   To install the agent via the CLI or API, provide the following string in the [user metadata](../../../../compute/concepts/vm-metadata.md#how-to-send-metadata) (`user-data`):

   ```
   #cloud-config\nruncmd:\n - wget -O - https://monitoring.{{ api-host }}/monitoring/v2/unifiedAgent/config/install.sh | bash
   ```
   To install the agent using {{ TF }}, add this metadata to the configuration file:

   ```
   resource "yandex_compute_instance" "this" {
   ...
   resources {
     ...
   }

   ...

   metadata = {
     ssh-keys = "<username>:<SSH_key_contents>",
     "install-unified-agent": "1"
   }
   }
   ```

   To install the agent and send metrics, make sure the VM has access to the internet.

   The agent is installed with a default configuration file located at `/etc/yandex/unified_agent/config.yml`.

   The configuration file is set up to send [basic virtual machine metrics](./inputs.md#linux_metrics_input) and [agent health metrics](./inputs.md#agent_metrics_input). You will be [charged](../../../pricing.md) for metric delivery.

   You can also [configure](./configuration.md) the delivery of custom metrics or [logs to {{ cloud-logging-name }}](./outputs.md#yc_logs_output).

   You are responsible for updating and maintaining the agent.

{% endlist %}

## Parameters for running a Docker container with {{ unified-agent-short-name }} {#configure-docker}

If you install {{ unified-agent-short-name }} using Docker, you can configure the agent using environment variables. In that case, you will not need to edit the configuration file located at `/etc/yandex/unified_agent/config.yml`. The environment variables are listed in the table below.

| Environment variable | Default value | Description |
-------------------- | --------------------- | --------
| `UA_STATUS_PORT` | `16241` | Port where the [agent status](./services.md#status) will be available. |
| `UA_LOG_PRIORITY` | `NOTICE` | [Agent's logging](./services.md#agent_log) level. |
| `FOLDER_ID` | No | ID of the folder to write metrics to (a required parameter). |
| `PROC_DIRECTORY` | `/proc` | Directory with mounted [procfs](https://en.wikipedia.org/wiki/Procfs) from where the agent will get [Linux system metrics](./inputs.md#linux_metrics_input). |
| `SYS_DIRECTORY` | `/sys` | Directory with mounted [sysfs](https://en.wikipedia.org/wiki/Sysfs) from where the agent will get [Linux system metrics](./inputs.md#linux_metrics_input). |
| `UA_LINUX_RESOURCE_CPU`<br/>`UA_LINUX_RESOURCE_MEMORY`<br/>`UA_LINUX_RESOURCE_NETWORK`</br>`UA_LINUX_RESOURCE_STORAGE`<br/>`UA_LINUX_RESOURCE_IO`<br/>`UA_LINUX_RESOURCE_KERNEL` | `basic` | Detail level of the [system metrics](./inputs.md#linux_metrics_input) for CPU, network, disks, I/O system, and Linux kernel. |

#### What's next {#what-is-next}

- Read about [{{ unified-agent-short-name }} concepts](./index.md).
- [Learn more about configuring {{ unified-agent-short-name }}](./configuration.md).
- [Read the {{ unified-agent-short-name }} operating guidelines](./best-practices.md).
