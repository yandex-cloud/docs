---
title: Параметры командного центра {{ GP }}
description: Из статьи вы узнаете, какую информацию о сессиях и запросах можно получить в командном центре {{ GP }}.
---

# Параметры командного центра {{ GP }}

В этом разделе описаны параметры сессий и запросов, доступные в [командном центре {{ GP }}](command-center.md).

## Сессия {#cc-session}

**{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_section_resources }}**:

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-cpu-time }}** — время, которое понадобилось ресурсам CPU для обработки запросов.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-peak-memory }}** — максимальное количество памяти, которое потребовалось для обработки запросов.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-spill-total-bytes }}** — суммарный размер файлов, сгенерированных и выгруженных на диск в ходе выполнения запроса.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-read-bytes }}** — количество байт, прочитанных с диска во время выполнения запроса.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-write-bytes }}** — количество байт, записанных на диск во время выполнения запроса.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-net-recv-chunks }}** — количество пакетов, принятых в рамках процесса `interconnect`.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-net-sent-chunks }}** — количество пакетов, отправленных в рамках процесса `interconnect`.

**{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_section_session-info }}**:

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-user }}** — имя пользователя.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-database }}** — имя БД.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-state-changed }}** — дата и время последнего изменения состояния.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-backend-start }}** — дата и время начала сессии.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-application }}** — имя приложения подключенного клиента.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-session-client-hostname }}** — имя хоста подключенного клиента.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-session-pid }}** — идентификатор текущей сессии.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-session-client-addr }}** — IP-адрес подключенного клиента.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-session-client-port }}** — номер порта, который клиент использует для подключения.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-session-xact-start }}** — дата и время начала текущей транзакции.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-session-waiting }}** — ожидает ли сессия завершения блокирующих ее событий.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-session-backend-xmin }}** — номер самой ранней транзакции.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-session-rsgid }}** — идентификатор объекта [ресурсной группы](../../managed-greenplum/concepts/resource-groups.md).

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-session-rsgname }}** — имя текущей ресурсной группы.

**{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_section_session-queries }}**:

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-running-query-key }}** — [ключ запроса](../../managed-greenplum/concepts/command-center.md#statement-key).

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-query-text }}** — текст выполняемого запроса.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-backend-start }}** — дата и время, когда запрос начал выполняться.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-query-status }}** — состояние выполняемого запроса.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-plan-id }}** — идентификатор плана выполнения запроса.

**{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_section_other-resources }}**:

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-total-system_stat-user_time_seconds }}** — время, которое понадобилось ресурсам CPU для выполнения инструкций программы.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-total-system_stat-kernel_time_seconds }}** — время, которое понадобилось ресурсам CPU для обработки системных вызовов.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-total-system_stat-rss }}** — объем памяти, использованный для выполнения запросов сессии (в байтах).

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-total-system_stat-vsize }}** — объем памяти, выделенный сессии.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-total-system_stat-rchar }}** — количество прочитанных символов.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-total-system_stat-wchar }}** — количество записанных символов.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-total-system_stat-syscr }}** — количество операций чтения.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-total-system_stat-syscw }}** — количество операций записи.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-total-system_stat-cancelled_write_bytes }}** — объем данных, запись которых была отменена.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-net-sent-chunks }}** — количество пакетов, отправленных в рамках процесса `interconnect`.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-net-recv-chunks }}** — количество пакетов, принятых в рамках процесса `interconnect`.

**{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_section_optimizations }}**:

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-total-instrumentation-nloops }}** — количество вызовов узла плана.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-total-instrumentation-firsttuple }}** — время, затраченное на обработку первой строки (в секундах).

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-total-instrumentation-startup }}** — время, затраченное на запуск оператора (в секундах).

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-total-instrumentation-total }}** — общее время, затраченное на работу со строками.

