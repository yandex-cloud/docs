# Запись метрик


<iframe width="640" height="360" src="https://runtime.strm.yandex.ru/player/video/vplvw3emvkulllyhgtkf?autoplay=0&mute=0" allow="autoplay; fullscreen; picture-in-picture; encrypted-media" frameborder="0" scrolling="no"></iframe>

[Смотреть видео на YouTube](https://youtu.be/KjDtR_zysPM).



Если в вашем окружении есть инсталляция Prometheus, которая [собирает](https://prometheus.io/docs/prometheus/latest/configuration/configuration/#scrape_config) метрики, вы можете подключить Yandex Managed Service for Prometheus® в качестве [удаленного хранилища](https://prometheus.io/docs/prometheus/latest/storage/#remote-storage-integrations). Для этого настройте [запись](remote-write.md) метрик через Remote API. 

Иначе воспользуйтесь любым агентом для сбора метрик, поддерживающим протокол записи [Remote Write](https://prometheus.io/docs/prometheus/latest/configuration/configuration/#remote_write), например Prometheus, запущенным в [режиме агента](https://prometheus.io/docs/prometheus/latest/feature_flags/#prometheus-agent).

Также при развертывании ВМ Linux вы можете [установить Unified Agent](prometheus-agent.md) для сбора метрик в формате Prometheus.

_© 2025 Linux Foundation. Все права защищены. Linux Foundation зарегистрировала товарные знаки и использует товарные знаки. Список товарных знаков Linux Foundation смотрите на странице [Trademark Usage](https://www.linuxfoundation.org/legal/trademark-usage)._