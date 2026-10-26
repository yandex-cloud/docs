# Мониторинг потребления ресурсов

{% include [minitoc](minitoc/monitoring.md) %}

#### Как следить за потреблением vRAM через мониторинг? {#track-vRAM-use}

{{ compute-name }} получает метрики со стороны гипервизора: выделенный ВМ объем памяти не показывает, сколько памяти используют процессы внутри гостевой ОС.

Для сбора метрик памяти и занятого пространства файловых систем установите внутри ВМ [{{ unified-agent-short-name }}](../../monitoring/concepts/data-collection/unified-agent/installation.md) и настройте [поставку системных метрик Linux](../../monitoring/operations/unified-agent/linux_metrics.md) в {{ monitoring-name }}. Также можно [записывать пользовательские метрики через API](../../monitoring/operations/metric/add.md).
