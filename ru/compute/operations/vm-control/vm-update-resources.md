# Изменить вычислительные ресурсы виртуальной машины

После создания ВМ вы можете изменить ее вычислительные ресурсы. Как изменить имя, описание и метки ВМ читайте в разделе [{#T}](vm-update.md).

## Изменить конфигурацию vCPU и RAM {#update-vcpu-ram}

В этом разделе приведена инструкция для изменения количества и производительности ядер процессора (vCPU), а также количества памяти (RAM).

{% list tabs %}

- Консоль управления

  Чтобы изменить vCPU и RAM ВМ:
  1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит ВМ.
  1. Выберите сервис **{{ compute-name }}**.
  1. Нажмите на имя нужной ВМ.
  1. Нажмите **Остановить** в правом верхнем углу страницы.
  1. В открывшемся окне нажмите кнопку **Остановить**.
  1. Подождите пока ВМ перейдет в статус `STOPPED` и нажмите кнопку **Изменить ВМ** в правом верхнем углу страницы.
  1. Измените [конфигурацию](../../concepts/performance-levels.md) ВМ в блоке **Вычислительные ресурсы**:
     * Выберите [платформу](../../concepts/vm-platforms.md).
     * Укажите необходимое количество vCPU.
	 * Выберите гарантированную долю vCPU.
	 * Укажите размер RAM.
  1. Нажмите кнопку **Сохранить изменения**.
  1. Нажмите кнопку **Запустить** в правом верхнем углу.
  1. В открывшемся окне нажмите кнопку **Запустить**.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для обновления параметров ВМ:

     ```bash
     yc compute instance update --help
     ```

  1. Получите список ВМ в каталоге по умолчанию:

     {% include [compute-instance-list](../../_includes_service/compute-instance-list.md) %}

  1. Выберите идентификатор (`ID`) или имя (`NAME`) нужной ВМ, например `first-instance`.
  1. Остановите ВМ:

     ```bash
     yc compute instance stop first-instance
     ```

  1. Получите текущую [конфигурацию](../../concepts/performance-levels.md) ВМ вместе с [метаданными](../../concepts/vm-metadata.md):

     ```bash
     yc compute instance get --full first-instance
     ```

  1. Измените конфигурацию ВМ:

     ```bash
     yc compute instance update first-instance \
       --memory 32 \
       --cores 4 \
       --core-fraction 100
     ```

     Данная команда изменит конфигурацию ВМ:
     * **Гарантированный уровень vCPU** — на 100%.
     * **vCPU** — на 4.
     * **RAM** — на 32 ГБ.

  1. Запустите ВМ:

     ```bash
     yc compute instance start first-instance
     ```

- API

  Чтобы изменить vCPU и RAM ВМ, воспользуйтесь методом REST API [update](../../api-ref/Instance/update.md) для ресурса [Instance](../../api-ref/Instance/) или вызовом gRPC API [InstanceService/Update](../../api-ref/grpc/instance_service.md#Update).

{% endlist %}

{% note warning %}

При изменении ресурсов ВМ возможна смена PCI-топологии. Учитывайте это при работе с операционными системами, чувствительными к таким изменениям. Например, при сильно измененных настройках сети в Windows Server возможна потеря сетевой связанности и, как следствие, пропадание доступа к ВМ.

{% endnote %}

## Добавить GPU к существующей виртуальной машине {#add-gpu}


Чтобы добавить [GPU](../../concepts/gpus.md) к существующей ВМ, измените платформу и укажите количество GPU.

{% list tabs %}

- Консоль управления

  Чтобы изменить количество GPU на ВМ:
  1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит ВМ.
  1. Выберите сервис **{{ compute-name }}**.
  1. Нажмите на имя нужной ВМ.
  1. Нажмите **Остановить** в правом верхнем углу страницы.
  1. В открывшемся окне нажмите кнопку **Остановить**.
  1. Подождите пока ВМ перейдет в статус `STOPPED` и нажмите **Изменить ВМ** в правом верхнем углу страницы.
  1. Измените [конфигурацию](../../concepts/performance-levels.md) ВМ в блоке **Вычислительные ресурсы**:
     * Выберите [платформу](../../concepts/vm-platforms.md) Intel Broadwell with NVIDIA® Tesla® V100.
     * Укажите необходимое количество GPU.
  1. Нажмите кнопку **Сохранить изменения**.
  1. Нажмите кнопку **Запустить** в правом верхнем углу.
  1. В открывшемся окне нажмите кнопку **Запустить**.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для обновления параметров ВМ:

     ```bash
     yc compute instance update --help
     ```

  1. Получите список ВМ в каталоге по умолчанию:

     {% include [compute-instance-list](../../_includes_service/compute-instance-list.md) %}

  1. Выберите идентификатор (`ID`) или имя (`NAME`) нужной ВМ, например `first-instance`.
  1. Остановите ВМ:

     ```bash
     yc compute instance stop first-instance
     ```

  1. Получите текущую [конфигурацию](../../concepts/performance-levels.md) ВМ вместе с [метаданными](../../concepts/vm-metadata.md):

     ```bash
     yc compute instance get --full first-instance
     ```

  1. Измените конфигурацию ВМ:

     ```bash
     yc compute instance update first-instance \
       --platform=gpu-standard-v3 \
       --cores=8 \
       --memory=96 \
       --gpus=1
     ```

     После выполнения данной команды изменятся следующие характеристики ВМ:
     * **Платформа** — на Intel Broadwell with NVIDIA® Tesla® V100.
     * **vCPU** — на 8.
     * **RAM** — на 96 ГБ.
     * **GPU** — на 1.

  1. Запустите ВМ:

     ```bash
     yc compute instance start first-instance
     ```

- API

  Чтобы изменить платформу и конфигурацию ВМ, воспользуйтесь методом REST API [update](../../api-ref/Instance/update.md) для ресурса [Instance](../../api-ref/Instance/) или вызовом gRPC API [InstanceService/Update](../../api-ref/grpc/instance_service.md#Update).

{% endlist %}

## Изменить количество GPU {#update-gpu}

{% list tabs %}

- Консоль управления

  Чтобы изменить количество [GPU](../../concepts/gpus.md) на существующей ВМ:
  1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит ВМ.
  1. Выберите сервис **{{ compute-name }}**.
  1. Нажмите на имя нужной ВМ.
  1. Нажмите **Остановить** в правом верхнем углу страницы.
  1. В открывшемся окне нажмите кнопку **Остановить**.
  1. Подождите пока ВМ перейдет в статус `STOPPED` и нажмите **Изменить ВМ** в правом верхнем углу страницы.
  1. Измените [конфигурацию](../../concepts/performance-levels.md) ВМ. В блоке **Вычислительные ресурсы** укажите необходимое количество GPU.
  1. Нажмите кнопку **Сохранить изменения**.
  1. Нажмите кнопку **Запустить** в правом верхнем углу.
  1. В открывшемся окне нажмите кнопку **Запустить**.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для обновления параметров ВМ:

     ```bash
     yc compute instance update --help
     ```

  1. Получите список ВМ в каталоге по умолчанию:

     {% include [compute-instance-list](../../_includes_service/compute-instance-list.md) %}

  1. Выберите идентификатор (`ID`) или имя (`NAME`) нужной ВМ, например `first-instance`.
  1. Остановите ВМ:

     ```bash
     yc compute instance stop first-instance
     ```

  1. Получите текущую [конфигурацию](../../concepts/performance-levels.md) ВМ вместе с [метаданными](../../concepts/vm-metadata.md):

     ```bash
     yc compute instance get --full first-instancegit
     ```

  1. Измените конфигурацию ВМ:

     ```bash
     yc compute instance update first-instance \
       --gpus=2 \
       --cores=16 \
       --memory=192
     ```

     Данная команда изменит количество GPU на 2.
  1. Запустите ВМ:

     ```bash
     yc compute instance start first-instance
     ```

- API

  Чтобы изменить количество GPU, воспользуйтесь методом REST API [update](../../api-ref/Instance/update.md) для ресурса [Instance](../../api-ref/Instance/) или вызовом gRPC API [InstanceService/Update](../../api-ref/grpc/instance_service.md#Update).

{% endlist %}

## Включить программно-ускоренную сеть {#enable-software-accelerated-network}

{% note warning %}

Функциональность доступна только по согласованию с вашим аккаунт-менеджером.

{% endnote %}

{% list tabs %}

- Консоль управления

  Чтобы включить [программно-ускоренную сеть](../../concepts/software-accelerated-network.md) на существующей ВМ:
  1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит ВМ.
  1. Выберите сервис **{{ compute-name }}**.
  1. Нажмите на имя нужной ВМ.
  1. Нажмите **Остановить** в правом верхнем углу страницы.
  1. В открывшемся окне нажмите кнопку **Остановить**.
  1. Подождите пока ВМ перейдет в статус `STOPPED` и нажмите **Изменить ВМ** в правом верхнем углу страницы.
  1. В блоке **Вычислительные ресурсы** выберите опцию **Программно-ускоренная сеть**.
  1. Нажмите кнопку **Сохранить изменения**.
  1. Нажмите кнопку **Запустить** в правом верхнем углу.
  1. В открывшемся окне нажмите кнопку **Запустить**.

{% endlist %}