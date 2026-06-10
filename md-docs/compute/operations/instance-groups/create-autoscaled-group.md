# Создать автоматически масштабируемую группу виртуальных машин


Вы можете создать [автоматически масштабируемую](../../concepts/instance-groups/scale.md#auto-scale) [группу однотипных ВМ](../../concepts/instance-groups/index.md). Управление размером такой группы [ВМ](../../concepts/vm.md) будет осуществляться автоматически.

{% note alert %}

Создавая группы ВМ, учитывайте [лимиты](../../concepts/limits.md). Чтобы не нарушить работу компонента Instance Groups, не изменяйте и не удаляйте вручную созданные им ресурсы: [целевую группу](../../../network-load-balancer/concepts/target-resources.md) Network Load Balancer, ВМ и диски. Вместо этого измените или удалите группу полностью.

{% endnote %}

Все операции в Instance Groups выполняются от имени сервисного аккаунта. Если сервисного аккаунта нет, [создайте его](../../../iam/operations/sa/create.md).

Чтобы иметь возможность создавать, обновлять и удалять ВМ в группе [назначьте](../../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту роль [compute.editor](../../security/index.md#compute-editor).

Чтобы создать автоматически масштабируемую группу ВМ:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором нужно создать группу виртуальных машин.
  1. Перейдите в сервис **Compute Cloud**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/layers-3-diagonal.svg) **Группы виртуальных машин**.
  1. Нажмите кнопку **Создать группу виртуальных машин**.
  1. В блоке **Базовые параметры**:
     * Введите имя и описание группы ВМ. Требования к имени:
  
       * длина — от 3 до 63 символов;
       * может содержать строчные буквы латинского алфавита, цифры и дефисы;
       * первый символ — буква, последний — не дефис.
  
       {% note info %}
       
       Имя виртуальной машины используется для генерации [внутреннего FQDN](../../concepts/network.md#hostname) единожды — при создании ВМ. Если для вас важен внутренний FQDN, учитывайте это и задавайте нужное имя ВМ при создании.
       
       {% endnote %}
  
     * Выберите [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md) из списка или создайте новый. Чтобы иметь возможность создавать, обновлять и удалять ВМ в группе, назначьте сервисному аккаунту роль [compute.editor](../../security/index.md#compute-editor). По умолчанию все операции в Instance Groups выполняются от имени сервисного аккаунта.
  
       Сервисный аккаунт нельзя удалить, пока он связан с группой виртуальных машин.
  
     * Включите опцию **Защита от удаления** при необходимости. Пока опция включена, невозможно удалить группу.
  1. В блоке **Распределение** в поле **Зона доступности** выберите нужные. ВМ группы могут находиться в [разных зонах доступности](../../../overview/concepts/geo-scope.md).
  1. В блоке **Шаблон виртуальной машины** нажмите кнопку **Задать**, чтобы задать конфигурацию базовой ВМ:
     * В блоке **Общая информация** введите описание [шаблона](../../concepts/instance-groups/instance-template.md).
     * В блоке **Образ загрузочного диска** выберите, какую систему развернуть на загрузочном [диске](../../concepts/disk.md) ВМ.
  
     * В блоке **Диски и файловые хранилища**:
       * Выберите [тип диска](../../concepts/disk.md#disks_types).
       * Укажите размер диска.
       * Чтобы добавить дополнительные диски, нажмите **Добавить диск**.
     * В блоке **Вычислительные ресурсы**:
       * Выберите [платформу](../../concepts/vm-platforms.md).
       * Укажите необходимое количество vCPU, [гарантированную долю vCPU](../../concepts/performance-levels.md) и объем RAM.
  
       * При необходимости сделайте виртуальную машину [Прерываемой](../../concepts/preemptible-vm.md).
         
         Создавая группу прерываемых машин, учитывайте, что виртуальные машины будут останавливаться спустя 24 часа непрерывной работы, а могут быть остановлены еще раньше. При этом возможна ситуация, что Instance Groups не сможет сразу перезапустить их из-за нехватки ресурсов. Это может произойти, если резко возрастет потребление вычислительных ресурсов в Yandex Cloud.
  
       * (опционально) Включите [программно ускоренную сеть](../../concepts/software-accelerated-network.md).
     * В блоке **Сетевые настройки**:
  
       * Укажите идентификатор подсети или выберите [облачную сеть](../../../vpc/concepts/network.md#network) из списка.
         Если сети нет, нажмите **Создать сеть** и создайте ее:
       
           * В открывшемся окне укажите имя сети.
           * (Опционально) Для автоматического создания подсетей выберите опцию **Создать подсети**.
           * Нажмите **Создать сеть**.
       
         У каждой сети должна быть как минимум одна [подсеть](../../../vpc/concepts/network.md#subnet). Если подсети нет, создайте ее, выбрав **Создать подсеть**.
       
       * В поле **Публичный адрес** выберите способ назначения адреса:
       
           * `Автоматически` — чтобы назначить случайный IP-адрес из пула адресов Yandex Cloud.
           * `Без адреса` — чтобы не назначать публичный IP-адрес.
       
       * Выберите [подходящие группы безопасности](../../../vpc/concepts/security-groups.md).
       
       * (опционально) Создайте записи для ВМ в [зоне DNS](../../../dns/concepts/dns-zone.md):
       
           * Разверните блок **Настройки DNS для внутренних адресов** и нажмите кнопку **Добавить запись**.
           * Укажите зону, FQDN и время жизни записи. При указании FQDN для зоны доступна опция `Определять автоматически`.
             Вы можете добавить несколько записей во [внутренние зоны](../../../dns/concepts/dns-zone.md) DNS. Подробнее см. [Интеграция Cloud DNS с Compute Cloud](../../../dns/concepts/compute-integration.md).
  
     * В блоке **Доступ** укажите данные для доступа на ВМ:
       * Выберите сервисный аккаунт, который следует привязать к ВМ.
       * Если выбран [образ](../../concepts/image.md) на основе Linux, заполните поля **Логин** и **SSH-ключ**. В качестве ключа укажите содержимое файла [открытого ключа](../vm-connect/ssh.md#creating-ssh-keys).
       * При необходимости выберите опцию `Доступ к серийной консоли`.
     * Нажмите кнопку **Сохранить**.
  1. В блоке **В процессе создания и обновления разрешено**:
     * В поле **Добавлять выше целевого значения** укажите, на какое количество ВМ можно превышать размер группы.
  
         При приведении количества ВМ в группе к целевому значению, созданные сверх целевого размера по квоте `max_expansion` виртуальные машины могут остаться в группе, в то время как ВМ, существовавшие в группе до этого, могут быть удалены.
     * В поле **Уменьшать относительно целевого значения** укажите, на какое количество ВМ можно уменьшать размер группы.
     * В поле **Одновременно создавать** укажите, сколько ВМ можно одновременно создавать.
     * В поле **Время запуска** укажите срок, после которого ВМ начнет получать нагрузку.
     * В поле **Одновременно останавливать** укажите, сколько ВМ можно одновременно останавливать.
     * В поле **Останавливать машины по стратегии** укажите одну из [стратегий](../../concepts/instance-groups/policies/deploy-policy.md#strategy):
       * `Автоматическая` — Instance Groups самостоятельно выбирает, какие ВМ остановить при обновлении или уменьшении группы.
       * `Ручная` — Instance Groups ожидает, когда ВМ остановятся самостоятельно или будут остановлены пользователем.
  1. В блоке **Масштабирование**:
     * Выберите `Автоматический` [тип масштабирования](../../concepts/instance-groups/scale.md).
     * Укажите:
       * **Тип автомасштабирования** — `Зональное` автомасштабирование регулирует количество ВМ отдельно в каждой зоне доступности, указанной в настройках группы. `Региональное` — во всей группе ВМ.
       * **Минимальное количество ВМ в зоне**.
       * **Максимальный размер группы**.
       * **Промежуток измерения нагрузки**, за который следует усреднять замеры нагрузки для каждой ВМ в группе.
       * **Время на разогрев ВМ** — время прогрева ВМ в группе.
       * **Период стабилизации** — период, в течение которого требуемое количество ВМ в группе не может быть снижено.
       * **Начальный размер группы**.
  1. В блоке **Метрики** укажите:
     * В поле **Метрика**:
       * [CPU](../../concepts/instance-groups/scale.md#cpu-utilization) — укажите средний уровень загрузки CPU, который должен поддерживать Instance Groups.
       * [Yandex Monitoring](../../concepts/instance-groups/scale.md#custom-metrics) — укажите имя пользовательской метрики и целевое значение, которое должен поддерживать Instance Groups.
  1. При необходимости активируйте опцию **Проверка состояний** для получения сведений о состоянии ВМ и их автоматического восстановления в случае сбоя.
     * В поле **Тип** выберите протокол проверок состояния: `HTTP` или `TCP`.
     * В поле **Путь** (для типа HTTP) укажите URL‐путь запроса, на который Instance Groups будет отправлять запросы проверки для HTTP.
     * В поле **Порт** укажите номер порта от 1 до 32767, на который Instance Groups будет отправлять запросы проверки.
     * В поле **Время ожидания, c** укажите время ожидания ответа от 1 до 60 секунд.
     * В поле **Интервал, c** укажите интервал между повторными проверками от 1 до 60 секунд. Интервал должен быть больше времени ожидания минимум на 1 секунду.
     * В поле **Порог работоспособности** укажите количество успешных проверок, после которого ВМ будет считаться работающей нормально.
     * В поле **Порог неработоспособности** укажите количество неудачных проверок, после которого ВМ будет считаться неработающей.
  1. В блоке **Пользовательские переменные** при необходимости укажите пары `Ключ`-`Значение`.
  1. Нажмите кнопку **Создать**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды [CLI](../../../cli/index.md) для создания группы ВМ:

     ```bash
     yc compute instance-group create --help
     ```

  1. Проверьте, есть ли в [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder) [сети](../../../vpc/concepts/network.md#network):

     ```bash
     yc vpc network list
     ```

     Если ни одной сети нет, [создайте ее](../../../vpc/operations/network-create.md).
  1. Выберите один из публичных образов Yandex Cloud Marketplace (например, [CentOS 7](https://yandex.cloud/ru/marketplace/products/yc/centos-7)).

     Чтобы получить список доступных образов с помощью CLI, выполните команду:
     
     ```bash
     yc compute image list --folder-id standard-images
     ```
     
     Результат:
     
     ```text
     +----------------------+-------------------------------------+--------------------------+----------------------+--------+
     |          ID          |                NAME                 |          FAMILY          |     PRODUCT IDS      | STATUS |
     +----------------------+-------------------------------------+--------------------------+----------------------+--------+
     ...
     | fdvk34al8k5n******** | centos-7-1549279494                 | centos-7                 | dqni65lfhvv2******** | READY  |
     | fdv7ooobjfl3******** | windows-2016-gvlk-1548913814        | windows-2016-gvlk        | dqnnc72gj2is******** | READY  |
     | fdv4f5kv5cvf******** | ubuntu-1604-lts-1549457823          | ubuntu-1604-lts          | dqnnb6dc7640******** | READY  |
     ...
     +----------------------+-------------------------------------+--------------------------+----------------------+--------+
     ```
     
     Где:
     
     * `ID` — идентификатор образа.
     * `NAME` — имя образа.
     * `FAMILY` — идентификатор [семейства образов](../../concepts/image.md#family), к которому относится образ.
     * `PRODUCT IDS` — идентификаторы [продуктов](../../../marketplace/concepts/product.md) Yandex Cloud Marketplace, связанных с образом.
     * `STATUS` — текущий статус образа. Может принимать одно из значений:
     
         * `STATUS_UNSPECIFIED` — статус образа не определен.
         * `CREATING` — образ в процессе создания.
         * `READY` — образ готов к использованию.
         * `ERROR` — образ нельзя использовать из-за возникшей с ним проблемы.
         * `DELETING` — образ в процессе удаления.

  1. Создайте YAML-файл с произвольным именем, например `specification.yaml`.
  1. Опишите в созданном файле:
     * Общую информацию о группе ВМ:

       ```yaml
       name: first-autoscaled-group
       service_account_id: <идентификатор_сервисного_аккаунта>
       description: "Эта группа ВМ создана с помощью YAML-файла конфигурации."
       ```

       Где:
       * `name` — произвольное имя группы ВМ. Имя должно быть уникальным в рамках каталога. Имя может содержать строчные буквы латинского алфавита, цифры и дефисы. Первый символ должен быть буквой. Последний символ не может быть дефисом. Максимальная длина имени — 63 символа.
       * `service_account_id` — идентификатор [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md).

          Чтобы иметь возможность создавать, обновлять и удалять ВМ в группе [назначьте](../../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту роль [compute.editor](../../security/index.md#compute-editor).

         Сервисный аккаунт нельзя удалить, пока он связан с группой виртуальных машин.

       * `description` — произвольное описание группы ВМ.
     * [Шаблон ВМ](../../concepts/instance-groups/instance-template.md), например:

       ```yaml
       instance_template:
         platform_id: standard-v3
         resources_spec:
           memory: 2g
           cores: 2
         boot_disk_spec:
           mode: READ_WRITE
           disk_spec:
             image_id: fdvk34al8k5n********
             type_id: network-hdd
             size: 32g
         network_interface_specs:
           - network_id: c64mknqgnd8a********
             primary_v4_address_spec: {}
             security_group_ids:
               - enps0ar5s3ti********
         scheduling_policy:
           preemptible: false
       ```

       По умолчанию размер диска указывается в байтах. Вы можете указать другую единицу измерения с помощью соответствующего суффикса.
       
       Суффикс | Приставка и множитель | Пример
       ----- | ----- | -----
       `k` | кило- (2^10^) | `640k` = 640 × 2^10^ = `655360`
       `m` | мега- (2^20^) | `48m` = 48 × 2^20^ = `50331648`
       `g` | гига- (2^30^) | `10g` = 10 × 2^30^ = `10737418240`
       `t` | тера- (2^40^) | `4t` = 4 × 2^40^ = `4398046511104`
       `p` | пета- (2^50^) | `2p` = 2 × 2^50^ = `2251799813685248`

       Где:
       * `platform_id` — идентификатор [платформы](../../concepts/vm-platforms.md).
       * `memory` — количество памяти (RAM).
       * `cores` — количество ядер процессора (vCPU).
       * `mode` — режим доступа к [диску](../../concepts/disk.md).
         * `READ_ONLY` — доступ на чтение.
         * `READ_WRITE` — доступ на чтение и запись.
       * `image_id` — идентификатор публичного образа. Его можно посмотреть в [консоли управления](https://console.yandex.cloud) при создании ВМ или в [Cloud Marketplace](https://yandex.cloud/ru/marketplace) на странице образа в блоке **Идентификаторы продукта**.
       * `type_id` — тип диска.
       * `size` — размер диска.
       * `network_id` — идентификатор сети `default-net`.
       * `primary_v4_address_spec` — спецификация версии интернет протокола IPv4. Вы можете предоставить публичный доступ к ВМ группы, указав версию IP для [публичного IP-адреса](../../../vpc/concepts/address.md#public-addresses). Подробнее читайте в разделе [Описание шаблона в YAML-файле](../../concepts/instance-groups/instance-template.md#instance-template).
       * `security_group_ids` — список идентификаторов [групп безопасности](../../../vpc/concepts/security-groups.md).
       * `scheduling_policy` — конфигурация политики планирования.
       * `preemptible` — флаг, указывающий создавать [прерываемые ВМ](../../concepts/preemptible-vm.md).
         * `true` — будет создана прерываемая ВМ.
         * `false` (по умолчанию) — обычная.

         Создавая группу прерываемых ВМ учитывайте, что ВМ будут останавливаться спустя 24 часа непрерывной работы, а могут быть остановлены еще раньше. При этом возможна ситуация, что ВМ не смогут сразу перезапуститься их из-за нехватки ресурсов. Это может произойти, если резко возрастет потребление вычислительных ресурсов в Yandex Cloud.
     * [Политики](../../concepts/instance-groups/policies/index.md):

       ```yaml
       deploy_policy:
         max_unavailable: 1
         max_expansion: 0
       scale_policy:
         auto_scale:
           initial_size: 5
           max_size: 15
           min_zone_size: 3
           measurement_duration: 30s
           warmup_duration: 60s
           stabilization_duration: 120s
           cpu_utilization_rule: 0.75
       allocation_policy:
         zones:
           - zone_id: ru-central1-a
       ```

       Где:
       * `deploy_policy` — [политика развертывания](../../concepts/instance-groups/policies/deploy-policy.md) ВМ в группе.
       * `scale_policy` — [политика масштабирования](../../concepts/instance-groups/policies/scale-policy.md) ВМ в группе.
       * `allocation_policy` — [политика распределения](../../concepts/instance-groups/policies/allocation-policy.md) ВМ по [зонам доступности](../../../overview/concepts/geo-scope.md).

     Полный код файла `specification.yaml`:

     ```yaml
     name: first-autoscaled-group
     service_account_id: <идентификатор_сервисного_аккаунта>
     description: "Эта группа ВМ создана с помощью YAML-файла конфигурации."
     instance_template:
       platform_id: standard-v3
       resources_spec:
         memory: 2g
         cores: 2
       boot_disk_spec:
         mode: READ_WRITE
         disk_spec:
           image_id: fdvk34al8k5n********
           type_id: network-hdd
           size: 32g
       network_interface_specs:
         - network_id: c64mknqgnd8a********
           primary_v4_address_spec: {}
           security_group_ids:
             - enps0ar5s3ti********
     deploy_policy:
       max_unavailable: 1
       max_expansion: 0
     scale_policy:
       auto_scale:
         initial_size: 5
         max_size: 15
         min_zone_size: 3
         measurement_duration: 30s
         warmup_duration: 60s
         stabilization_duration: 120s
         cpu_utilization_rule:
           utilization_target: 75
     allocation_policy:
       zones:
         - zone_id: ru-central1-a
     ```

  1. Создайте группу ВМ в каталоге по умолчанию:

     ```bash
     yc compute instance-group create --file specification.yaml
     ```

     Данная команда создаст автоматически масштабируемую группу ВМ со следующими характеристиками:
     * С именем `first-autoscaled-group`.
     * С OC CentOS 7.
     * В сети `default-net`.
     * В зоне доступности `ru-central1-a`.
     * С 2 vCPU и 2 ГБ RAM.
     * С сетевым [HDD-диском](../../concepts/disk.md#disks-types) объемом 32 ГБ.

- Terraform {#tf}

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

     ```hcl
     resource "yandex_iam_service_account" "ig-sa" {
       name        = "ig-sa"
       description = "Сервисный аккаунт для управления группой ВМ."
     }

     resource "yandex_resourcemanager_folder_iam_member" "compute_editor" {
       folder_id = "<идентификатор_каталога>"
       role      = "compute.editor"
       member    = "serviceAccount:${yandex_iam_service_account.ig-sa.id}"
     }

     resource "yandex_compute_instance_group" "ig-1" {
       name               = "autoscaled-ig"
       folder_id          = "<идентификатор_каталога>"
       service_account_id = "${yandex_iam_service_account.ig-sa.id}"
       deletion_protection = "<защита_от_удаления>"
       instance_template {
         platform_id = "standard-v3"
         resources {
           memory = <объем_RAM_ГБ>
           cores  = <количество_ядер_vCPU>
         }

         boot_disk {
           mode = "READ_WRITE"
           initialize_params {
             image_id = "<идентификатор_образа>"
           }
         }

         network_interface {
           network_id         = "${yandex_vpc_network.network-1.id}"
           subnet_ids         = ["${yandex_vpc_subnet.subnet-1.id}"]
           security_group_ids = ["<список_идентификаторов_групп_безопасности>"]
         }

         metadata = {
           ssh-keys = "<имя_пользователя>:<содержимое_SSH-ключа>"
         }
       }

       scale_policy {
         auto_scale {
           initial_size           = 3
           measurement_duration   = 60
           cpu_utilization_target = 75
           min_zone_size          = 3
           max_size               = 15
           warmup_duration        = 60
           stabilization_duration = 120
         }
       }

       allocation_policy {
         zones = ["ru-central1-a"]
       }

       deploy_policy {
         max_unavailable = 1
         max_expansion   = 0
       }
     }

     resource "yandex_vpc_network" "network-1" {
       name = "network1"
     }

     resource "yandex_vpc_subnet" "subnet-1" {
       name           = "subnet1"
       zone           = "ru-central1-a"
       network_id     = "${yandex_vpc_network.network-1.id}"
       v4_cidr_blocks = ["192.168.10.0/24"]
     }
     ```

     Где:
     * `yandex_iam_service_account` — описание [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md). Все операции с группой ВМ выполняются от имени сервисного аккаунта.
     * `yandex_resourcemanager_folder_iam_member` — описание прав доступа к [каталогу](../../../resource-manager/concepts/resources-hierarchy.md#folder), которому принадлежит сервисный аккаунт. Чтобы иметь возможность создавать, обновлять и удалять ВМ в группе, назначьте сервисному аккаунту роль [compute.editor](../../security/index.md#compute-editor).
     * `yandex_compute_instance_group` — описание группы ВМ.
       * Общая информация о группе ВМ:
         * `name` — имя группы ВМ.
         * `folder_id` — идентификатор каталога.
         * `service_account_id` — идентификатор [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md).
         * `deletion_protection` — защита группы ВМ от удаления: `true` или `false`. Пока опция включена, группу ВМ удалить невозможно. Значение по умолчанию `false`.
       * [Шаблон ВМ](../../concepts/instance-groups/instance-template.md):
         * `platform_id` — [платформа](../../concepts/vm-platforms.md).
         * `resources` — количество ядер vCPU и объем RAM, доступные ВМ. Значения должны соответствовать выбранной платформе.
         * `boot_disk` — настройки загрузочного [диска](../../concepts/disk.md).
           * Идентификатор выбранного образа. Вы можете получить идентификатор образа из [списка публичных образов](../images-with-pre-installed-software/get-list.md).
           * Режим доступа к диску: `READ_ONLY` (чтение) или `READ_WRITE` (чтение и запись).
         * `network_interface` — настройка [сети](../../../vpc/concepts/network.md#network). Укажите идентификаторы сети, [подсети](../../../vpc/concepts/network.md#subnet) и [групп безопасности](../../../vpc/concepts/security-groups.md).
         * `metadata` — в [метаданных](../../concepts/vm-metadata.md) необходимо передать открытый ключ для [SSH-доступа](../../../glossary/ssh-keygen.md) на ВМ. Подробнее в разделе [Метаданные виртуальной машины](../../concepts/vm-metadata.md).
       * [Политики](../../concepts/instance-groups/policies/index.md):
         * `deploy_policy` — [политика развертывания](../../concepts/instance-groups/policies/deploy-policy.md) ВМ в группе.
         * `scale_policy` — [политика масштабирования](../../concepts/instance-groups/policies/scale-policy.md) ВМ в группе.
         * `allocation_policy` — [политика распределения](../../concepts/instance-groups/policies/allocation-policy.md) ВМ по [зонам доступности](../../../overview/concepts/geo-scope.md).
     * `yandex_vpc_network` — описание облачной сети.
     * `yandex_vpc_subnet` — описание подсети, к которой будет подключена группа ВМ.

       {% note info %}

       Если у вас уже есть подходящие ресурсы (сервисный аккаунт, облачная сеть и подсеть), описывать их повторно не нужно. Используйте их имена и идентификаторы в соответствующих параметрах.

       {% endnote %}

     Более подробную информацию о ресурсах, которые вы можете создать с помощью Terraform, читайте в [документации провайдера](../../../terraform/index.md).
  1. Создайте ресурсы:

     1. В терминале перейдите в директорию с конфигурационным файлом.
     1. Проверьте корректность конфигурации с помощью команды:
     
        ```bash
        terraform validate
        ```
     
        Если конфигурация является корректной, появится сообщение:
     
        ```bash
        Success! The configuration is valid.
        ```
     
     1. Выполните команду:
     
        ```bash
        terraform plan
        ```
     
        В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
     1. Примените изменения конфигурации:
     
        ```bash
        terraform apply
        ```
     
     1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

     После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления](https://console.yandex.cloud).

- API {#api}

  Воспользуйтесь методом REST API [create](../../instancegroup/api-ref/InstanceGroup/create.md) для ресурса [InstanceGroup](../../instancegroup/api-ref/InstanceGroup/index.md) или вызовом gRPC API [InstanceGroupService/Create](../../instancegroup/api-ref/grpc/InstanceGroup/create.md).

{% endlist %}

Если вы используете образ на основе Windows, [сбросьте](../vm-control/vm-reset-password.md) пароль после создания ВМ.