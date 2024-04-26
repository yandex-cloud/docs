Имя метрики пишется в метку `name`.

Общие метки для всех метрик сервиса {{ mgp-name }}: 

Метка | Значение
----|----
service | Идентификатор сервиса: `managed-greenplum`
resource_type | Тип ресурса: `cluster`
resource_id | Имя кластера 
cid | Идентификатор кластера
host | FQDN хоста
fqdn | FQDN хоста

## Метрики CPU {#managed-greenplum-cpu-metrics}
Загрузка процессорных ядер.

| Имя<br/>Тип, единицы измерения | Описание |
| ----- | ----- |
| `cpu.cpu.fraction`<br/>`DGAUGE`, % | Гарантированная доля vCPU. | 
| `cpu.cpu.guarantee`<br/>`DGAUGE`, штуки | Гарантированное число ядер. | 
| `cpu.cpu.limit`<br/>`DGAUGE`, штуки | Предельное число используемых ядер. | 
| `cpu.usage_guest`<br/>`DGAUGE`, % | Использование процессорных ядер, тип потребления `guest`. | 
| `cpu.usage_guest_nice`<br/>`DGAUGE`, % | Использование процессорных ядер, тип потребления `guest_nice`. | 
| `cpu.usage_idle`<br/>`DGAUGE`, % | Использование процессорных ядер, тип потребления `idle`. | 
| `cpu.usage_iowait`<br/>`DGAUGE`, % | Использование процессорных ядер, тип потребления `iowait`. | 
| `cpu.usage_irq`<br/>`DGAUGE`, % | Использование процессорных ядер, тип потребления `irq`. | 
| `cpu.usage_nice`<br/>`DGAUGE`, % | Использование процессорных ядер, тип потребления `nice`. | 
| `cpu.usage_softirq`<br/>`DGAUGE`, % | Использование процессорных ядер, тип потребления `softirq`. | 
| `cpu.usage_steal`<br/>`DGAUGE`, % | Использование процессорных ядер, тип потребления `steal`. | 
| `cpu.usage_system`<br/>`DGAUGE`, % | Использование процессорных ядер, тип потребления `system`. | 
| `cpu.usage_user`<br/>`DGAUGE`, % | Использование процессорных ядер, тип потребления `user`. |

## Метрики диска {#managed-greenplum-disk-metrics}
Дополнительные метки: `device` — идентификатор диска в системе.

| Имя<br/>Тип, единицы измерения | Описание |
| ----- | ----- |
| `disk.free`<br/>`DGAUGE`, байты | Свободное место. | 
| `disk.inodes_free`<br/>`DGAUGE`, штуки | Свободное количество inodes. | 
| `disk.inodes_total`<br/>`DGAUGE`, штуки | Доступное количество inodes. | 
| `disk.inodes_used`<br/>`DGAUGE`, штуки | Использованное количество inodes. | 
| `disk.total`<br/>`DGAUGE`, байты | Доступное место. | 
| `disk.used`<br/>`DGAUGE`, байты | Использованное место. | 
| `disk.used_percent`<br/>`DGAUGE`, % | Процент использованного места. |

## Метрики дисковых операций {#managed-greenplum-diskio-metrics}
Дополнительные метки: `dev` — идентификатор диска в системе.

| Имя<br/>Тип, единицы измерения | Описание |
| ----- | ----- |
| `diskio.io_time`<br/>`DGAUGE`, миллисекунды | Длительность дисковых операций. | 
| `diskio.iops_in_progress`<br/>`DGAUGE`, штуки | Количество незавершенных дисковых операций. | 
| `diskio.merged_reads`<br/>`DGAUGE`, штуки | Количество слитых операций чтения с диска. | 
| `diskio.merged_writes`<br/>`DGAUGE`, штуки | Количество слитых операций записи на диск. | 
| `diskio.read_bytes`<br/>`DGAUGE`, байты | Объем чтения с диска. | 
| `diskio.read_time`<br/>`DGAUGE`, миллисекунды | Длительность чтения с диска. | 
| `diskio.reads`<br/>`DGAUGE`, штуки | Количество операций чтения с диска. | 
| `diskio.weighted_io_time`<br/>`DGAUGE`, миллисекунды | Длительность ожидания операций ввода/вывода. | 
| `diskio.write_bytes`<br/>`DGAUGE`, байты | Объем записи на диск.  | 
| `diskio.write_time`<br/>`DGAUGE`, миллисекунды | Длительность записи на диск. | 
| `diskio.writes`<br/>`DGAUGE`, штуки | Количество операций записи на диск. | 

## Метрики RAM {#managed-greenplum-ram-metrics}
| Имя<br/>Тип, единицы измерения | Описание |
| ----- | ----- |
| `mem.active`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `active`. | 
| `mem.available`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `available`. | 
| `mem.available_percent`<br/>`DGAUGE`, % | Процент доступной оперативной памяти. | 
| `mem.buffered`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `buffered`. | 
| `mem.cached`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `cached`. | 
| `mem.commit_limit`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `commit_limit`. | 
| `mem.committed_as`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `committed_as`. | 
| `mem.dirty`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `dirty`. | 
| `mem.free`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `free`. | 
| `mem.high_free`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `high_free`. | 
| `mem.high_total`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `high_total`. | 
| `mem.huge_page_size`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `huge_page_size`. | 
| `mem.huge_pages_free`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `huge_pages_free`. | 
| `mem.huge_pages_total`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `huge_pages_total`. | 
| `mem.inactive`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `inactive`. | 
| `mem.low_free`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `low_free`. | 
| `mem.low_total`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `low_total`. | 
| `mem.mapped`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `mapped`. | 
| `mem.page_tables`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `page_tables`. | 
| `mem.shared`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `shared`. | 
| `mem.slab`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `slab`. | 
| `mem.sreclaimable`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `sreclaimable`. | 
| `mem.sunreclaim`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `sunreclaim`. | 
| `mem.swap_cached`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `swap_cached`. | 
| `mem.swap_free`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `swap_free`. | 
| `mem.swap_total`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `swap_total`. | 
| `mem.total`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `total`. | 
| `mem.used`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `used`. | 
| `mem.used_percent`<br/>`DGAUGE`, % | Процент использованной оперативной памяти. | 
| `mem.vmalloc_chunk`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `vmalloc_chunk`. | 
| `mem.vmalloc_total`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `vmalloc_total`. | 
| `mem.vmalloc_used`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `vmalloc_used`. | 
| `mem.write_back`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `write_back`. | 
| `mem.write_back_tmp`<br/>`DGAUGE`, байты | Использование оперативной памяти, тип потребления `write_back_tmp`. |

