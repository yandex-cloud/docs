Имя метрики пишется в метку `name`.

Общие метки для всех метрик сервиса {{ mmg-name }}: 

Метка | Значение
----|----
service | Идентификатор сервиса: `managed-mongodb`
resource_type | Тип ресурса: `cluster`
resource_id | Идентификатор кластера
host | FQDN хоста
node | Тип хоста: `primary`, `secondary`
shard | Идентификатор шарда

## Метрики CPU {#managed-mongodb-cpu-metrics}
Загрузка процессорных ядер.

| Имя<br/>Тип, единицы измерения | Описание |
| ----- | ----- |
| `cpu.fraction`<br/>`DGAUGE`, % | Гарантированная доля vCPU. | 
| `cpu.guarantee`<br/>`DGAUGE`, штуки | Гарантированное число ядер. | 
| `cpu.guest_nice`<br/>`DGAUGE`, % | Использование процессорных ядер, тип потребления `guest_nice`. | 
| `cpu.limit`<br/>`DGAUGE`, штуки | Предельное число используемых ядер. | 
| `cpu.guest`<br/>`DGAUGE`, % | Использование процессорных ядер, тип потребления `guest`. | 
| `cpu.idle`<br/>`DGAUGE`, % | Использование процессорных ядер, тип потребления `idle`. | 
| `cpu.iowait`<br/>`DGAUGE`, % | Использование процессорных ядер, тип потребления `iowait`. | 
| `cpu.irq`<br/>`DGAUGE`, % | Использование процессорных ядер, тип потребления `irq`. | 
| `cpu.nice`<br/>`DGAUGE`, % | Использование процессорных ядер, тип потребления `nice`. | 
| `cpu.softirq`<br/>`DGAUGE`, % | Использование процессорных ядер, тип потребления `softirq`. | 
| `cpu.steal`<br/>`DGAUGE`, % | Использование процессорных ядер, тип потребления `steal`. | 
| `cpu.system`<br/>`DGAUGE`, % | Использование процессорных ядер, тип потребления `system`. | 
| `cpu.user`<br/>`DGAUGE`, % | Использование процессорных ядер, тип потребления `user`. |
| `cpu_utilization_by_db_15`<br/>`DGAUGE`, % | Средняя утилизация процессорных ядер ВМ (vCPU) базой данных в процентах за 15 секунд. Принимает значения от 0% до [уровня производительности vCPU](../../../compute/concepts/performance-levels.md). | 
| `cpu_utilization_by_db_15_limit`<br/>`DGAUGE`, % | Предельная утилизация процессорных ядер ВМ (vCPU) базой данных в процентах за 15 секунд. | 
| `cpu_utilization_by_db_60`<br/>`DGAUGE`, % | Средняя утилизация процессорных ядер ВМ (vCPU) базой данных в процентах за 60 секунд. | 
| `cpu_utilization_by_db_60_limit`<br/>`DGAUGE`, % | Предельная утилизация процессорных ядер ВМ (vCPU) базой данных в процентах за 60 секунд. |

## Метрики диска {#managed-mongodb-disk-metrics}
| Имя<br/>Тип, единицы измерения | Описание |
| ----- | ----- |
| `disk.free_bytes`<br/>`DGAUGE`, байты | Свободное место. | 
| `disk.free_inodes`<br/>`DGAUGE`, штуки | Свободное количество inodes. | 
| `disk.total_bytes`<br/>`DGAUGE`, байты | Доступное место. | 
| `disk.total_inodes`<br/>`DGAUGE`, штуки | Доступное количество inodes. | 
| `disk.used_bytes`<br/>`DGAUGE`, байты | Занятое место. | 
| `disk.used_inodes`<br/>`DGAUGE`, штуки | Занятое количество inodes. |
| `load.avg_15min`<br/>`DGAUGE`, % | Средняя нагрузка за 15 минут. | 
| `load.avg_1min`<br/>`DGAUGE`, % | Средняя нагрузка за 1 минуту. | 
| `load.avg_5min`<br/>`DGAUGE`, % | Средняя нагрузка за 5 минут. |

## Метрики дисковых операций {#managed-mongodb-diskio-metrics}
| Имя<br/>Тип, единицы измерения | Описание |
| ----- | ----- |
| `io.disk*.iops_in_progress`<br/>`DGAUGE`, штуки | Количество незавершенных дисковых операций. | 
| `io.disk*.merged_reads`<br/>`DGAUGE`, штуки | Количество слитых операций чтения с конкретного диска. | 
| `io.disk*.merged_writes`<br/>`DGAUGE`, штуки | Количество слитых операций записи на конкретный диск. | 
| `io.disk*.read_bytes`<br/>`DGAUGE`, байт/с | Скорость чтения с конкретного диска. | 
| `io.disk*.read_count`<br/>`DGAUGE`, операций/с | Количество операций чтения с конкретного диска в секунду. | 
| `io.disk*.read_time`<br/>`DGAUGE`, миллисекунды | Среднее время чтения с конкретного диска. |
| `io.disk*.utilization`<br/>`DGAUGE`, % | Использование конкретного диска. Не работает для сетевых дисков. | 
| `io.disk*.weighted_io_time`<br/>`DGAUGE`, миллисекунды | Длительность ожидания операций ввода/вывода на конкретном диске. | 
| `io.disk*.write_bytes`<br/>`DGAUGE`, байт/с | Скорость записи на конкретный диск. | 
| `io.disk*.write_count`<br/>`DGAUGE`, операций/с | Количество операций записи на конкретный диск в секунду. | 
| `io.disk*.write_time`<br/>`DGAUGE`, миллисекунды | Среднее время записи на конкретный диск. | 

