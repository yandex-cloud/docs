---
title: Создать группу виртуальных машин с подключением к {{ objstorage-full-name }}
description: Следуя данной инструкции, вы сможете создать группу виртуальных машин с подключением к {{ objstorage-name }}.
---

# Создать группу виртуальных машин с подключением к {{ objstorage-full-name }}


Одним из способов работы со [Stateful-нагрузкой](../../concepts/instance-groups/stateful-workload.md) является сохранение состояния приложения в независимом от группы ВМ [бакете {{ objstorage-name }}](../../../storage/concepts/bucket.md).

Чтобы создать группу ВМ, в которой к каждой ВМ будет автоматически подключаться общий бакет {{ objstorage-name }}:

1. {% include [sa.md](../../../_includes/instance-groups/sa.md) %}
1. Если у вас нет бакета {{ objstorage-name }}, [создайте его](../../../storage/operations/buckets/create.md).
1. Операции с бакетом выполняются от имени сервисного аккаунта, созданного в том же [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder), что, что и сам бакет. Если такого сервисного аккаунта нет, создайте его. Для работы с бакетом назначьте сервисному аккаунту [роль](../../../storage/security/index.md#storage-editor) `storage.editor`.

    Для работы с группой виртуальных машин и с бакетом можно использовать как один, так и два разных сервисных аккаунта.

1. Создайте группу ВМ:

    {% list tabs group=instructions %}

    - CLI {#cli}

      {% include [cli-install.md](../../../_includes/cli-install.md) %}

      {% include [default-catalogue.md](../../../_includes/default-catalogue.md) %}

      1. Посмотрите описание команды [CLI](../../../cli/) для создания группы ВМ:

         ```bash
         {{ yc-compute-ig }} create --help
         ```

      1. Проверьте, есть ли в [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder) [сети](../../../vpc/concepts/network.md#network):

         ```bash
         yc vpc network list
         ```

         Если ни одной сети нет, [создайте ее](../../../vpc/operations/network-create.md).
      1. Выберите один из публичных образов {{ marketplace-full-name }} (например, [Ubuntu 22.04 LTS](/marketplace/products/yc/ubuntu-22-04-lts)).

         {% include [standard-images.md](../../../_includes/standard-images.md) %}

      1. Подготовьте файл с [YAML-спецификацией](../../concepts/instance-groups/specification.md) группы ВМ с произвольным именем, например `specification.yaml`.

          Для того чтобы привязать бакет к виртуальным машинам группы, добавьте в спецификацию:

          * В поле `instance_template` — вложенное поле `service_account_id`, содержащее [идентификатор](../../../iam/operations/sa/get-id.md) сервисного аккаунта с назначенной ролью `storage.editor`:

              ```yml
              instance_template:
                ...
                service_account_id: <идентификатор_сервисного_аккаунта>
              ```

              Чтобы добиться более гранулярного управления правами доступа, привязывайте к группе ВМ и к виртуальным машинам группы разные сервисные аккаунты с разными наборами разрешений.

          * В секцию `#cloud-config` поля `instance_template.metadata.user-data` — набор команд для монтирования бакета на ВМ:

              ```yml
              instance_template:
                ...
                metadata:
                  user-data: |-
                    #cloud-config
                    ...
                    runcmd:
                      - apt-get install fuse
                      - wget https://github.com/yandex-cloud/geesefs/releases/latest/download/geesefs-linux-amd64
                      - chmod a+x geesefs-linux-amd64
                      - cp geesefs-linux-amd64 /usr/bin/geesefs
                      - mkdir <точка_монтирования_на_ВМ>
                      - echo "user_allow_other" | tee -a /etc/fuse.conf
                      - echo "<имя_бакета>    <точка_монтирования_на_ВМ>    fuse.geesefs    _netdev,allow_other,--iam    0   0" | tee -a /etc/fstab
                      - mount -a
              ```

              Где:
              * `- apt-get install fuse` — команда для установки модуля [FUSE](https://ru.wikipedia.org/wiki/FUSE_(модуль_ядра)). Подходит для операционных систем Ubuntu и Debian. Для ОС на основе Red Hat, таких как CentOS и Fedora, используйте команду `- yum install fuse`, для ОС OpenSUSE — `- zypper install fuse`, и т.п.
              * `<точка_монтирования_на_ВМ>` — директория на ВМ, в которую будет смонтирован подключенный бакет. Например: `/mnt/gfs0`.
              * `<имя_бакета>` — [имя бакета](../../../storage/concepts/bucket.md#naming), который требуется подключить к ВМ.

          Пример YAML-спецификации:

          ```yml
          name: vm-group-with-object-storage
          service_account_id: ajegtlf2q28a********
          description: "Эта группа ВМ создана с помощью YAML-файла конфигурации."
          instance_template:
            platform_id: standard-v3
            resources_spec:
              memory: 2g
              cores: 2
            boot_disk_spec:
              mode: READ_WRITE
              disk_spec:
                image_id: fd8dlvgiatiqd8tt2qke
                type_id: network-hdd
                size: 32g
            network_interface_specs:
              - network_id: enp9mji1m7b3********
                primary_v4_address_spec: {
                  one_to_one_nat_spec: {
                    ip_version: IPV4
                  }
                }
                security_group_ids:
                  - enpuatgvejtn********
            service_account_id: aje1ki4ae68u********
            metadata:
              user-data: |-
                #cloud-config
                datasource:
                 Ec2:
                  strict_id: false
                ssh_pwauth: no
                users:
                - name: my-user
                  sudo: ALL=(ALL) NOPASSWD:ALL
                  shell: /bin/bash
                  ssh_authorized_keys:
                  - <публичный_SSH-ключ>
                runcmd:
                - apt-get install fuse
                - wget https://github.com/yandex-cloud/geesefs/releases/latest/download/geesefs-linux-amd64
                - chmod a+x geesefs-linux-amd64
                - cp geesefs-linux-amd64 /usr/bin/geesefs
                - mkdir /mnt/gfs0
                - echo "user_allow_other" | tee -a /etc/fuse.conf
                - echo "my-bucket-for-vm-group    /mnt/gfs0    fuse.geesefs    _netdev,allow_other,--iam    0   0" | tee -a /etc/fstab
                - mount -a
          deploy_policy:
            max_unavailable: 1
            max_expansion: 0
          scale_policy:
            fixed_scale:
              size: 2
          allocation_policy:
            zones:
              - zone_id: {{ region-id }}-a
                instance_tags_pool:
                - first
                - second
          ```

          В данном примере приведена спецификация для [создания группы ВМ фиксированного размера](./create-fixed-group.md) с подключенным к виртуальным машинам бакетом {{ objstorage-name }}.

          Подробнее о параметрах спецификации группы ВМ см. в разделе [{#T}](../../concepts/instance-groups/specification.md).

      1. Создайте группу ВМ в каталоге по умолчанию:

          ```bash
          {{ yc-compute-ig }} create --file specification.yaml
          ```

         Данная команда создаст группу из двух однотипных ВМ со следующими характеристиками:
         * С именем `my-vm-group-with-object-storage`.
         * С OC `Ubuntu 22.04 LTS`.
         * В зоне доступности `{{ region-id }}-a`.
         * С 2 vCPU и 2 ГБ RAM.
         * С сетевым [HDD-диском](../../concepts/disk.md#disks-types) объемом 32 ГБ.
         * С подключенным бакетом {{ objstorage-name }}. Бакет будет смонтирован в директорию `/mnt/gfs0` виртуальных машин группы.
         * {% include [ssh-connection-internal-ip](../../../_includes/instance-groups/ssh-connection-internal-ip.md) %}

    - {{ TF }} {#tf}

      {% include [terraform-install](../../../_includes/terraform-install.md) %}

      1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

          ```hcl
          resource "yandex_iam_service_account" "ig-sa" {
            name        = "ig-sa"
            description = "Сервисный аккаунт для управления группой ВМ."
          }

          resource "yandex_iam_service_account" "storage-sa" {
            name        = "storage-sa"
            description = "Сервисный аккаунт для управления бакетом."
          }

          resource "yandex_resourcemanager_folder_iam_member" "editor" {
            folder_id  = "<идентификатор_каталога>"
            role       = "editor"
            member     = "serviceAccount:${yandex_iam_service_account.ig-sa.id}"
            depends_on = [
              yandex_iam_service_account.ig-sa,
            ]
          }

          resource "yandex_resourcemanager_folder_iam_member" "storage_editor" {
            folder_id  = "<идентификатор_каталога>"
            role       = "storage.editor"
            member     = "serviceAccount:${yandex_iam_service_account.storage-sa.id}"
            depends_on = [
              yandex_iam_service_account.storage-sa,
            ]
          }

          resource "yandex_compute_instance_group" "ig-1" {
            name                = "fixed-ig"
            folder_id           = "<идентификатор_каталога>"
            service_account_id  = "${yandex_iam_service_account.ig-sa.id}"
            deletion_protection = "<защита_от_удаления>"
            depends_on          = [yandex_resourcemanager_folder_iam_member.editor]
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

              service_account_id = "${yandex_iam_service_account.storage-sa.id}"

              network_interface {
                network_id         = "${yandex_vpc_network.network-1.id}"
                subnet_ids         = ["${yandex_vpc_subnet.subnet-1.id}"]
                security_group_ids = ["<список_идентификаторов_групп_безопасности>"]
                nat                = true
              }

              metadata = {
                user-data = "#cloud-config\n      datasource:\n       Ec2:\n        strict_id: false\n      ssh_pwauth: no\n      users:\n      - name: <имя_пользователя_ВМ>\n        sudo: ALL=(ALL) NOPASSWD:ALL\n        shell: /bin/bash\n        ssh_authorized_keys:\n        - <публичный_SSH-ключ>\n      runcmd:\n      - apt-get install fuse\n      - wget https://github.com/yandex-cloud/geesefs/releases/latest/download/geesefs-linux-amd64\n      - chmod a+x geesefs-linux-amd64\n      - cp geesefs-linux-amd64 /usr/bin/geesefs\n      - mkdir <точка_монтирования_на_ВМ>\n      - echo \"user_allow_other\" | tee -a /etc/fuse.conf\n      - echo \"<имя_бакета>    <точка_монтирования_на_ВМ>    fuse.geesefs    _netdev,allow_other,--iam    0   0\" | tee -a /etc/fstab\n      - mount -a"
              }
            }

            scale_policy {
              fixed_scale {
                size = <количество_ВМ_в_группе>
              }
            }

            allocation_policy {
              zones = ["{{ region-id }}-a"]
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
            zone           = "{{ region-id }}-a"
            network_id     = "${yandex_vpc_network.network-1.id}"
            v4_cidr_blocks = ["192.168.10.0/24"]
          }
          ```

          Где:
          * `yandex_iam_service_account` — описание [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md). Все операции в {{ ig-name }} выполняются от имени сервисного аккаунта. Чтобы добиться более гранулярного управления правами доступа, привязывайте к группе ВМ и к виртуальным машинам группы разные сервисные аккаунты с разными наборами разрешений.

            {% include [sa-dependence-brief](../../../_includes/instance-groups/sa-dependence-brief.md) %}

          * `yandex_resourcemanager_folder_iam_member` — описание прав доступа к [каталогу](../../../resource-manager/concepts/resources-hierarchy.md#folder), которому принадлежит сервисный аккаунт. Чтобы иметь возможность создавать, обновлять и удалять ВМ в группе, назначьте сервисному аккаунту [роль](../../../iam/concepts/access-control/roles.md) `editor`.
          * `yandex_compute_instance_group` — описание группы ВМ:
            * Общая информация о группе ВМ:
              * `name` — имя группы ВМ.
              * `folder_id` — идентификатор каталога.
              * `service_account_id` — идентификатор сервисного аккаунта для группы ВМ.
              * `deletion_protection` — защита группы ВМ от удаления: `true` или `false`. Пока опция включена, группу ВМ удалить невозможно. Значение по умолчанию `false`.
            * [Шаблон ВМ](../../concepts/instance-groups/instance-template.md):
              * `platform_id` — [платформа](../../concepts/vm-platforms.md).
              * `resources` — количество ядер vCPU и объем RAM, доступные ВМ. Значения должны соответствовать выбранной [платформе](../../concepts/vm-platforms.md).
              * `boot_disk` — настройки загрузочного [диска](../../concepts/disk.md).
                * `mode` — режим доступа к диску: `READ_ONLY` (чтение) или `READ_WRITE` (чтение и запись).
                * `image_id` — идентификатор выбранного образа. Вы можете получить идентификатор образа из [списка публичных образов](../images-with-pre-installed-software/get-list.md).
              * `service_account_id` — идентификатор сервисного аккаунта для бакета.    
              * `network_interface` — настройка [сети](../../../vpc/concepts/network.md#network). Укажите идентификаторы сети, [подсети](../../../vpc/concepts/network.md#subnet) и [групп безопасности](../../../vpc/concepts/security-groups.md).
              * `metadata` — в [метаданных](../../concepts/vm-metadata.md) необходимо передать:
                * Имя пользователя ВМ и открытый ключ для [SSH-доступа](../../../glossary/ssh-keygen.md) этого пользователя на ВМ. 
                * `- apt-get install fuse` — команда для установки модуля [FUSE](https://ru.wikipedia.org/wiki/FUSE_(модуль_ядра)). Подходит для операционных систем Ubuntu и Debian. Для ОС на основе Red Hat, таких как CentOS и Fedora, используйте команду `- yum install fuse`, для ОС OpenSUSE — `- zypper install fuse`, и т.п.
                * `<точка_монтирования_на_ВМ>` — директория на ВМ, в которую будет смонтирован подключенный бакет. Например: `/mnt/gfs0`.
                * `<имя_бакета>` — [имя бакета](../../../storage/concepts/bucket.md#naming), который требуется подключить к ВМ.

                Подробнее см. в разделе [{#T}](../../concepts/vm-metadata.md).
            * [Политики](../../concepts/instance-groups/policies/index.md):
              * `deploy_policy` — [политика развертывания](../../concepts/instance-groups/policies/deploy-policy.md) ВМ в группе.
              * `scale_policy` — [политика масштабирования](../../concepts/instance-groups/policies/scale-policy.md) ВМ в группе.
              * `allocation_policy` — [политика распределения](../../concepts/instance-groups/policies/allocation-policy.md) ВМ по [зонам доступности](../../../overview/concepts/geo-scope.md) и регионам.
          * `yandex_vpc_network` — описание облачной сети.
          * `yandex_vpc_subnet` — описание подсети, к которой будет подключена группа ВМ.

            {% note info %}

            Если у вас уже есть подходящие ресурсы (сервисные аккаунты, облачная сеть и подсеть), описывать их повторно не нужно. Используйте их имена и идентификаторы в соответствующих параметрах.

            {% endnote %}

          Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, см. в [документации провайдера]({{ tf-provider-link }}).

      1. Создайте ресурсы:

          {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

          После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}).

          {% include [ssh-connection-internal-ip](../../../_includes/instance-groups/ssh-connection-internal-ip.md) %}

    - API {#api}

      Воспользуйтесь методом REST API [create](../../instancegroup/api-ref/InstanceGroup/create.md) для ресурса [InstanceGroup](../../instancegroup/api-ref/InstanceGroup/index.md) или вызовом gRPC API [InstanceGroupService/Create](../../instancegroup/api-ref/grpc/InstanceGroup/create.md).

    {% endlist %}

Убедитесь, что бакет подключен к виртуальным машинам группы. Для этого [подключитесь](../vm-connect/ssh.md#vm-connect) к ВМ по SSH и перейдите в директорию, которую вы указали в качестве точки монтирования.