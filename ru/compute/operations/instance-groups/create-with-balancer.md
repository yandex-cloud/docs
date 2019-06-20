# Создать группу виртуальных машин фиксированного размера с балансировщиком

Вы можете создать группу виртуальных машин фиксированного размера совместно с сетевым балансировщиком, который будет равномерно распределять нагрузку по облачным ресурсам. Подробнее читайте в разделе [#T](../../../load-balancer/concepts/index.md) документации сервиса {{ load-balancer-full-name }}.

{% include [warning.md](../../../_includes/instance-groups/warning.md) %}

{% include [sa.md](../../../_includes/instance-groups/sa.md) %}

Чтобы создать группу виртуальных машин с балансировщиком нагрузки:

{% list tabs %}

- Консоль управления
  
  1. В консоли управления выберите каталог, в котором нужно создать группу виртуальных машин.
  
  1. Выберите сервис **{{ compute-full-name }}**.
  
  1. На странице **Виртуальные машины** перейдите на вкладку **Группы виртуальных машин**.
  
  1. Нажмите кнопку **Создать группу**.
  
  1. В блоке **Базовые параметры**:
  
      - Введите имя и описание группы.
  
          {% include [name-format](../../../_includes/name-format.md) %}
  
      - Выберите сервисный аккаунт из списка или создайте новый. Cервисный аккаунт должен обладать ролью `{{ roles-editor }}`, чтобы создавать, обновлять и удалять виртуальные машины в группе.
  
  1. В блоке **Распределение** выберите нужные зоны доступности. Виртуальные машины группы могут находиться в разных зонах и регионах доступности. [Подробнее о географии Облака](../../../overview/concepts/geo-scope.md).
  
  1. В блоке **Шаблон виртуальной машины** нажмите кнопку **Задать**, чтобы задать конфигурацию базовой виртуальной машины:
  
      - Выберите публичный [образ](../images-with-pre-installed-software/get-list.md).
  
      - В блоке **Диски**:
  
          - Выберите [тип диска](../../concepts/disk.md#disks_types).
  
          - Укажите размер диска.
  
              Чтобы добавить дополнительные диски, нажмите **Добавить диск**.
  
      - В блоке **Вычислительные ресурсы**:
  
          - Выберите [платформу](../../concepts/vm-platforms.md).
  
          - Укажите [гарантированную долю](../../concepts/performance-levels.md) и необходимое количество vCPU и объем RAM.
  
      - В блоке **Сетевые настройки**:
  
          - Выберите [облачную сеть](../../concepts/vm.md#network) и подсеть. Если нужной подсети в списке нет, [создайте ее](../../../vpc/operations/subnet-create.md).
  
          - Отметьте необходимость в публичном IP-адресе.
  
      - В блоке **Доступ** укажите данные для доступа на виртуальную машину:
  
          - В поле **Логин** введите имя пользователя.
  
          - В поле **SSH-ключ** вставьте содержимое файла открытого ключа. Пару ключей для подключения по SSH необходимо [создать](../vm-connect/ssh.md#creating-ssh-keys) самостоятельно.
  
      - Нажмите кнопку **Добавить**.
  
  1. В блоке **В процессе создания и обновления разрешено** укажите:
  
      - На какое количество виртуальных машин можно превысить размер группы.
  
      - На какое количество виртуальных машин можно уменьшать размер группы.
  
      - Сколько виртуальных машин можно одновременно создавать.
  
      - Сколько виртуальных машин можно одновременно удалять.
  
          Подробнее читайте в разделе [#T](../../concepts/instance-groups/policies.md#deploy-policy).
  
  1. В блоке **Масштабирование**:
  
      - Выберите [тип масштабирования](../../concepts/instance-groups/scale.md). На данный момент можно создавать только группы с фиксированным типом масштабирования.
  
      - Укажите размер группы.
  
  1. В блоке **Интеграция с {{ load-balancer-name }}** передвиньте переключатель вправо напротив поля **Создать целевую группу**.
  
  1. Введите произвольные имя и описание целевой группы.
  
  1. Нажмите кнопку **Создать**.
  
- CLI
  
  {% include [cli-install.md](../../../_includes/cli-install.md) %}
  
  {% include [default-catalogue.md](../../../_includes/default-catalogue.md) %}
  
  1. Посмотрите описание команды CLI для создания группы виртуальных машин:
  
      ```
      $ {{ yc-compute-ig }} create --help
      ```
  
  1. Проверьте, есть ли в каталоге сети:
  
      ```
      $ yc vpc network list
      ```
  
      Если ни одной сети в каталоге нет, [создайте нужные сети](../../../vpc/operations/subnet-create.md) в сервисе {{ vpc-short-name }}.
  
  1. Выберите один из [публичных образов](../images-with-pre-installed-software/get-list.md) (например, CentOS 7).
  
      {% include [standard-images.md](../../../_includes/standard-images.md) %}
  
  1. Создайте YAML-файл с произвольным именем, например `specification.yaml`.
  1. Опишите в созданном файле:
  
      - Общую информацию о группе:
  
          ```
          name: first-group
          service_account_id: <ID>
          description: "This instance group was created from YAML config"
          ```
  
          Ключи:
  
          Ключ | Значение
          ----- | -----
          `name` | Произвольное имя группы виртуальных машин. Имя должно быть уникальным в рамках каталога. Имя может содержать строчные буквы латинского алфавита, цифры и дефисы. Первый символ должен быть буквой. Последний символ не может быть дефисом. Максимальная длина имени — 63 символа.
          `service_account_id` | Идентификатор сервисного аккаунта.
          `description` | Произвольное описание группы виртуальных машин.
  
      - [Шаблон виртуальной машины](../../concepts/instance-groups/instance-template.md):
  
          ```
          instance_template:
              platform_id: standard-v1
              resources_spec:
                  memory: 4294967296
                  cores: 1
              boot_disk_spec:
                  mode: READ_WRITE
                  disk_spec:
                      image_id: fdvk34al8k5nltb58shr
                      type_id: network-hdd
                      size: 34359738368
              network_interface_specs:
                  - network_id: c64mknqgnd8avp6edhbt
                    primary_v4_address_spec: {}
          ```
  
          {% include [default-unit-size](../../../_includes/instance-groups/default-unit-size.md) %}
  
          Ключи (в таблице приведены ключи, которые непосредственно определяют параметры ВМ):
  
          Ключ | Значение
          ----- | -----
          `platform_id` | Идентификатор [платформы](../../concepts/vm-platforms.md).
          `memory` | Количество памяти (RAM).
          `cores` | Количество ядер процессора (vCPU).
          `mode` | Режим доступа к диску. </br> - `READ_ONLY` — доступ на чтение. </br>- `READ_WRITE` — доступ на чтение и запись.
          `image_id` | Идентификатор публичного образа с CentOS 7.
          `type_id` | Тип диска.
          `size` | Размер диска.
          `network_id` | Идентификатор сети `default-net`.
          `primary_v4_address_spec` | Спецификация версии интернет протокола IPv4. На данный момент доступен только протокол IPv4. Вы можете предоставить публичный доступ к виртуальным машинам группы, указав версию IP для публичного IP-адреса. Подробнее читайте в разделе [#T](../../concepts/instance-groups/instance-template.md#instance-template).
  
      - [Политики](../../concepts/instance-groups/policies.md):
  
          ```
          deploy_policy:
              max_unavailable: 1
              max_expansion: 0
          scale_policy:
              fixed_scale:
                  size: 3
          allocation_policy:
              zones:
                  - zone_id: ru-central1-a
          ```
  
          Ключи:
  
          Ключ | Значение
          ----- | -----
          `deploy_policy` | Политика развертывания виртуальных машин в группе.
          `scale_policy` | Политика масштабирования виртуальных машин в группе.
          `allocation_policy` | Политика распределения виртуальных машин по зонам и регионам.
  
      - Целевую группу {{ load-balancer-name }}:
  
          ```
          load_balancer_spec:
              target_group_spec:
                  name: first-target-group
          ```
  
          Ключи:
  
          Ключ | Значение
          ----- | -----
          `target_group_spec` | Спецификация целевой группы {{ load-balancer-name }}, связанной с группой виртуальных машин.
          `name` | Произвольное имя целевой группы {{ load-balancer-name }}. Имя должно быть уникальным в рамках каталога. Имя может содержать строчные буквы латинского алфавита, цифры и дефисы. Первый символ должен быть буквой. Последний символ не может быть дефисом. Максимальная длина имени — 63 символа.
  
          Полный код файла `specification.yaml`:
  
          ```
          name: first-group-with-balancer
          service_account_id: <ID>
          description: "This instance group was created from YAML config"
          instance_template:
              platform_id: standard-v1
              resources_spec:
                  memory: 4294967296
                  cores: 1
              boot_disk_spec:
                  mode: READ_WRITE
                  disk_spec:
                      image_id: fdvk34al8k5nltb58shr
                      type_id: network-hdd
                      size: 34359738368
              network_interface_specs:
                  - network_id: c64mknqgnd8avp6edhbt
                    primary_v4_address_spec: {}
          deploy_policy:
              max_unavailable: 1
              max_expansion: 0
          scale_policy:
              fixed_scale:
                  size: 3
          allocation_policy:
              zones:
                  - zone_id: ru-central1-a
          load_balancer_spec:
              target_group_spec:
                  name: first-target-group
          ```
  
  1. Создайте группу виртуальных машин в каталоге по умолчанию:
  
      ```
      $ {{ yc-compute-ig }} create --file specification.yaml
      ```
  
      Данная команда создаст группу из трех однотипных виртуальных машин со следующими характеристиками:
  
      - С именем `first-group-with-balancer`.
      - С OC CentOS 7.
      - В сети `default-net`.
      - В зоне доступности `ru-central1-a`.
      - С одним ядром и RAM 4 ГБ.
      - С сетевым HDD-диском объемом 32 ГБ.
      - С целевой группой `first-target-group`.
  
  1. Создайте [балансировщик](../../../load-balancer/operations/load-balancer-create.md) и добавьте к нему целевую группу `first-target-group`.
  
- API
  
  Воспользуйтесь методом API [create](../../api-ref/InstanceGroup/create.md).
  
{% endlist %}