## Метрики сети {#managed-greenplum-net-metrics}
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
| `net.icmp_inaddrmaskreps`<br/>`DGAUGE`, штуки | Количество полученных ответных ICMP-сообщений с маской адреса от опрашиваемого узла.  | 
| `net.icmp_inaddrmasks`<br/>`DGAUGE`, штуки | Количество полученных сообщений с запросом маски ICMP-адреса.  | 
| `net.icmp_incsumerrors`<br/>`DGAUGE`, штуки | Общее количество IP-пакетов с ошибками контрольной суммы.  | 
| `net.icmp_indestunreachs`<br/>`DGAUGE`, штуки | Количество полученных сообщений о недоступности назначения ICMP.  | 
| `net.icmp_inechoreps`<br/>`DGAUGE`, штуки | Количество полученных ICMP-сообщений Echo Reply.  | 
| `net.icmp_inechos`<br/>`DGAUGE`, штуки | Количество полученных ICMP-сообщений Echo (запросов).  | 
| `net.icmp_inerrors`<br/>`DGAUGE`, штуки | Количество полученных ICMP-пакетов с ошибками, не включая ошибки контрольной суммы.  | 
| `net.icmp_inmsgs`<br/>`DGAUGE`, штуки | Общее количество полученных ICMP-сообщений.  | 
| `net.icmp_inparmprobs`<br/>`DGAUGE`, штуки | Количество полученных сообщений о неполадках с параметрами ICMP. | 
| `net.icmp_inredirects`<br/>`DGAUGE`, штуки | Количество полученных сообщений о перенаправлении ICMP.  | 
| `net.icmp_insrcquenchs`<br/>`DGAUGE`, штуки | Количество полученных ICMP-сообщений Source Quench.  | 
| `net.icmp_intimeexcds`<br/>`DGAUGE`, штуки | Количество полученных сообщений с превышением времени ICMP превысило количество полученных сообщений.  | 
| `net.icmp_intimestampreps`<br/>`DGAUGE`, штуки | Количество полученных ответных сообщений с меткой времени ICMP.  | 
| `net.icmp_intimestamps`<br/>`DGAUGE`, штуки | Количество полученных сообщений (запросов) с меткой времени ICMP.  | 
| `net.icmp_outaddrmaskreps`<br/>`DGAUGE`, штуки | Количество отправленных ответных сообщений по маске ICMP-адреса.  | 
| `net.icmp_outaddrmasks`<br/>`DGAUGE`, штуки | Количество отправленных сообщений с запросом маски ICMP-адреса.  | 
| `net.icmp_outdestunreachs`<br/>`DGAUGE`, штуки | Количество отправленных сообщений о недоступности назначения ICMP.  | 
| `net.icmp_outechoreps`<br/>`DGAUGE`, штуки | Количество отправленных ICMP-сообщений Echo Reply.  | 
| `net.icmp_outechos`<br/>`DGAUGE`, штуки | Количество отправленных ICMP-сообщений Echo (запросов).  | 
| `net.icmp_outerrors`<br/>`DGAUGE`, штуки | Количество ICMP-сообщений, которые этот объект не отправил из-за проблем, обнаруженных в ICMP, таких как нехватка буферов.  | 
| `net.icmp_outmsgs`<br/>`DGAUGE`, штуки | Общее количество ICMP-сообщений, которые пытался отправить этот объект. Включает все сообщения, подсчитанные `icmp_outerrors`.  | 
| `net.icmp_outparmprobs`<br/>`DGAUGE`, штуки | Количество отправленных сообщений о проблемах с параметрами ICMP.  | 
| `net.icmp_outredirects`<br/>`DGAUGE`, штуки | Количество отправленных сообщений с перенаправлениями маршрута.  | 
| `net.icmp_outsrcquenchs`<br/>`DGAUGE`, штуки | Количество отправленных сообщений Source Quench по протоколу ICMP.  | 
| `net.icmp_outtimeexcds`<br/>`DGAUGE`, штуки | Количество отправленных сообщений с превышением времени ICMP превысило количество отправленных сообщений.  | 
| `net.icmp_outtimestampreps`<br/>`DGAUGE`, штуки | Количество отправленных ответных сообщений с меткой времени ICMP.  | 
| `net.icmp_outtimestamps`<br/>`DGAUGE`, штуки | Количество отправленных сообщений с меткой времени ICMP.  | 
| `net.icmpmsg_intype0`<br/>`DGAUGE`, штуки | Количество полученных ICMP-сообщений типа 0 (Echo Reply).  | 
| `net.icmpmsg_intype3`<br/>`DGAUGE`, штуки | Количество полученных ICMP-сообщений типа 3 (Destination Unreachable).  | 
| `net.icmpmsg_intype8`<br/>`DGAUGE`, штуки | Количество полученных ICMP-сообщений типа 8 (Echo Request).  | 
| `net.icmpmsg_outtype0`<br/>`DGAUGE`, штуки | Общее количество отправленных ICMP-сообщений типа 0 (Echo Reply).  | 
| `net.icmpmsg_outtype3`<br/>`DGAUGE`, штуки | Общее количество отправленных ICMP-сообщений типа 3 (Destination Unreachable).  | 
| `net.icmpmsg_outtype8`<br/>`DGAUGE`, штуки | Общее количество отправленных ICMP-сообщений типа 8 (Echo Request).  | 
| `net.ip_defaultttl`<br/>`DGAUGE`, строка | Значение по умолчанию, вставляемое в поле Time-To-Live заголовка IP-пакетов, созданных в этом объекте, когда значение TTL не предоставляется протоколом транспортного уровня.  | 
| `net.ip_forwarding`<br/>`DGAUGE` | Состояние пересылки IP (в сетевом протоколе SNMP) (`0` — отключено, `1` — включено).  | 
| `net.ip_forwdatagrams`<br/>`DGAUGE`, штуки | Количество входящих пакетов, для которых этот объект не был их конечным IP-адресатом, в результате чего была предпринята попытка найти маршрут для пересылки их в этот конечный пункт назначения. В объектах, которые не действуют как IP-маршрутизаторы, этот счетчик будет включать только те пакеты, которые были перенаправлены источником через этот объект, и обработка параметра исходного маршрута прошла успешно.  | 
| `net.ip_fragcreates`<br/>`DGAUGE`, штуки | Количество фрагментов IP-пакетов, которые были сгенерированы в результате фрагментации в этом объекте.  | 
| `net.ip_fragfails`<br/>`DGAUGE`, штуки | Количество IP-пакетов, которые были отброшены, поскольку они должны были быть фрагментированы в этом объекте, но не могли быть фрагментированы, например, потому что был установлен флаг, запрещающий фрагментацию.  | 
| `net.ip_fragoks`<br/>`DGAUGE`, штуки | Количество успешных фрагментаций IP-пакетов.  | 
| `net.ip_inaddrerrors`<br/>`DGAUGE`, штуки | Количество входящих пакетов, отброшенных из-за того, что IP-адрес в поле назначения их IP-заголовка не был допустимым адресом для получения в этом объекте. Это количество включает недопустимые адреса (например, `0.0.0.0`) и адреса неподдерживаемых классов (например, класс E). Для объектов, которые не являются IP-маршрутизаторами и, следовательно, не пересылают пакеты, этот счетчик включает пакеты, отброшенные из-за того, что адрес назначения не был локальным адресом.  | 
| `net.ip_indelivers`<br/>`DGAUGE`, штуки | Общее количество доставленных IP-пакетов.  | 
| `net.ip_indiscards`<br/>`DGAUGE`, штуки | Количество входящих IP-пакетов, для которых не возникло проблем, препятствующих их дальнейшей обработке, но которые были отброшены (например, из-за нехватки места в буфере). Этот счетчик не включает в себя пакеты, отброшенные в ожидании повторной сборки.  | 
| `net.ip_inhdrerrors`<br/>`DGAUGE`, штуки | Количество входящих пакетов с ошибками в заголовке.  | 
| `net.ip_inreceives`<br/>`DGAUGE`, штуки | Общее количество входящих пакетов, полученных от интерфейсов, включая полученные по ошибке.  | 
| `net.ip_inunknownprotos`<br/>`DGAUGE`, штуки | Количество полученных пакетов с неизвестными протоколами.  | 
| `net.ip_outdiscards`<br/>`DGAUGE`, штуки | Количество выходящих IP-пакетов, для которых не возникло проблем, препятствующих их передаче по назначению, но которые были отброшены (например, из-за нехватки места в буфере). Обратите внимание, что этот счетчик включал бы пакеты, подсчитанные в `ip_forwdatagrams`, если бы такие пакеты удовлетворяли этому (дискреционному) критерию отбрасывания. | 
| `net.ip_outnoroutes`<br/>`DGAUGE`, штуки | Количество отброшенных IP-пакетов, для которых не удалось найти маршрут для их передачи по назначению. Этот счетчик включает все пакеты, подсчитанные в `ip_forwdatagrams`, которые соответствуют критерию «без маршрута». Сюда входят любые пакеты, которые хост не может перенаправить, поскольку все его маршрутизаторы по умолчанию не работают.  | 
| `net.ip_outrequests`<br/>`DGAUGE`, штуки | Общее количество IP-пакетов, которые локальные пользовательские протоколы IP (включая ICMP) передали IP в запросах на передачу. Этот счетчик не включает в себя пакеты, подсчитанные в `ip_forwdatagrams`.  | 
| `net.ip_reasmfails`<br/>`DGAUGE`, штуки | Количество сбоев, обнаруженных алгоритмом повторной сборки IP (по любой причине: тайм-аут, ошибки и т.д.). Это не обязательно количество отброшенных IP-фрагментов, поскольку некоторые алгоритмы (в частности, алгоритм в RFC 815) могут потерять отслеживание количества фрагментов, объединяя их по мере их получения.  | 
| `net.ip_reasmoks`<br/>`DGAUGE`, штуки | Количество IP-пакетов, успешно собранных повторно.  | 
| `net.ip_reasmreqds`<br/>`DGAUGE`, штуки | Количество полученных IP-фрагментов, которые необходимо было повторно собрать в этом объекте.  | 
| `net.ip_reasmtimeout`<br/>`DGAUGE`, секунды | Максимальное количество секунд, в течение которых удерживаются полученные фрагменты, пока они ожидают повторной сборки в этом объекте.  | 
| `net.tcp_activeopens`<br/>`DGAUGE`, штуки | Количество раз, когда TCP-соединения совершали прямой переход из состояния `CLOSED` в состояние `SYN-SENT`.  | 
| `net.tcp_attemptfails`<br/>`DGAUGE`, штуки | Количество раз, когда TCP-соединения совершали прямой переход в состояние `CLOSED` либо из состояния `SYN-SENT`, либо из состояния `SYN-RCVD`, плюс количество раз, когда TCP-соединения совершали прямой переход.  | 
| `net.tcp_currestab`<br/>`DGAUGE`, штуки | Текущее количество TCP-соединений для состояния `ESTABLISHED` или `CLOSE WAIT`.  | 
| `net.tcp_estabresets`<br/>`DGAUGE`, штуки | Количество раз, когда TCP-соединения совершали прямой переход в состояние `CLOSED` либо из состояния `ESTABLISHED`, либо из состояния `CLOSE-WAIT`.  | 
| `net.tcp_incsumerrors`<br/>`DGAUGE`, штуки | Увеличивается, когда полученный TCP-пакет имеет неправильную контрольную сумму.  | 
| `net.tcp_inerrs`<br/>`DGAUGE`, штуки | Общее количество сегментов, полученных с ошибкой (например, неверные контрольные суммы TCP).  | 
| `net.tcp_insegs`<br/>`DGAUGE`, штуки | Общее количество полученных сегментов, включая те, которые были получены по ошибке.  | 
| `net.tcp_maxconn`<br/>`DGAUGE`, штуки | Максимальное количество допустимых TCP-соединений.  | 
| `net.tcp_outrsts`<br/>`DGAUGE`, штуки | Количество отправленных TCP-сегментов, содержащих флаг `RST`.  | 
| `net.tcp_outsegs`<br/>`DGAUGE`, штуки | Общее количество отправленных TCP-сегментов.  | 
| `net.tcp_passiveopens`<br/>`DGAUGE`, штуки | Количество раз, когда TCP-соединения осуществляли прямой переход в состояние `SYN-RCVD` из состояния `LISTEN`.  | 
| `net.tcp_retranssegs`<br/>`DGAUGE`, штуки | Общее количество повторно переданных сегментов, то есть количество переданных TCP-сегментов, содержащих один или несколько ранее переданных октетов.  | 
| `net.tcp_rtoalgorithm`<br/>`DGAUGE` | Алгоритм, используемый для определения значения тайм-аута, используемого для повторной передачи неподтвержденных октетов.  | 
| `net.tcp_rtomax`<br/>`DGAUGE`, миллисекунды | Максимальное значение, разрешенное реализацией TCP для времени ожидания повторной передачи, измеряемое в миллисекундах.  | 
| `net.tcp_rtomin`<br/>`DGAUGE`, миллисекунды | Минимальное значение, разрешенное реализацией TCP для времени ожидания повторной передачи, измеряемое в миллисекундах.  | 
| `net.udp_ignoredmulti`<br/>`DGAUGE`, штуки | Для многоадресной рассылки UDP.  | 
| `net.udp_incsumerrors`<br/>`DGAUGE`, штуки | Увеличивается, когда полученный UDP-пакет содержит недопустимую контрольную сумму кода ядра.  | 
| `net.udp_indatagrams`<br/>`DGAUGE`, штуки | Общее количество принятых UDP-пакетов.  | 
| `net.udp_inerrors`<br/>`DGAUGE`, штуки | Количество полученных UDP-пакетов с ошибками, не включая ошибки контрольной суммы.  | 
| `net.udp_noports`<br/>`DGAUGE`, штуки | Общее количество полученных UDP-пакетов, для которых на порту назначения не было приложения.  | 
| `net.udp_outdatagrams`<br/>`DGAUGE`, штуки | Общее количество UDP-пакетов, отправленных от этого объекта.  | 
| `net.udp_rcvbuferrors`<br/>`DGAUGE`, штуки | Количество ошибок буфера приема UDP.  | 
| `net.udp_sndbuferrors`<br/>`DGAUGE`, штуки | Количество ошибок буфера отправки UDP.  | 
| `net.udplite_ignoredmulti`<br/>`DGAUGE`, штуки | Для многоадресной рассылки UDP-Lite.  | 
| `net.udplite_incsumerrors`<br/>`DGAUGE`, штуки | Увеличивается, когда полученный пакет UDP-Lite содержит недопустимую контрольную сумму кода ядра.  | 
| `net.udplite_indatagrams`<br/>`DGAUGE`, штуки | Общее количество принятых пакетов UDP-Lite.  | 
| `net.udplite_inerrors`<br/>`DGAUGE`, штуки | Общее количество ошибок при получении пакетов UDP-Lite.  | 
| `net.udplite_noports`<br/>`DGAUGE`, штуки | Количество полученных пакетов UDP-Lite, для которых не найден соответствующий порт приемника.  | 
| `net.udplite_outdatagrams`<br/>`DGAUGE`, штуки | Общее количество отправленных датаграмм UDP-Lite.  | 
| `net.udplite_rcvbuferrors`<br/>`DGAUGE`, штуки | Количество ошибок буфера приема UDP-Lite.  | 
| `net.udplite_sndbuferrors`<br/>`DGAUGE`, штуки | Количество ошибок буфера отправки UDP-Lite.  | 
| `net_response.response_time`<br/>`DGAUGE`, миллисекунды | Время отклика сети.  | 
| `net_response.result_code`<br/>`DGAUGE`, `0`-`10` | Код результата ответа сети.  | 
| `nstat.ipextinbcastoctets`<br/>`DGAUGE`, байты | Общее количество полученных входящих широковещательных байт с IP-адресами.  | 
| `nstat.ipextinbcastpkts`<br/>`DGAUGE`, штуки | Общее количество полученных входящих широковещательных пакетов с IP-адресами.  | 
| `nstat.ipextincepkts`<br/>`DGAUGE`, штуки | Количество полученных IP-пакетов с расширенными сведениями о трафике.  | 
| `nstat.ipextincsumerrors`<br/>`DGAUGE`, штуки | Количество ошибок входящих контрольных сумм с IP-адресами и расширенными сведениями о трафике.  | 
| `nstat.ipextinect0pkts`<br/>`DGAUGE`, штуки | Количество входящих пакетов с IP-адресами и расширенными сведениями о трафике с ECN (управление перегрузкой сети) кодом `0`.  | 
| `nstat.ipextinect1pkts`<br/>`DGAUGE`, штуки | Количество входящих пакетов с IP-адресами и расширенными сведениями о трафике с ECN кодом `1`.  | 
| `nstat.ipextinmcastoctets`<br/>`DGAUGE`, байты | Общее количество полученных входящих байт многоадресного трафика с IP-адресами и расширенными сведениями о трафике.  | 
| `nstat.ipextinmcastpkts`<br/>`DGAUGE`, штуки | Общее количество полученных входящих многоадресных пакетов с IP-адресами и расширенными сведениями о трафике.  | 
| `nstat.ipextinnoectpkts`<br/>`DGAUGE`, штуки | Количество полученных входящих пакетов с IP-адресами и расширенными сведениями о трафике без действующего ECN.  | 
| `nstat.ipextinnoroutes`<br/>`DGAUGE`, штуки | Количество входящих пакетов, сброшенных из-за отсутствия маршрута.  | 
| `nstat.ipextinoctets`<br/>`DGAUGE`, байты | Общее количество полученных входящих байт с IP-адресами и расширенными сведениями о трафике.  | 
| `nstat.ipextintruncatedpkts`<br/>`DGAUGE`, штуки | Количество исходящих пакетов, удаленных из-за превышения размера выборки.  | 
| `nstat.ipextoutbcastoctets`<br/>`DGAUGE`, байты | Общее количество отправленных внешних байт широковещательного трафика с IP-адресами и расширенными сведениями о трафике.  | 
| `nstat.ipextoutbcastpkts`<br/>`DGAUGE`, штуки | Общее количество отправленных внешних широковещательных пакетов с IP-адресами и расширенными сведениями о трафике.  | 
| `nstat.ipextoutmcastoctets`<br/>`DGAUGE`, байты | Общее количество отправленных внешних байт многоадресного трафика с IP-адресами и расширенными сведениями о трафике.  | 
| `nstat.ipextoutmcastpkts`<br/>`DGAUGE`, штуки | Общее количество отправленных внешних многоадресных пакетов с IP-адресами и расширенными сведениями о трафике.  | 
| `nstat.ipextoutoctets`<br/>`DGAUGE`, байты | Общее количество отправленных внешних байт с IP-адресами и расширенными сведениями о трафике.  | 
| `nstat.ipextreasmoverlaps`<br/>`DGAUGE`, штуки | Количество перекрывающихся фрагментов в процессе дефрагментации IP-пакетов.  | 
| `nstat.tcpextarpfilter`<br/>`DGAUGE`, штуки | Количество пакетов, отфильтрованных с помощью фильтра ARP в TCP.  | 
| `nstat.tcpextbusypollrxpackets`<br/>`DGAUGE`, штуки | Количество пакетов, полученных с помощью опроса при занятости в TCP.  | 
| `nstat.tcpextdelayedacklocked`<br/>`DGAUGE`, штуки | Количество блокированных задержанных подтверждений (ACK) в TCP.  | 
| `nstat.tcpextdelayedacklost`<br/>`DGAUGE`, штуки | Количество потерянных задержанных подтверждений (ACK) в TCP.  | 
| `nstat.tcpextdelayedacks`<br/>`DGAUGE`, штуки | Количество задержанных подтверждений (ACK) в TCP.  | 
| `nstat.tcpextembryonicrsts`<br/>`DGAUGE`, штуки | Количество сброшенных соединений на стадии формирования (Embryonic) в TCP.  | 
| `nstat.tcpextipreversepathfilter`<br/>`DGAUGE`, штуки | Количество пакетов, отфильтрованных с помощью обратной фильтрации пути IP в TCP.  | 
| `nstat.tcpextlistendrops`<br/>`DGAUGE`, штуки | Количество отброшенных TCP-соединений в режиме прослушивания.  | 
| `nstat.tcpextlistenoverflows`<br/>`DGAUGE`, штуки | Количество переполнений TCP-соединений в режиме прослушивания.  | 
| `nstat.tcpextlockdroppedicmps`<br/>`DGAUGE`, штуки | Количество отброшенных ICMP-пакетов в результате исчерпания ресурсов блокировок TCP.  | 
| `nstat.tcpextofopruned`<br/>`DGAUGE`, штуки | Количество обработанных TCP-пакетов, исключенных из анализа вследствие превышения определенных ограничений.  | 
| `nstat.tcpextoutofwindowicmps`<br/>`DGAUGE`, штуки | Количество ICMP-пакетов, отброшенных из-за нахождения за пределами окна TCP.  | 
| `nstat.tcpextpawsactive`<br/>`DGAUGE`, штуки | Количество активных таймеров Paws (проверки преждевременного расходования сегментов) TCP.  | 
| `nstat.tcpextpawsestab`<br/>`DGAUGE`, штуки | Количество установленных соединений Paws (проверка преждевременного расходования сегментов) TCP.  | 
| `nstat.tcpextpfmemallocdrop`<br/>`DGAUGE`, штуки | Количество отброшенных TCP-пакетов из-за исчерпания ресурсов аллокации памяти.  | 
| `nstat.tcpextprunecalled`<br/>`DGAUGE`, штуки | Количество вызовов функции прунинга (отбрасывание) TCP.  | 
| `nstat.tcpextrcvpruned`<br/>`DGAUGE`, штуки | Количество TCP-пакетов, отброшенных при приеме из-за ограничений на принимаемый буфер.  | 
| `nstat.tcpextsyncookiesfailed`<br/>`DGAUGE`, штуки | Количество неудачных попыток использования SYN cookies TCP.  | 
| `nstat.tcpextsyncookiesrecv`<br/>`DGAUGE`, штуки | Количество SYN-пакетов TCP, полученных с использованием SYN cookies.  | 
| `nstat.tcpextsyncookiessent`<br/>`DGAUGE`, штуки | Количество SYN-пакетов TCP, отправленных с использованием SYN cookies.  | 
| `nstat.tcpexttcpabortfailed`<br/>`DGAUGE`, штуки | Количество неудачных попыток прерывания TCP-соединений.  | 
| `nstat.tcpexttcpabortonclose`<br/>`DGAUGE`, штуки | Количество прерываний TCP-соединений, вызванных при закрытии.  | 
| `nstat.tcpexttcpabortondata`<br/>`DGAUGE`, штуки | Количество прерываний TCP-соединений, вызванных при передаче данных.  | 
| `nstat.tcpexttcpabortonlinger`<br/>`DGAUGE`, штуки | Количество прерываний TCP-соединений, вызванных при ожидании завершения передачи данных в режиме ожидания (linger).  | 
| `nstat.tcpexttcpabortonmemory`<br/>`DGAUGE`, штуки | Количество прерываний TCP-соединений, вызванных при нехватке памяти.  | 
| `nstat.tcpexttcpabortontimeout`<br/>`DGAUGE`, штуки | Количество прерываний TCP-соединений, вызванных по истечении времени ожидания.  | 
| `nstat.tcpexttcpackcompressed`<br/>`DGAUGE`, штуки | Количество сжатых ACK-пакетов TCP.  | 
| `nstat.tcpexttcpackskippedchallenge`<br/>`DGAUGE`, штуки | Количество пропущенных ACK-пакетов TCP, вызванных вызовом Challenge ACK.  | 
| `nstat.tcpexttcpackskippedfinwait2`<br/>`DGAUGE`, штуки | Количество пропущенных ACK-пакетов TCP, вызванных нахождением соединений в состоянии `FIN_WAIT2`.  | 
| `nstat.tcpexttcpackskippedpaws`<br/>`DGAUGE`, штуки | Количество пропущенных ACK-пакетов TCP, вызванных нахождением соединений в состоянии `PAWS` (проверка преждевременного расходования сегментов).  | 
| `nstat.tcpexttcpackskippedseq`<br/>`DGAUGE`, штуки | Количество пропущенных ACK-пакетов TCP, вызванных нахождением соединений в неправильной последовательности.  | 
| `nstat.tcpexttcpackskippedsynrecv`<br/>`DGAUGE`, штуки | Количество пропущенных ACK-пакетов TCP, вызванных нахождением соединений в состоянии `SYN_RECV`.  | 
| `nstat.tcpexttcpackskippedtimewait`<br/>`DGAUGE`, штуки | Количество пропущенных ACK-пакетов TCP, вызванных нахождением соединений в состоянии `TIME_WAIT`.  | 
| `nstat.tcpexttcpautocorking`<br/>`DGAUGE`, штуки | Количество автоматически выполняемых операций задержки TCP (autocorking).  | 
| `nstat.tcpexttcpbacklogcoalesce`<br/>`DGAUGE`, штуки | Количество объединений задержки TCP (backlog coalesce).  | 
| `nstat.tcpexttcpbacklogdrop`<br/>`DGAUGE`, штуки | Количество TCP-соединений, отброшенных из-за переполнения очереди ожидания.  | 
| `nstat.tcpexttcpchallengeack`<br/>`DGAUGE`, штуки | Количество Challenge ACK-пакетов TCP.  | 
| `nstat.tcpexttcpdeferacceptdrop`<br/>`DGAUGE`, штуки | Количество TCP-соединений, отброшенных при отложенном принятии (defer accept).  | 
| `nstat.tcpexttcpdelivered`<br/>`DGAUGE`, штуки | Количество TCP-пакетов, доставленных успешно.  | 
| `nstat.tcpexttcpdeliveredce`<br/>`DGAUGE`, штуки | Количество TCP-пакетов, доставленных успешно с учетом коррекции ошибок (Checksum Error).  | 
| `nstat.tcpexttcpdsackignorednoundo`<br/>`DGAUGE`, штуки | Количество TCP-пакетов, сигнализирующих о доступности дублирующих (duplicate) блоков данных, которые не были использованы при приеме.  | 
| `nstat.tcpexttcpdsackignoredold`<br/>`DGAUGE`, штуки | Количество TCP-пакетов, сигнализирующих о доступности устаревших (old) данных, полученных при приеме.  | 
| `nstat.tcpexttcpdsackoforecv`<br/>`DGAUGE`, штуки | Количество TCP-пакетов, сигнализирующих о доступности дублирующих (duplicate) блоков данных, которые были отправлены при передаче.  | 
| `nstat.tcpexttcpdsackofosent`<br/>`DGAUGE`, штуки | Количество TCP-пакетов, сигнализирующих о доступности опережающих (out-of-order) блоков данных, полученных при приеме.  | 
| `nstat.tcpexttcpdsackoldsent`<br/>`DGAUGE`, штуки | Количество TCP-пакетов, сигнализирующих о доступности опережающих (out-of-order) блоков данных, отправленных при передаче.  | 
| `nstat.tcpexttcpdsackrecv`<br/>`DGAUGE`, штуки | Количество TCP-пакетов, сигнализирующих о доступности устаревших (old) блоков данных, отправленных при передаче.  | 
| `nstat.tcpexttcpdsackundo`<br/>`DGAUGE`, штуки | Количество TCP-пакетов, сигнализирующих о доступности опережающих (out-of-order) блоков данных, полученных при приеме.  | 
| `nstat.tcpexttcpfastopenactive`<br/>`DGAUGE`, штуки | Количество TCP-пакетов, сигнализирующих о доступности исправленных (undo) блоков данных, полученных при приеме.  | 
| `nstat.tcpexttcpfastopenactivefail`<br/>`DGAUGE`, штуки | Количество неудачных попыток активного использования TCP Fast Open.  | 
| `nstat.tcpexttcpfastopenblackhole`<br/>`DGAUGE`, штуки | Количество пакетов TCP Fast Open, отправленных, но не доставленных (потерянных).  | 
| `nstat.tcpexttcpfastopencookiereqd`<br/>`DGAUGE`, штуки | Количество пакетов TCP Fast Open, запрашивающих использование куки.  | 
| `nstat.tcpexttcpfastopenlistenoverflow`<br/>`DGAUGE`, штуки | Количество пакетов TCP Fast Open, отброшенных при попытке принятия в режиме пассивного использования.  | 
| `nstat.tcpexttcpfastopenpassive`<br/>`DGAUGE`, штуки | Количество пакетов TCP Fast Open, успешно принятых в режиме пассивного использования.  | 
| `nstat.tcpexttcpfastopenpassivealtkey`<br/>`DGAUGE`, штуки | Количество пакетов TCP Fast Open, успешно принятых с использованием альтернативного ключа.  | 
| `nstat.tcpexttcpfastopenpassivefail`<br/>`DGAUGE`, штуки | Количество неудачных попыток принятия пакетов TCP Fast Open в режиме пассивного использования.  | 
| `nstat.tcpexttcpfastretrans`<br/>`DGAUGE`, штуки | Количество TCP-пакетов, быстрых повторных передач (Fast Retransmission).  | 
| `nstat.tcpexttcpfromzerowindowadv`<br/>`DGAUGE`, штуки | Количество объявлений нулевого окна TCP, полученных при отправке.  | 
| `nstat.tcpexttcpfullundo`<br/>`DGAUGE`, штуки | Количество полных отмен (undo) операций TCP.  | 
| `nstat.tcpexttcphpacks`<br/>`DGAUGE`, штуки | Количество TCP-пакетов с флагами `PUSH-ACK` (Pushed ACK).  | 
| `nstat.tcpexttcphphits`<br/>`DGAUGE`, штуки | Количество TCP-пакетов с флагами `PUSH-ACK` и успешным совпадением с хешем (hash).  | 
| `nstat.tcpexttcphystartdelaycwnd`<br/>`DGAUGE`, штуки | Количество задержек при запуске TCP-соединения, связанных со сбором информации о задержке между отправкой и получением пакетов.  | 
| `nstat.tcpexttcphystartdelaydetect`<br/>`DGAUGE`, штуки | Количество обнаруженных задержек при запуске TCP-соединения.  | 
| `nstat.tcpexttcphystarttraincwnd`<br/>`DGAUGE`, штуки | Количество задержек при тренировке TCP-соединения, связанных со сбором информации о задержке отправки и получения пакетов.  | 
| `nstat.tcpexttcphystarttraindetect`<br/>`DGAUGE`, штуки | Количество обнаруженных задержек при тренировке TCP-соединения.  | 
| `nstat.tcpexttcpkeepalive`<br/>`DGAUGE`, штуки | Количество проверок keep-alive TCP.  | 
| `nstat.tcpexttcplossfailures`<br/>`DGAUGE`, штуки | Количество сбоев в передаче TCP.  | 
| `nstat.tcpexttcplossproberecovery`<br/>`DGAUGE`, штуки | Количество восстановлений после сбоев в передаче TCP при использовании метода сбора информации о потерях (Loss Detection).  | 
| `nstat.tcpexttcplossprobes`<br/>`DGAUGE`, штуки | Количество проверок потери TCP-пакетов.  | 
| `nstat.tcpexttcplossundo`<br/>`DGAUGE`, штуки | Количество отмен (undo) операций при потере TCP-пакетов.  | 
| `nstat.tcpexttcplostretransmit`<br/>`DGAUGE`, штуки | Количество повторных передач TCP-пакетов при потере.  | 
| `nstat.tcpexttcpmd5failure`<br/>`DGAUGE`, штуки | Количество сбоев в проверке аутентичности TCP MD5.  | 
| `nstat.tcpexttcpmd5notfound`<br/>`DGAUGE`, штуки | Количество не найденных ключей TCP MD5.  | 
| `nstat.tcpexttcpmd5unexpected`<br/>`DGAUGE`, штуки | Количество неожиданных ошибок аутентификации TCP MD5.  | 
| `nstat.tcpexttcpmemorypressures`<br/>`DGAUGE`, штуки | Количество сбоев из-за недостатка памяти TCP.  | 
| `nstat.tcpexttcpmemorypressureschrono`<br/>`DGAUGE`, штуки | Количество сбоев из-за недостатка памяти TCP с учетом времени.  | 
| `nstat.tcpexttcpminttldrop`<br/>`DGAUGE`, штуки | Количество прерываний TCP-соединений, вызванных минимальным значением TTL.  | 
| `nstat.tcpexttcpmtupfail`<br/>`DGAUGE`, штуки | Количество сбоев в подгонке MTU TCP.  | 
| `nstat.tcpexttcpmtupsuccess`<br/>`DGAUGE`, штуки | Количество успешных подгонок MTU TCP.  | 
| `nstat.tcpexttcpofodrop`<br/>`DGAUGE`, штуки | Количество отброшенных опережающих (out-of-order) TCP-пакетов.  | 
| `nstat.tcpexttcpofomerge`<br/>`DGAUGE`, штуки | Количество объединений опережающих TCP-пакеты.  | 
| `nstat.tcpexttcpofoqueue`<br/>`DGAUGE`, штуки | Количество пакетов опережающих TCP-пакеты в очереди.  | 
| `nstat.tcpexttcporigdatasent`<br/>`DGAUGE`, штуки | Количество отправленных данных TCP до противоположной стороны.  | 
| `nstat.tcpexttcppartialundo`<br/>`DGAUGE`, штуки | Количество частичных операций отмены TCP.  | 
| `nstat.tcpexttcppureacks`<br/>`DGAUGE`, штуки | Количество пакетов с чистыми ACK TCP.  | 
| `nstat.tcpexttcprcvcoalesce`<br/>`DGAUGE`, штуки | Количество объединений TCP-пакетов, полученных при приеме.  | 
| `nstat.tcpexttcprcvcollapsed`<br/>`DGAUGE`, штуки | Количество объединений TCP-пакетов, сжатых при приеме.  | 
| `nstat.tcpexttcprcvqdrop`<br/>`DGAUGE`, штуки | Количество отброшенных TCP-пакетов в очереди приема.  | 
| `nstat.tcpexttcprenofailures`<br/>`DGAUGE`, штуки | Количество сбоев в алгоритме RENO TCP при пересылке пакетов.  | 
| `nstat.tcpexttcprenorecovery`<br/>`DGAUGE`, штуки | Количество успешных восстановлений после сбоев в алгоритме RENO TCP.  | 
| `nstat.tcpexttcprenorecoveryfail`<br/>`DGAUGE`, штуки | Количество неудачных восстановлений после сбоев в алгоритме RENO TCP.  | 
| `nstat.tcpexttcprenoreorder`<br/>`DGAUGE`, штуки | Количество перестановок TCP-пакетов при восстановлении.  | 
| `nstat.tcpexttcpreqqfulldocookies`<br/>`DGAUGE`, штуки | Количество полных запросов (RE-ACK) TCP, требующих использование куков (cookies).  | 
| `nstat.tcpexttcpreqqfulldrop`<br/>`DGAUGE`, штуки | Количество полных запросов (RE-ACK) TCP, отброшенных.  | 
| `nstat.tcpexttcpretransfail`<br/>`DGAUGE`, штуки | Количество сбоев при повторной передаче TCP-пакетов.  | 
| `nstat.tcpexttcpsackdiscard`<br/>`DGAUGE`, штуки | Количество отброшенных блоков SACK (Selective Acknowledgment) TCP.  | 
| `nstat.tcpexttcpsackfailures`<br/>`DGAUGE`, штуки | Количество ошибок при обработке блоков SACK TCP.  | 
| `nstat.tcpexttcpsackmerged`<br/>`DGAUGE`, штуки | Количество слияний блоков SACK (Selective Acknowledgment) TCP.  | 
| `nstat.tcpexttcpsackrecovery`<br/>`DGAUGE`, штуки | Количество восстановлений блоков SACK TCP.  | 
| `nstat.tcpexttcpsackrecoveryfail`<br/>`DGAUGE`, штуки | Количество неудачных восстановлений блоков SACK TCP.  | 
| `nstat.tcpexttcpsackreneging`<br/>`DGAUGE`, штуки | Количество отказов от восстановления блоков SACK TCP.  | 
| `nstat.tcpexttcpsackreorder`<br/>`DGAUGE`, штуки | Количество перестановок блоков SACK TCP.  | 
| `nstat.tcpexttcpsackshifted`<br/>`DGAUGE`, штуки | Количество сдвигов блоков SACK TCP.  | 
| `nstat.tcpexttcpsackshiftfallback`<br/>`DGAUGE`, штуки | Количество откатов на сдвиги блоков SACK TCP.  | 
| `nstat.tcpexttcpslowstartretrans`<br/>`DGAUGE`, штуки | Количество повторных передач в медленном старте TCP.  | 
| `nstat.tcpexttcpspuriousrtos`<br/>`DGAUGE`, штуки | Количество ложных срабатываний RTO (Retransmission Time-Out) TCP.  | 
| `nstat.tcpexttcpspuriousrtxhostqueues`<br/>`DGAUGE`, штуки | Количество ложных повторных передач в очередь хоста TCP.  | 
| `nstat.tcpexttcpsynchallenge`<br/>`DGAUGE`, штуки | Количество вызовов синхронизации TCP.  | 
| `nstat.tcpexttcpsynretrans`<br/>`DGAUGE`, штуки | Количество повторных передач синхронизаций TCP.  | 
| `nstat.tcpexttcptimeouts`<br/>`DGAUGE`, штуки | Количество истекших временных интервалов TCP.  | 
| `nstat.tcpexttcptimewaitoverflow`<br/>`DGAUGE`, штуки | Количество переполнений ожидания TCP TIME_WAIT.  | 
| `nstat.tcpexttcptozerowindowadv`<br/>`DGAUGE`, штуки | Количество объявлений нулевого размера TCP окна в сегменте.  | 
| `nstat.tcpexttcptsreorder`<br/>`DGAUGE`, штуки | Количество перестановок TCP-пакетов в сегменте.  | 
| `nstat.tcpexttcpwantzerowindowadv`<br/>`DGAUGE`, штуки | Количество объявлений нулевого размера TCP окна в сегменте.  | 
| `nstat.tcpexttcpwinprobe`<br/>`DGAUGE`, штуки | Количество исследовательских сегментов TCP окна.  | 
| `nstat.tcpexttcpwqueuetoobig`<br/>`DGAUGE`, штуки | Количество сбоев из-за переполнения очереди TCP отправки.  | 
| `nstat.tcpexttcpzerowindowdrop`<br/>`DGAUGE`, штуки | Количество отброшенных сегментов с нулевым размером окна TCP.  | 
| `nstat.tcpexttw`<br/>`DGAUGE`, штуки | Количество сокетов TCP в состоянии `TIME_WAIT`.  | 
| `nstat.tcpexttwkilled`<br/>`DGAUGE`, штуки | Количество прерванных сокетов TCP в состоянии `TIME_WAIT`.  | 
| `nstat.tcpexttwrecycled`<br/>`DGAUGE`, штуки | Количество переиспользованных сокетов TCP в состоянии `TIME_WAIT`.  | 
| `ping.average_response_ms`<br/>`DGAUGE`, миллисекунды | Среднее время ответа пинга. |
| `ping.maximum_response_ms`<br/>`DGAUGE`, миллисекунды | Максимальное время ответа пинга. |
| `ping.minimum_response_ms`<br/>`DGAUGE`, миллисекунды | Минимальное время ответа пинга. |
| `ping.packets_received`<br/>`DGAUGE`, штуки | Количество полученных пакетов пинга. |
| `ping.packets_transmitted`<br/>`DGAUGE`, штуки | Количество отправленных пакетов пинга. |
| `ping.percent_packet_loss`<br/>`DGAUGE`, % | Доля потерянных пакетов пинга. |
| `ping.result_code`<br/>`DGAUGE`, `0`-`4` | Результат кода пинга. |
| `ping.standard_deviation_ms`<br/>`DGAUGE`, миллисекунды | Стандартное отклонение времени ответа пинга. |
| `ping.ttl`<br/>`DGAUGE`, штуки | TTL пинга — количество переходов (hop) между сетевыми узлами (обычно измеряемое в количестве маршрутизаторов), которые должен пройти пакет пинга. |