**{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_section_counters }}**:

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-total-instrumentation-shared_blks_hit }}** — количество блоков разделяемой памяти, полученных из буфера.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-total-instrumentation-shared_blks_read }}** — количество блоков разделяемой памяти, которые пришлось прочитать с диска, потому что их не было в буфере.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-total-instrumentation-shared_blks_dirtied }}** — количество блоков разделяемой памяти, которые были изменены и поэтому подлежат записи на диск.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-total-instrumentation-shared_blks_written }}** — количество блоков разделяемой памяти, записанных на диск.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-total-instrumentation-local_blks_hit }}** — количество локальных блоков, полученных из буфера.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-total-instrumentation-local_blks_read }}** — количество локальных блоков, которые пришлось прочитать с диска, потому что их не было в буфере.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-total-instrumentation-local_blks_written }}** — количество локальных блоков, записанных на диск.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-total-instrumentation-temp_blks_read }}** — количество блоков временных файлов, прочитанных с диска.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-total-instrumentation-temp_blks_written }}** — количество блоков временных файлов, записанных на диск.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-total-instrumentation-blk_read_time }}** — время, затраченное на чтение блоков.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-total-instrumentation-blk_write_time }}** — время, затраченное на запись блоков.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-total-spill-file_count }}** — количество временных файлов.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-instrumentation-startup-time }}** — время, затраченное на ожидание ресурсов и планирование.

## Запрос {#cc-query}

**{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_section_resources }}**:

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-cpu-time }}** — время, которое понадобилось ресурсам CPU для обработки запросов.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-peak-memory }}** — максимальное количество памяти, которое потребовалось для обработки запросов.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-spill-total-bytes }}** — суммарный размер файлов, сгенерированных и выгруженных на диск в ходе выполнения запроса.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-read-bytes }}** — количество байт, прочитанных с диска во время выполнения запроса.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-write-bytes }}** — количество байт, записанных на диск во время выполнения запроса.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-net-recv-chunks }}** — количество пакетов, принятых в рамках процесса `interconnect`.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-net-sent-chunks }}** — количество пакетов, отправленных в рамках процесса `interconnect`.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-skew }}** — перекос (неравномерное распределение данных по сегментам).

**{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_section_query-info }}**:

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-query-key }}** — уникальный атрибут, который присваивается запросу во время его выполнения.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-start-time }}** — дата и время, когда началось выполнение запроса.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-end-time }}** — дата и время, когда выполнение запроса завершилось.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-generator }}** — [оптимизатор запросов](https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/7/greenplum-database/admin_guide-query-topics-optimizer-hints.html).

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-min-time }}** — минимальное время выполнения запроса.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-max-time }}** — максимальное время выполнения запроса.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-username }}** — имя пользователя.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-database }}** — имя БД.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-query-id }}** — [неуникальный хеш](../../managed-greenplum/concepts/command-center.md#statement-id), полученный из текста запроса.

**{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_section_other-resources }}**:

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-user-time-seconds }}** — время, которое понадобилось ресурсам CPU для выполнения инструкций программы.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-kernel-time-seconds }}** — время, которое понадобилось ресурсам CPU для обработки системных вызовов.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-rss }}** — объем памяти, использованный для выполнения запроса (в байтах).

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-vsize }}** — объем памяти, выделенный для выполнения запроса.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-rchar }}** — количество прочитанных символов.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-wchar }}** — количество записанных символов.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-syscr }}** — количество операций чтения.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-syscw }}** — количество операций записи.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-cancelled_write_bytes }}** — объем данных, запись которых была отменена.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-net-sent-chunks }}** — количество пакетов, отправленных в рамках процесса `interconnect`.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-net-recv-chunks }}** — количество пакетов, принятых в рамках процесса `interconnect`.

**{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_section_optimizations }}**:

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-nloops }}** — количество вызовов узла плана.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-firsttuple }}** — время, затраченное на обработку первой строки (в секундах).

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-startup }}** — время, затраченное на запуск оператора (в секундах).

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-total-time }}** — общее время, затраченное на работу со строками.

