[Документация Yandex Cloud](../../index.md) > [Yandex Compute Cloud](../index.md) > Вопросы и ответы > Мониторинг

# Мониторинг потребления ресурсов

* [Как следить за потреблением vRAM через мониторинг?](#track-vRAM-use)

#### Как следить за потреблением vRAM через мониторинг? {#track-vRAM-use}

Compute Cloud получает метрики со стороны гипервизора: выделенный ВМ объем памяти не показывает, сколько памяти используют процессы внутри гостевой ОС.

Для сбора метрик памяти и занятого пространства файловых систем установите внутри ВМ [Unified Agent](../../monitoring/concepts/data-collection/unified-agent/installation.md) и настройте [поставку системных метрик Linux](../../monitoring/operations/unified-agent/linux_metrics.md) в Monitoring. Также можно [записывать пользовательские метрики через API](../../monitoring/operations/metric/add.md).