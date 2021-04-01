# Конфигурации вычислительных ресурсов

Сразу после создания проект запускается с минимальной конфигурацией вычислительных ресурсов — <q>S</q> (4 vCPU).
Вы можете [изменить конфигурацию](../operations/projects/control-compute-resources.md) в процессе работы в ноутбуке. При этом состояние интерпретатора сохранится: все переменные и результаты вычислений не потеряются.

**Доступные конфигурации вычислительных ресурсов:**

Имя | Количество vCPU на<br>[платформе Intel Broadwell](../../compute/concepts/performance-levels.md) | Количество GPU на<br>[платформе NVIDIA Tesla V100](../../compute/concepts/gpus.md).
---- | ---- | ----
**S** (по умолчанию) | 4 | 0
**M** | 8 | 0 
**L** | 8 | 1
**XL** | 32 | 4  

#### См. также

* [{#T}](../operations/projects/control-compute-resources.md)
* [{#T}](../../compute/concepts/performance-levels.md)
* [{#T}](../../compute/concepts/gpus.md)