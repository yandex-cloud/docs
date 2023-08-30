# Конфигурации вычислительных ресурсов

[В режиме {{ ds }}](project.md#serverless) сразу после создания проект запускается с минимальной конфигурацией вычислительных ресурсов — <q>c1.4</q> (4 vCPU). Вы можете [изменить конфигурацию](../operations/projects/control-compute-resources.md) в процессе работы в ноутбуке. При этом состояние интерпретатора сохранится: все переменные и результаты вычислений не потеряются.

[В режиме {{ dd }}](project.md#dedicated) можно выбрать конфигурацию из списка [разрешенных в сообществе](../operations/community/manage-community-config.md). 


{% include [configurations](../../_includes/datasphere/migration/configurations.md) %}

#### См. также

* [{#T}](../operations/projects/control-compute-resources.md)
* [{#T}](../../compute/concepts/performance-levels.md)
* [{#T}](../../compute/concepts/gpus.md)