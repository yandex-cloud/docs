# Создать виртуальную машину из публичного образа Linux

В этом разделе приведена инструкция для создания виртуальной машины с операционной системой Linux. Для создания виртуальной машины на базе Windows воспользуйтесь инструкцией [{#T}](create-windows-vm.md).

Чтобы создать виртуальную машину:

{% list tabs %}

- Консоль управления

  {% include [create-instance-via-concole-linux](../../_includes_service/create-instance-via-concole-linux.md) %}

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для создания виртуальной машины:

      ```
      $ yc compute instance create --help
      ```

  1. Подготовьте пару ключей (открытый и закрытый) для SSH-доступа на виртуальную машину.
  1. Выберите один из публичных [образов](../images-with-pre-installed-software/get-list.md) на базе операционной системы Linux (например, CentOS 7).

      {% include [standard-images](../../../_includes/standard-images.md) %}

  1.  Создайте виртуальную машину в каталоге по умолчанию. Укажите следующие параметры:
        
      - `name` — Имя виртуальной машины.

      {% include [name-fqdn](../../../_includes/compute/name-fqdn.md) %}
    
      - `zone` — зона доступности.
      - `subnet-name` — подсеть.
      - `image-family` — операционная система.
      - Публичный IP. Чтобы создать виртуальную машину без публичного IP, исключите опцию `nat-ip-version=ipv4`.

      ```
      $ yc compute instance create \
          --name first-instance \
          --zone ru-central1-a \
          --network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 \
          --create-boot-disk image-folder-id=standard-images,image-family=centos-7 \
          --ssh-key ~/.ssh/id_rsa.pub
      ```
 
      Будет создана виртуальная машина `first-instance`.
- API

  Воспользуйтесь методом [Create](../../api-ref/Instance/create.md) для ресурса `Instance`.

{% endlist %}

{% include [ip-fqdn-connection](../../../_includes/ip-fqdn-connection.md) %}

#### См. также

- [{#T}](../vm-connect/ssh.md)
