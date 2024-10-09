---
title: Как записать метрики
description: Следуя данной инструкции, вы сможете записать метрики.
---

# Запись метрик


{% list tabs %}

- VK

  <iframe src="https://vk.com/video_ext.php?oid=-200452713&id=456239450&hash=8fa7722c8be1c400" width="640" height="360" frameborder="0" allowfullscreen="1" allow="autoplay; encrypted-media; fullscreen; picture-in-picture"></iframe><br>

- YouTube

  @[youtube](https://youtu.be/KjDtR_zysPM)

{% endlist %}




Если в вашем окружении есть инсталляция {{ prometheus-name }}, которая [собирает](https://prometheus.io/docs/prometheus/latest/configuration/configuration/#scrape_config) метрики, чтобы подключить {{ managed-prometheus-name }} в качестве [удаленного хранилища](https://prometheus.io/docs/prometheus/latest/storage/#remote-storage-integrations), настройте [запись](remote-write.md) метрик через Remote API. Иначе воспользуйтесь любым агентом для сбора метрик, поддерживающим протокол записи [Remote Write](https://prometheus.io/docs/prometheus/latest/configuration/configuration/#remote_write), например {{ prometheus-name }}, запущенным в [режиме агента](https://prometheus.io/docs/prometheus/latest/feature_flags/#prometheus-agent).

{% include [trademark](../../../../_includes/monitoring/trademark.md) %}
