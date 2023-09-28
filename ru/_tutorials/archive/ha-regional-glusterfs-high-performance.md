# Развертывание параллельной файловой системы GlusterFS в высокопроизводительном режиме

[GlusterFS](https://ru.wikipedia.org/wiki/GlusterFS) — это распределенная, параллельная, линейно масштабируемая файловая система. При использовании горизонтального масштабирования она обеспечивает в облаке агрегированную пропускную способность в десятки ГБ/с и в сотни тысяч [IOPS](https://ru.wikipedia.org/wiki/IOPS).

При помощи этого руководства вы сможете создать инфраструктуру из тридцати сегментов, имеющих общую файловую систему GlusterFS. Размещение [дисков](../../compute/concepts/disk.md) для хранения данных в одной [зоне доступности](../../overview/concepts/geo-scope.md) обеспечит высокую производительность файловой системы. В данном сценарии производительность ограничивается скоростью обращения к физическим дискам, а сетевые задержки играют менее значимую роль.

Чтобы настроить высокопроизводительную файловую систему:

1. [Подготовьте облако к работе](#prepare-cloud).
1. [Настройте профиль CLI](#setup-profile).
1. [Подготовьте среду для развертывания ресурсов](#setup-environment).
1. [Разверните ресурсы](#deploy-resources).
1. [Установите и настройте GlusterFS](#install-glusterfs).
1. [Протестируйте доступность решения](#test-glusterfs).
1. [Протестируйте производительность решения](#test-glusterfs-performance).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).
 
## Подготовьте облако к работе {#prepare-cloud}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}


### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входят:

* плата за постоянно работающие ВМ и диски (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md));
* плата за использование публичных IP-адресов и исходящий трафик (см. [тарифы {{ vpc-full-name }}](../../vpc/pricing.md));


## Настройте профиль CLI {#setup-profile}

1. Если у вас еще нет интерфейса командной строки {{ yandex-cloud }}, [установите](../../cli/quickstart.md) его и авторизируйтесь от имени пользователя.
1. Создайте сервисный аккаунт:
   
   {% list tabs %}

   - Консоль управления

      1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать сервисный аккаунт.
      1. На вкладке **{{ ui-key.yacloud.iam.folder.switch_service-accounts }}** нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
      1. Введите имя сервисного аккаунта, например, `sa-glusterfs`.
      1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

   - CLI

      {% include [default-catalogue](../../_includes/default-catalogue.md) %}

      Выполните команду для создания сервисного аккаунта, указав имя `sa-glusterfs`:

      ```bash
      yc iam service-account create --name sa-glusterfs
      ```

      Где `name` — имя сервисного аккаунта.

      Результат:
      ```yaml
      id: ajehr0to1g8b********
      folder_id: b1gv87ssvu49********
      created_at: "2023-06-20T09:03:11.665153755Z"
      name: sa-glusterfs
      ```

   - API

      Чтобы создать сервисный аккаунт, воспользуйтесь методом [ServiceAccountService/Create](../../iam/api-ref/grpc/service_account_service.md#Create) gRPC API или методом [create](../../iam/api-ref/ServiceAccount/create.md) для ресурса `ServiceAccount` REST API.

   {% endlist %}

1. Назначьте сервисному аккаунту [роль](../../iam/concepts/access-control/roles.md) администратора на каталог: 

   {% list tabs %}

   - Консоль управления

      1. На [стартовой странице]({{ link-console-main }}) консоли управления выберите каталог.
      1. Перейдите на вкладку **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}**.
      1. Найдите аккаунт `sa-glusterfs` в списке и нажмите значок ![image](../../_assets/options.svg).
      1. Нажмите кнопку **{{ ui-key.yacloud.common.resource-acl.button_assign-binding }}**.
      1. В открывшемся диалоге нажмите кнопку **Добавить роль** и выберите роль `admin`.

   - CLI

      Выполните команду:
      ```
      yc resource-manager folder add-access-binding <идентификатор_каталога> \
         --role admin \
         --subject serviceAccount:<идентификатор_сервисного_аккаунта>
      ```

   - API

      Чтобы назначить сервисному аккаунту роль на каталог, воспользуйтесь методом REST API [setAccessBindings](../../iam/api-ref/ServiceAccount/setAccessBindings.md) для ресурса [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) или вызовом gRPC API [ServiceAccountService/SetAccessBindings](../../iam/api-ref/grpc/service_account_service.md#SetAccessBindings).

   {% endlist %}

1. Настройте профиль CLI для выполнения операций от имени сервисного аккаунта:

   {% list tabs %}

   - CLI

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
1. Клонируйте репозиторий `yandex-cloud/yc-architect-solution-library` из GitHub и перейдите в папку `yc-ha-regional-glusterfs`:
    ```
    git clone https://github.com/yandex-cloud/yc-architect-solution-library.git
    cd ./yc-architect-solution-library/yc-ha-regional-glusterfs
    ```
1. Отредактируйте файл `variables.tf`, указав параметры разворачиваемых ресурсов:

   {% note warning %}

   Заданные в файле значения приводят к разворачиванию ресурсоемкой инфраструктуры.
   Чтобы развернуть ресурсы в рамках имеющихся у вас квот, используйте приведенные ниже значения или измените значения на свое усмотрение.

   {% endnote %}

   1. В секции `is_ha` значение `default` измените на `false`.
   1. В секции `client_node_per_zone` значение `default` измените на `30`.
   1. В секции `storage_node_per_zone` значение `default` измените на `30`.

      {% note info %}

      В данном сценарии разворачивается 30 виртуальных машин. Вы можете изменить это количество в зависимости от требований к объёму конечного хранилища или общей пропускной способности.
      Максимальная агрегированная пропускная способность всей системы рассчитывается как произведение пропускной способности каждого сегмента (450 МБ/с для [сетевых SSD-дисков](https://cloud.yandex.ru/docs/compute/concepts/disk#disks-types)) на количество сегментов (30), что составляет около 13,5 ГБ/с.
      Объем системы рассчитывается как произведение количества сегментов (30) на размер каждого хранилища (1 ТБ), что составляет 30 ТБ.

      {% endnote %}

   1. Если при создании пары ключей SSH вы указали имя, отличное от имени по умолчанию, в секции `local_pubkey_path` значение `default` измените на `<путь_к_публичному_ключу_SSH>`.
   1. Если вам необходима повышенная производительность и не важна гарантия сохранности данных, вы можете использовать [нереплицируемые SSD-диски](https://cloud.yandex.ru/docs/compute/concepts/disk#nr-disks). Для этого в секции `disk_type` значение `default` измените на `network-ssd-nonreplicated`. Кроме этого, в секции `disk_size` значение `default` должно быть кратно 93.

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

   В результате в каталоге будут созданы 30 ВМ для размещения клиентского кода (`client01`, `client02` и так далее) и 30 привязанных к ним ВМ для распределенного хранения данных (`gluster01`, `gluster02` и так далее) в одной зоне доступности.

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
         clients: 'client[01-30]'
         gluster: 'gluster[01-30]'
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
   1. Проверьте доступность ВМ от `gluster02` до `gluster30`:
      ```bash
      clush -w gluster01 'for i in {2..9}; do gluster peer probe gluster0$i; done'
      clush -w gluster01 'for i in {10..30}; do gluster peer probe gluster$i; done'
      ```
   1. Создайте папки `vol0` в ВМ для хранения данных и настройте доступность и отказоустойчивость за счет подключения к папке общего доступа `stripe-volume`:
      ```bash
      clush -w @gluster mkdir -p /bricks/brick1/vol0
      export STRIPE_NODES=$(nodeset -S':/bricks/brick1/vol0 ' -e @gluster)
      clush -w gluster01 gluster volume create stripe-volume ${STRIPE_NODES}:/bricks/brick1/vol0 
      ```

   1. Выполните дополнительные настройки производительности:
      ```bash
      clush -w gluster01 gluster volume set stripe-volume client.event-threads 8
      clush -w gluster01 gluster volume set stripe-volume server.event-threads 8
      clush -w gluster01 gluster volume set stripe-volume cluster.shd-max-threads 8
      clush -w gluster01 gluster volume set stripe-volume performance.read-ahead-page-count 16
      clush -w gluster01 gluster volume set stripe-volume performance.client-io-threads on
      clush -w gluster01 gluster volume set stripe-volume performance.quick-read off 
      clush -w gluster01 gluster volume set stripe-volume performance.parallel-readdir on 
      clush -w gluster01 gluster volume set stripe-volume performance.io-thread-count 32
      clush -w gluster01 gluster volume set stripe-volume performance.cache-size 1GB
      clush -w gluster01 gluster volume set stripe-volume performance.cache-invalidation on
      clush -w gluster01 gluster volume set stripe-volume performance.md-cache-timeout 600
      clush -w gluster01 gluster volume set stripe-volume performance.stat-prefetch on
      clush -w gluster01 gluster volume set stripe-volume server.allow-insecure on   
      clush -w gluster01 gluster volume set stripe-volume network.inode-lru-limit 200000
      clush -w gluster01 gluster volume set stripe-volume features.shard-block-size 128MB
      clush -w gluster01 gluster volume set stripe-volume features.shard on
      clush -w gluster01 gluster volume set stripe-volume features.cache-invalidation-timeout 600
      clush -w gluster01 gluster volume set stripe-volume storage.fips-mode-rchecksum on  
      ```
   1. Смонтируйте папку общего доступа `stripe-volume` на клиентских ВМ:
      ```bash
      clush -w gluster01  gluster volume start stripe-volume      
      clush -w @clients mount -t glusterfs gluster01:/stripe-volume /mnt/
      ```

## Протестируйте доступность решения {#test-glusterfs}

   1. Проверьте статус папки общего доступа `stripe-volume`:
      ```bash
      clush -w gluster01  gluster volume status
      ```      

   1. Создайте текстовый файл:
      ```bash
      cat > /mnt/test.txt <<EOF
      Hello, GlusterFS!
      EOF
      ```
   
   1. Убедитесь, что файл доступен на всех клиентских ВМ:
      ```bash
      clush -w @clients sha256sum /mnt/test.txt
      ```
      Результат:
      ```bash
      client01: 5fd9c031531c39f2568a8af5512803fad053baf3fe9eef2a03ed2a6f0a884c85  /mnt/test.txt
      client02: 5fd9c031531c39f2568a8af5512803fad053baf3fe9eef2a03ed2a6f0a884c85  /mnt/test.txt
      client03: 5fd9c031531c39f2568a8af5512803fad053baf3fe9eef2a03ed2a6f0a884c85  /mnt/test.txt
      ...
      client30: 5fd9c031531c39f2568a8af5512803fad053baf3fe9eef2a03ed2a6f0a884c85  /mnt/test.txt
      ```

## Протестируйте производительность решения {#test-glusterfs-performance}

   [IOR](https://github.com/hpc/ior) — это бенчмарк для параллельных операций ввода-вывода, который может использоваться для тестирования производительности параллельных систем хранения данных с использованием различных интерфейсов и сценариев доступа.

   1. Установите зависимости:
      ```bash
      clush -w @clients dnf install -y autoconf automake pkg-config m4 libtool git mpich mpich-devel make fio
      cd /mnt/
      git clone https://github.com/hpc/ior.git
      cd ior
      mkdir prefix
      ```

   1. Выйдите из командной оболочки и войдите заново:
      ```bash
      ^C
      sudo -i
      module load mpi/mpich-x86_64
      cd /mnt/ior
      ```

   1. Установите IOR:
      ```bash
      ./bootstrap
      ./configure --disable-dependency-tracking  --prefix /mnt/ior/prefix
      make 
      make install
      mkdir -p /mnt/benchmark/ior
      ```

   1. Запустите IOR:
      ```bash
      export NODES=$(nodeset  -S',' -e @clients)
      mpirun -hosts $NODES -ppn 16 /mnt/ior/prefix/bin/ior  -o /mnt/benchmark/ior/ior_file -t 1m -b 16m -s 16 -F
      mpirun -hosts $NODES -ppn 16 /mnt/ior/prefix/bin/ior  -o /mnt/benchmark/ior/ior_file -t 1m -b 16m -s 16 -F -C
      ```

      Результат:
      ```bash
      IOR-4.1.0+dev: MPI Coordinated Test of Parallel I/O
      Options:
      api                 : POSIX
      apiVersion          :
      test filename       : /mnt/benchmark/ior/ior_file
      access              : file-per-process
      type                : independent
      segments            : 16
      ordering in a file  : sequential
      ordering inter file : no tasks offsets
      nodes               : 30
      tasks               : 480
      clients per node    : 16
      memoryBuffer        : CPU
      dataAccess          : CPU
      GPUDirect           : 0
      repetitions         : 1
      xfersize            : 1 MiB
      blocksize           : 16 MiB
      aggregate filesize  : 120 GiB

      Results:

      access    bw(MiB/s)  IOPS       Latency(s)  block(KiB) xfer(KiB)  open(s)    wr/rd(s)   close(s)   total(s)   iter
      ------    ---------  ----       ----------  ---------- ---------  --------   --------   --------   --------   ----
      write     1223.48    1223.99    4.65        16384      1024.00    2.44       100.39     88.37      100.44     0
      read      1175.45    1175.65    4.83        16384      1024.00    0.643641   104.52     37.97      104.54     0
      ```


## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы, удалите их:
   ```bash
   terraform destroy -auto-approve
   ```
