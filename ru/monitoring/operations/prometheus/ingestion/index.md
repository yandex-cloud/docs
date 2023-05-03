# Запись метрик

{% include [note-preview](../../../../_includes/monitoring/prometheus-preview.md) %}

Если в вашем окружении есть инсталляция {{ prometheus-name }}, которая [собирает](https://prometheus.io/docs/prometheus/latest/configuration/configuration/#scrape_config) метрики, чтобы подключить {{ managed-prometheus-name }} в качестве [удаленного хранилища](https://prometheus.io/docs/prometheus/latest/storage/#remote-storage-integrations), настройте [запись](remote-write.md) метрик через Remote API. Иначе воспользуйтесь любым агентом для сбора метрик, поддерживающим протокол записи [Remote Write](https://prometheus.io/docs/prometheus/latest/configuration/configuration/#remote_write), например {{ prometheus-name }}, запущенным в [режиме агента](https://prometheus.io/docs/prometheus/latest/feature_flags/#prometheus-agent).

{% include [trademark](../../../../_includes/monitoring/trademark.md) %}