## Метрики сервиса {#managed-greenplum-metrics}
| Имя<br/>Тип, единицы измерения | Описание |
| ----- | ----- |
| `gp.conn_aborted`<br/>`DGAUGE`, штуки | Количество соединений с БД. Статус соединения: `aborted`. | 
| `gp.conn_active`<br/>`DGAUGE`, штуки | Количество соединений с БД. Статус соединения: `active`. | 
| `gp.conn_count`<br/>`DGAUGE`, штуки | Количество соединений с БД. | 
| `gp.conn_idle`<br/>`DGAUGE`, штуки | Количество соединений с БД. Статус соединения: `idle`. | 
| `gp.conn_idle_in_transaction`<br/>`DGAUGE`, штуки | Количество соединений с БД. Статус соединения: `idle_in_transaction`. | 
| `gp.conn_user_count`<br/>`DGAUGE`, штуки | Количество установленных пользовательских соединений с БД.  | 
| `gp.conn_waiting`<br/>`DGAUGE`, штуки | Количество ожидающих в очереди подключений к БД. | 
| `gp.connect_percent`<br/>`DGAUGE`, % | Процент соединений. | 
| `gp.has_alive`<br/>`DGAUGE` | Индикатор, показывающий наличие «живых» сегментов. `1` — все сегменты работают нормально, `0` — указывает на отсутствие рабочих сегментов.  | 
| `gp.has_dead`<br/>`DGAUGE` | Индикатор наличия «мертвых» или неработающих сегментов. Значение `1` — есть неработающие сегменты, `0` — нет неработающих сегментов.  | 
| `gp.is_alive`<br/>`DGAUGE` | Показатель работоспособности хоста.<br/>Принимает значение `1`, если хост БД работает, `0`, если нет. | 
| `gp.is_alive_segment`<br/>`DGAUGE` | Показатель работоспособности хоста-сегмента.<br/>Принимает значение `1`, если хост БД работает, `0`, если нет. | 
| `gp.is_dead`<br/>`DGAUGE` | Показатель работоспособности хоста.<br/>Принимает значение `0`, если хост БД работает, `1`, если нет. | 
| `gp.is_master`<br/>`DGAUGE` | Показатель типа хоста.<br/>Принимает значение `1`, если хост является мастер-хостом БД, `0`, если нет. | 
| `gp.master_replication_state`<br/>`DGAUGE` | Состояние репликации мастера. | 
| `gp.percent_xid_wraparound`<br/>`DGAUGE`, % | Использование последовательности идентификаторов транзакций.<br/>Дополнительные метки: `db_name` | 
| `gp.ping`<br/>`DGAUGE` | <br/>Дополнительные метки: `can_read`, `is_master`, `can_write`| 
| `gp.pxf_is_alive`<br/>`DGAUGE` | Показатель доступности расширения PXF. | 
| `gp.replication_lag_mb`<br/>`DGAUGE`, мегабайты | Задержка репликации данных между мастер-сегментом и зеркальным сегментом.  | 
| `gp.rg_cpu_used`<br/>`DGAUGE` | Распределение CPU по ресурсным группам.<br/>Дополнительные метки: `resgroup` | 
| `gp.rg_mem_available`<br/>`DGAUGE` | Распределение доступной памяти по ресурсным группам.<br/>Дополнительные метки: `resgroup` | 
| `gp.rg_mem_used`<br/>`DGAUGE` | Распределение использованной памяти по ресурсным группам.<br/>Дополнительные метки: `resgroup` | 
| `gp.seg_count`<br/>`DGAUGE`, штуки | Количество сегментов в кластере. | 
| `gp.seg_down`<br/>`DGAUGE` | Недоступные сегменты. |
| `gp.seg_not_pref_role`<br/>`DGAUGE`, штуки | Количество сегментов, работающих не в предпочтительной роли (то есть мастер-сегменты выполняют роль зеркальных и наоборот).  | 
| `gp.seg_not_synch`<br/>`DGAUGE` | Несинхронизированные сегменты. | 
| `gp.segment_conn_aborted`<br/>`DGAUGE`, штуки | Общее количество прерванных сегментных соединений.  | 
| `gp.segment_conn_active`<br/>`DGAUGE`, штуки | Количество активных соединений с сегментами.  | 
| `gp.segment_conn_count`<br/>`DGAUGE`, штуки | Общее количество соединений с сегментами.  | 
| `gp.segment_conn_idle`<br/>`DGAUGE`, штуки | Количество простаивающих соединений с сегментами.  | 
| `gp.segment_conn_idle_in_transaction`<br/>`DGAUGE`, штуки | Количество простаивающих соединений с сегментами, находящихся в транзакции.  | 
| `gp.segment_conn_waiting`<br/>`DGAUGE`, штуки | Количество соединений с сегментами, ожидающих выполнение запроса.  | 
| `gp.spill_files_num_per_seghost`<br/>`DGAUGE`, штуки | Число временных файлов на хост. | 
| `gp.spill_files_size_per_seghost`<br/>`DGAUGE`, байты | Размер временных файлов на хост. |

