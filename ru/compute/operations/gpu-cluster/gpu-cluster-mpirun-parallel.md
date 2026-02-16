---
title: Запустить параллельные задачи в кластере GPU
description: Следуя данной инструкции, вы сможете использовать утилиту mpirun для выполнения распределенных задач на кластере GPU.
---

# Запустить параллельные задачи в кластере GPU


1. [Подключитесь](../../../compute/operations/vm-connect/ssh.md) к каждой ВМ в кластере по SSH.
1. Установите на каждую ВМ [Open MPI](https://www.open-mpi.org/) и [NCCL](https://github.com/NVIDIA/nccl):

   ```bash
   sudo apt-get update
   sudo apt-get install openmpi-bin libnccl2 libnccl-dev
   ```

1. На основной ВМ:
   1. Клонируйте репозиторий тестов:
      ```bash
      git clone https://github.com/NVIDIA/nccl-tests
      ```

   1. Соберите тесты:

      ```bash
      cd nccl-tests
      MPI_HOME=/usr/lib/x86_64-linux-gnu/openmpi MPI=1 make
      ```

   1. Скопируйте бинарный файл `all_reduce_perf` из каталога `build` на все ВМ кластера. Файл `all_reduce_perf` должен находиться в той же директории на всех ВМ, что и на основной (например, `~/nccl-tests/build/`).

1. На основной ВМ создайте SSH-ключи без пароля:

   ```bash
   ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519 -N ""
   ```

1. Скопируйте файлы `id_ed25519` и `id_ed25519.pub` на все остальные ВМ.
1. На каждой ВМ добавьте публичный ключ в `authorized_keys`:

   ```bash
   cat ~/.ssh/id_ed25519.pub >> ~/.ssh/authorized_keys
   ```

1. На основной ВМ выполните команду:

   ```bash
   mpirun --host <IP_1>:8,<IP_2>:8 \
       --allow-run-as-root -np 16 \
       -mca btl_tcp_if_include eth0 \
       ~/nccl-tests/build/all_reduce_perf -b 512M -e 8G -f 2 -g 1
   ```

   Где:

   * `IP_1:8`, `IP_2:8` — IP-адреса ВМ и количество GPU на них
   * `np` — общее количество процессов, (количество_ВМ) × (GPU_на_одной_ВМ)

   Результат:

   ```text
   #                                                              out-of-place                       in-place
   #       size         count      type   redop    root     time   algbw   busbw #wrong     time   algbw   busbw #wrong
   #        (B)    (elements)                               (us)  (GB/s)  (GB/s)            (us)  (GB/s)  (GB/s)
      536870912     134217728     float     sum      -1   8476.3   63.34  118.76      0   8573.0   62.62  117.42      0
   1073741824     268435456     float     sum      -1    16512   65.03  121.92      0    16493   65.10  122.07      0
   2147483648     536870912     float     sum      -1    32742   65.59  122.98      0    32757   65.56  122.92      0
   4294967296    1073741824     float     sum      -1    65409   65.66  123.12      0    65376   65.70  123.18      0
   8589934592    2147483648     float     sum      -1   132702   64.73  121.37      0   133186   64.50  120.93      0
   # Out of bounds values : 0 OK
   # Avg bus bandwidth    : 121.467
   ```