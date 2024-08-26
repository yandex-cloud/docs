# Развертывание параллельной файловой системы GlusterFS в высокодоступном режиме


[GlusterFS](https://ru.wikipedia.org/wiki/GlusterFS) — это распределенная, параллельная, линейно масштабируемая файловая система. При использовании горизонтального масштабирования она обеспечивает в облаке агрегированную пропускную способность в десятки ГБ/с и в сотни тысяч [IOPS](https://ru.wikipedia.org/wiki/IOPS).

При помощи этого руководства вы сможете создать инфраструктуру из трех сегментов, имеющих общую файловую систему GlusterFS. Размещение [дисков](../../compute/concepts/disk.md) для хранения данных в трех разных [зонах доступности](../../overview/concepts/geo-scope.md) обеспечит высокую доступность и отказоустойчивость файловой системы.

Чтобы настроить высокодоступную файловую систему:

1. [Подготовьте облако к работе](#prepare-cloud).
1. [Настройте профиль CLI](#setup-profile).
1. [Подготовьте среду для развертывания ресурсов](#setup-environment).
1. [Разверните ресурсы](#deploy-resources).
1. [Установите и настройте GlusterFS](#install-glusterfs).
1. [Протестируйте доступность и отказоустойчивость решения](#test-glusterfs).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).
 
## Подготовьте облако к работе {#prepare-cloud}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}


### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входят:

* плата за постоянно работающие ВМ и диски (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md));
* плата за использование публичных IP-адресов и исходящий трафик (см. [тарифы {{ vpc-full-name }}](../../vpc/pricing.md));


## Настройте профиль CLI {#setup-profile}

1. Если у вас еще нет интерфейса командной строки {{ yandex-cloud }}, [установите](../../cli/quickstart.md) его и авторизуйтесь от имени пользователя.
1. Создайте сервисный аккаунт:
   
   {% list tabs group=instructions %}

   - Консоль управления {#console}

      1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать сервисный аккаунт.
      1. На вкладке **{{ ui-key.yacloud.iam.folder.switch_service-accounts }}** нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
      1. Введите имя сервисного аккаунта, например, `sa-glusterfs`.
      1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

   - CLI {#cli}

      {% include [default-catalogue](../../_includes/default-catalogue.md) %}

      Выполните команду для создания сервисного аккаунта, указав имя `sa-glusterfs`:

      ```bash
      yc iam service-account create --name sa-glusterfs
      ```

      Где `name` — имя сервисного аккаунта.

      Результат:
      ```bash
      id: ajehr0to1g8b********
      folder_id: b1gv87ssvu49********
      created_at: "2023-06-20T09:03:11.665153755Z"
      name: sa-glusterfs
      ```

   - API {#api}

      Чтобы создать сервисный аккаунт, воспользуйтесь вызовом gRPC API [ServiceAccountService/Create](../../iam/api-ref/grpc/service_account_service.md#Create) или методом [create](../../iam/api-ref/ServiceAccount/create.md) для ресурса `ServiceAccount` REST API.

   {% endlist %}

1. Назначьте сервисному аккаунту [роль](../../iam/concepts/access-control/roles.md) администратора на каталог:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

      1. На [стартовой странице]({{ link-console-main }}) консоли управления выберите каталог.
      1. Перейдите на вкладку **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}**.
      1. Найдите аккаунт `sa-glusterfs` в списке и нажмите значок ![image](../../_assets/options.svg).
      1. Нажмите кнопку **{{ ui-key.yacloud.common.resource-acl.button_assign-binding }}**.
      1. В открывшемся диалоге нажмите кнопку **{{ ui-key.yacloud_components.acl.button.add-role }}** и выберите роль `admin`.

   - CLI {#cli}

      Выполните команду:
      ```
      yc resource-manager folder add-access-binding <идентификатор_каталога> \
         --role admin \
         --subject serviceAccount:<идентификатор_сервисного_аккаунта>
      ```

   - API {#api}

      Чтобы назначить сервисному аккаунту роль на каталог, воспользуйтесь методом REST API [setAccessBindings](../../iam/api-ref/ServiceAccount/setAccessBindings.md) для ресурса [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) или вызовом gRPC API [ServiceAccountService/SetAccessBindings](../../iam/api-ref/grpc/service_account_service.md#SetAccessBindings).

   {% endlist %}

1. Настройте профиль CLI для выполнения операций от имени сервисного аккаунта:

   {% list tabs group=instructions %}

   - CLI {#cli}

      1. Создайте [авторизованный ключ](../../iam/concepts/authorization/key.md) для сервисного аккаунта и запишите его в файл:
         ```
         yc iam key create \
         --service-account-id <идентификатор_сервисного_аккаунта> \
         --folder-id <id_каталога_с_сервисным_аккаунтом> \
         --output key.json
         ```
         Где:
         * `service-account-id` — идентификатор сервисного аккаунта.
         * `folder-id` — идентификатор каталога, в котором создан сервисный аккаунт.
         * `output` — имя файла с авторизованным ключом.

         Результат:
         ```
         id: aje8nn871qo4********
         service_account_id: ajehr0to1g8b********
         created_at: "2023-06-20T09:16:43.479156798Z"
         key_algorithm: RSA_2048
         ```

      1. Создайте профиль CLI для выполнения операций от имени сервисного аккаунта:
         ```
         yc config profile create sa-glusterfs
         ```

         Результат:
         ```
         Profile 'sa-glusterfs' created and activated
         ```

      1. Задайте конфигурацию профиля:
         ```
         yc config set service-account-key key.json
         yc config set cloud-id <идентификатор_облака>
         yc config set folder-id <идентификатор_каталога>  
         ```

         Где:
         * `service-account-key` — файл с авторизованным ключом сервисного аккаунта.
         * `cloud-id` — [идентификатор облака](../../resource-manager/operations/cloud/get-id.md).
         * `folder-id` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md).

      1. Добавьте аутентификационные данные в переменные окружения:
         ```
         export YC_TOKEN=$(yc iam create-token)
         export YC_CLOUD_ID=$(yc config get cloud-id)
         export YC_FOLDER_ID=$(yc config get folder-id)
         ```

    {% endlist %}


## Подготовьте среду для развертывания ресурсов {#setup-environment}

1. Создайте пару ключей [SSH](../../glossary/ssh-keygen.md):
   ```bash
   ssh-keygen -t ed25519
   ```
   Рекомендуем оставить имя файла ключа без изменения.
1. [Установите {{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
1. Клонируйте репозиторий `yandex-cloud-examples/yc-distributed-ha-storage-with-glusterfs` из GitHub и перейдите в папку `yc-distributed-ha-storage-with-glusterfs`:
    ```
    git clone https://github.com/yandex-cloud-examples/yc-distributed-ha-storage-with-glusterfs.git
    cd ./yc-distributed-ha-storage-with-glusterfs
    ```
1. Отредактируйте файл `variables.tf`, указав параметры разворачиваемых ресурсов:

   {% note warning %}

   Заданные в файле значения приводят к разворачиванию ресурсоемкой инфраструктуры.
   Чтобы развернуть ресурсы в рамках имеющихся у вас квот, используйте приведенные ниже значения или измените значения на свое усмотрение.

   {% endnote %}

   1. В секции `disk_size` значение `default` измените на `30`.
   1. В секции `client_cpu_count` значение `default` измените на `2`.
   1. В секции `storage_cpu_count` значение `default` измените на `2`.
   1. Если при создании пары ключей SSH вы указали имя, отличное от имени по умолчанию, в секции `local_pubkey_path` значение `default` измените на `<путь_к_публичному_ключу_SSH>`.

## Разверните ресурсы {#deploy-resources}
   
   1. Выполните инициализацию {{TF}}:
      ```bash
      terraform init
      ```
   1. Проверьте конфигурацию {{TF}} файлов:
      ```bash
      terraform validate
      ```
   1. Проверьте список создаваемых облачных ресурсов:
      ```bash
      terraform plan
      ```
   1. Создайте ресурсы:
      ```bash
      terraform apply -auto-approve
      ```
   1. Дождитесь появления сообщения о завершении процесса:
      ```bash
      Outputs:

      connect_line = "ssh storage@158.160.108.137"
      public_ip = "158.160.108.137"
      ```

   В результате в каталоге будут созданы три ВМ для размещения клиентского кода (`client01`, `client02` и `client03`) и три привязанные к ним ВМ для распределенного хранения данных (`gluster01`, `gluster02` и `gluster03`) в трех разных зонах доступности.

## Установите и настройте GlusterFS {#install-glusterfs}

   1. Подключитесь к ВМ `client01`, используя команду из выдачи о завершении процесса:
      ```bash
      ssh storage@158.160.108.137
      ```
   1. Перейдите в режим работы с правами суперпользователя `root`:
      ```bash
      sudo -i
      ```
   1. Установите [ClusterShell](https://clustershell.readthedocs.io/en/latest/intro.html):
      ```bash
      dnf install epel-release -y
      dnf install clustershell -y
      echo 'ssh_options: -oStrictHostKeyChecking=no' >> /etc/clustershell/clush.conf
      ```
   1. Создайте конфигурационные файлы:
      ```bash
      cat > /etc/clustershell/groups.conf <<EOF
      [Main]
      default: cluster
      confdir: /etc/clustershell/groups.conf.d $CFGDIR/groups.conf.d
      autodir: /etc/clustershell/groups.d $CFGDIR/groups.d
      EOF      

      cat > /etc/clustershell/groups.d/cluster.yaml <<EOF
      cluster:
          all: '@clients,@gluster'
          clients: 'client[01-03]'
          gluster: 'gluster[01-03]'
      EOF 
      ```
   1. Установите GlusterFS:
      ```bash
      clush -w @all hostname # check and auto add fingerprints
      clush -w @all dnf install centos-release-gluster -y
      clush -w @all dnf --enablerepo=powertools install glusterfs-server -y
      clush -w @gluster mkfs.xfs -f -i size=512 /dev/vdb
      clush -w @gluster mkdir -p /bricks/brick1
      clush -w @gluster "echo '/dev/vdb /bricks/brick1 xfs defaults 1 2' >> /etc/fstab"
      clush -w @gluster "mount -a && mount"
      ```
   1. Перезапустите GlusterFS:
      ```bash
      clush -w @gluster systemctl enable glusterd
      clush -w @gluster systemctl restart glusterd
      ```
   1. Проверьте доступность ВМ `gluster02` и `gluster03`:
      ```bash
      clush -w gluster01 gluster peer probe gluster02
      clush -w gluster01 gluster peer probe gluster03
      ```
   1. Создайте папки `vol0` в ВМ для хранения данных и настройте доступность и отказоустойчивость за счет подключения к папке общего доступа `regional-volume`:
      ```bash
      clush -w @gluster mkdir -p /bricks/brick1/vol0
      clush -w gluster01 gluster volume create regional-volume disperse 3 redundancy 1 gluster01:/bricks/brick1/vol0 gluster02:/bricks/brick1/vol0 gluster03:/bricks/brick1/vol0  
      ```

   1. Выполните дополнительные настройки производительности:
      ```bash
      clush -w gluster01 gluster volume set regional-volume client.event-threads 8
      clush -w gluster01 gluster volume set regional-volume server.event-threads 8
      clush -w gluster01 gluster volume set regional-volume cluster.shd-max-threads 8
      clush -w gluster01 gluster volume set regional-volume performance.read-ahead-page-count 16
      clush -w gluster01 gluster volume set regional-volume performance.client-io-threads on
      clush -w gluster01 gluster volume set regional-volume performance.quick-read off 
      clush -w gluster01 gluster volume set regional-volume performance.parallel-readdir on 
      clush -w gluster01 gluster volume set regional-volume performance.io-thread-count 32
      clush -w gluster01 gluster volume set regional-volume performance.cache-size 1GB
      clush -w gluster01 gluster volume set regional-volume server.allow-insecure on   
      ```
   1. Смонтируйте папку общего доступа `regional-volume` на клиентских ВМ:
      ```bash
      clush -w gluster01 gluster volume start regional-volume
      clush -w @clients mount -t glusterfs gluster01:/regional-volume /mnt/
      ```

## Протестируйте доступность и отказоустойчивость решения {#test-glusterfs}

   1. Проверьте статус папки общего доступа `regional-volume`:
      ```bash
      clush -w gluster01 gluster volume status
      ```
      Результат:

      ```bash
      gluster01: Status of volume: regional-volume
      gluster01: Gluster process                             TCP Port  RDMA Port  Online  Pid
      gluster01: ------------------------------------------------------------------------------
      gluster01: Brick gluster01:/bricks/brick1/vol0         54660     0          Y       1374
      gluster01: Brick gluster02:/bricks/brick1/vol0         58127     0          Y       7716
      gluster01: Brick gluster03:/bricks/brick1/vol0         53346     0          Y       7733
      gluster01: Self-heal Daemon on localhost               N/A       N/A        Y       1396
      gluster01: Self-heal Daemon on gluster02               N/A       N/A        Y       7738
      gluster01: Self-heal Daemon on gluster03               N/A       N/A        Y       7755
      gluster01:
      gluster01: Task Status of Volume regional-volume
      gluster01: ------------------------------------------------------------------------------
      gluster01: There are no active volume tasks
      gluster01:
      ```

   1. Создайте текстовый файл:
      ```bash
      cat > /mnt/test.txt <<EOF
      Hello, GlusterFS!
      EOF
      ```
   
   1. Убедитесь, что файл доступен на всех трех клиентских ВМ:
      ```bash
      clush -w @clients sha256sum /mnt/test.txt
      ```
      Результат:
      ```bash
      client01: 5fd9c031531c39f2568a8af5512803fad053baf3fe9eef2a03ed2a6f0a884c85  /mnt/test.txt
      client02: 5fd9c031531c39f2568a8af5512803fad053baf3fe9eef2a03ed2a6f0a884c85  /mnt/test.txt
      client03: 5fd9c031531c39f2568a8af5512803fad053baf3fe9eef2a03ed2a6f0a884c85  /mnt/test.txt
      ```
   1. Отключите одну из ВМ для хранения данных, например, `gluster02`:

      {% list tabs group=instructions %}

      - Консоль управления {#console}

        1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит ВМ.
        1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
        1. Выберите ВМ `gluster02` в списке, нажмите значок ![image](../../_assets/options.svg) и выберите **{{ ui-key.yacloud.common.stop }}**.
        1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.compute.instances.popup-confirm_button_stop }}**.

      - CLI {#cli}

        1. Посмотрите описание команды CLI для остановки ВМ:

           ```bash
           yc compute instance stop --help
           ```
        1. Остановите ВМ:

           ```bash
           yc compute instance stop gluster02
           ```

      - API {#api}

        Воспользуйтесь методом REST API [stop](../../compute/api-ref/Instance/stop.md) для ресурса [Instance](../../compute/api-ref/Instance/) или вызовом gRPC API [InstanceService/Stop](../../compute/api-ref/grpc/instance_service.md#Stop).

      {% endlist %}

   1. Убедитесь, что ВМ отключена:
      ```bash
      clush -w gluster01  gluster volume status
      ```
      Результат:

      ```bash
      gluster01: Status of volume: regional-volume
      gluster01: Gluster process                             TCP Port  RDMA Port  Online  Pid
      gluster01: ------------------------------------------------------------------------------
      gluster01: Brick gluster01:/bricks/brick1/vol0         54660     0          Y       1374
      gluster01: Brick gluster03:/bricks/brick1/vol0         53346     0          Y       7733
      gluster01: Self-heal Daemon on localhost               N/A       N/A        Y       1396
      gluster01: Self-heal Daemon on gluster03               N/A       N/A        Y       7755
      gluster01:
      gluster01: Task Status of Volume regional-volume
      gluster01: ------------------------------------------------------------------------------
      gluster01: There are no active volume tasks
      gluster01:
      ```

   1. Убедитесь, что файл по-прежнему доступен на всех трех клиентских ВМ:
      ```bash
      clush -w @clients sha256sum /mnt/test.txt
      ```
      Результат:
      ```bash
      client01: 5fd9c031531c39f2568a8af5512803fad053baf3fe9eef2a03ed2a6f0a884c85  /mnt/test.txt
      client02: 5fd9c031531c39f2568a8af5512803fad053baf3fe9eef2a03ed2a6f0a884c85  /mnt/test.txt
      client03: 5fd9c031531c39f2568a8af5512803fad053baf3fe9eef2a03ed2a6f0a884c85  /mnt/test.txt
      ```

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы, удалите их:
   ```bash
   terraform destroy -auto-approve
   ```
