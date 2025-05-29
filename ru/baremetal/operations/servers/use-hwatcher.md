---
title: Как проанализировать состояние дисков сервера {{ baremetal-name }}
description: Следуя данной инструкции, вы сможете использовать утилиту HW Watcher, чтобы сформировать отчет о состоянии сервера, его дисков и периферийных устройств.
---

# Проанализировать состояние дисков сервера {{ baremetal-name }} с помощью утилиты HW Watcher

Если в процессе работы с [сервером](../../concepts/servers.md) {{ baremetal-name }} вы столкнулись с ошибками чтения/записи данных на диски, отказом диска или [RAID](https://ru.wikipedia.org/wiki/RAID)-массива, вы можете выполнить [диагностику сервера](../../concepts/smart-disk-analysis.md), которая позволит определить источник проблемы и сформирует отчет для [отправки]({{ link-console-support }}/tickets/create) в службу технической поддержки.

{% note info %}

Использовать утилиту `HW Watcher` можно только на серверах под управлением ОС [Linux](https://ru.wikipedia.org/wiki/Linux).

{% endnote %}

## Сформируйте отчет {#generate-report}

Чтобы сформировать отчет о состоянии системы с помощью утилиты `HW Watcher`:

1. Подключитесь к серверу с ОС Linux по [SSH](../../../glossary/ssh-keygen.md), выполнив в терминале команду:

    ```bash
    ssh root@<публичный_IP-адрес_сервера>
    ```
1. Скачайте утилиту:

    ```bash
    wget https://{{ s3-storage-host }}/baremetal/support/hwcheck
    ```
1. Добавьте root-пользователю права на выполнение скачанного исполняемого файла:

    ```bash
    chmod u+x hwcheck
    ```
1. Запустите скачанную утилиту:

    ```bash
    ./hwcheck
    ```

    В результате файлы отчета будут сохранены в архив:

    ```text
    ...
    Save data to archive: hwcheck_my-sample-server-_2025-05-27_20-31-04.tgz
    ```
1. Чтобы посмотреть отчеты о состоянии отдельных дисков сервера, распакуйте полученный архив, указав его имя:

    ```bash
    tar -xvzf <имя_файла_с_архивом_отчета>
    ```
1. В директории `drive` посмотрите список файлов с отчетами о состоянии дисков:

    ```
    ls ./drive/ -l
    ```

    Результат:

    ```text
    total 24
    -rw-r--r-- 1 root root 8957 May 27 20:31 sda-smartctl
    -rw-r--r-- 1 root root 8957 May 27 20:31 sdb-smartctl
    ```
1. Посмотрите содержимое файла с отчетом о нужном диске — идентификатор дискового устройства указан в имени файла:

    ```bash
    cat ./drive/sda-smartctl
    ```

    В числе прочего, на экран будет выведена таблица со значениями [SMART](https://ru.wikipedia.org/wiki/S.M.A.R.T.)-атрибутов диска:

    ```text
    ...
    SMART Attributes Data Structure revision number: 1
    Vendor Specific SMART Attributes with Thresholds:
    ID# ATTRIBUTE_NAME          FLAGS    VALUE WORST THRESH FAIL RAW_VALUE
      5 Reallocated_Sector_Ct   PO--CK   100   100   010    -    0
      9 Power_On_Hours          -O--CK   086   086   000    -    67715
     12 Power_Cycle_Count       -O--CK   099   099   000    -    108
    177 Wear_Leveling_Count     PO--C-   062   062   005    -    1182
    179 Used_Rsvd_Blk_Cnt_Tot   PO--C-   100   100   010    -    0
    180 Unused_Rsvd_Blk_Cnt_Tot PO--C-   100   100   010    -    17618
    181 Program_Fail_Cnt_Total  -O--CK   100   100   000    -    0
    182 Erase_Fail_Count_Total  -O--CK   100   100   000    -    0
    183 Runtime_Bad_Block       PO--C-   100   100   010    -    0
    184 End-to-End_Error        PO--CK   100   100   097    -    0
    187 Reported_Uncorrect      -O--CK   100   100   000    -    0
    190 Airflow_Temperature_Cel -O--CK   074   049   000    -    26
    195 Hardware_ECC_Recovered  -O-RC-   200   200   000    -    0
    199 UDMA_CRC_Error_Count    -OSRCK   100   100   000    -    0
    202 Unknown_SSD_Attribute   PO--CK   100   100   010    -    0
    235 Unknown_Attribute       -O--C-   099   099   000    -    68
    241 Total_LBAs_Written      -O--CK   099   099   000    -    2179265164499
                                ||||||_ K auto-keep
                                |||||__ C event count
                                ||||___ R error rate
                                |||____ S speed/performance
                                ||_____ O updated online
                                |______ P prefailure warning
    ...
    ``` 

    Вы можете самостоятельно [проанализировать](../../concepts/smart-disk-analysis.md) полученные результаты или [обратиться](#report-issue) за помощью в службу технической поддержки.

## Отправьте отчет в службу технической поддержки {#report-issue}

Чтобы отправить полученный отчет в службу технической поддержки:

1. Скопируйте отчет с сервера на ваш локальный компьютер, выполнив команду в терминале локального компьютера:

    ```bash
    scp root@<публичный_IP-адрес_сервера>:/root/<имя_файла_с_архивом_отчета> ./
    ```

    В результате файл с отчетом будет сохранен в текущую директорию на вашем локальном компьютере.
1. [Создайте]({{ link-console-support }}/tickets/create) обращение в службу технической поддержки.

    В обращении подробно опишите возникшую с сервером проблему и приложите сохраненный архив с отчетом.

#### См. также {#see-also}

* [{#T}](../../concepts/smart-disk-analysis.md)
* [{#T}](./switch-raid-member.md)