## Метрики RAM {#managed-mongodb-ram-metrics}
| Имя<br/>Тип, единицы измерения | Описание |
| ----- | ----- |
| `mem.active_bytes`<br/>`DGAUGE`, байты | Объем оперативной памяти, которая используется наиболее часто и освобождается только в крайнем случае. | 
| `mem.available_bytes`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `available`. | 
| `mem.available_percent_bytes`<br/>`DGAUGE`, % | Доля использования оперативной памяти, тип потребления `available`. | 
| `mem.buffers_bytes`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `buffers`. | 
| `mem.cached_bytes`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `cached`. | 
| `mem.commit_limit_bytes`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `commit_limit`. | 
| `mem.committed_as_bytes`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `committed_as`. | 
| `mem.dirty_bytes`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `dirty`. | 
| `mem.free_bytes`<br/>`DGAUGE`, байты | Объем свободной оперативной памяти, доступной для использования, без учета `mem.buffers_bytes` и `mem.cached_bytes`. |
| `mem.high_free_bytes`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `high_free`. | 
| `mem.high_total_bytes`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `high_total`. | 
| `mem.huge_page_size_bytes`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `huge_page_size`. | 
| `mem.huge_pages_free_bytes`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `huge_pages_free`. | 
| `mem.huge_pages_total_bytes`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `huge_pages_total`. | 
| `mem.inactive_bytes`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `inactive`. | 
| `mem.low_free_bytes`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `low_free`. | 
| `mem.low_total_bytes`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `low_total`. | 
| `mem.mapped_bytes`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `mapped`. | 
| `mem.page_tables_bytes`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `page_tables`. | 
| `mem.slab_bytes`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `slab`. | 
| `mem.sreclaimable_bytes`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `sreclaimable`. | 
| `mem.sunreclaim_bytes`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `sunreclaim`. | 
| `mem.swap_cached_bytes`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `swap_cached`. | 
| `mem.swap_free_bytes`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `swap_free`. | 
| `mem.swap_total_bytes`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `swap_total`. | 
| `mem.shared_bytes`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `shared`. | 
| `mem.total_bytes`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `total`. | 
| `mem.used_bytes`<br/>`DGAUGE`, байты | Объем оперативной памяти, которую в данный момент используют запущенные процессы. | 
| `mem.used_percent_bytes`<br/>`DGAUGE`, % | Процент использованной оперативной памяти. | 
| `mem.vmalloc_chunk_bytes`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `vmalloc_chunk`. | 
| `mem.vmalloc_total_bytes`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `vmalloc_total`. | 
| `mem.vmalloc_used_bytes`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `vmalloc_used`. | 
| `mem.write_back_bytes`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `write_back`. | 
| `mem.write_back_tmp_bytes`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `write_back_tmp`. |

## Метрики сети {#managed-mongodb-net-metrics}
| Имя<br/>Тип, единицы измерения | Описание |
| ----- | ----- |
| `net.bytes_recv`<br/>`DGAUGE`, байт/с | Скорость получения данных по сети. | 
| `net.bytes_sent`<br/>`DGAUGE`, байт/с | Скорость отправки данных по сети. | 
| `net.drop_in`<br/>`DGAUGE`, штуки | Количество пакетов, отброшенных при получении. | 
| `net.drop_out`<br/>`DGAUGE`, штуки | Количество пакетов, отброшенных при отправке. | 
| `net.err_in`<br/>`DGAUGE`, штуки | Количество ошибок при получении. | 
| `net.err_out`<br/>`DGAUGE`, штуки | Количество ошибок при отправке. | 
| `net.packets_recv`<br/>`DGAUGE`, пакетов/с | Интенсивность получения данных по сети. | 
| `net.packets_sent`<br/>`DGAUGE`, пакетов/с | Интенсивность отправки данных по сети. | 

## Метрики dbStats {#managed-mongodb-dbstats-metrics}

| Имя<br/>Тип, единицы измерения | Описание |
| ----- | ----- |
| `db_stats_dataSize`<br/>`DGAUGE`, байты | Размер несжатых данных в базе. | 
| `db_stats_indexSize`<br/>`DGAUGE`, байты | Размер места, занимаемого индексами базы. | 
| `db_stats_config_dataSize`<br/>DGAUGE, байты | Размер несжатых данных конфигурационной базы. |
| `db_stats_config_indexSize`<br/>DGAUGE, байты | Размер места, занимаемого индексами конфигурационной базы. |
| `db_stats_local_dataSize`<br/>DGAUGE, байты | Размер несжатых данных локальной базы. |
| `db_stats_local_indexSize`<br/>DGAUGE, байты | Размер места, занимаемого индексами локальной базы. |
| `db_stats_mdb_internal_dataSize`<br/>DGAUGE, байты | Размер несжатых данных внутренней базы. |
| `db_stats_mdb_internal_indexSize`<br/>DGAUGE, байты | Размер места, занимаемого индексами внутренней базы. |

