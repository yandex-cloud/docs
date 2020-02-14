# Список доступных конфигураций виртуальных машин

Проект всегда запускается на виртуальной машине с минимальной конфигурацией <q>S</q> (2 vCPU).

Вы можете [мигрировать на ВМ с другой конфигурацией](../operations/projects/control-compute-resources.md) в процессе работы в ноутбуке. При миграции сохранится состояние интерпретатора: все переменные и результаты вычислений не потеряются.

**Доступные конфигурации виртуальных машин:**

Имя | Количество vCPU на<br>[платформе Intel Broadwell](../../compute/concepts/performance-levels.md) | Количество GPU на<br>[платформе NVIDIA Tesla V100](../../compute/concepts/gpus.md).
---- | ---- | ----
**S** | 4 | 0
**L** | 8 | 1

#### См. также

* [{#T}](../operations/projects/control-compute-resources.md)
* [{#T}](../../compute/concepts/performance-levels.md)
* [{#T}](../../compute/concepts/gpus.md)