**{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_section_counters }}**:

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-shared_blks_hit }}** — количество блоков разделяемой памяти, полученных из буфера.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-shared-blks-read }}** — количество блоков разделяемой памяти, которые пришлось прочитать с диска, потому что их не было в буфере.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-shared-blks-dirtied }}** — количество блоков разделяемой памяти, которые были изменены и поэтому подлежат записи на диск.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-shared_blks_written }}** — количество блоков разделяемой памяти, записанных на диск.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-local_blks_hit }}** — количество локальных блоков, полученных из буфера.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-local_blks_read }}** — количество локальных блоков, которые пришлось прочитать с диска, потому что их не было в буфере.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-local_blks_dirtied }}** — количество локальных блоков, которые были изменены и поэтому подлежат записи на диск.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-local_blks_written }}** — количество локальных блоков, записанных на диск.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-temp_blks_read }}** — количество блоков временных файлов, прочитанных с диска.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-temp_blks_written }}** — количество блоков временных файлов, записанных на диск.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-blk_read_time }}** — время, затраченное на чтение блоков.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-blk_write_time }}** — время, затраченное на запись блоков.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-query-spill-file_count }}** — количество временных файлов.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-instrumentation-startup-time }}** — время, затраченное на ожидание ресурсов и планирование.

## Сетевая статистика interconnect {#cc-interconnect}

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_interconnect-active-connections-num }}** — максимальное зафиксированное количество активных исходящих соединений.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_interconnect-buffer-counting-time }}** — монотонно возрастающий счетчик, который показывает, сколько раз перед отправкой пакетов подсчитывалось количество доступных буферов. Возрастает каждый раз, когда устанавливается исходящее соединение.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_interconnect-capacity-counting-time }}** — монотонно возрастающий счетчик, который показывает, сколько раз подсчитывался размер исходящей очереди. Возрастает каждый раз, когда обрабатывается соединение.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_interconnect-crc-errors }}** — монотонно возрастающий счетчик, который показывает, сколько пакетов не прошло [проверку контрольной суммы](https://ru.wikipedia.org/wiki/Циклический_избыточный_код). Работает, если включена опция `gp_interconnect_full_crc`.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_interconnect-disordered-pkt-num }}** — монотонно возрастающий счетчик неупорядоченных пакетов. Возрастает, если выполняется хотя бы одно из условий:
  
  * порядковый номер входящего пакета не соответствует ожидаемому;
  * при обработке входящих пакетов очередь переполнилась и пакет не был сохранен.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_interconnect-duplicated-pkt-num }}** — монотонно возрастающий счетчик дублирующихся пакетов. Возрастает, если порядковый номер входящего пакета меньше максимального номера среди уже обработанных пакетов.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_interconnect-mismatch-num }}** — монотонно возрастающий счетчик несоответствующих пакетов. Это пакеты, которые относятся к предыдущему запросу либо относятся к текущему запросу, но еще не готовы к обработке.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_interconnect-recv-ack-num }}** — монотонно возрастающий счетчик подтверждений входящих пакетов.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_interconnect-recv-pkt-num }}** — монотонно возрастающий счетчик обработанных входящих пакетов.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_interconnect-recv-queue-size-counting-time }}** — монотонно возрастающий счетчик, который показывает, сколько раз подсчитывался размер входящей очереди. Возрастает каждый раз, когда обрабатывается соединение.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_interconnect-retransmits }}** — монотонно возрастающий счетчик повторно переданных пакетов. Повторно передаются неупорядоченные и устаревшие пакеты.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_interconnect-snd-pkt-num }}** — монотонно возрастающий счетчик отправленных пакетов.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_interconnect-startup-cached-pkt-num }}** — монотонно возрастающий счетчик закешированных пакетов, которые получены, но еще не готовы к обработке.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_interconnect-status-query-msg-num }}** — монотонно возрастающий счетчик переданных статусных пакетов. Они используются для проверки состояния соединения, если некоторое время не приходит подтверждение об отправке пакетов.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_interconnect-total-buffers }}** — минимальное количество доступных буферов, зафиксированное перед отправкой пакетов.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_interconnect-total-capacity }}** — максимальный размер исходящей очереди (в пакетах).

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_interconnect-total-recv-queue-size }}** — максимальный размер входящей очереди (в пакетах).

Больше информации о работе процесса `interconnect` см. в [официальной документации](https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/admin_guide-intro-arch_overview.html#arch_interconnect).

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
