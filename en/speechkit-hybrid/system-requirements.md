---
title: System requirements
description: This article describes system and software requirements for servers.
---

# System requirements

{% include [system-requirements](../_includes/speechkit/system-requirements.md) %}

{% include [licensing-server-requirements](../_includes/speechkit/licensing-server-requirements.md) %}

{% include [system-requirements-gpu](../_includes/speechkit/system-requirements-gpu.md) %}

## Software requirements {#software}

Your dedicated {{ sk-hybrid-name }} server must have [NVIDIA LTS 535 drivers](https://www.nvidia.com/en-us/drivers/unix/) and [NVIDIA Container Toolkit 1.15](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html) or higher. For more information about the drivers, see the [official NVIDIA documentation](https://docs.nvidia.com/datacenter/tesla/drivers/index.html#lifecycle). You do not need to install the CUDA Toolkit as it comes as part of {{ sk-hybrid-name }} images.

To install and configure {{ sk-hybrid-name }} services, you will need the [{{ yandex-cloud }} CLI](../cli/concepts/index.md) and a registry in [{{ container-registry-full-name }}](../container-registry/).

{% include [install-env](../_includes/speechkit/hybrid-env-install.md) %}
