Имя метрики пишется в метку `name`.

Общие метки для всех метрик сервиса {{ mos-name }}: 

Метка | Значение
----|----
service | Идентификатор сервиса: `managed-opensearch`
resource_type | Тип ресурса: `cluster`
resource_id | Идентификатор кластера
host | FQDN хоста

## Метрики CPU {#managed-opensearch-cpu-metrics}
Загрузка процессорных ядер.

| Имя<br/>Тип, единицы измерения | Описание |
| ----- | ----- |
| `cpu.fraction`<br/>`DGAUGE`, % | Гарантированная доля vCPU. | 
| `cpu.guarantee`<br/>`DGAUGE`, штуки | Гарантированное число ядер. | 
| `cpu.limit`<br/>`DGAUGE`, штуки | Предельное число используемых ядер. | 
| `cpu.guest`<br/>`DGAUGE`, % | Использование процессорных ядер, тип потребления `guest`. | 
| `cpu.guest_nice`<br/>`DGAUGE`, % | Использование процессорных ядер, тип потребления `guest_nice`. | 
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
| `load.avg_15min`<br/>`DGAUGE`, % | Средняя нагрузка за 15 минут. | 
| `load.avg_1min`<br/>`DGAUGE`, % | Средняя нагрузка за 1 минуту. | 
| `load.avg_5min`<br/>`DGAUGE`, % | Средняя нагрузка за 5 минут. |

## Метрики диска {#managed-opensearch-disk-metrics}
| Имя<br/>Тип, единицы измерения | Описание |
| ----- | ----- |
| `disk.free_bytes`<br/>`DGAUGE`, байты | Свободное место. | 
| `disk.free_inodes`<br/>`DGAUGE`, штуки | Свободное количество inodes. | 
| `disk.total_bytes`<br/>`DGAUGE`, байты | Доступное место. | 
| `disk.total_inodes`<br/>`DGAUGE`, штуки | Доступное количество inodes. | 
| `disk.used_bytes`<br/>`DGAUGE`, байты | Занятое место. | 
| `disk.used_inodes`<br/>`DGAUGE`, штуки | Занятое количество inodes. |

## Метрики дисковых операций {#managed-opensearch-diskio-metrics}
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

## Метрики RAM {#managed-opensearch-ram-metrics}
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
| `mem.shared_bytes`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `shared`. | 
| `mem.slab_bytes`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `slab`. | 
| `mem.sreclaimable_bytes`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `sreclaimable`. | 
| `mem.sunreclaim_bytes`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `sunreclaim`. | 
| `mem.swap_cached_bytes`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `swap_cached`. | 
| `mem.swap_free_bytes`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `swap_free`. | 
| `mem.swap_total_bytes`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `swap_total`. | 
| `mem.total_bytes`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `total`. | 
| `mem.used_bytes`<br/>`DGAUGE`, байты | Объем оперативной памяти, которую в данный момент используют запущенные процессы. | 
| `mem.used_percent_bytes`<br/>`DGAUGE`, % | Процент использованной оперативной памяти. | 
| `mem.vmalloc_chunk_bytes`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `vmalloc_chunk`. | 
| `mem.vmalloc_total_bytes`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `vmalloc_total`. | 
| `mem.vmalloc_used_bytes`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `vmalloc_used`. | 
| `mem.write_back_bytes`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `write_back`. | 
| `mem.write_back_tmp_bytes`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `write_back_tmp`. |

