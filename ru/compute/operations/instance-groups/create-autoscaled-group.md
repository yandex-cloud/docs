# Создать автоматически масштабируемую группу виртуальных машин

Вы можете создать автоматически масштабируемую группу однотипных виртуальных машин. Управление размером такой группой будет осуществляться автоматически. Подробнее читайте в разделе [{#T}](../../concepts/instance-groups/scale.md#auto-scale).

{% include [warning.md](../../../_includes/instance-groups/warning.md) %}

{% include [sa.md](../../../_includes/instance-groups/sa.md) %}

Чтобы создать автоматически масштабируемую группу виртуальных машин:

{% list tabs %}

- Консоль управления

  {% include [create-autoscaled-group-via-concole.md](../../../_includes/instance-groups/create-autoscaled-group-via-concole.md) %}
  
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
          name: first-autoscaled-group
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
          `platform_id` | Идентификатор платформы.
          `memory` | Количество памяти (RAM).
          `cores` | Количество ядер процессора (vCPU).
          `mode` | Режим доступа к диску. </br> - `READ_ONLY` — доступ на чтение. </br>- `READ_WRITE` — доступ на чтение и запись.
          `image_id` | Идентификатор публичного образа с CentOS 7.
          `type_id` | Тип диска.
          `size` | Размер диска.
          `network_id` | Идентификатор сети `default-net`.
          `primary_v4_address_spec` | Спецификация версии интернет протокола IPv4. На данный момент доступен только протокол IPv4. Вы можете предоставить публичный доступ к виртуальным машинам группы, указав версию IP для публичного IP-адреса. Подробнее читайте в разделе [{#T}](../../concepts/instance-groups/instance-template.md#instance-template).
  
      - [Политики](../../concepts/instance-groups/policies.md):
  
          ```
          deploy_policy:
              max_unavailable: 1
              max_expansion: 0
          scale_policy:
              auto_scale:
                  initial_size: 5
                  max_size: 15
                  min_zone_size: 3
                  measurement_duration: 30
                  warmup_duration: 60
                  cooldown_duration: 120
                  cpu_utilization_rule: 0.75
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
  
          Полный код файла `specification.yaml`:
  
          ```
          name: first-autoscaled-group
          service_account_id: ajed6ilf11qg839dcl1e
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
              auto_scale:
                  initial_size: 5
                  max_size: 15
                  min_zone_size: 3
                  measurement_duration: 30
                  warmup_duration: 60
                  cooldown_duration: 120
                  cpu_utilization_rule:
                      utilization_target: 75
          allocation_policy:
              zones:
                  - zone_id: ru-central1-a
          ```
  
  1. Создайте группу виртуальных машин в каталоге по умолчанию:
  
      ```
      $ {{ yc-compute-ig }} create --file specification.yaml
      ```
  
      Данная команда создаст автоматически масштабируемую группу ВМ со следующими характеристиками:
  
      - С именем `first-autoscaled-group`.
      - С OC CentOS 7.
      - В сети `default-net`.
      - В зоне доступности `ru-central1-a`.
      - С одним ядром и RAM 4 ГБ.
      - С сетевым HDD-диском объемом 32 ГБ.
  
- API
  
  Воспользуйтесь методом API [create](../../api-ref/InstanceGroup/create.md).
  
{% endlist %}
