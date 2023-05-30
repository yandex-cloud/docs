#### Квоты {#dataproc-quotas}

Виртуальные машины, из которых состоят кластеры сервиса {{ dataproc-name }}, расходуют [квоты]({{ link-console-quotas }}) вашего облака для сервиса {{ compute-full-name }}.

#### Лимиты {#dataproc-limits}

Вид ограничения | Значение
--- | ---
Минимальная конфигурация хоста | b2.medium (2 × [50%](../../compute/concepts/performance-levels.md) vCPU Intel Cascade Lake, 4 ГБ RAM)
Максимальная конфигурация хоста | s3-c96-m576 (96 vCPU Intel Ice Lake, 576 ГБ RAM)
Максимальное количество хостов в одном подкластере | 32
Максимальный объем хранилища для одного хоста на сетевых HDD- (`network-hdd`) или SSD-дисках (`network-ssd`) | 4096 ГБ
Максимальный объем хранилища для одного хоста на сетевых нереплицируемых дисках (`network-ssd-nonreplicated`) | 262 074 ГБ