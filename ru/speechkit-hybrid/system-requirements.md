---
title: "Системные требования"
description: "Для установки {{ sk-hybrid-name }} вам необходим сервер с ОС Linux, который поддерживает Docker Engine. Список поддерживаемых ОС см. в официальной документации Docker."
---

# Системные требования

{% include [system-requirements](../_includes/speechkit/system-requirements.md) %}

{% include [system-requirements](../_includes/speechkit/system-requirements-gpu.md) %}

## Программные требования {#software}

Выделенный для работы {{ sk-hybrid-name }} сервер должен поддерживать [запуск контейнеров на базе CUDA® 11.4 и выше](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html#docker) и должны быть установлены соответствующие драйверы NVIDIA. Подробнее о требованиях CUDA Toolkit см. в [официальной документации NVIDIA](https://docs.nvidia.com/cuda/cuda-toolkit-release-notes/index.html).

Для установки и настройки сервисов {{ sk-hybrid-name }} понадобятся интерфейс командной строки {{ yandex-cloud }} и реестр в {{ container-registry-full-name }}.

{% include [install-env](../_includes/speechkit/hybrid-env-install.md) %}