## Метрики сети {#managed-opensearch-net-metrics}
| Имя<br/>Тип, единицы измерения | Описание |
| ----- | ----- |
| `net.bytes_recv`<br/>`DGAUGE`, байт/с | Скорость получения данных по сети. | 
| `net.bytes_sent`<br/>`DGAUGE`, байт/с | Скорость отправки данных по сети. | 
| `net.drop_in`<br/>`DGAUGE`, штуки | Количество пакетов, отброшенных при получении. | 
| `net.drop_out`<br/>`DGAUGE`, штуки | Количество пакетов, отброшенных при отправке. | 
| `net.dropin`<br/>`DGAUGE`, штуки | Количество пакетов, отброшенных при получении. | 
| `net.dropout`<br/>`DGAUGE`, штуки | Количество пакетов, отброшенных при отправке. | 
| `net.err_in`<br/>`DGAUGE`, штуки | Количество ошибок при получении. | 
| `net.err_out`<br/>`DGAUGE`, штуки | Количество ошибок при отправке. | 
| `net.errin`<br/>`DGAUGE`, штуки | Количество ошибок при получении. | 
| `net.errout`<br/>`DGAUGE`, штуки | Количество ошибок при отправке. | 
| `net.packets_recv`<br/>`DGAUGE`, пакетов/с | Интенсивность получения данных по сети. | 
| `net.packets_sent`<br/>`DGAUGE`, пакетов/с | Интенсивность отправки данных по сети. | 

## Метрики сервиса {#managed-opensearch-metrics}
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
| `icmp_inaddrmaskreps`<br/>`DGAUGE`, штуки | Количество полученных ответных ICMP-сообщений с маской адреса от опрашиваемого узла.  | 
| `icmp_inaddrmasks`<br/>`DGAUGE`, штуки | Количество полученных сообщений с запросом маски ICMP-адреса. | 
| `icmp_incsumerrors`<br/>`DGAUGE`, штуки | Общее количество IP-пакетов с ошибками контрольной суммы. | 
| `icmp_indestunreachs`<br/>`DGAUGE`, штуки | Количество полученных сообщений о недоступности назначения ICMP. | 
| `icmp_inechoreps`<br/>`DGAUGE`, штуки | Количество полученных ICMP-сообщений Echo Reply. | 
| `icmp_inechos`<br/>`DGAUGE`, штуки | Количество полученных ICMP-сообщений Echo (запросов). | 
| `icmp_inerrors`<br/>`DGAUGE`, штуки | Количество полученных ICMP-пакетов с ошибками, не включая ошибки контрольной суммы.  | 
| `icmp_inmsgs`<br/>`DGAUGE`, штуки | Общее количество полученных ICMP-сообщений.  | 
| `icmp_inparmprobs`<br/>`DGAUGE`, штуки | Количество полученных сообщений о неполадках с параметрами ICMP. | 
| `icmp_inredirects`<br/>`DGAUGE`, штуки | Количество полученных сообщений о перенаправлении ICMP. | 
| `icmp_insrcquenchs`<br/>`DGAUGE`, штуки | Количество полученных ICMP-сообщений Source Quench. | 
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
| `icmpmsg_intype0`<br/>`DGAUGE`, штуки | Количество полученных ICMP-сообщений типа 0 (Echo Reply).  | 
| `icmpmsg_intype8`<br/>`DGAUGE`, штуки | Количество полученных ICMP-сообщений типа 8 (Echo Request).  | 
| `icmpmsg_outtype0`<br/>`DGAUGE`, штуки | Общее количество отправленных ICMP-сообщений типа 0 (Echo Reply).  | 
| `icmpmsg_outtype3`<br/>`DGAUGE`, штуки | Общее количество отправленных ICMP-сообщений типа 3 (Destination Unreachable).  | 
| `icmpmsg_outtype8`<br/>`DGAUGE`, штуки | Общее количество отправленных ICMP-сообщений типа 8 (Echo Request).  | 
| `inactive`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `inactive`. | 
| `index_docs_count`<br/>`DGAUGE`, штуки | Количество документов в индексе. Отображаются 10 индексов с наибольшим количеством документов. Учитываются только индексы размером больше 1 МБ. |
| `index_primary_store_size`<br/>`DGAUGE`, байты | Размер индекса. Отображаются 10 индексов наибольшего размера. Учитываются только индексы размером больше 1 МБ. |
| `inodes_free`<br/>`DGAUGE`, штуки | Свободное количество inodes. | 
| `inodes_total`<br/>`DGAUGE`, штуки | Доступное количество inodes. | 
| `inodes_used`<br/>`DGAUGE`, штуки | Занятое количество inodes. |
| `instance_userfault_broken`<br/>`DGAUGE`, 0/1 | Показатель, оценивающий вывод хоста из строя по вине пользователя. |
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
| `merged_reads`<br/>`DGAUGE`, штуки | Количество слитых операций чтения с дисков. | 
| `merged_writes`<br/>`DGAUGE`, штуки | Количество слитых операций записи на диски. | 
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
| `udp_noports`<br/>`DGAUGE`, штуки | Общее количество полученных UDP-пакетов, для которых на порту назначения не было приложения. | 
| `udp_outdatagrams`<br/>`DGAUGE`, штуки | Общее количество UDP-пакетов, отправленных от этого объекта. | 
| `udp_rcvbuferrors`<br/>`DGAUGE`, штуки | Количество ошибок буфера приема UDP.  | 
| `udp_sndbuferrors`<br/>`DGAUGE`, штуки | Количество ошибок буфера отправки UDP.  | 
| `udplite_ignoredmulti`<br/>`DGAUGE`, штуки | Для многоадресной рассылки UDP-Lite.  | 
| `udplite_incsumerrors`<br/>`DGAUGE`, штуки | Увеличивается, когда полученный пакет UDP Lite содержит недопустимую контрольную сумму кода ядра. | 
| `udplite_indatagrams`<br/>`DGAUGE`, штуки | Общее количество принятых пакетов UDP-Lite.  | 
| `udplite_inerrors`<br/>`DGAUGE`, штуки | Общее количество ошибок при получении пакетов UDP-Lite.  | 
| `udplite_noports`<br/>`DGAUGE`, штуки | Общее количество принятых пакетов UDP Lite, для которых на порте назначения не было слушателя. Перебои в значении этого счетчика могут возникать при повторной инициализации системы управления и в другое время, на что указывает значение `udplite_statsdiscontinuitytime`. | 
| `udplite_outdatagrams`<br/>`DGAUGE`, штуки | Общее количество отправленных датаграмм UDP-Lite.  | 
| `udplite_rcvbuferrors`<br/>`DGAUGE`, штуки | Увеличивается, когда память не может быть выделена для обработки входящего пакета UDP Lite. | 
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

