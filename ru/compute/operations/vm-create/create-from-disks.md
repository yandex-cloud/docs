# Создать виртуальную машину из набора дисков

Создать виртуальную машину можно из существующих дисков. Диски должны находиться в одной из зон доступности и не быть добавленными к другим виртуальным машинам.

{% include [disk-auto-delete](../../_includes_service/disk-auto-delete.md) %}

Чтобы создать виртуальную машину из набора дисков:

{% list tabs %}

- Консоль управления
  
  1. В консоли управления выберите каталог, в котором нужно создать виртуальную машину.
  1. Выберите сервис **{{ compute-name }}**.
  1. На странице **Виртуальные машины** нажмите кнопку **Создать ВМ**.
  1. В блоке **Базовые параметры** введите имя и описание ВМ.
  
      {% include [name-format](../../../_includes/name-format.md) %}
  
      {% include [name-fqdn](../../../_includes/compute/name-fqdn.md) %}
  
  1. В блоке **Зона доступности** выберите нужную зону доступности. [Подробнее о географии Облака](../../../overview/concepts/geo-scope.md).
  1. Выберите один из публичных [образов](../../operations/images-with-pre-installed-software/get-list.md).
  1. В блоке **Диски** нажмите **Добавить диск**:
      - Введите имя диска.
      - Укажите нужный размер диска.
      - Выберите [тип диска](../../concepts/disk.md#disks_types).
      - В поле **Наполнение** выберите **Диск**. Если диска нет, [создайте](../disk-create/empty.md) его.
  1. В блоке **Вычислительные ресурсы**:
      - Выберите [платформу](../../concepts/vm-platforms.md).
      - Выберите [уровень производительности](../../concepts/performance-levels.md) и необходимое количество vCPU, а также объем RAM.
  1. В блоке **Сетевые настройки** выберите сеть из списка или создайте новую, нажав кнопку **Создать новую сеть**.
  1. Выберите нужную подсеть из списка или создайте новую, нажав кнопку **Создать новую подсеть**.
  1. Выберите нужный вариант публичного IP-адреса.
  1. В блоке **Доступ** укажите данные для доступа на виртуальную машину:
      - В поле **Логин** введите имя пользователя.
      - В поле **SSH-ключ** вставьте содержимое файла открытого ключа. Пару ключей для подключения по SSH необходимо [создать](../vm-connect/ssh.md#creating-ssh-keys) самостоятельно.
  1. Нажмите кнопку **Создать ВМ**.
  
- CLI
  
  {% include [cli-install](../../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}
  
  1. Посмотрите описание команды CLI для создания виртуальной машины:
  
      ```
      $ yc compute instance create --help
      ```
  
  1. Получите список дисков в каталоге по умолчанию:
  
      {% include [compute-disk-list](../../../_includes/compute/disk-list.md) %}
  
  1. Выберите идентификатор (`ID`) или имя (`NAME`) нужных дисков.
  1. Создайте виртуальную машину в каталоге по умолчанию:
  
      ```
      $ yc compute instance create \
          --name first-instance \
          --zone ru-central1-a \
          --network-interface subnet-name=default-a,nat-ip-version=ipv4 \
          --use-boot-disk disk-name=first-disk \
          --attach-disk disk-name=second-disk \
          --ssh-key ~/.ssh/id_rsa.pub
      ```
  
      Данная команда создаст виртуальную машину:
  
      - С именем `first-instance`.
      - В зоне доступности `ru-central1-a`.
      - В подсети `default-a`.
      - С публичным IP и двумя дисками.
  
      Чтобы создать виртуальную машину без публичного IP, исключите флаг `--public-ip`.
  
      {% include [name-format](../../../_includes/name-format.md) %}
  
      {% include [name-fqdn](../../../_includes/compute/name-fqdn.md) %}
  
      Чтобы указать необходимость удаления диска при удалении машины, установите флаг `--auto-delete`:
  
      ```
      yc compute instance create \
      --name first-instance \
      --zone ru-central1-a \
      --network-interface subnet-name=default-a,nat-ip-version=ipv4 \
      --use-boot-disk disk-name=first-disk,auto-delete=yes \
      --attach-disk disk-name=second-disk,auto-delete=yes \
      --ssh-key ~/.ssh/id_rsa.pub
      ```
  
- API
  
  Воспользуйтесь методом [Create](../../api-ref/Instance/create.md) для ресурса `Instance`.
  
{% endlist %}