## Метрики сервиса {#managed-mongodb-metrics}
| Имя<br/>Тип, единицы измерения | Описание |
| ----- | ----- |
| `active`<br/>`DGAUGE`, штуки | Объем оперативной памяти, которая используется наиболее часто и освобождается только в крайнем случае. |
| `available`<br/>`DGAUGE`, штуки | Использование оперативной памяти, тип потребления `available`. |
| `available_percent`<br/>`DGAUGE`, % | Доля использования оперативной памяти, тип потребления `available`. |
| `buffered`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `buffered`. |
| `bytes_recv`<br/>`DGAUGE`, байты | Размер полученных данных. |
| `bytes_sent`<br/>`DGAUGE`, байты | Размер отправленных данных. |
| `cached`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `cached`. |
| `commit_limit`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `commit_limit`. |
| `committed_as`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `committed_as`. |
| `dirty`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `dirty`. | 
| `drop_in`<br/>`DGAUGE`, штуки | Количество пакетов, отброшенных при получении. | 
| `drop_out`<br/>`DGAUGE`, штуки | Количество пакетов, отброшенных при отправке. | 
| `err_in`<br/>`DGAUGE`, штуки | Количество ошибок при получении. | 
| `err_out`<br/>`DGAUGE`, штуки | Количество ошибок при отправке. | 
| `free`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `free`. | 
| `high_free`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `high_free`. | 
| `high_total`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `high_total`. | 
| `huge_page_size`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `huge_page_size`. | 
| `huge_pages_free`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `huge_pages_free`. | 
| `huge_pages_total`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `huge_pages_total`. | 
| `icmp_inaddrmasks`<br/>`DGAUGE`, штуки | Количество полученных сообщений с запросом маски ICMP-адреса. | 
| `icmp_incsumerrors`<br/>`DGAUGE`, штуки | Общее количество IP-пакетов с ошибками контрольной суммы. | 
| `icmp_indestunreachs`<br/>`DGAUGE`, штуки | Количество полученных сообщений о недоступности назначения ICMP. | 
| `icmp_inechoreps`<br/>`DGAUGE`, штуки | Количество полученных ICMP-сообщений Echo Reply. | 
| `icmp_inechos`<br/>`DGAUGE`, штуки | Количество полученных ICMP-сообщений Echo (запросов). | 
| `icmp_inerrors`<br/>`DGAUGE`, штуки | Количество полученных ICMP-пакетов с ошибками, не включая ошибки контрольной суммы.  | 
| `icmp_inmsgs`<br/>`DGAUGE`, штуки | Общее количество полученных ICMP-сообщений.  | 
| `icmp_inparmprobs`<br/>`DGAUGE`, штуки | Количество полученных сообщений о неполадках с параметрами ICMP. | 
| `icmp_inredirects`<br/>`DGAUGE`, штуки | Количество полученных сообщений о перенаправлении ICMP. | 
| `icmp_insrcquenchs`<br/>`DGAUGE`, штуки | Количество полученных сообщений о неполадках с параметрами ICMP. | 
| `icmp_intimeexcds`<br/>`DGAUGE`, штуки | Количество полученных сообщений с превышением времени ICMP превысило количество полученных сообщений. | 
| `icmp_intimestampreps`<br/>`DGAUGE`, штуки | Количество полученных ответных сообщений с меткой времени ICMP. | 
| `icmp_intimestamps`<br/>`DGAUGE`, штуки | Количество полученных сообщений (запросов) с меткой времени ICMP. | 
| `icmp_outaddrmaskreps`<br/>`DGAUGE`, штуки | Количество отправленных ответных сообщений по маске ICMP-адреса. | 
| `icmp_outaddrmasks`<br/>`DGAUGE`, штуки | Количество отправленных сообщений с запросом маски ICMP-адреса. | 
| `icmp_outdestunreachs`<br/>`DGAUGE`, штуки | Количество отправленных сообщений о недоступности назначения ICMP. | 
| `icmp_outechoreps`<br/>`DGAUGE`, штуки | Количество отправленных ICMP-сообщений Echo Reply. | 
| `icmp_outechos`<br/>`DGAUGE`, штуки | Количество отправленных ICMP-сообщений Echo (запросов). | 
| `icmp_outerrors`<br/>`DGAUGE`, штуки | Количество ICMP-сообщений, которые этот объект не отправил из-за проблем, обнаруженных в ICMP, таких как нехватка буферов. | 
| `icmp_outmsgs`<br/>`DGAUGE`, штуки | Общее количество ICMP-сообщений, которые пытался отправить этот объект. Включает все сообщения, подсчитанные `icmp_outerrors`. |
| `icmp_outparmprobs`<br/>`DGAUGE`, штуки | Количество отправленных сообщений о проблемах с параметрами ICMP. | 
| `icmp_outredirects`<br/>`DGAUGE`, штуки | Количество отправленных сообщений с перенаправлениями маршрута.  | 
| `icmp_outsrcquenchs`<br/>`DGAUGE`, штуки | Количество отправленных сообщений Source Quench по протоколу ICMP. |
| `icmp_outtimeexcds`<br/>`DGAUGE`, штуки | Количество отправленных сообщений с превышением времени ICMP превысило количество отправленных сообщений. | 
| `icmp_outtimestampreps`<br/>`DGAUGE`, штуки | Количество отправленных ответных сообщений с меткой времени ICMP. | 
| `icmp_outtimestamps`<br/>`DGAUGE`, штуки | Количество отправленных сообщений с меткой времени ICMP.  | 
| `inactive`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `inactive`. | 
| `inodes_free`<br/>`DGAUGE`, штуки | Свободное количество inodes. | 
| `inodes_total`<br/>`DGAUGE`, штуки | Доступное количество inodes. | 
| `inodes_used`<br/>`DGAUGE`, штуки | Занятое количество inodes. |
| `instance_userfault_broken`<br/>`DGAUGE`, штуки | Количество ошибок в операциях с памятью. |
| `iops_in_progress`<br/>`DGAUGE`, штуки | Количество незавершенных дисковых операций. | 
| `ip_defaultttl`<br/>`DGAUGE`, строка | Значение по умолчанию, вставляемое в поле Time-To-Live заголовка IP-пакетов, созданных в этом объекте, когда значение TTL не предоставляется протоколом транспортного уровня. | 
| `ip_forwarding`<br/>`DGAUGE` | Состояние пересылки IP (в сетевом протоколе SNMP) (`0` — отключено, `1` — включено).  | 
| `ip_forwdatagrams`<br/>`DGAUGE`, штуки | Количество входящих пакетов, для которых этот объект не был их конечным IP-адресатом, в результате чего была предпринята попытка найти маршрут для пересылки их в этот конечный пункт назначения. В объектах, которые не действуют как IP-маршрутизаторы, этот счетчик будет включать только те пакеты, которые были перенаправлены источником через этот объект, и обработка параметра исходного маршрута прошла успешно. | 
| `ip_fragcreates`<br/>`DGAUGE`, штуки | Количество фрагментов IP-пакетов, которые были сгенерированы в результате фрагментации в этом объекте. | 
| `ip_fragfails`<br/>`DGAUGE`, штуки | Количество IP-пакетов, которые были отброшены, поскольку они должны были быть фрагментированы в этом объекте, но не могли быть фрагментированы, например, потому что был установлен флаг, запрещающий фрагментацию. | 
| `ip_fragoks`<br/>`DGAUGE`, штуки | Количество успешных фрагментаций IP-пакетов.  | 
| `ip_inaddrerrors`<br/>`DGAUGE`, штуки | Количество входящих пакетов, отброшенных из-за того, что IP-адрес в поле назначения их IP-заголовка не был допустимым адресом для получения в этом объекте. Это количество включает недопустимые адреса (например, `0.0.0.0`) и адреса неподдерживаемых классов (например, класс E). Для объектов, которые не являются IP-маршрутизаторами и, следовательно, не пересылают пакеты, этот счетчик включает пакеты, отброшенные из-за того, что адрес назначения не был локальным адресом. | 
| `ip_indelivers`<br/>`DGAUGE`, штуки | Общее количество доставленных IP-пакетов.  | 
| `ip_indiscards`<br/>`DGAUGE`, штуки | Количество входящих IP-пакетов, для которых не возникло проблем, препятствующих их дальнейшей обработке, но которые были отброшены (например, из-за нехватки места в буфере). Этот счетчик не включает в себя пакеты, отброшенные в ожидании повторной сборки. | 
| `ip_inhdrerrors`<br/>`DGAUGE`, штуки | Количество входящих пакетов с ошибками в заголовке.  | 
| `ip_inreceives`<br/>`DGAUGE`, штуки | Общее количество входящих пакетов, полученных от интерфейсов, включая полученные по ошибке. | 
| `ip_inunknownprotos`<br/>`DGAUGE`, штуки | Количество полученных пакетов с неизвестными протоколами.  | 
| `ip_outdiscards`<br/>`DGAUGE`, штуки | Количество выходящих IP-пакетов, для которых не возникло проблем, препятствующих их передаче по назначению, но которые были отброшены (например, из-за нехватки места в буфере). Обратите внимание, что этот счетчик включал бы пакеты, подсчитанные в `ip_forwdatagrams`, если бы такие пакеты удовлетворяли этому (дискреционному) критерию отбрасывания. | 
| `ip_outnoroutes`<br/>`DGAUGE`, штуки | Количество отброшенных IP-пакетов, для которых не удалось найти маршрут для их передачи по назначению. Этот счетчик включает все пакеты, подсчитанные в `ip_forwdatagrams`, которые соответствуют критерию «без маршрута». Сюда входят любые пакеты, которые хост не может перенаправить, поскольку все его маршрутизаторы по умолчанию не работают. | 
| `ip_outrequests`<br/>`DGAUGE`, штуки | Общее количество IP-пакетов, которые локальные пользовательские протоколы IP (включая ICMP) передали IP в запросах на передачу. Этот счетчик не включает в себя пакеты, подсчитанные в `ip_forwdatagrams`. | 
| `ip_reasmfails`<br/>`DGAUGE`, штуки | Количество сбоев, обнаруженных алгоритмом повторной сборки IP (по любой причине: тайм-аут, ошибки и т.д.). Это не обязательно количество отброшенных IP-фрагментов, поскольку некоторые алгоритмы (в частности, алгоритм в RFC 815) могут потерять отслеживание количества фрагментов, объединяя их по мере их получения. | 
| `ip_reasmoks`<br/>`DGAUGE`, штуки | Количество IP-пакетов, успешно собранных повторно. | 
| `ip_reasmreqds`<br/>`DGAUGE`, штуки | Количество полученных IP-фрагментов, которые необходимо было повторно собрать в этом объекте. | 
| `ip_reasmtimeout`<br/>`DGAUGE`, секунды | Максимальное количество секунд, в течение которых удерживаются полученные фрагменты, пока они ожидают повторной сборки в этом объекте. | 
| `low_free`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `low_free`. | 
| `low_total`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `low_total`. | 
| `mapped`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `mapped`. | 
| `memory_utilization_by_db_percent`<br/>`DGAUGE`, % | Утилизация памяти БД. | 
| `memory_utilization_by_db_percent_limit`<br/>`DGAUGE`, % | Ограничение утилизации памяти БД. | 
| `memory_utilization_by_db_rss`<br/>`DGAUGE`, байты | Общий объем памяти, занимаемый процессами БД. | 
| `merged_reads`<br/>`DGAUGE`, штуки | Количество слитых операций чтения с дисков. | 
| `merged_writes`<br/>`DGAUGE`, штуки | Количество слитых операций записи на диски. | 
| `mongod-is_alive`<br/>`DGAUGE` | Показатель работоспособности хоста.<br/>Принимает значение `1`, если хост БД работает, `0`, если нет. | 
| `n_cpus`<br/>`DGAUGE`, штуки | Предельное число используемых ядер. | 
| `n_users`<br/>`DGAUGE`, штуки | Предельное число пользователей. | 
| `packets_recv`<br/>`DGAUGE`, пакетов/с | Интенсивность получения данных по сети. | 
| `packets_sent`<br/>`DGAUGE`, пакетов/с | Интенсивность отправки данных по сети. | 
| `page_tables`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `page_tables`. | 
| `read_bytes`<br/>`DGAUGE`, байт/с | Скорость чтения с конкретного диска. | 
| `read_count`<br/>`DGAUGE`, операций/с | Количество операций чтения с конкретного диска в секунду. | 
| `read_time`<br/>`DGAUGE`, миллисекунды | Среднее время чтения с дисков. | 
| `shared`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `shared`. | 
| `slab`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `slab`. | 
| `sreclaimable`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `sreclaimable`. | 
| `sunreclaim`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `sunreclaim`. | 
| `swap_cached`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `swap_cached`. | 
| `swap_free`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `swap_free`. | 
| `swap_total`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `swap_total`. | 
| `tcp_activeopens`<br/>`DGAUGE`, штуки | Количество раз, когда TCP-соединения совершали прямой переход из состояния `CLOSED` в состояние `SYN-SENT`. | 
| `tcp_attemptfails`<br/>`DGAUGE`, штуки | Количество раз, когда TCP-соединения совершали прямой переход в состояние `CLOSED` либо из состояния `SYN-SENT`, либо из состояния `SYN-RCVD`, плюс количество раз, когда TCP-соединения совершали прямой переход. | 
| `tcp_currestab`<br/>`DGAUGE`, штуки | Текущее количество TCP-соединений для состояния `ESTABLISHED` или `CLOSE WAIT`. | 
| `tcp_estabresets`<br/>`DGAUGE`, штуки | Количество раз, когда TCP-соединения совершали прямой переход в состояние `CLOSED` либо из состояния `ESTABLISHED`, либо из состояния `CLOSE-WAIT`. | 
| `tcp_incsumerrors`<br/>`DGAUGE`, штуки | Увеличивается, когда полученный TCP-пакет имеет неправильную контрольную сумму. | 
| `tcp_inerrs`<br/>`DGAUGE`, штуки | Общее количество сегментов, полученных с ошибкой (например, неверные контрольные суммы TCP). |
| `tcp_insegs`<br/>`DGAUGE`, штуки | Общее количество полученных сегментов, включая те, которые были получены по ошибке. | 
| `tcp_maxconn`<br/>`DGAUGE`, штуки | Максимальное количество допустимых TCP-соединений.  | 
| `tcp_outrsts`<br/>`DGAUGE`, штуки | Количество отправленных TCP-сегментов, содержащих флаг `RST`. |
| `tcp_outsegs`<br/>`DGAUGE`, штуки | Общее количество отправленных TCP-сегментов.  | 
| `tcp_passiveopens`<br/>`DGAUGE`, штуки | Количество раз, когда TCP-соединения осуществляли прямой переход в состояние `SYN-RCVD` из состояния `LISTEN`. | 
| `tcp_retranssegs`<br/>`DGAUGE`, штуки | Общее количество повторно переданных сегментов, то есть количество переданных TCP-сегментов, содержащих один или несколько ранее переданных октетов. | 
| `tcp_rtoalgorithm`<br/>`DGAUGE` | Алгоритм, используемый для определения значения тайм-аута, используемого для повторной передачи неподтвержденных октетов. |
| `tcp_rtomax`<br/>`DGAUGE`, миллисекунды | Максимальное значение, разрешенное реализацией TCP для времени ожидания повторной передачи, измеряемое в миллисекундах. | 
| `tcp_rtomin`<br/>`DGAUGE`, миллисекунды | Минимальное значение, разрешенное реализацией TCP для времени ожидания повторной передачи, измеряемое в миллисекундах. | 
| `total`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `total`. | 
| `udp_ignoredmulti`<br/>`DGAUGE`, штуки | Для многоадресной рассылки UDP. | 
| `udp_incsumerrors`<br/>`DGAUGE`, штуки | Увеличивается, когда полученный UDP-пакет содержит недопустимую контрольную сумму кода ядра. | 
| `udp_indatagrams`<br/>`DGAUGE`, штуки | Общее количество принятых UDP-пакетов.  | 
| `udp_inerrors`<br/>`DGAUGE`, штуки | Количество полученных UDP-пакетов с ошибками, не включая ошибки контрольной суммы.  | 
| `udp_noports`<br/>`DGAUGE`, штуки | Общее количество полученных UDP-пакетов, для которых на порту назначения не было приложения.  | 
| `udp_outdatagrams`<br/>`DGAUGE`, штуки | Общее количество UDP-пакетов, отправленных от этого объекта. | 
| `udp_rcvbuferrors`<br/>`DGAUGE`, штуки | Количество ошибок буфера приема UDP.  | 
| `udp_sndbuferrors`<br/>`DGAUGE`, штуки | Количество ошибок буфера отправки UDP.  | 
| `udplite_ignoredmulti`<br/>`DGAUGE`, штуки | Для многоадресной рассылки UDP-Lite.  | 
| `udplite_incsumerrors`<br/>`DGAUGE`, штуки | Увеличивается, когда полученный пакет UDP-Lite содержит недопустимую контрольную сумму кода ядра.  | 
| `udplite_indatagrams`<br/>`DGAUGE`, штуки | Общее количество принятых пакетов UDP-Lite.  | 
| `udplite_inerrors`<br/>`DGAUGE`, штуки | Общее количество ошибок при получении пакетов UDP-Lite.  | 
| `udplite_noports`<br/>`DGAUGE`, штуки | Общее количество принятых пакетов UDP Lite, для которых на порте назначения не было слушателя. Перебои в значении этого счетчика могут возникать при повторной инициализации системы управления и в другое время, на что указывает значение `udplite_statsdiscontinuitytime`. | 
| `udplite_outdatagrams`<br/>`DGAUGE`, штуки | Общее количество отправленных датаграмм UDP-Lite.  | 
| `udplite_rcvbuferrors`<br/>`DGAUGE`, штуки | Количество ошибок буфера приема UDP-Lite.  | 
| `udplite_sndbuferrors`<br/>`DGAUGE`, штуки | Увеличивается, когда память не может быть выделена для отправки пакета UDP Lite. | 
| `uptime`<br/>`DGAUGE`, % | Коэффициент отказоустойчивости. | 
| `usage_guest`<br/>`DGAUGE`, % | Использование процессорных ядер, тип потребления `guest`. | 
| `usage_guest_nice`<br/>`DGAUGE`, % | Использование процессорных ядер, тип потребления `guest_nice`. | 
| `usage_idle`<br/>`DGAUGE`, % | Использование процессорных ядер, тип потребления `idle`. | 
| `usage_iowait`<br/>`DGAUGE`, % | Использование процессорных ядер, тип потребления `iowait`. | 
| `usage_irq`<br/>`DGAUGE`, % | Использование процессорных ядер, тип потребления `irq`. | 
| `usage_nice`<br/>`DGAUGE`, % | Использование процессорных ядер, тип потребления `nice`. | 
| `usage_softirq`<br/>`DGAUGE`, % | Использование процессорных ядер, тип потребления `softirq`. | 
| `usage_steal`<br/>`DGAUGE`, % | Использование процессорных ядер, тип потребления `steal`. | 
| `usage_system`<br/>`DGAUGE`, % | Использование процессорных ядер, тип потребления `system`. | 
| `usage_user`<br/>`DGAUGE`, % | Использование процессорных ядер, тип потребления `user`. | 
| `used`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `used`. | 
| `used_percent`<br/>`DGAUGE`, % | Доля использования оперативной памяти, тип потребления `used`. | 
| `utilization`<br/>`DGAUGE`, % | Средняя утилизация процессорных ядер ВМ (vCPU) базой данных. | 
| `vmalloc_chunk`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `vmalloc_chunk`. | 
| `vmalloc_total`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `vmalloc_total`. | 
| `vmalloc_used`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `vmalloc_used`. | 
| `weighted_io_time`<br/>`DGAUGE`, миллисекунды | Длительность ожидания операций ввода/вывода. | 
| `write_back`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `write_back`. | 
| `write_back_tmp`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `write_back_tmp`. |
| `write_bytes`<br/>`DGAUGE`, байт/с | Скорость записи на диски. | 
| `write_count`<br/>`DGAUGE`, операций/с | Количество операций записи в секунду. | 
| `write_time`<br/>`DGAUGE`, миллисекунды | Среднее время записи на диски. | 

