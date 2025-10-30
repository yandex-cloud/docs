---
title: How to install and update {{ unified-agent-full-name }}
description: In this tutorial, you will learn how to install and update {{ unified-agent-full-name }}.
sourcePath: en/monitoring_includes/concepts/data-collection/unified-agent/installation.md
---

# Installing and updating {{ unified-agent-full-name }}

{% include [agent-version](../../../../_includes/monitoring/agent-version.md) %}

For more information, see [{#T}](../../../operations/prometheus/ingestion/prometheus-agent.md).

## List of supported operating systems {#supported-os}

{{ unified-agent-short-name }} is supported by the following operating systems:

- Ubuntu 16.04 or higher (you can [install it using any method](#setup)).
- Debian 9 or higher (Docker image, deb package, or binary file).
- CentOS 7 or higher (Docker image).
- Fedora 32 or higher (Docker image).
- Fedora CoreOS (Docker image).




## Before you begin installation {#before-you-begin}

Prior to installing {{ unified-agent-full-name }}, follow these steps:

1. Create a VM in {{ yandex-cloud }} or a host outside {{ yandex-cloud }} on one of the [supported operating systems](#supported-os), e.g., Ubuntu 16.04 or higher.

1. Optionally, [install Docker](https://docs.docker.com/install/) if you want to use Docker to run {{ unified-agent-short-name }}. Docker is pre-installed in Fedora CoreOS.
   - Set up a public IPv4 address (recommended).
   - [Configure Docker to work with IPv6](https://docs.docker.com/config/daemon/ipv6) and [enable network address translation](https://medium.com/@skleeschulte/how-to-enable-ipv6-for-docker-containers-on-ubuntu-18-04-c68394a219a2) if you cannot use a public IPv4 address.

1. [Create a service account](../../../../iam/operations/sa/create.md) in the folder you want to write metrics to and [assign it](../../../../iam/operations/sa/assign-role-for-sa.md) the `{{ roles-monitoring-editor }}` role.

1. Set up agent authorization in the {{ monitoring-full-name }} API:
   - If the agent is installed on a VM in {{ yandex-cloud }}, [link the service account you created](../../../../compute/operations/vm-connect/auth-inside-vm.md#link-sa-with-instance) to the VM. In that case, the agent will automatically receive the service account IAM token from the metadata service.
   - If the agent is installed on a host outside {{ yandex-cloud }}, [create an authorized key](../../../../iam/operations/authentication/manage-authorized-keys.md#create-authorized-key) for service accounts. For more information about delivering metrics from hosts outside {{ yandex-cloud }}, see [{#T}](../../../operations/unified-agent/non-yc.md).


## Installation {#setup}

Install {{ unified-agent-short-name }} using one of the following methods:

{% list tabs group=unified_agent %}

- Docker image {#docker}

  Install Docker Engine. Use [this guide](https://docs.docker.com/engine/install/#supported-platforms) to install and run Docker for your operating system.

  {{ unified-agent-short-name }} is distributed as a Docker image. The image is published in the `{{ registry }}/yc` repository with the `unified_agent` name and the `latest` tag. The image includes a binary file with the agent and a configuration file used to set up the agent [for Linux system metric delivery](../../../operations/unified-agent/linux_metrics.md) in {{ monitoring-full-name }}.

  To upload a Docker image, run this command:

  ```bash
  sudo docker pull {{ registry }}/yc/unified-agent:latest
  ```

- deb package {#deb}

  {{ unified-agent-short-name }} is distributed as a deb package for Ubuntu 16.04 or higher and Debian 9 or higher. The package contains a binary file with the agent and a configuration file located at `/etc/yandex/unified_agent/config.yml`.

  To install {{ unified-agent-short-name }}:

  {% include [agent-setup-deb](../../../../_includes/monitoring/agent-setup-deb.md) %}


  {% include [agent-setup-actions](../../../../_includes/monitoring/agent-setup-actions.md) %}

- Binary file {#binary}

  {{ unified-agent-short-name }} is distributed as a binary file built for the x86-64/amd64 architecture for Ubuntu 16.04 or higher.

  To download the latest version of the agent's binary file, run:

  ```bash
  ua_version=$(curl --silent https://{{ s3-storage-host }}/yc-unified-agent/latest-version) \
  bash -c 'curl --silent --remote-name https://{{ s3-storage-host }}/yc-unified-agent/releases/$ua_version/unified_agent && chmod +x ./unified_agent'
  ```

- When creating a VM {#vm}

  You can install {{ unified-agent-short-name }} when creating a VM through the management console, CLI, API, or {{ TF }}.

  To install the agent from the [management console]({{ link-console-main }}), enable **{{ ui-key.yacloud.compute.instances.create.section_monitoring }}** under **{{ ui-key.yacloud.compute.instances.create.unified-agent }}**.

  To install the agent via the CLI, API, or {{ TF }}, provide the following string in the [user metadata](../../../../compute/concepts/metadata/sending-metadata.md) (`user-data`):

  
  ```text
  #cloud-config\nruncmd:\n  - wget -O - https://monitoring.{{ api-host }}/monitoring/v2/unifiedAgent/config/install.sh | bash
  ```




  To install the agent and send metrics, make sure the VM has access to the internet.

  {% include [agent-setup-actions](../../../../_includes/monitoring/agent-setup-actions.md) %}


  Once the VM is deployed, {{ unified-agent-short-name }} will be started automatically and begin delivering basic VM metrics to {{ monitoring-full-name }}.

  Update the agent manually via a binary file.

{% endlist %}


## Updating {#update}

Update {{ unified-agent-short-name }} using one of the following methods:

{% list tabs group=unified_agent %}

- Docker image {#docker}

  1. Stop the `ua` container:

      ```bash
      sudo docker stop ua
      ```

  1. Delete the container:

      ```bash
      sudo docker rm ua
      ```

  1. [Run](./run-and-stop.md#run) the container.

- deb package {#deb}

  Re-download and [install](#setup) the latest deb package.

- Binary file {#binary}

  {% include [agent-update-binary](../../../../_includes/monitoring/agent-update-binary.md) %}

- When creating a VM {#vm}

  {% include [agent-update-binary](../../../../_includes/monitoring/agent-update-binary.md) %}

{% endlist %}


#### What's next {#what-is-next}

- [Learn how to run and stop {{ unified-agent-short-name }}](./run-and-stop.md)
- [Read about {{ unified-agent-short-name }} concepts](./index.md)
- [Learn more about configuring {{ unified-agent-short-name }}](./configuration.md)
- [Read the {{ unified-agent-short-name }} operating guidelines](./best-practices.md)
