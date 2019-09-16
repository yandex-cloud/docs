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

  1.  Создайте виртуальную машину в каталоге по умолчанию:

      ```
      $ yc compute instance create \
          --name first-instance \
          --zone ru-central1-a \
          --network-interface subnet-name=default-a,nat-ip-version=ipv4 \
          --create-boot-disk image-folder-id=standard-images,image-family=centos-7 \
          --ssh-key ~/.ssh/id_rsa.pub
      ```

      Данная команда создаст виртуальную машину со следующими характеристиками:

      - С именем `first-instance`.
      - С OC CentOS 7.
      - В зоне доступности `ru-central1-a`.
      - В подсети `default-a`.
      - С публичным IP.

      На машине будет создан пользователь `yc-user` с публичным ключом из файла `~/.ssh/id_rsa.pub`. Чтобы создать виртуальную машину без публичного IP, исключите опцию `nat-ip-version=ipv4`.

      {% include [name-format](../../../_includes/name-format.md) %}

      {% include [name-fqdn](../../../_includes/compute/name-fqdn.md) %}

- API

  Воспользуйтесь методом [Create](../../api-ref/Instance/create.md) для ресурса `Instance`.

{% endlist %}

{% include [ip-fqdn-connection](../../../_includes/ip-fqdn-connection.md) %}

#### См. также

- [{#T}](../vm-connect/ssh.md)
