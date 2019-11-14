# Создание виртуальной машины с GPU

В этом разделе приведена инструкция для создания виртуальной машины с GPU. Подробнее с конфигурациями виртуальных машин вы можете ознакомиться в разделе [{#T}](../../concepts/gpus.md).

Сейчас по умолчанию в облаке установлена нулевая квота на создание виртуальных машин с GPU. Чтобы изменить квоту, обратитесь в [техническую поддержку](https://cloud.yandex.ru/support).

{% list tabs %}

- Консоль управления

  {% include [create-vm-with-gpu](../../../_includes/compute/create/create-vm-with-gpu-console.md) %}

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для создания виртуальной машины:

      ```
      $ yc compute instance create --help
      ```

  1. Подготовьте [пару ключей](../vm-connect/ssh.md#creating-ssh-keys) (открытый и закрытый) для SSH-доступа на виртуальную машину.
  1. Выберите один из публичных [образов](../images-with-pre-installed-software/get-list.md).

      {% include [gpu-images](../../../_includes/gpu-images.md) %}

      {% include [gpu-os](../../../_includes/compute/gpu-os.md) %}

  1. Создайте виртуальную машину в каталоге по умолчанию. Укажите следующие параметры:

      - Имя виртуальной машины.

          {% include [name-fqdn](../../../_includes/compute/name-fqdn.md) %}

      - [Зону доступности](../../../overview/concepts/geo-scope.md).
      - Идентификатор [платформы](../../concepts/vm-platforms.md), `gpu-standard-v1` для платформы Intel Broadwell with NVIDIA Tesla V100.
      - [Количество vCPU](../../concepts/gpus.md).
      - [Размер RAM](../../concepts/gpus.md).
      - [Количество GPU](../../concepts/gpus.md).
      - При необходимости сделайте виртуальную машину [прерываемой](../../concepts/preemptible-vm.md) с помощью опции `--preemptible`.
      - [Образ](../images-with-pre-installed-software/get-list.md) операционной системы. `ubuntu-1604-lts-gpu` — образ Ubuntu 16.04.6 LTS c CUDA драйверами.
      - Публичный IP. Чтобы создать виртуальную машину без публичного IP, исключите опцию `nat-ip-version=ipv4`.

      Например:

      ```
      $ yc compute instance create \
            --name gpu-instance \
            --zone ru-central1-a \
            --platform-id=gpu-standard-v1 \
            --cores=8 \
            --memory=96 \
            --gpus=1 \
            --network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 \
            --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-1604-lts-gpu \
            --ssh-key ~/.ssh/id_rsa.pub
      ```

      Будет создана виртуальная машина `gpu-instance` с одним GPU, 8 vCPU и 96 ГБ RAM:

      ```
      $ yc compute instance get --full gpu-instance
          ...
          name: gpu-instance
          zone_id: ru-central1-a
          platform_id: gpu-standard-v1
          resources:
            memory: "103079215104"
            cores: "8"
            core_fraction: "100"
            gpus: "1"
          status: RUNNING
          ...
      ```

- API

  Чтобы создать виртуальную машину, воспользуйтесь методом [Create](../../api-ref/Instance/create.md) для ресурса `Instance`.

{% endlist %}

{% include [ip-fqdn-connection](../../../_includes/ip-fqdn-connection.md) %}

#### См. также

- Узнайте, как [изменить конфигурацию виртуальной машины](../vm-control/vm-update-resources.md).