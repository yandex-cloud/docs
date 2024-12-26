---
title: Системные требования
description: В этой статье описаны системные и программные требования к серверам.
---

# Системные требования

{% include [system-requirements](../_includes/speechkit/system-requirements.md) %}

{% include [licensing-server-requirements](../_includes/speechkit/licensing-server-requirements.md) %}

{% include [system-requirements-gpu](../_includes/speechkit/system-requirements-gpu.md) %}

## Программные требования {#software}

На выделенном для работы {{ sk-hybrid-name }} сервере должны быть установлены [драйверы NVIDIA LTS 535](https://www.nvidia.com/ru-ru/drivers/unix/) и [NVIDIA Container Toolkit 1.15](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html) или выше. Подробнее о драйверах см. в [официальной документации NVIDIA](https://docs.nvidia.com/datacenter/tesla/drivers/index.html#lifecycle). Устанавливать CUDA Toolkit не требуется, поскольку они входят в состав образов {{ sk-hybrid-name }}.

Для установки и настройки сервисов {{ sk-hybrid-name }} понадобятся [интерфейс командной строки {{ yandex-cloud }}](../cli/concepts/index.md) и реестр в [{{ container-registry-full-name }}](../container-registry/).

{% include [install-env](../_includes/speechkit/hybrid-env-install.md) %}
