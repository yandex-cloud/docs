# Навигация

#### Где посмотреть график RAM на виртуальной машине? {#ram-graphs-overview}

Сервис {{ compute-full-name }} не может измерить потребление vRAM внутри гостевой операционной системы: для сервиса потребление памяти ВМ всегда одинаковое — то, которое выделено в момент ее запуска.

Вы можете самостоятельно настроить сбор пользовательских метрик {% if audience == "external" %}[через API](../../monitoring/operations/metric/add.md){% endif %}{% if audience == "internal" %}через API{% endif %}, а для Linux-совместимых ОС — с помощью {% if audience == "external" %}[агента для поставки системных метрик](../../monitoring/operations/unified-agent/linux_metrics.md){% endif %}{% if audience == "internal" %}агента для поставки системных метрик{% endif %}.

#### Где посмотреть график места на диске ВМ? {#space-graphs-overview}

{{ monitoring-name }} не имеет доступа к гостевым ОС, поэтому такой метрики нет.

Вы можете самостоятельно настроить сбор пользовательских метрик {% if audience == "external" %}[через API](../../monitoring/operations/metric/add.md){% endif %}{% if audience == "internal" %}через API{% endif %}, а для Linux-совместимых ОС — с помощью {% if audience == "external" %}[агента для поставки системных метрик](../../monitoring/operations/unified-agent/linux_metrics.md){% endif %}{% if audience == "internal" %}агента для поставки системных метрик{% endif %}.