#### Системные метрики {#managed-greenplum-config-metrics}
| Имя<br/>Тип, единицы измерения | Описание |
| ----- | ----- |
| `system.load.avg_1min`<br/>`DGAUGE`, % | Средняя нагрузка процессора за 1 минуту. |
| `system.load.avg_5min`<br/>`DGAUGE`, % | Средняя нагрузка процессора за 5 минут. |
| `system.load.avg_15min`<br/>`DGAUGE`, % | Средняя нагрузка процессора за 15 минут. |
| `system.n_cpus`<br/>`DGAUGE`, штуки | Предельное число используемых ядер. |
| `system.n_users`<br/>`DGAUGE`, штуки | Предельное число пользователей. |
| `system.uptime`<br/>`DGAUGE`, % | Коэффициент отказоустойчивости. | 

## Метрики PXF {#managed-greenplum-pxf-metrics}

PXF помечает все метрики, которые он возвращает, меткой `application` со значением `pxf-service`.

Дополнительные метки:

* `profile` — имя профиля PXF.
* `segment` — идентификатор сегмента базы данных, обрабатывающего определенный блок данных.
* `server` — имя сервера, с которым PXF взаимодействует для доступа к данным.
* `user` — имя пользователя, выполнившего операцию.

| Имя<br/>Тип, единицы измерения | Описание |
| ----- | ----- |
| `pxf.jvm_memory_committed_bytes`<br/>`DGAUGE`, байты | Размер выделенной операционной системой памяти для JVM PXF. | 
| `pxf.jvm_memory_max_bytes`<br/>`DGAUGE`, байты | Максимальный размер доступной JVM PXF памяти. | 
| `pxf.jvm_memory_used_bytes`<br/>`DGAUGE`, байты | Размер использованной памяти JVM PXF. | 
| `pxf.jvm_threads_daemon_threads`<br/>`DGAUGE`, штуки | Количество потоков-демонов JVM PXF. | 
| `pxf.jvm_threads_live_threads`<br/>`DGAUGE`, штуки | Количество активных потоков JVM PXF. | 
| `pxf.jvm_threads_states_threads`<br/>`DGAUGE`, штуки | Количество потоков JVM PXF в каждом состоянии. | 
| `pxf.log4j2_events_total`<br/>`DGAUGE`, штуки | Общее количество событий Log4j2 в JVM PXF. | 
| `pxf.process_files_max_files`<br/>`DGAUGE`, штуки | Максимальное количество одновременно открытых файлов в процессе PXF. | 
| `pxf.process_files_open_files`<br/>`DGAUGE`, штуки | Количество текущих открытых файлов в процессе PXF. | 
| `pxf.pxf_bytes_receivced_total`<br/>`DGAUGE`, байты | Количество байтов, полученнных PXF. | 
| `pxf.pxf_bytes_sent_total`<br/>`DGAUGE`, байты | Количество байтов, отправленных PXF. | 
| `pxf.pxf_fragments_sent`<br/>`DGAUGE`, штуки | Количество фрагментов данных, отправленных PXF.<br/>Дополнительная метка: `outcome`. Принимает значение `success`, если успешно отправлены все данные фрагмента, `error`, если нет. | 
| `pxf.pxf_records_receivced_total`<br/>`DGAUGE`, штуки | Количество записей, полученнных PXF. | 
| `pxf.pxf_records_sent_total`<br/>`DGAUGE`, штуки | Количество записей, отправленных PXF. | 
| `pxf.tomcat_connections_config_max_connections`<br/>`DGAUGE`, штуки | Максимальное количество соединений в настройках Tomcat PXF. | 
| `pxf.tomcat_connections_current_connections`<br/>`DGAUGE`, штуки | Количество текущих соединений в Tomcat PXF. | 
| `pxf.tomcat_connections_keepalive_current_connections`<br/>`DGAUGE`, штуки | Количество текущих соединений keepalive в Tomcat PXF. | 
| `pxf.tomcat_threads_busy_threads`<br/>`DGAUGE`, штуки | Количество занятых потоков в Tomcat PXF. | 
| `pxf.tomcat_threads_config_max_threads`<br/>`DGAUGE`, штуки | Максимальное количество потоков в настройках Tomcat PXF. | 
| `pxf.tomcat_threads_current_threads`<br/>`DGAUGE`, штуки | Количество текущих потоков в Tomcat PXF. | 

