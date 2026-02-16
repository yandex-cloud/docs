---
title: Проверить пропускную способность InfiniBand
description: Следуя данной инструкции, вы сможете запустить тест пропускной способности InfiniBand на одной машине с разделением ресурсов по NUMA-нодам.
---

# Проверить пропускную способность InfiniBand

1. [Подключитесь](../../../compute/operations/vm-connect/ssh.md) к ВМ по SSH.
1. Установите инструменты для тестирования:

   ```bash
   sudo apt update
   sudo apt install perftest numactl
   ```

1. Создайте файл `/etc/security/limits.d/limits.conf` со следующим содержимым:

   ```text
   * soft memlock unlimited
   * hard memlock unlimited
   ```

1. Выйдите из системы и войдите заново или перезагрузите машину, чтобы изменения вступили в силу. Проверьте лимит командой:

   ```text
   ulimit -l
   ```

   Результат должен быть `unlimited`.

1. Создайте файл `infiniband_test.sh` со следующим содержимым:

   ```bash
   #!/bin/bash
   set -eu

   # Проверка лимита memlock
   echo "Текущий лимит memlock:"
   ulimit -l
   if [[ $(ulimit -l) != "unlimited" ]]; then
      echo "Лимит memlock не установлен в unlimited."
      echo "Создайте файл /etc/security/limits.d/limits.conf со следующим содержимым:"
      echo "* soft memlock unlimited"
      echo "* hard memlock unlimited"
      exit 1
   fi

   # Функция очистки: остановка всех процессов ib_write_bw при завершении скрипта
   clean() {
      killall -9 ib_write_bw &>/dev/null
   }
   trap clean EXIT

   # Параметры теста
   size=33554432  # размер блока (в байтах)
   iters=10000    # количество итераций
   q=1

   # Задайте номера CPU и названия сетевых устройств для разных NUMA-нод
   # Пример:
   numa0_cpu=40      # CPU для клиента (NUMA нода 0)
   numa1_cpu=130     # CPU для сервера (NUMA нода 1)
   numa0_net=mlx5_0  # сетевой интерфейс для клиента
   numa1_net=mlx5_7  # сетевой интерфейс для сервера

   # Запуск сервера на NUMA-ноде 1
   numactl -C $numa1_cpu --membind 1 /usr/bin/ib_write_bw --ib-dev=$numa1_net --report_gbits -s $size  --iters $iters -q $q &>/dev/null &
   sleep 1

   # Запуск клиента на NUMA-ноде 0 с высоким приоритетом
   nice -20 numactl -C $numa0_cpu  --membind 0 /usr/bin/ib_write_bw --ib-dev=$numa0_net --report_gbits -s $size --iters $iters -q $q localhost &
   wait
   ```

1. Сделайте скрипт исполняемым:

   ```bash
   chmod +x infiniband_test.sh
   ```

1. Запустите скрипт:

   ```bash
   ./infiniband_test.sh
   ```

   Результат:

   ```text
   ---------------------------------------------------------------------------------------
   #bytes     #iterations    BW peak[Gb/sec]    BW average[Gb/sec]   MsgRate[Mpps]
   33554432    10000            394.58             394.40                    0.001469
   ---------------------------------------------------------------------------------------
   ```