#### Нативные метрики {{ OS }} {#managed-opensearch-system-metrics}

| Имя<br/>Тип, единицы измерения | 
| ----- | 
| `opensearch_discovered_cluster_manager`<br/>`DGAUGE`, 0/1 | 
| `opensearch_discovered_master`<br/>`DGAUGE`, 0/1 | 
| `opensearch_fs_io_stats_total_operations`<br/>`DGAUGE`, штуки | 
| `opensearch_fs_io_stats_total_read_kilobytes`<br/>`DGAUGE`, килобайты | 
| `opensearch_fs_io_stats_total_read_operations`<br/>`DGAUGE`, штуки | 
| `opensearch_fs_io_stats_total_write_kilobytes`<br/>`DGAUGE`, килобайты | 
| `opensearch_fs_io_stats_total_write_operations`<br/>`DGAUGE`, штуки | 
| `opensearch_fs_total_available_in_bytes`<br/>`DGAUGE`, байты | 
| `opensearch_fs_total_cache_reserved_in_bytes`<br/>`DGAUGE`, байты | 
| `opensearch_fs_total_free_in_bytes`<br/>`DGAUGE`, байты | 
| `opensearch_fs_total_total_in_bytes`<br/>`DGAUGE`, байты | 
| `opensearch_fs_total_used_in_bytes`<br/>`DGAUGE`, байты | 
| `opensearch_fs_total_used_percent`<br/>`DGAUGE`, штуки | 
| `opensearch_http_current_open`<br/>`DGAUGE`, штуки |
| `opensearch_http_total_opened`<br/>`DGAUGE`, штуки |
| `opensearch_indices_completion_size_in_bytes`<br/>`DGAUGE`, байты | 
| `opensearch_indices_docs_count`<br/>`DGAUGE`, штуки | 
| `opensearch_indices_docs_deleted`<br/>`DGAUGE`, штуки | 
| `opensearch_indices_fielddata_evictions`<br/>`DGAUGE`, штуки | 
| `opensearch_indices_fielddata_memory_size_in_bytes`<br/>`DGAUGE`, байты | 
| `opensearch_indices_flush_periodic`<br/>`DGAUGE`, штуки | 
| `opensearch_indices_flush_total`<br/>`DGAUGE`, штуки | 
| `opensearch_indices_flush_total_time_in_millis`<br/>`DGAUGE`, миллисекунды | 
| `opensearch_indices_get_current`<br/>`DGAUGE`, штуки | 
| `opensearch_indices_get_exists_time_in_millis`<br/>`DGAUGE`, миллисекунды | 
| `opensearch_indices_get_exists_total`<br/>`DGAUGE`, штуки | 
| `opensearch_indices_get_missing_time_in_millis`<br/>`DGAUGE`, миллисекунды | 
| `opensearch_indices_get_missing_total`<br/>`DGAUGE`, штуки | 
| `opensearch_indices_get_time_in_millis`<br/>`DGAUGE`, миллисекунды | 
| `opensearch_indices_get_total`<br/>`DGAUGE`, штуки |
| `opensearch_indices_indexing_delete_current`<br/>`DGAUGE`, штуки |
| `opensearch_indices_indexing_delete_time_in_millis`<br/>`DGAUGE`, миллисекунды | 
| `opensearch_indices_indexing_delete_total`<br/>`DGAUGE`, штуки | 
| `opensearch_indices_indexing_index_current`<br/>`DGAUGE`, штуки | 
| `opensearch_indices_indexing_index_failed`<br/>`DGAUGE`, штуки | 
| `opensearch_indices_indexing_index_time_in_millis`<br/>`DGAUGE`, миллисекунды  | 
| `opensearch_indices_indexing_index_total`<br/>`DGAUGE`, штуки | 
| `opensearch_indices_indexing_noop_update_total`<br/>`DGAUGE`, штуки | 
| `opensearch_indices_indexing_throttle_time_in_millis`<br/>`DGAUGE`, миллисекунды | 
| `opensearch_indices_merges_current`<br/>`DGAUGE`, штуки | 
| `opensearch_indices_merges_current_docs`<br/>`DGAUGE`, штуки | 
| `opensearch_indices_merges_current_size_in_bytes`<br/>`DGAUGE`, байты | 
| `opensearch_indices_merges_total`<br/>`DGAUGE`, штуки | 
| `opensearch_indices_merges_total_auto_throttle_in_bytes`<br/>`DGAUGE`, байты | 
| `opensearch_indices_merges_total_docs`<br/>`DGAUGE`, штуки | 
| `opensearch_indices_merges_total_size_in_bytes`<br/>`DGAUGE`, байты | 
| `opensearch_indices_merges_total_stopped_time_in_millis`<br/>`DGAUGE`, миллисекунды | 
| `opensearch_indices_merges_total_throttled_time_in_millis`<br/>`DGAUGE`, миллисекунды | 
| `opensearch_indices_merges_total_time_in_millis`<br/>`DGAUGE`, миллисекунды | 
| `opensearch_indices_query_cache_cache_count`<br/>`DGAUGE`, штуки | 
| `opensearch_indices_query_cache_cache_size`<br/>`DGAUGE`, байты | 
| `opensearch_indices_query_cache_evictions`<br/>`DGAUGE`, штуки | 
| `opensearch_indices_query_cache_hit_count`<br/>`DGAUGE`, штуки | 
| `opensearch_indices_query_cache_memory_size_in_bytes`<br/>`DGAUGE`, байты | 
| `opensearch_indices_query_cache_miss_count`<br/>`DGAUGE`, штуки | 
| `opensearch_indices_query_cache_total_count`<br/>`DGAUGE`, штуки | 
| `opensearch_indices_recovery_current_as_source`<br/>`DGAUGE`, штуки | 
| `opensearch_indices_recovery_current_as_target`<br/>`DGAUGE`, штуки | 
| `opensearch_indices_recovery_throttle_time_in_millis`<br/>`DGAUGE`, миллисекунды | 
| `opensearch_indices_refresh_external_total`<br/>`DGAUGE`, штуки | 
| `opensearch_indices_refresh_external_total_time_in_millis`<br/>`DGAUGE`, миллисекунды |
| `opensearch_indices_refresh_listeners`<br/>`DGAUGE`, штуки | 
| `opensearch_indices_refresh_total`<br/>`DGAUGE`, штуки | 
| `opensearch_indices_refresh_total_time_in_millis`<br/>`DGAUGE`, миллисекунды |
| `opensearch_indices_request_cache_evictions`<br/>`DGAUGE`, штуки | 
| `opensearch_indices_request_cache_hit_count`<br/>`DGAUGE`, штуки | 
| `opensearch_indices_request_cache_memory_size_in_bytes`<br/>`DGAUGE`, байты | 
| `opensearch_indices_request_cache_miss_count`<br/>`DGAUGE`, штуки | 
| `opensearch_indices_search_fetch_current`<br/>`DGAUGE`, штуки | 
| `opensearch_indices_search_fetch_time_in_millis`<br/>`DGAUGE`, миллисекунды |
| `opensearch_indices_search_fetch_total`<br/>`DGAUGE`, штуки | 
| `opensearch_indices_search_open_contexts`<br/>`DGAUGE`, штуки | 
| `opensearch_indices_search_point_in_time_current`<br/>`DGAUGE`, штуки | 
| `opensearch_indices_search_point_in_time_time_in_millis`<br/>`DGAUGE`, миллисекунды | 
| `opensearch_indices_search_point_in_time_total`<br/>`DGAUGE`, штуки | 
| `opensearch_indices_search_query_current`<br/>`DGAUGE`, штуки | 
| `opensearch_indices_search_query_time_in_millis`<br/>`DGAUGE`, миллисекунды | 
| `opensearch_indices_search_query_total`<br/>`DGAUGE`, штуки | 
| `opensearch_indices_search_scroll_current`<br/>`DGAUGE`, штуки | 
| `opensearch_indices_search_scroll_time_in_millis`<br/>`DGAUGE`, миллисекунды |
| `opensearch_indices_search_scroll_total`<br/>`DGAUGE`, штуки | 
| `opensearch_indices_search_suggest_current`<br/>`DGAUGE`, штуки | 
| `opensearch_indices_search_suggest_time_in_millis`<br/>`DGAUGE`, миллисекунды |
| `opensearch_indices_search_suggest_total`<br/>`DGAUGE`, штуки | 
| `opensearch_indices_segments_count`<br/>`DGAUGE`, штуки | 
| `opensearch_indices_segments_doc_values_memory_in_bytes`<br/>`DGAUGE`, байты | 
| `opensearch_indices_segments_fixed_bit_set_memory_in_bytes`<br/>`DGAUGE`, байты | 
| `opensearch_indices_segments_index_writer_memory_in_bytes`<br/>`DGAUGE`, байты | 
| `opensearch_indices_segments_max_unsafe_auto_id_timestamp`<br/>`DGAUGE`, таймстамп | 
| `opensearch_indices_segments_memory_in_bytes`<br/>`DGAUGE`, байты | 
| `opensearch_indices_segments_norms_memory_in_bytes`<br/>`DGAUGE`, байты | 
| `opensearch_indices_segments_points_memory_in_bytes`<br/>`DGAUGE`, байты | 
| `opensearch_indices_segments_stored_fields_memory_in_bytes`<br/>`DGAUGE`, байты | 
| `opensearch_indices_segments_term_vectors_memory_in_bytes`<br/>`DGAUGE`, байты | 
| `opensearch_indices_segments_terms_memory_in_bytes`<br/>`DGAUGE`, байты | 
| `opensearch_indices_segments_version_map_memory_in_bytes`<br/>`DGAUGE`, байты | 
| `opensearch_indices_store_reserved_in_bytes`<br/>`DGAUGE`, байты | 
| `opensearch_indices_store_size_in_bytes`<br/>`DGAUGE`, байты | 
| `opensearch_indices_translog_earliest_last_modified_age`<br/>`DGAUGE`, штуки | 
| `opensearch_indices_translog_operations`<br/>`DGAUGE`, штуки |
| `opensearch_indices_translog_size_in_bytes`<br/>`DGAUGE`, байты | 
| `opensearch_indices_translog_uncommitted_operations`<br/>`DGAUGE`, штуки |  | 
| `opensearch_indices_translog_uncommitted_size_in_bytes`<br/>`DGAUGE`, байты | 
| `opensearch_indices_warmer_current`<br/>`DGAUGE`, штуки | 
| `opensearch_indices_warmer_total`<br/>`DGAUGE`, штуки | 
| `opensearch_indices_warmer_total_time_in_millis`<br/>`DGAUGE`, миллисекунды |
| `opensearch_jvm_gc_collectors_old_collection_count`<br/>`DGAUGE`, штуки | 
| `opensearch_jvm_gc_collectors_young_collection_count`<br/>`DGAUGE`, штуки | 
| `opensearch_jvm_mem_heap_committed_in_bytes`<br/>`DGAUGE`, байты | 
| `opensearch_jvm_mem_heap_max_in_bytes`<br/>`DGAUGE`, байты | 
| `opensearch_jvm_mem_heap_pressure`<br/>`DGAUGE` | 
| `opensearch_jvm_mem_heap_used_in_bytes`<br/>`DGAUGE`, байты | 
| `opensearch_jvm_mem_heap_used_percent`<br/>`DGAUGE`, штуки | 
| `opensearch_jvm_mem_non_heap_committed_in_bytes`<br/>`DGAUGE`, байты | 
| `opensearch_jvm_mem_non_heap_used_in_bytes`<br/>`DGAUGE`, байты | 
| `opensearch_jvm_mem_pools_old_max_in_bytes`<br/>`DGAUGE`, байты | 
| `opensearch_jvm_mem_pools_old_used_in_bytes`<br/>`DGAUGE`, байты | 
| `opensearch_number_of_data_nodes`<br/>`DGAUGE`, штуки | 
| `opensearch_number_of_in_flight_fetch`<br/>`DGAUGE`, штуки | 
| `opensearch_number_of_nodes`<br/>`DGAUGE`, штуки | 
| `opensearch_number_of_pending_tasks`<br/>`DGAUGE`, штуки | 
| `opensearch_process_cpu_percent`<br/>`DGAUGE`, штуки | 
| `opensearch_process_cpu_total_in_millis`<br/>`DGAUGE`, миллисекунды | 
| `opensearch_process_max_file_descriptors`<br/>`DGAUGE`, штуки | 
| `opensearch_process_mem_total_virtual_in_bytes`<br/>`DGAUGE`, байты | 
| `opensearch_process_open_file_descriptors`<br/>`DGAUGE`, штуки | 
| `opensearch_process_timestamp`<br/>`DGAUGE`, таймстамп | 
| `opensearch_task_max_waiting_in_queue_millis`<br/>`DGAUGE`, миллисекунды |
| `opensearch_thread_pool_<thread_pool_name>_active`<br/>`DGAUGE`, штуки | 
| `opensearch_thread_pool_<thread_pool_name>_completed`<br/>`DGAUGE`, штуки | 
| `opensearch_thread_pool_<thread_pool_name>_largest`<br/>`DGAUGE`, штуки | 
| `opensearch_thread_pool_<thread_pool_name>_queue`<br/>`DGAUGE`, штуки | 
| `opensearch_thread_pool_<thread_pool_name>_rejected`<br/>`DGAUGE`, штуки | 
| `opensearch_thread_pool_<thread_pool_name>_threads`<br/>`DGAUGE`, штуки | 
| `opensearch_transport_rx_count`<br/>`DGAUGE`, штуки | 
| `opensearch_transport_rx_size_in_bytes`<br/>`DGAUGE`, байты | 
| `opensearch_transport_server_open`<br/>`DGAUGE`, штуки | 
| `opensearch_transport_total_outbound_connections`<br/>`DGAUGE`, штуки | 
| `opensearch_transport_tx_count`<br/>`DGAUGE`, штуки | 
| `opensearch_transport_tx_size_in_bytes`<br/>`DGAUGE`, байты |

