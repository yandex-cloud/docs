---
title: Как записать метрики
description: Следуя данной инструкции, вы сможете записать метрики.
---

# Запись метрик


<iframe width="640" height="360" src="https://runtime.strm.yandex.ru/player/video/vplvw3emvkulllyhgtkf?autoplay=0&mute=0" allow="autoplay; fullscreen; picture-in-picture; encrypted-media" frameborder="0" scrolling="no"></iframe>

[Смотреть видео на YouTube](https://youtu.be/KjDtR_zysPM).



Если в вашем окружении есть инсталляция {{ prometheus-name }}, которая [собирает](https://prometheus.io/docs/prometheus/latest/configuration/configuration/#scrape_config) метрики, чтобы подключить {{ managed-prometheus-name }} в качестве [удаленного хранилища](https://prometheus.io/docs/prometheus/latest/storage/#remote-storage-integrations), настройте [запись](remote-write.md) метрик через Remote API. Иначе воспользуйтесь любым агентом для сбора метрик, поддерживающим протокол записи [Remote Write](https://prometheus.io/docs/prometheus/latest/configuration/configuration/#remote_write), например {{ prometheus-name }}, запущенным в [режиме агента](https://prometheus.io/docs/prometheus/latest/feature_flags/#prometheus-agent).

{% include [trademark](../../../../_includes/monitoring/trademark.md) %}