## Метрики SNMP {#managed-greenplum-snmp-metrics}
| Имя<br/>Тип, единицы измерения | Описание |
| ----- | ----- |
| `snmp.icmpinaddrmaskreps`<br/>`DGAUGE`, штуки | Количество полученных ответных ICMP-сообщений с маской адреса от опрашиваемого узла (в сетевом протоколе SNMP). |
| `snmp.icmpinaddrmasks`<br/>`DGAUGE`, штуки | Количество полученных сообщений с запросом маски ICMP-адреса (в сетевом протоколе SNMP). |
| `snmp.icmpincsumerrors`<br/>`DGAUGE`, штуки | Увеличивается, когда полученный ICMP-пакет имеет неправильную контрольную сумму (в сетевом протоколе SNMP). |
| `snmp.icmpindestunreachs`<br/>`DGAUGE`, штуки | Количество полученных сообщений о недоступности назначения ICMP (в сетевом протоколе SNMP). |
| `snmp.icmpinechoreps`<br/>`DGAUGE`, штуки | Количество полученных ICMP-сообщений Echo Reply (в сетевом протоколе SNMP). |
| `snmp.icmpinechos`<br/>`DGAUGE`, штуки | Количество полученных ICMP-сообщений Echo (запросов) (в сетевом протоколе SNMP). |
| `snmp.icmpinerrors`<br/>`DGAUGE`, штуки | Количество полученных ICMP-пакетов с ошибками, не включая ошибки контрольной суммы (в сетевом протоколе SNMP). |
| `snmp.icmpinmsgs`<br/>`DGAUGE`, штуки | Общее количество полученных ICMP-сообщений (в сетевом протоколе SNMP). |
| `snmp.icmpinparmprobs`<br/>`DGAUGE`, штуки | Количество полученных сообщений о неполадках с параметрами ICMP (в сетевом протоколе SNMP). |
| `snmp.icmpinredirects`<br/>`DGAUGE`, штуки | Количество полученных сообщений о перенаправлении ICMP (в сетевом протоколе SNMP). |
| `snmp.icmpinsrcquenchs`<br/>`DGAUGE`, штуки | Количество полученных ICMP-сообщений Source Quench (в сетевом протоколе SNMP). |
| `snmp.icmpintimeexcds`<br/>`DGAUGE`, штуки | Количество полученных сообщений с превышением времени ICMP превысило количество полученных сообщений (в сетевом протоколе SNMP). |
| `snmp.icmpintimestampreps`<br/>`DGAUGE`, штуки | Количество полученных ответных сообщений с меткой времени ICMP (в сетевом протоколе SNMP). |
| `snmp.icmpintimestamps`<br/>`DGAUGE`, штуки | Количество полученных сообщений (запросов) с меткой времени ICMP (в сетевом протоколе SNMP). |
| `snmp.icmpmsgintype0`<br/>`DGAUGE`, штуки | Количество ICMP-сообщений типа 0 (Echo Reply) (в сетевом протоколе SNMP). |
| `snmp.icmpmsgintype3`<br/>`DGAUGE`, штуки | Количество ICMP-сообщений типа 3 (Destination Unreachable) (в сетевом протоколе SNMP). |
| `snmp.icmpmsgintype8`<br/>`DGAUGE`, штуки | Количество ICMP-сообщений типа 8 (Echo Request) (в сетевом протоколе SNMP). |
| `snmp.icmpmsgouttype0`<br/>`DGAUGE`, штуки | Количество отправленных ICMP-сообщений типа 0 (Echo Reply) (в сетевом протоколе SNMP). |
| `snmp.icmpmsgouttype3`<br/>`DGAUGE`, штуки | Количество отправленных ICMP-сообщений типа 3 (Destination Unreachable) (в сетевом протоколе SNMP). |
| `snmp.icmpmsgouttype8`<br/>`DGAUGE`, штуки | Количество отправленных ICMP-сообщений типа 8 (Echo Request) (в сетевом протоколе SNMP). |
| `snmp.icmpoutaddrmaskreps`<br/>`DGAUGE`, штуки | Количество отправленных ответных сообщений по маске ICMP-адреса (в сетевом протоколе SNMP). |
| `snmp.icmpoutaddrmasks`<br/>`DGAUGE`, штуки | Количество отправленных сообщений с запросом маски ICMP-адреса (в сетевом протоколе SNMP). |
| `snmp.icmpoutdestunreachs`<br/>`DGAUGE`, штуки | Количество отправленных сообщений о недоступности назначения ICMP (в сетевом протоколе SNMP). |
| `snmp.icmpoutechoreps`<br/>`DGAUGE`, штуки | Количество отправленных ICMP-сообщений Echo Reply (в сетевом протоколе SNMP). |
| `snmp.icmpoutechos`<br/>`DGAUGE`, штуки | Количество отправленных ICMP-сообщений Echo (запросов) (в сетевом протоколе SNMP). |
| `snmp.icmpouterrors`<br/>`DGAUGE`, штуки | Количество ICMP-сообщений, которые этот объект не отправил из-за проблем, обнаруженных в ICMP, таких как нехватка буферов (в сетевом протоколе SNMP). |
| `snmp.icmpoutmsgs`<br/>`DGAUGE`, штуки | Общее количество ICMP-сообщений, которые пытался отправить этот объект. Включает все сообщения, подсчитанные `snmp.icmpouterrors` (в сетевом протоколе SNMP). |
| `snmp.icmpoutparmprobs`<br/>`DGAUGE`, штуки | Количество отправленных сообщений о проблемах с параметрами ICMP (в сетевом протоколе SNMP). |
| `snmp.icmpoutredirects`<br/>`DGAUGE`, штуки | Количество отправленных сообщений с перенаправлениями маршрута (в сетевом протоколе SNMP). |
| `snmp.icmpoutsrcquenchs`<br/>`DGAUGE`, штуки | Количество отправленных сообщений Source Quench по протоколу ICMP (в сетевом протоколе SNMP). |
| `snmp.icmpouttimeexcds`<br/>`DGAUGE`, штуки | Количество отправленных сообщений с превышением времени ICMP превысило количество отправленных сообщений (в сетевом протоколе SNMP). |
| `snmp.icmpouttimestampreps`<br/>`DGAUGE`, штуки | Количество отправленных ответных сообщений с меткой времени ICMP (в сетевом протоколе SNMP). |
| `snmp.icmpouttimestamps`<br/>`DGAUGE`, штуки | Количество отправленных сообщений с меткой времени ICMP (в сетевом протоколе SNMP). |
| `snmp.ipdefaultttl`<br/>`DGAUGE`, штуки | Значение по умолчанию, вставляемое в поле Time-To-Live заголовка IP-пакетов, созданных в этом объекте, когда значение TTL не предоставляется протоколом транспортного уровня. |
| `snmp.ipforwarding`<br/>`DGAUGE` | Состояние пересылки IP (в сетевом протоколе SNMP) (`0` — отключено, `1` — включено). |
| `snmp.ipforwdatagrams`<br/>`DGAUGE`, штуки | Количество входящих пакетов, для которых этот объект не был их конечным IP-адресатом, в результате чего была предпринята попытка найти маршрут для пересылки их в этот конечный пункт назначения. В объектах, которые не действуют как IP-маршрутизаторы, этот счетчик будет включать только те пакеты, которые были перенаправлены источником через этот объект, и обработка параметра исходного маршрута прошла успешно (в сетевом протоколе SNMP). |
| `snmp.ipfragcreates`<br/>`DGAUGE`, штуки | Количество фрагментов IP-пакетов, которые были сгенерированы в результате фрагментации в этом объекте (в сетевом протоколе SNMP). |
| `snmp.ipfragfails`<br/>`DGAUGE`, штуки | Количество IP-пакетов, которые были отброшены, поскольку они должны были быть фрагментированы в этом объекте, но не могли быть фрагментированы, например, потому что был установлен флаг, запрещающий фрагментацию (в сетевом протоколе SNMP). |
| `snmp.ipfragoks`<br/>`DGAUGE`, штуки | Количество успешных фрагментаций IP-пакетов (в сетевом протоколе SNMP). |
| `snmp.ipinaddrerrors`<br/>`DGAUGE`, штуки | Количество входящих пакетов, отброшенных из-за того, что IP-адрес в поле назначения их IP-заголовка не был допустимым адресом для получения в этом объекте. Это количество включает недопустимые адреса (например, `0.0.0.0`) и адреса неподдерживаемых классов (например, класс E). Для объектов, которые не являются IP-маршрутизаторами и, следовательно, не пересылают пакеты, этот счетчик включает пакеты, отброшенные из-за того, что адрес назначения не был локальным адресом (в сетевом протоколе SNMP). |
| `snmp.ipindelivers`<br/>`DGAUGE`, штуки | Общее количество доставленных IP-пакетов (в сетевом протоколе SNMP). |
| `snmp.ipindiscards`<br/>`DGAUGE`, штуки | Количество входящих IP-пакетов, для которых не возникло проблем, препятствующих их дальнейшей обработке, но которые были отброшены (например, из-за нехватки места в буфере). Этот счетчик не включает в себя пакеты, отброшенные в ожидании повторной сборки (в сетевом протоколе SNMP). |
| `snmp.ipinhdrerrors`<br/>`DGAUGE`, штуки | Количество входящих пакетов с ошибками в заголовке (в сетевом протоколе SNMP). |
| `snmp.ipinreceives`<br/>`DGAUGE`, штуки | Общее количество входящих пакетов, полученных от интерфейсов, включая полученные по ошибке (в сетевом протоколе SNMP). |
| `snmp.ipinunknownprotos`<br/>`DGAUGE`, штуки |Количество полученных пакетов с неизвестными протоколами (в сетевом протоколе SNMP). |
| `snmp.ipoutdiscards`<br/>`DGAUGE`, штуки | Количество выходящих IP-пакетов, для которых не возникло проблем, препятствующих их передаче по назначению, но которые были отброшены (например, из-за нехватки места в буфере). Обратите внимание, что этот счетчик включал бы пакеты, подсчитанные в `snmp.ipforwdatagrams`, если бы такие пакеты удовлетворяли этому (дискреционному) критерию отбрасывания (в сетевом протоколе SNMP). |
| `snmp.ipoutnoroutes`<br/>`DGAUGE`, штуки | Количество отброшенных IP-пакетов, для которых не удалось найти маршрут для их передачи по назначению. Этот счетчик включает все пакеты, подсчитанные в `snmp.ipforwdatagrams`, которые соответствуют критерию «без маршрута». Сюда входят любые пакеты, которые хост не может перенаправить, поскольку все его маршрутизаторы по умолчанию не работают. |
| `snmp.ipoutrequests`<br/>`DGAUGE`, штуки | Общее количество IP-пакетов, которые локальные пользовательские протоколы IP (включая ICMP) передали IP в запросах на передачу. Этот счетчик не включает в себя пакеты, подсчитанные в `snmp.ipforwdatagrams` (в сетевом протоколе SNMP). |
| `snmp.ipreasmfails`<br/>`DGAUGE`, штуки | Количество сбоев, обнаруженных алгоритмом повторной сборки IP (по любой причине: тайм-аут, ошибки и т.д.). Это не обязательно количество отброшенных IP-фрагментов, поскольку некоторые алгоритмы (в частности, алгоритм в RFC 815) могут потерять отслеживание количества фрагментов, объединяя их по мере их получения (в сетевом протоколе SNMP). |
| `snmp.ipreasmoks`<br/>`DGAUGE`, штуки | Количество IP-пакетов, успешно собранных повторно (в сетевом протоколе SNMP). |
| `snmp.ipreasmreqds`<br/>`DGAUGE`, штуки | Количество полученных IP-фрагментов, которые необходимо было повторно собрать в этом объекте (в сетевом протоколе SNMP). |
| `snmp.ipreasmtimeout`<br/>`DGAUGE`, секунды | Максимальное количество секунд, в течение которых удерживаются полученные фрагменты, пока они ожидают повторной сборки в этом объекте (в сетевом протоколе SNMP). |
| `snmp.tcpactiveopens`<br/>`DGAUGE`, штуки | Количество раз, когда TCP-соединения совершали прямой переход из состояния `CLOSED` в состояние `SYN-SENT` (в сетевом протоколе SNMP). |
| `snmp.tcpattemptfails`<br/>`DGAUGE`, штуки | Количество раз, когда TCP-соединения совершали прямой переход в состояние `CLOSED` либо из состояния `SYN-SENT`, либо из состояния `SYN-RCVD`, плюс количество раз, когда TCP-соединения совершали прямой переход (в сетевом протоколе SNMP). |
| `snmp.tcpcurrestab`<br/>`DGAUGE`, штуки | Текущее количество TCP-соединений для состояния `ESTABLISHED` или `CLOSE WAIT` (в сетевом протоколе SNMP). |
| `snmp.tcpestabresets`<br/>`DGAUGE`, штуки | Количество раз, когда TCP-соединения совершали прямой переход в состояние `CLOSED` либо из состояния `ESTABLISHED`, либо из состояния `CLOSE-WAIT` (в сетевом протоколе SNMP). |
| `snmp.tcpincsumerrors`<br/>`DGAUGE`, штуки | Увеличивается, когда полученный TCP-пакет имеет неправильную контрольную сумму (в сетевом протоколе SNMP). |
| `snmp.tcpinerrs`<br/>`DGAUGE`, штуки | Общее количество сегментов, полученных с ошибкой (например, неверные контрольные суммы TCP) (в сетевом протоколе SNMP). |
| `snmp.tcpinsegs`<br/>`DGAUGE`, штуки | Общее количество полученных сегментов, включая те, которые были получены по ошибке (в сетевом протоколе SNMP). |
| `snmp.tcpmaxconn`<br/>`DGAUGE`, штуки | Максимальное количество допустимых TCP-соединений (в сетевом протоколе SNMP). |
| `snmp.tcpoutrsts`<br/>`DGAUGE`, штуки | Количество отправленных TCP-сегментов, содержащих флаг `RST` (в сетевом протоколе SNMP). |
| `snmp.tcpoutsegs`<br/>`DGAUGE`, штуки | Количество исходящих TCP-сегментов (в сетевом протоколе SNMP). |
| `snmp.tcppassiveopens`<br/>`DGAUGE`, штуки | Количество раз, когда TCP-соединения осуществляли прямой переход в состояние `SYN-RCVD` из состояния `LISTEN` (в сетевом протоколе SNMP). |
| `snmp.tcpretranssegs`<br/>`DGAUGE`, штуки | Общее количество повторно переданных сегментов, то есть количество переданных TCP-сегментов, содержащих один или несколько ранее переданных октетов (в сетевом протоколе SNMP). |
| `snmp.tcprtoalgorithm`<br/>`DGAUGE` | Алгоритм, используемый для определения значения тайм-аута, используемого для повторной передачи неподтвержденных октетов. |
| `snmp.tcprtomax`<br/>`DGAUGE`, миллисекунды | Максимальное значение, разрешенное реализацией TCP для времени ожидания повторной передачи, измеряемое в миллисекундах (в сетевом протоколе SNMP). |
| `snmp.tcprtomin`<br/>`DGAUGE`, миллисекунды | Минимальное значение, разрешенное реализацией TCP для времени ожидания повторной передачи, измеряемое в миллисекундах (в сетевом протоколе SNMP). |
| `snmp.udpignoredmulti`<br/>`DGAUGE`, штуки | Для многоадресной рассылки UDP (в сетевом протоколе SNMP). |
| `snmp.udpincsumerrors`<br/>`DGAUGE`, штуки | Увеличивается, когда полученный UDP-пакет содержит недопустимую контрольную сумму кода ядра (в сетевом протоколе SNMP). |
| `snmp.udpindatagrams`<br/>`DGAUGE`, штуки | Общее количество принятых UDP-пакетов (в сетевом протоколе SNMP). |
| `snmp.udpinerrors`<br/>`DGAUGE`, штуки | Количество полученных UDP-пакетов с ошибками, не включая ошибки контрольной суммы (в сетевом протоколе SNMP). |
| `snmp.udpliteignoredmulti`<br/>`DGAUGE`, штуки | Для многоадресной рассылки UDP-Lite (в сетевом протоколе SNMP). |
| `snmp.udpliteincsumerrors`<br/>`DGAUGE`, штуки | Увеличивается, когда полученный пакет UDP-Lite содержит недопустимую контрольную сумму кода ядра (в сетевом протоколе SNMP). |
| `snmp.udpliteindatagrams`<br/>`DGAUGE`, штуки | Общее количество принятых пакетов UDP-Lite (в сетевом протоколе SNMP). |
| `snmp.udpliteinerrors`<br/>`DGAUGE`, штуки | Общее количество ошибок при получении пакетов UDP-Lite (в сетевом протоколе SNMP). |
| `snmp.udplitenoports`<br/>`DGAUGE`, штуки | Общее количество принятых пакетов UDP-Lite, для которых на порте назначения не было слушателя (в сетевом протоколе SNMP). |
| `snmp.udpliteoutdatagrams`<br/>`DGAUGE`, штуки | Общее количество пакетов UDP-Lite, отправленных от этого объекта (в сетевом протоколе SNMP). |
| `snmp.udplitercvbuferrors`<br/>`DGAUGE`, штуки | Увеличивается, когда память не может быть выделена для обработки входящего пакета UDP-Lite (в сетевом протоколе SNMP). |
| `snmp.udplitesndbuferrors`<br/>`DGAUGE`, штуки | Увеличивается, когда память не может быть выделена для отправки пакета UDP-Lite (в сетевом протоколе SNMP). |
| `snmp.udpnoports`<br/>`DGAUGE`, штуки | Общее количество принятых UDP-пакетов, для которых на порте назначения не было слушателя (в сетевом протоколе SNMP). |
| `snmp.udpoutdatagrams`<br/>`DGAUGE`, штуки | Общее количество UDP-пакетов, отправленных от этого объекта (в сетевом протоколе SNMP). |
| `snmp.udprcvbuferrors`<br/>`DGAUGE`, штуки | Количество ошибок буфера приема UDP (в сетевом протоколе SNMP). |
| `snmp.udpsndbuferrors`<br/>`DGAUGE`, штуки | Количество ошибок буфера отправки UDP (в сетевом протоколе SNMP). |
| `snmp6.icmp6incsumerrors`<br/>`DGAUGE`, штуки | Увеличивается, когда полученный ICMPv6-пакет содержит недопустимую контрольную сумму кода ядра (в сетевом протоколе SNMP). |
| `snmp6.icmp6indestunreachs`<br/>`DGAUGE`, штуки | Количество полученных сообщений о недоступности назначения ICMPv6 (в сетевом протоколе SNMP). |
| `snmp6.icmp6inechoreplies`<br/>`DGAUGE`, штуки | Количество входящих ответов на Echo Request ICMPv6 (в сетевом протоколе SNMP). |
| `snmp6.icmp6inechos`<br/>`DGAUGE`, штуки | Количество полученных ICMPv6-сообщений Echo (запросов) (в сетевом протоколе SNMP). |
| `snmp6.icmp6inerrors`<br/>`DGAUGE`, штуки | Количество полученных ICMPv6-пакетов с ошибками, не включая ошибки контрольной суммы (в сетевом протоколе SNMP). |
| `snmp6.icmp6ingroupmembqueries`<br/>`DGAUGE`, штуки | Количество запросов на присоединение к группе (Multicast Listener Query) ICMPv6 (в сетевом протоколе SNMP). |
| `snmp6.icmp6ingroupmembreductions`<br/>`DGAUGE`, штуки | Количество сокращений участников группы (Multicast Listener Reduction) ICMPv6 (в сетевом протоколе SNMP). |
| `snmp6.icmp6ingroupmembresponses`<br/>`DGAUGE`, штуки | Количество ответов на запросы на присоединение к группе ICMPv6 (в сетевом протоколе SNMP). |
| `snmp6.icmp6inmldv2reports`<br/>`DGAUGE`, штуки | Количество отчетов MLDv2 ICMPv6 (в сетевом протоколе SNMP). |
| `snmp6.icmp6inmsgs`<br/>`DGAUGE`, штуки | Общее количество полученных ICMPv6-сообщений (в сетевом протоколе SNMP). |
| `snmp6.icmp6inneighboradvertisements`<br/>`DGAUGE`, штуки | Количество объявлений соседей (Neighbor Advertisement) ICMPv6 (в сетевом протоколе SNMP). |
| `snmp6.icmp6inneighborsolicits`<br/>`DGAUGE`, штуки | Количество запросов соседей (Neighbor Solicitation) ICMPv6 (в сетевом протоколе SNMP). |
| `snmp6.icmp6inparmproblems`<br/>`DGAUGE`, штуки | Количество ошибок входящих ICMPv6-сообщений о некорректных параметрах (в сетевом протоколе SNMP). |
| `snmp6.icmp6inpkttoobigs`<br/>`DGAUGE`, штуки | Количество входящих ICMPv6-сообщений о слишком больших пакетах (в сетевом протоколе SNMP). |
| `snmp6.icmp6inredirects`<br/>`DGAUGE`, штуки | Количество полученных сообщений о перенаправлении ICMPv6 (в сетевом протоколе SNMP). |
| `snmp6.icmp6inrouteradvertisements`<br/>`DGAUGE`, штуки | Количество объявлений маршрутизаторов (Router Advertisement) ICMPv6 (в сетевом протоколе SNMP). |
| `snmp6.icmp6inroutersolicits`<br/>`DGAUGE`, штуки | Количество запросов маршрутизаторов (Router Solicitation) ICMPv6 (в сетевом протоколе SNMP). |
| `snmp6.icmp6intimeexcds`<br/>`DGAUGE`, штуки | Количество полученных сообщений с превышением времени ICMPv6 превысило количество полученных сообщений (в сетевом протоколе SNMP). |
| `snmp6.icmp6intype1`<br/>`DGAUGE`, штуки | Количество входящих ICMPv6-сообщений типа 1 (Destination Unreachable) (в сетевом протоколе SNMP). |
| `snmp6.icmp6intype128`<br/>`DGAUGE`, штуки | Количество входящих ICMPv6-сообщений типа 128 (Echo Request) (в сетевом протоколе SNMP). |
| `snmp6.icmp6intype134`<br/>`DGAUGE`, штуки | Количество входящих ICMPv6-сообщений типа 134 (Router Solicitation) (в сетевом протоколе SNMP). |
| `snmp6.icmp6intype135`<br/>`DGAUGE`, штуки | Количество входящих ICMPv6-сообщений типа 135 (Neighbor Solicitation`) (в сетевом протоколе SNMP). |
| `snmp6.icmp6intype136`<br/>`DGAUGE`, штуки | Количество входящих ICMPv6-сообщений типа 136 (Neighbor Advertisement) (в сетевом протоколе SNMP). |
| `snmp6.icmp6outdestunreachs`<br/>`DGAUGE`, штуки | Количество исходящих ICMPv6-сообщений типа 1 (Destination Unreachable) (в сетевом протоколе SNMP). |
| `snmp6.icmp6outechoreplies`<br/>`DGAUGE`, штуки | Количество исходящих ответов на Echo Request ICMPv6 (в сетевом протоколе SNMP). |
| `snmp6.icmp6outechos`<br/>`DGAUGE`, штуки | Количество отправленных ICMPv6-сообщений (в сетевом протоколе SNMP). |
| `snmp6.icmp6outerrors`<br/>`DGAUGE`, штуки | Количество ICMPv6-сообщений, которые этот объект не отправил из-за проблем, обнаруженных в ICMP, таких как нехватка буферов (в сетевом протоколе SNMP). |
| `snmp6.icmp6outgroupmembqueries`<br/>`DGAUGE`, штуки | Количество отправленных запросов на присоединение к группе (Multicast Listener Query) ICMPv6 (в сетевом протоколе SNMP). |
| `snmp6.icmp6outgroupmembreductions`<br/>`DGAUGE`, штуки | Количество отправленных сокращений участников группы (Multicast Listener Reduction) ICMPv6 (в сетевом протоколе SNMP). |
| `snmp6.icmp6outgroupmembresponses`<br/>`DGAUGE`, штуки | Количество отправленных ответов на запросы на присоединение к группе ICMPv6 (в сетевом протоколе SNMP). |
| `snmp6.icmp6outmldv2reports`<br/>`DGAUGE`, штуки | Количество отправленных отчетов MLDv2 ICMPv6 (в сетевом протоколе SNMP). |
| `snmp6.icmp6outmsgs`<br/>`DGAUGE`, штуки | Общее количество ICMPv6-сообщений, которые пытался отправить этот объект. Включает все сообщения, подсчитанные `snmp6.icmp6outerrors` (в сетевом протоколе SNMP). |
| `snmp6.icmp6outneighboradvertisements`<br/>`DGAUGE`, штуки | Количество отправленных объявлений соседей (Neighbor Advertisement) ICMPv6 (в сетевом протоколе SNMP). |
| `snmp6.icmp6outneighborsolicits`<br/>`DGAUGE`, штуки | Количество отправленных запросов соседей (Neighbor Solicitation) ICMPv6 (в сетевом протоколе SNMP). |
| `snmp6.icmp6outparmproblems`<br/>`DGAUGE`, штуки | Количество ошибок при отправке ICMPv6-сообщений о некорректных параметрах (в сетевом протоколе SNMP). |
| `snmp6.icmp6outpkttoobigs`<br/>`DGAUGE`, штуки | Количество ошибок при отправке ICMPv6-сообщений о слишком больших пакетах (в сетевом протоколе SNMP). |
| `snmp6.icmp6outredirects`<br/>`DGAUGE`, штуки | Количество отправленных ICMPv6-сообщений с перенаправлениями маршрута (в сетевом протоколе SNMP). |
| `snmp6.icmp6outrouteradvertisements`<br/>`DGAUGE`, штуки | Количество отправленных объявлений маршрутизаторов (Router Advertisement) ICMPv6 (в сетевом протоколе SNMP). |
| `snmp6.icmp6outroutersolicits`<br/>`DGAUGE`, штуки | Количество отправленных запросов маршрутизаторов (Router Solicitation) ICMPv6 (в сетевом протоколе SNMP). |
| `snmp6.icmp6outtimeexcds`<br/>`DGAUGE`, штуки | Количество отправленных сообщений с превышением времени ICMPv6 превысило количество отправленных сообщений (в сетевом протоколе SNMP). |
| `snmp6.icmp6outtype1`<br/>`DGAUGE`, штуки | Количество отправленных ICMPv6-сообщений типа 1 (Destination Unreachable) (в сетевом протоколе SNMP). |
| `snmp6.icmp6outtype129`<br/>`DGAUGE`, штуки | Количество отправленных ICMPv6-сообщений типа 129 (в сетевом протоколе SNMP). |
| `snmp6.icmp6outtype133`<br/>`DGAUGE`, штуки | Количество отправленных ICMPv6-сообщений типа 133 (Router Solicitation) (в сетевом протоколе SNMP). |
| `snmp6.icmp6outtype135`<br/>`DGAUGE`, штуки | Количество отправленных ICMPv6-сообщений типа 135 (Neighbor Solicitation) (в сетевом протоколе SNMP). |
| `snmp6.icmp6outtype136`<br/>`DGAUGE`, штуки | Количество отправленных ICMPv6-сообщений типа 136 (Neighbor Advertisement`) (в сетевом протоколе SNMP). |
| `snmp6.icmp6outtype143`<br/>`DGAUGE`, штуки | Количество отправленных ICMPv6-сообщений типа 143 (в сетевом протоколе SNMP). |
| `snmp6.ip6fragcreates`<br/>`DGAUGE`, штуки | Количество фрагментов IPv6-пакетов, которые были сгенерированы в результате фрагментации в этом объекте (в сетевом протоколе SNMP). |
| `snmp6.ip6fragfails`<br/>`DGAUGE`, штуки | Количество IPv6-пакетов, которые были отброшены, поскольку они должны были быть фрагментированы в этом объекте, но не могли быть фрагментированы, например, потому что был установлен флаг, запрещающий фрагментацию (в сетевом протоколе SNMP). |
| `snmp6.ip6fragoks`<br/>`DGAUGE`, штуки | Количество успешных фрагментаций IPv6-пакетов (в сетевом протоколе SNMP). |
| `snmp6.ip6inaddrerrors`<br/>`DGAUGE`, штуки | Количество входящих пакетов, отброшенных из-за того, что IP-адрес в поле назначения их IPv6-заголовка не был допустимым адресом для получения в этом объекте. Это количество включает недопустимые адреса (например, `0.0.0.0`) и адреса неподдерживаемых классов (например, класс E). Для объектов, которые не являются IP-маршрутизаторами и, следовательно, не пересылают пакеты, этот счетчик включает пакеты, отброшенные из-за того, что адрес назначения не был локальным адресом (в сетевом протоколе SNMP). |
| `snmp6.ip6inbcastoctets`<br/>`DGAUGE`, штуки | Общее количество полученных входящих широковещательных байт с IPv6-адресами (в сетевом протоколе SNMP). |
| `snmp6.ip6incepkts`<br/>`DGAUGE`, штуки | Количество полученных IPv6-пакетов с расширенными сведениями о трафике (в сетевом протоколе SNMP). |
| `snmp6.ip6indelivers`<br/>`DGAUGE`, штуки | Общее количество доставленных IPv6-пакетов (в сетевом протоколе SNMP). |
| `snmp6.ip6indiscards`<br/>`DGAUGE`, штуки | Количество входящих IPv6-пакетов, для которых не возникло проблем, препятствующих их дальнейшей обработке, но которые были отброшены (например, из-за нехватки места в буфере). Этот счетчик не включает в себя пакеты, отброшенные в ожидании повторной сборки (в сетевом протоколе SNMP). |
| `snmp6.ip6inect0pkts`<br/>`DGAUGE`, штуки | Количество принятых IPv6-пакетов с классом трафика `0` (в сетевом протоколе SNMP). |
| `snmp6.ip6inect1pkts`<br/>`DGAUGE`, штуки | Количество принятых IPv6-пакетов с классом трафика `1` (в сетевом протоколе SNMP). |
| `snmp6.ip6inhdrerrors`<br/>`DGAUGE`, штуки | Количество входящих пакетов с ошибками в заголовке IPv6 (в сетевом протоколе SNMP). |
| `snmp6.ip6inmcastoctets`<br/>`DGAUGE`, штуки | Общее количество полученных входящих байт многоадресного трафика с IPv6-адресами и расширенными сведениями о трафике (в сетевом протоколе SNMP). |
| `snmp6.ip6inmcastpkts`<br/>`DGAUGE`, штуки | Общее количество полученных входящих многоадресных пакетов с IPv6-адресами и расширенными сведениями о трафике (в сетевом протоколе SNMP). |
| `snmp6.ip6innoectpkts`<br/>`DGAUGE`, штуки | Количество принятых IPv6-пакетов без класса трафика (в сетевом протоколе SNMP). |
| `snmp6.ip6innoroutes`<br/>`DGAUGE`, штуки | Количество входящих IPv6-пакетов, сброшенных из-за отсутствия маршрута (в сетевом протоколе SNMP). |
| `snmp6.ip6inoctets`<br/>`DGAUGE`, штуки | Общее количество полученных входящих байт с IPv6-адресами и расширенными сведениями о трафике (в сетевом протоколе SNMP). |
| `snmp6.ip6inreceives`<br/>`DGAUGE`, штуки | Общее количество входящих IPv6-пакетов, полученных от интерфейсов, включая полученные по ошибке (в сетевом протоколе SNMP). |
| `snmp6.ip6intoobigerrors`<br/>`DGAUGE`, штуки | Количество принятых IPv6-пакетов с ошибкой `Превышение размера` (в сетевом протоколе SNMP). |
| `snmp6.ip6intruncatedpkts`<br/>`DGAUGE`, штуки | Количество исходящих IPv6-пакетов, удаленных из-за превышения размера выборки (в сетевом протоколе SNMP). |
| `snmp6.ip6inunknownprotos`<br/>`DGAUGE`, штуки | Количество полученных IPv6-пакетов с неизвестными протоколами (в сетевом протоколе SNMP). |
| `snmp6.ip6outbcastoctets`<br/>`DGAUGE`, штуки | Общее количество отправленных внешних байт широковещательного трафика с IPv6-адресами и расширенными сведениями о трафике (в сетевом протоколе SNMP). |
| `snmp6.ip6outdiscards`<br/>`DGAUGE`, штуки | Количество выходящих IPv6-пакетов, для которых не возникло проблем, препятствующих их передаче по назначению, но которые были отброшены (например, из-за нехватки места в буфере) (в сетевом протоколе SNMP). |
| `snmp6.ip6outforwdatagrams`<br/>`DGAUGE`, штуки | Количество отправленных IPv6-пакетов для передачи в сеть (в сетевом протоколе SNMP). |
| `snmp6.ip6outmcastoctets`<br/>`DGAUGE`, штуки | Общее количество отправленных внешних байт многоадресного трафика с IPv6-адресами и расширенными сведениями о трафике (в сетевом протоколе SNMP). |
| `snmp6.ip6outmcastpkts`<br/>`DGAUGE`, штуки | Общее количество отправленных внешних многоадресных пакетов с IPv6-адресами и расширенными сведениями о трафике (в сетевом протоколе SNMP). |
| `snmp6.ip6outnoroutes`<br/>`DGAUGE`, штуки | Количество отброшенных IPv6-пакетов, для которых не удалось найти маршрут для их передачи по назначению (в сетевом протоколе SNMP). |
| `snmp6.ip6outoctets`<br/>`DGAUGE`, штуки | Общее количество отправленных внешних байт с IPv6-адресами и расширенными сведениями о трафике (в сетевом протоколе SNMP). |
| `snmp6.ip6outrequests`<br/>`DGAUGE`, штуки | Общее количество IPv6-пакетов, которые локальные пользовательские протоколы IPv6 (включая ICMP) передали IPv6 в запросах на передачу (в сетевом протоколе SNMP). |
| `snmp6.ip6reasmfails`<br/>`DGAUGE`, штуки | Количество сбоев, обнаруженных алгоритмом повторной сборки IPv6 (по любой причине: тайм-аут, ошибки и т.д.). Это не обязательно количество отброшенных IPv6-фрагментов, поскольку некоторые алгоритмы (в частности, алгоритм в RFC 815) могут потерять отслеживание количества фрагментов, объединяя их по мере их получения (в сетевом протоколе SNMP). |
| `snmp6.ip6reasmoks`<br/>`DGAUGE`, штуки | Количество IPv6-пакетов, успешно собранных повторно (в сетевом протоколе SNMP). |
| `snmp6.ip6reasmreqds`<br/>`DGAUGE`, штуки | Количество полученных IPv6-фрагментов, которые необходимо было повторно собрать в этом объекте (в сетевом протоколе SNMP). |
| `snmp6.ip6reasmtimeout`<br/>`DGAUGE`, штуки | Максимальное количество секунд, в течение которых удерживаются полученные IPv6-фрагменты, пока они ожидают повторной сборки в этом объекте (в сетевом протоколе SNMP). |
| `snmp6.udp6ignoredmulti`<br/>`DGAUGE`, штуки | Количество проигнорированных многоадресных UDPv6-пакетов (в сетевом протоколе SNMP). |
| `snmp6.udp6incsumerrors`<br/>`DGAUGE`, штуки | Увеличивается, когда полученный UDPv6-пакет содержит недопустимую контрольную сумму кода ядра (в сетевом протоколе SNMP). |
| `snmp6.udp6indatagrams`<br/>`DGAUGE`, штуки | Общее количество принятых UDPv6-пакетов (в сетевом протоколе SNMP). |
| `snmp6.udp6inerrors`<br/>`DGAUGE`, штуки | Количество полученных UDPv6-пакетов с ошибками, не включая ошибки контрольной суммы (в сетевом протоколе SNMP). |
| `snmp6.udp6noports`<br/>`DGAUGE`, штуки | Общее количество полученных UDPv6-пакетов, для которых на порту назначения не было приложения (в сетевом протоколе SNMP). |
| `snmp6.udp6outdatagrams`<br/>`DGAUGE`, штуки | Общее количество UDPv6-пакетов, отправленных от этого объекта (в сетевом протоколе SNMP). |
| `snmp6.udp6rcvbuferrors`<br/>`DGAUGE`, штуки | Количество ошибок буфера приема UDPv6 (в сетевом протоколе SNMP). |
| `snmp6.udp6sndbuferrors`<br/>`DGAUGE`, штуки | Количество ошибок буфера отправки UDPv6 (в сетевом протоколе SNMP). |
| `snmp6.udplite6incsumerrors`<br/>`DGAUGE`, штуки | Увеличивается, когда полученный пакет UDP-Litev6 содержит недопустимую контрольную сумму кода ядра (в сетевом протоколе SNMP). |
| `snmp6.udplite6indatagrams`<br/>`DGAUGE`, штуки | Общее количество принятых пакетов UDP-Litev6 (в сетевом протоколе SNMP). |
| `snmp6.udplite6inerrors`<br/>`DGAUGE`, штуки | Общее количество ошибок при получении пакетов UDP-Litev6 (в сетевом протоколе SNMP). |
| `snmp6.udplite6noports`<br/>`DGAUGE`, штуки | Количество полученных пакетов UDP-Litev6, для которых не найден соответствующий порт приемника (в сетевом протоколе SNMP). |
| `snmp6.udplite6outdatagrams`<br/>`DGAUGE`, штуки | Общее количество пакетов UDP-litev6, отправленных от этого объекта (в сетевом протоколе SNMP). |
| `snmp6.udplite6rcvbuferrors`<br/>`DGAUGE`, штуки | Количество ошибок буфера приема UDP-Litev6 (в сетевом протоколе SNMP). |
| `snmp6.udplite6sndbuferrors`<br/>`DGAUGE`, штуки | Количество ошибок буфера отправки UDP-Litev6 (в сетевом протоколе SNMP). |