#### Прочие метрики {#managed-opensearch-other-metrics}
| Имя<br/>Тип, единицы измерения | Описание |
| ----- | ----- |
| `opensearch_active_primary_shards`<br/>`DGAUGE`, штуки | Количество активных [первичных шардов](../../../managed-opensearch/concepts/scalability-and-resilience.md) и общее количество активных шардов в кластере. | 
| `opensearch_active_shards`<br/>`DGAUGE`, штуки | Количество активных шардов. | 
| `opensearch_active_shards_percent_as_number`<br/>`DGAUGE`, штуки | Процент активных шардов. | 
| `opensearch_backup_incremental_size`<br/>`DGAUGE`, байты | Размер файлов, созданных в рамках инкрементной резервной копии. |
| `opensearch_backup_total_size`<br/>`DGAUGE`, байты | Размер файлов, на которые ссылается резервная копия. |
| `opensearch_backup_free_space_required`<br/>`DGAUGE`, байты | Объем хранилища, необходимый для восстановления кластера из резервной копии. |
| `opensearch_delayed_unassigned_shards`<br/>`DGAUGE`, штуки | Количество отложенных к назначению шардов. |
| `opensearch_initializing_shards`<br/>`DGAUGE`, штуки | Количество шардов в состоянии инициализации. | 
| `opensearch_is_alive`<br/>`DGAUGE`, 0/1 | Показатель работоспособности хоста.<br/>Принимает значение `1`, если хост БД работает, `0`, если нет. | 
| `opensearch_relocating_shards`<br/>`DGAUGE`, штуки | Количество перемещаемых шардов. | 
| `opensearch_status`<br/>`DGAUGE`, 0/1/2 | Уровень работоспособности и техническое состояние кластера:<br/>`0` — красный: неработоспособное или частично работоспособное состояние. Хотя бы один из первичных шардов недоступен. Если кластер отвечает на запросы, результаты поиска в ответах будут неполными.<br/>`1` — желтый: работоспособное состояние. Нет доступа хотя бы к одному из шардов-реплик. Результаты поиска в ответах кластера полные, но если появятся еще недоступные шарды, работоспособность кластера нарушится.<br/>`2` — зеленый: исправное состояние. Все шарды кластера доступны. |
| `opensearch_unassigned_shards`<br/>`DGAUGE`, штуки | Количество неактивных шардов с неназначенным хостом. |
| `dashboards_is_alive`<br/>`DGAUGE`, 0/1 | Показатель работоспособности хоста.<br/>Принимает значение `1`, если хост БД работает, `0`, если нет. | 
| `dashboards_metrics_requests_total`<br/>`DGAUGE`, штуки | Общее количество запросов к кластеру. | 
