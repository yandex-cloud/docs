---
title: "System requirements"
description: "This article describes system and software requirements for servers."
---

# System requirements

{% include [system-requirements](../_includes/speechkit/system-requirements.md) %}

{% include [system-requirements](../_includes/speechkit/system-requirements-gpu.md) %}

## Software requirements {#software}

A dedicated {{ sk-hybrid-name }} server should support [running CUDA® 11.4 containers and higher](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html#docker) and have the appropriate NVIDIA drivers installed. For more information on CUDA Toolkit requirements, see the [official NVIDIA documentation](https://docs.nvidia.com/cuda/cuda-toolkit-release-notes/index.html).

To install and configure {{ sk-hybrid-name }} services, you will need the {{ yandex-cloud }} CLI and a registry in {{ container-registry-full-name }}.

{% include [install-env](../_includes/speechkit/hybrid-env-install.md) %}
