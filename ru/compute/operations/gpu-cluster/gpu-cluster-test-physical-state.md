---
title: Проверить физическое состояние кластера GPU
description: Следуя данной инструкции, вы сможете проверить работоспособность InfiniBand-соединений между GPU в кластере.
---

# Проверить физическое состояние кластера GPU


## Проверьте состояния портов InfiniBand { #check-state }

1. [Подключитесь](../../../compute/operations/vm-connect/ssh.md) к ВМ по SSH.
1. Установите пакет `infiniband-diags`:

   ```bash
   sudo apt update
   sudo apt install infiniband-diags
   ```

1. Выполните команду `ibstatus`.

   Результат:

   ```text
   state:           4: ACTIVE
   phys state:      5: LinkUp
   ```

1. Убедитесь, что для всех портов в параметре `phys state` указано `LinkUp`.

## Проверьте производительность сети

Для проверки скорости передачи данных между GPU на разных ВМ:

1. На каждой из тестовых ВМ установите пакет `perftest`:

   ```bash
   sudo apt install perftest
   ```

1. Подключитесь к первой ВМ по SSH.
1. Выполните команду:

   ```bash
   ib_send_bw --report_gbits
   ```

1. Подключитесь ко второй ВМ по SSH.
1. Выполните команду:

   ```bash
   ib_send_bw <внутренний_IP_первой_ВМ> --report_gbits
   ```

   Результат:
   
   ```text
   #bytes     #iterations    BW peak[Gb/sec]    BW average[Gb/sec]   MsgRate[Mpps]
   65536      1000             245.54             244.08             0.465536
   ```

1. Убедитесь, что в выводе ненулевые значения параметров:
   * `BW average[Gb/sec]` — средняя скорость передачи;
   * `MsgRate[Mpps]` — частота сообщений.