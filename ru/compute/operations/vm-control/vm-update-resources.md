# Изменить вычислительные ресурсы виртуальной машины

После создания ВМ вы можете изменить ее вычислительные ресурсы. Как изменить имя, описание и метки ВМ читайте в разделе [{#T}](vm-update.md).

## Изменить конфигурацию vCPU и RAM {#update-vcpu-ram}

В этом разделе приведена инструкция для изменения количества и производительности ядер процессора (vCPU), а также количества памяти (RAM).

{% list tabs %}

- Консоль управления

  Чтобы изменить vCPU и RAM ВМ:
  1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит ВМ.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. Нажмите на имя нужной ВМ.
  1. В правом верхнем углу страницы нажмите кнопку **{{ ui-key.yacloud.compute.instance.overview.button_action-stop }}**.
  1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.compute.instance.stop-dialog.button_stop }}**.
  1. Подождите пока ВМ перейдет в статус `Stopped` и в правом верхнем углу страницы нажмите ![image](../../../_assets/pencil.svg) **{{ ui-key.yacloud.compute.instance.overview.button_action-edit }}**.
  1. Измените [конфигурацию](../../concepts/performance-levels.md) ВМ в блоке **{{ ui-key.yacloud.compute.instances.create.section_platform }}**:
     * Выберите [платформу](../../concepts/vm-platforms.md).
     * Укажите необходимое количество vCPU.
	 * Выберите гарантированную долю vCPU.
	 * Укажите размер RAM.
  1. Нажмите кнопку **{{ ui-key.yacloud.compute.instance.edit.button_update }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.button_action-start }}** в правом верхнем углу.
  1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.compute.instances.popup-confirm_button_start }}**.

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
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. Нажмите на имя нужной ВМ.
  1. В правом верхнем углу страницы нажмите кнопку **{{ ui-key.yacloud.compute.instance.overview.button_action-stop }}**.
  1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.compute.instance.stop-dialog.button_stop }}**.
  1. Подождите пока ВМ перейдет в статус `Stopped` и в правом верхнем углу страницы нажмите ![image](../../../_assets/pencil.svg) **{{ ui-key.yacloud.compute.instance.overview.button_action-edit }}**.
  1. Измените [конфигурацию](../../concepts/performance-levels.md) ВМ в блоке **{{ ui-key.yacloud.compute.instances.create.section_platform }}**:
     * Выберите [платформу](../../concepts/vm-platforms.md#gpu-platforms).

       
     * Укажите необходимое количество GPU.
  1. Нажмите кнопку **{{ ui-key.yacloud.compute.instance.edit.button_update }}**.
  1. В правом верхнем углу страницы нажмите кнопку **{{ ui-key.yacloud.compute.instances.button_action-start }}**.
  1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.compute.instances.popup-confirm_button_start }}**.

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
       --platform=standard-v3-t4 \
       --cores=8 \
       --memory=32 \
       --gpus=1
     ```

     После выполнения данной команды изменятся следующие характеристики ВМ:
     * **Платформа** — на {{ t4-ice-lake }}.


     * **vCPU** — на 8.
     * **RAM** — на 32 ГБ.
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
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. Нажмите на имя нужной ВМ.
  1. В правом верхнем углу страницы нажмите кнопку **{{ ui-key.yacloud.compute.instance.overview.button_action-stop }}**.
  1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.compute.instance.stop-dialog.button_stop }}**.
  1. Подождите, пока ВМ перейдет в статус `Stopped`, и в правом верхнем углу страницы нажмите ![image](../../../_assets/pencil.svg) **{{ ui-key.yacloud.compute.instance.overview.button_action-edit }}**.
  1. Измените [конфигурацию](../../concepts/performance-levels.md) ВМ. В блоке **{{ ui-key.yacloud.compute.instances.create.section_platform }}** укажите необходимое количество GPU.
  1. Нажмите кнопку **{{ ui-key.yacloud.compute.instance.edit.button_update }}**.
  1. В правом верхнем углу страницы нажмите кнопку **{{ ui-key.yacloud.compute.instances.button_action-start }}**.
  1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.compute.instances.popup-confirm_button_start }}**.

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
       --cores=56 \
       --memory=238
     ```

     Данная команда изменит количество GPU на 2. 
     
     Значения параметров `--cores` (количество vCPU) и `--memory` (размер RAM в ГБ) зависят от платформы и количества GPU. См. [список доступных конфигураций](../../concepts/gpus.md#config).
     
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
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. Нажмите на имя нужной ВМ.
  1. В правом верхнем углу страницы нажмите кнопку **{{ ui-key.yacloud.compute.instance.overview.button_action-stop }}**.
  1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.compute.instance.stop-dialog.button_stop }}**.
  1. Подождите пока ВМ перейдет в статус `Stopped` и в правом верхнем углу страницы нажмите ![image](../../../_assets/pencil.svg) **{{ ui-key.yacloud.compute.instance.overview.button_action-edit }}**.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_platform }}** включите опцию **{{ ui-key.yacloud.component.compute.resources.label_sw-accelerated-net }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.compute.instance.edit.button_update }}**.
  1.  В правом верхнем углу страницы нажмите кнопку **{{ ui-key.yacloud.compute.instances.button_action-start }}**.
  1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.compute.instances.popup-confirm_button_start }}**.

{% endlist %}