[Документация Yandex Cloud](../../index.md) > [Yandex Compute Cloud](../index.md) > Вопросы и ответы > Графические ускорители GPU

# Вопросы и ответы про графические ускорители GPU в Compute Cloud

* [Как проверить физическое состояние кластера GPU?](#test-physical-state)

* [Как запустить параллельные задачи в кластере GPU?](#mpirun-parallel)

* [Как проверить пропускную способность InfiniBand?](#preinstall-software)


* [Что делать, если на ВМ перестала работать GPU?](#gpu-not-working)


#### Как проверить физическое состояние кластера GPU? {#test-physical-state}

* Проверьте порты InfiniBand.
* Проверьте сеть.

Подробнее читайте в разделе [Проверить физическое состояние кластера GPU](../operations/gpu-cluster/gpu-cluster-test-physical-state.md).

#### Как запустить параллельные задачи в кластере GPU? {#mpirun-parallel}

Чтобы запустить параллельные задачи в кластере GPU:

1. Подключитесь к каждой ВМ по SSH и установите [Open MPI](https://www.open-mpi.org/) и [NCCL](https://github.com/NVIDIA/nccl).
1. На основной ВМ соберите тесты NVIDIA и настройте SSH-ключи без пароля.
1. На каждой ВМ добавьте публичный ключ в `authorized_keys`.
1. На основной ВМ выполните команду `mpirun` с IP-адресами ВМ и количеством GPU.

Подробнее читайте в разделе [Запустить параллельные задачи в кластере GPU](../operations/gpu-cluster/gpu-cluster-mpirun-parallel.md).

#### Как проверить пропускную способность InfiniBand? {#preinstall-software}

Чтобы проверить пропускную способность InfiniBand создайте и запустите скрипт для запуска тестов `perftest` с использованием `numactl`.

Подробнее читайте в разделе [Проверить пропускную способность InfiniBand](../operations/gpu-cluster/test-infiniband-bandwidth.md).


#### Что делать, если на ВМ перестал работать GPU? {#gpu-not-working}

В таком случае необходимо [остановить](../operations/vm-control/vm-stop-and-start.md#stop) и снова [запустить](../operations/vm-control/vm-stop-and-start.md#start) виртуальную машину. В большинстве случаев требуются именно остановка и повторный запуск, а не перезагрузка, поскольку при перезагрузке ВМ остается на том же хосте, где возникла проблема с GPU.