#### Метрики serverStatus {#managed-mongodb-serverstatus-metrics}
| Имя<br/>Тип, единицы измерения | Описание |
| ----- | ----- |
| `server_status_admin_asserts.msg_rate`<br/>`DGAUGE`, штуки | Прирост срабатываний ассертов сообщений за секунду. | 
| `server_status_admin_asserts.regular_rate`<br/>`DGAUGE`, штуки | Прирост срабатываний регулярных ассертов за секунду. | 
| `server_status_admin_asserts.user_rate`<br/>`DGAUGE`, штуки | Прирост срабатываний пользовательский ассертов за секунду. | 
| `server_status_admin_connections.available`<br/>`DGAUGE`, штуки | Количество доступных для использования соединений. | 
| `server_status_admin_connections.current`<br/>`DGAUGE`, штуки | Количество входящих соединений с БД. | 
| `server_status_admin_extra_info.page_faults_rate`<br/>`DGAUGE`, штуки | Количество [отказов страниц](https://ru.wikipedia.org/wiki/Отказ_страницы). | 
| `server_status_admin_globalLock.currentQueue.readers`<br/>`DGAUGE`, штуки | Количество операций в очереди операций, ожидающих снятия блокировки на чтение. | 
| `server_status_admin_globalLock.currentQueue.writers`<br/>`DGAUGE`, штуки | Количество операций в очереди операций, ожидающих снятия блокировки на запись. | 
| `server_status_admin_metrics.cursor.open.noTimeout`<br/>`DGAUGE`, штуки | Количество открытых курсоров с настройкой `DBQuery.Option.noTimeout` для предотвращения таймаута в случае неактивности. | 
| `server_status_admin_metrics.cursor.open.pinned`<br/>`DGAUGE`, штуки | Количество закрепленных открытых курсоров. | 
| `server_status_admin_metrics.cursor.open.total`<br/>`DGAUGE`, штуки | Количество открытых курсоров. | 
| `server_status_admin_metrics.document.deleted_rate`<br/>`DGAUGE`, штуки | Прирост удаленных документов за секунду. | 
| `server_status_admin_metrics.document.inserted_rate`<br/>`DGAUGE`, штуки | Прирост вставленных документов за секунду. | 
| `server_status_admin_metrics.document.returned_rate`<br/>`DGAUGE`, штуки | Прирост возвращенных документов за секунду. | 
| `server_status_admin_metrics.document.updated_rate`<br/>`DGAUGE`, штуки | Прирост обновленных документов за секунду. | 
| `server_status_admin_metrics.getLastError.wtime.totalMillis_rate`<br/>`DGAUGE`, миллисекунды | Прирост миллисекунд, которое БД потратила в ожидании подтверждения успешной записи, за секунду. | 
| `server_status_admin_metrics.operation.scanAndOrder_rate`<br/>`DGAUGE`, штуки | Прирост сортировок данных без использования индекса за секунду. | 
| `server_status_admin_metrics.operation.writeConflicts_rate`<br/>`DGAUGE`, штуки | Прирост конфликтов при записи за секунду. | 
| `server_status_admin_metrics.queryExecutor.scanned_rate`<br/>`DGAUGE`, штуки | Прирост просканированных ключей индекса за секунду. | 
| `server_status_admin_metrics.queryExecutor.scannedObjects_rate`<br/>`DGAUGE`, штуки | Прирост просканированных документов за секунду. | 
| `server_status_admin_metrics.ttl.deletedDocuments_rate`<br/>`DGAUGE`, штуки | Прирост удаленных документов с использованием [TTL индекса](https://www.mongodb.com/docs/manual/core/index-ttl/) за секунду. | 
| `server_status_admin_metrics.ttl.passes_rate`<br/>`DGAUGE`, штуки | Прирост фоновых операций удаления документов из коллекций с использованием TTL индекса за секунду. | 
| `server_status_admin_opLatencies.commands.latency_rate`<br/>`DGAUGE`, микросекунды | Изменение задержки выполнения команд БД за секунду. | 
| `server_status_admin_opLatencies.commands.ops_rate`<br/>`DGAUGE`, штуки | Прирост операций над коллекциями БД за секунду. | 
| `server_status_admin_opLatencies.reads.latency_rate`<br/>`DGAUGE`, микросекунды | Изменение задержки выполнения команд чтения за секунду. | 
| `server_status_admin_opLatencies.reads.ops_rate`<br/>`DGAUGE`, штуки | Прирост операций чтения коллекций БД за секунду. | 
| `server_status_admin_opLatencies.transactions.latency_rate`<br/>`DGAUGE`, микросекунды |Изменение задержки транзакций за секунду.  | 
| `server_status_admin_opLatencies.transactions.ops_rate`<br/>`DGAUGE`, штуки | Прирост транзакций в БД за секунду. | 
| `server_status_admin_opLatencies.writes.latency_rate`<br/>`DGAUGE`, микросекунды | Изменение задержки выполнения команд записи за секунду. | 
| `server_status_admin_opLatencies.writes.ops_rate`<br/>`DGAUGE`, штуки | Прирост операций записи коллекций БД за секунду. | 
| `server_status_admin_repl.secondary`<br/>`DGAUGE`, штуки | Количество secondary-узлов в репликационном наборе. | 
| `server_status_admin_opcounters.command_rate`<br/>`DGAUGE`, штуки | Прирост количества команд к БД за секунду. Кроме команд `insert`, `update`, `delete`. | 
| `server_status_admin_opcounters.delete_rate`<br/>`DGAUGE`, штуки | Прирост количества `delete` операций в БД за секунду. | 
| `server_status_admin_opcounters.getmore_rate`<br/>`DGAUGE`, штуки | Прирост количества `getmore` операций в БД за секунду. | 
| `server_status_admin_opcounters.insert_rate`<br/>`DGAUGE`, штуки | Прирост количества `insert` операций в БД за секунду. | 
| `server_status_admin_opcounters.query_rate`<br/>`DGAUGE`, штуки | Прирост количества `query` операций в БД за секунду. | 
| `server_status_admin_opcounters.update_rate`<br/>`DGAUGE`, штуки | Прирост количества `update` операций в БД за секунду. | 
| `server_status_admin_opcountersRepl.command_rate`<br/>`DGAUGE`, штуки | Прирост количества реплицируемых команд к БД за секунду. | 
| `server_status_admin_opcountersRepl.delete_rate`<br/>`DGAUGE`, штуки | Прирост количества реплицируемых `delete` операций в БД за секунду. | 
| `server_status_admin_opcountersRepl.getmore_rate`<br/>`DGAUGE`, штуки | Прирост количества реплицируемых `getmore` операций в БД за секунду. | 
| `server_status_admin_opcountersRepl.insert_rate`<br/>`DGAUGE`, штуки | Прирост количества реплицируемых `insert` операций в БД за секунду. | 
| `server_status_admin_opcountersRepl.query_rate`<br/>`DGAUGE`, штуки | Прирост количества реплицируемых `query` операций в БД за секунду. | 
| `server_status_admin_opcountersRepl.update_rate`<br/>`DGAUGE`, штуки | Прирост количества реплицируемых `update` операций в БД за секунду. | 
| `server_status_admin_wiredTiger.cache.bytes_currently_in_the_cache`<br/>`DGAUGE`, байты | Размер использованного кеша WiredTiger. | 
| `server_status_admin_wiredTiger.cache.maximum_bytes_configured`<br/>`DGAUGE`, байты | Установленный максимальный размер кеша. | 
| `server_status_admin_wiredTiger.cache.modified_pages_evicted_rate`<br/>`DGAUGE`, штуки | Прирост освобожденных измененных страниц оперативной памяти за секунду. | 
| `server_status_admin_wiredTiger.cache.tracked_dirty_bytes_in_the_cache`<br/>`DGAUGE`, байты | Размер грязного кеша. | 
| `server_status_admin_wiredTiger.cache.unmodified_pages_evicted_rate`<br/>`DGAUGE`, штуки | Прирост освобожденных неизмененных страниц оперативной памяти за секунду. | 
| `server_status_admin_wiredTiger.concurrentTransactions.read.out`<br/>`DGAUGE`, штуки | Количество задействованных тикетов параллельных транзакций чтения. | 
| `server_status_admin_wiredTiger.concurrentTransactions.read.totalTickets`<br/>`DGAUGE`, штуки | Количество доступных тикетов параллельных транзакций чтения. | 
| `server_status_admin_wiredTiger.concurrentTransactions.write.out`<br/>`DGAUGE`, штуки | Количество задействованных тикетов параллельных транзакций записи. | 
| `server_status_admin_wiredTiger.concurrentTransactions.write.totalTickets`<br/>`DGAUGE`, штуки | Количество доступных тикетов параллельных транзакций записи. | 
| `server_status_admin_wiredTiger.transaction.transaction_begins`<br/>`DGAUGE`, штуки | Количество запущенных транзакций. | 
| `server_status_admin_wiredTiger.transaction.transaction_checkpoint_max_time_msecs`<br/>`DGAUGE`, миллисекунды | Максимальное время создания чекпоинта. | 
| `server_status_admin_wiredTiger.transaction.transaction_checkpoint_min_time_msecs`<br/>`DGAUGE`, миллисекунды | Минимальное время создания чекпоинта. |  
| `server_status_admin_wiredTiger.transaction.transaction_checkpoint_most_recent_time_msecs`<br/>`DGAUGE`, миллисекунды | Время создания последнего чекпоинта (в миллисекундах). | 
| `server_status_admin_wiredTiger.transaction.transactions_committed_rate`<br/>`DGAUGE`, штуки | Прирост завершенных транзакций за секунду. | 
| `server_status_admin_wiredTiger.transaction.transactions_rolled_back_rate`<br/>`DGAUGE`, штуки | Прирост отмененных транзакций за секунду. | 

## Прочие метрики {#managed-mongodb-other-metrics}
| Имя<br/>Тип, единицы измерения | Описание |
| ----- | ----- |
| `can_read`<br/>`DGAUGE`, 0/1 | Показатель доступности на чтение.<br/>Принимает значение `1`, если кластер доступен на чтение, `0`, если нет.  | 
| `can_write`<br/>`DGAUGE`, 0/1 | Показатель доступности на запись.<br/>Принимает значение `1`, если кластер доступен на запись, `0`, если нет.  | 
| `oplog-diff`<br/>`DGAUGE`, миллисекунды | Размер журнала операций (в миллисекундах). | 
| `oplog-maxSize`<br/>`DGAUGE`, байты | Максимальный размер журнала операций. | 
| `replset_status-replicationLag`<br/>`DGAUGE`, секунды | Задержка репликации. |
