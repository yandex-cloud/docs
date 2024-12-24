# Высокопроизводительные вычисления (HPC) на прерываемых виртуальных машинах

[HPC-кластеры](https://ru.wikipedia.org/wiki/Кластер_(группа_компьютеров)) используются в вычислительных целях, в частности в научных исследованиях и расчетных задачах. Вычислительный кластер представляет собой массив серверов (вычислительных узлов), объединенных сетью. Каждый вычислительный узел имеет несколько многоядерных процессоров, свою оперативную память и работает под управлением независимой операционной системы. Наиболее распространено использование однородных кластеров, где все узлы одинаковы по своей архитектуре и производительности.

По этой инструкции вы создадите кластер [прерываемых ВМ](../../compute/concepts/preemptible-vm.md), которые будут решать общую вычислительную задачу. Примером вычислительной задачи будет решение системы линейных алгебраических уравнений с помощью [метода Якоби](https://ru.wikipedia.org/wiki/Метод_Якоби).

Для создания кластера и запуска вычислительной задачи:
1. [Подготовьте облако к работе](#before-you-begin).
1. [Подготовьте основную ВМ в облаке](#create-master-vm).
1. [Подготовьте кластер ВМ](#prepare-cluster).
1. [Создайте кластер](#create-cluster).
1. [Подготовьте задачу для вычислений в кластере](#config-hpc).
1. [Запустите и проанализируйте вычисления](#start-hpc).
1. [Удалите созданные ресурсы](#clear-out).

## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки серверов входит:
* Плата за несколько запущенных [ВМ](../../compute/concepts/vm.md) (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md)).
* Плата за использование динамического или статического [публичного IP-адреса](../../vpc/concepts/address.md#public-addresses) (см. [тарифы {{ vpc-full-name }}](../../vpc/pricing.md)).


## Подготовьте основную ВМ в облаке {#create-master-vm}

### Создайте ВМ {#create-vm}

Чтобы создать ВМ:

1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет создана ВМ.
1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
1. На панели слева выберите ![image](../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.switch_instances }}**.
1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.button_create }}**.
1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** выберите образ [Ubuntu](/marketplace?tab=software&search=Ubuntu&categories=os).
1. В блоке **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}** выберите [зону доступности](../../overview/concepts/geo-scope.md), в которой будет находиться ВМ.
1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_storages }}** выберите тип загрузочного [диска](../../compute/concepts/disk.md) `{{ ui-key.yacloud.compute.value_disk-type-network-ssd }}`.
1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_platform }}** перейдите на вкладку **{{ ui-key.yacloud.component.compute.resources.label_tab-custom }}** и укажите параметры для решения текущих вычислительных задач:

    * **{{ ui-key.yacloud.component.compute.resources.field_platform }}** — `Intel Ice Lake`.
    * **{{ ui-key.yacloud.component.compute.resources.field_cores }}** — `4`.
    * **{{ ui-key.yacloud.component.compute.resources.field_core-fraction }}** — `100%`.
    * **{{ ui-key.yacloud.component.compute.resources.field_memory }}** — `4 {{ ui-key.yacloud.common.units.label_gigabyte }}`.
    * **{{ ui-key.yacloud.component.compute.resources.field_advanced }}** — `{{ ui-key.yacloud.component.compute.resources.field_preemptible }}`.

1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

    * В поле **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** укажите идентификатор подсети в зоне доступности создаваемой ВМ или выберите [облачную сеть](../../vpc/concepts/network.md#network) из списка.

        * У каждой сети должна быть как минимум одна [подсеть](../../vpc/concepts/network.md#subnet). Если подсети нет, создайте ее, выбрав **{{ ui-key.yacloud.component.vpc.network-select.button_create-subnetwork }}**.
        * Если сети нет, нажмите **{{ ui-key.yacloud.component.vpc.network-select.button_create-network }}** и создайте ее:

            * В открывшемся окне укажите имя сети и выберите каталог, в котором она будет создана.
            * (Опционально) Выберите опцию **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}**, чтобы автоматически создать подсети во всех зонах доступности.
            * Нажмите **{{ ui-key.yacloud.vpc.networks.create.button_create }}**.

    * В поле **{{ ui-key.yacloud.component.compute.network-select.field_external }}** выберите `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}`, чтобы назначить виртуальной машине случайный внешний IP-адрес из пула {{ yandex-cloud }}, или выберите статический адрес из списка, если вы зарезервировали его заранее.

1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}** выберите **{{ ui-key.yacloud.compute.instance.access-method.label_oslogin-control-ssh-option-title }}** и укажите данные для доступа к ВМ:

    * В поле **{{ ui-key.yacloud.compute.instances.create.field_user }}** введите имя пользователя, который будет создан на виртуальной машине, например `ubuntu`.

      {% note alert %}

      Не используйте логин `root` или другие имена, зарезервированные операционной системой. Для выполнения операций, требующих прав суперпользователя, используйте команду `sudo`.

      {% endnote %}

    * {% include [access-ssh-key](../../_includes/compute/create/access-ssh-key.md) %}

1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_base }}** задайте имя ВМ. Для наглядности примера укажите `master-node`.
1. Нажмите **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

### Настройте ВМ {#setup-vm}

1. [Зайдите по SSH](../../compute/operations/vm-connect/ssh.md) на ВМ и перейдите в режим администратора в консоли:

   ```bash
   sudo -i
   ```

1. Выполните обновление репозитория и поставьте требуемые утилиты:

   ```bash
   apt update
   apt install -y net-tools htop libopenmpi-dev nfs-common
   ```

1. Выйдите из режима администратора и сгенерируйте SSH-ключи для доступа между ВМ:

   ```bash
   exit
   ssh-keygen -t ed25519
   ```

1. Добавьте сгенерированный ключ в список разрешенных:

   ```bash
   cd ~/.ssh
   cat id_ed25519.pub >> authorized_keys
   ```

## Подготовьте кластер ВМ {#prepare-cluster}

### Создайте кластер {#create-cluster}

1. В [консоли управления]({{ link-console-main }}) перейдите в раздел **{{ ui-key.yacloud.compute.switch_disks }}**.
1. Справа от диска ВМ `master-node` нажмите ![image](../../_assets/options.svg) и выберите **{{ ui-key.yacloud.compute.disks.button_action-snapshot }}**. Задайте имя `master-node-snapshot`. После того как снимок будет создан, он появится в разделе **{{ ui-key.yacloud.compute.switch_snapshots }}**.
1. Перейдите в раздел **{{ ui-key.yacloud.compute.switch_groups }}** и нажмите **{{ ui-key.yacloud.compute.groups.button_create }}**.
1. Создайте [группу ВМ](../../compute/concepts/instance-groups/index.md):
   * В поле **{{ ui-key.yacloud.compute.groups.create.field_name }}** укажите имя будущей группы ВМ, например `compute-group`.
   * В поле **{{ ui-key.yacloud.compute.groups.create.field_service-account }}** добавьте [сервисный аккаунт](../../compute/concepts/instance-groups/access.md) к данной группе ВМ. Если у вас нет сервисного аккаунта, нажмите **{{ ui-key.yacloud.component.service-account-select.button_create-account-new }}**, укажите его имя и нажмите на кнопку **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

     Чтобы иметь возможность создавать, обновлять и удалять ВМ в группе, назначьте сервисному аккаунту роль [compute.editor](../../compute/security/index.md#compute-editor). По умолчанию все операции в {{ ig-name }} выполняются от имени сервисного аккаунта.

   * В поле **{{ ui-key.yacloud.compute.groups.create.field_zone }}** выберите зону, в которой находится ВМ `master-node`. Зоны доступности должны совпадать, чтобы минимизировать задержки при взаимодействии ВМ.
   * В блоке **{{ ui-key.yacloud.compute.groups.create.section_instance }}** нажмите кнопку **{{ ui-key.yacloud.compute.groups.create.button_instance_empty-create }}**. Откроется экран создания [шаблона](../../compute/concepts/instance-groups/instance-template.md).
     * В блоке **{{ ui-key.yacloud.compute.instances.create.section_storages }}** выберите **{{ ui-key.yacloud.compute.component.instance-storage-dialog.button_add-disk }}**. В открывшемся окне укажите:
       * **{{ ui-key.yacloud.compute.disk-form.field_type }}** — [SSD](../../compute/concepts/disk.md#disks-types).
       * **{{ ui-key.yacloud.compute.instances.create-disk.field_source }}** — из созданного [снимка](../../compute/concepts/snapshot.md) `master-node-snapshot`.
     * В блоке **{{ ui-key.yacloud.compute.instances.create.section_platform }}** задайте конфигурацию, аналогичную конфигурации основной ВМ:
       * **{{ ui-key.yacloud.component.compute.resources.field_platform }}** — `Intel Ice Lake`.
       * **{{ ui-key.yacloud.component.compute.resources.field_cores }}** — `4`.
       * **{{ ui-key.yacloud.component.compute.resources.field_core-fraction }}** — `100%`.
       * **{{ ui-key.yacloud.component.compute.resources.field_memory }}** — `4 {{ ui-key.yacloud.common.units.label_gigabyte }}`.
       * **{{ ui-key.yacloud.component.compute.resources.field_advanced }}** — `{{ ui-key.yacloud.component.compute.resources.field_preemptible }}`.
     * В блоке **{{ ui-key.yacloud.compute.instances.create.section_network }}** укажите те же сеть и подсеть, что и у основной ВМ. Тип IP-адреса оставьте **{{ ui-key.yacloud.component.compute.network-select.switch_auto }}**.
     * В блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}** укажите данные для доступа к ВМ:
       * В поле **{{ ui-key.yacloud.compute.instances.create.field_user }}** введите предпочтительное имя пользователя, который будет создан на ВМ.
       * В поле **{{ ui-key.yacloud.compute.instances.create.field_key }}** скопируйте ваш открытый SSH-ключ. Пару ключей для подключения по SSH необходимо создать самостоятельно, см. [раздел о подключении к ВМ по SSH](../../compute/operations/vm-connect/ssh.md).
     * Нажмите кнопку **{{ ui-key.yacloud.compute.groups.create.button_edit }}**. Вы вернетесь на экран создания группы ВМ.
1. В блоке **{{ ui-key.yacloud.compute.groups.create.section_scale }}** выберите количество создаваемых ВМ. Укажите 3 ВМ.
1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

### Проверьте работу кластера {#test-cluster}

[Зайдите по SSH](../../compute/operations/vm-connect/ssh.md) на каждую из ВМ в группе `compute-group` и убедитесь, что с них есть доступ к ВМ `master-node` по SSH:

```bash
ping master-node
ssh master-node
```

### Настройте NFS {#configure-nfs}

Чтобы ВМ могли использовать одни и те же исходные файлы, создайте общую сетевую директорию с помощью протокола сетевого доступа [NFS](https://ru.wikipedia.org/wiki/Network_File_System):
1. Зайдите на ВМ `master-node` по SSH и установите NFS-сервер:

   ```bash
   ssh <публичный IP-адрес ВМ master-node>
   sudo apt install nfs-kernel-server
   ```

1. Создайте директорию `shared`, которая будет общей для всех ВМ:

   ```bash
   mkdir ~/shared
   ```

1. Откройте файл `/etc/exports` любым текстовым редактором, например, `nano`:
   
   ```bash
   sudo nano /etc/exports
   ```

1. Добавьте запись для доступа к директории `shared` в файл:

   ```text
   /home/<имя пользователя>/shared *(rw,sync,no_root_squash,no_subtree_check)
   ```

   Сохраните файл.
1. Примените настройки и перезагрузите сервис:

   ```bash
   sudo exportfs -a
   sudo service nfs-kernel-server restart
   ```

#### Смонтируйте директории на ВМ из группы {#mount}

На каждой ВМ из группы `compute-group` смонтируйте созданную директорию:
1. Создайте директорию `shared` и смонтируйте туда директорию с ВМ `master-node`:

   ```bash
   mkdir ~/shared
   sudo mount -t nfs master-node:/home/<имя пользователя>/shared ~/shared
   ```

1. Убедитесь, что директория была успешно смонтирована:

   ```bash
   df -h
   ```

   Результат:

   ```text
   Filesystem                                   Size  Used  Avail  Use%  Mounted on
   ...
   master-node:/home/<имя пользователя>/shared  13G   1.8G  11G    15%   /home/<имя пользователя>/shared
   ```

## Подготовьте задачу для вычислений в кластере {#config-hpc}

1. Зайдите по SSH на ВМ `master-node`, перейдите в директорию `shared` и скачайте исходный файл `task.c` с вычислительной задачей:

   ```bash
   cd ~/shared
   wget https://raw.githubusercontent.com/cloud-docs-writer/examples/master/hpc-on-preemptible/task.c
   ```

   Этот код решает систему линейных алгебраических уравнений с помощью метода Якоби. Задача имеет одну из распределенных реализаций с помощью MPI.
1. Скомпилируйте исходный файл в исполняемый:

   ```bash
   mpicc task.c -o task
   ```

   В директории `shared` должен был появиться исполняемый файл `task`.

## Запустите и проанализируйте вычисления {#start-hpc}

{% note tip %}

Для проверки загрузки ядер ВМ можно выполнять команду `htop` в отдельной SSH-сессии на каждой ВМ.

{% endnote %}

1. Запустите выполнение задачи на 2 ядрах, используя ресурсы только ВМ `master-node`:

   ```bash
   mpirun -np 2 task
   ```

   После выполнения задачи программа выведет затраченное на решение время:

   ```text
   JAC1 STARTED
   1: Time of task=45.104153
   0: Time of task=45.103931
   ```

1. Запустите выполнение задачи на 4 ядрах, используя ресурсы только ВМ `master-node`:

   ```bash
   mpirun -np 4 task
   ```

   Результат:

   ```text
   JAC1 STARTED
   1: Time of task=36.562328
   2: Time of task=36.562291
   3: Time of task=36.561989
   0: Time of task=36.561695
   ```

1. Запустите выполнение задачи на 4 ядрах, используя ресурсы двух ВМ, по 2 ядра на каждой ВМ. Для этого запустите выполнение задачи с ключом `-host`, который принимает параметры вида `<IP-адрес ВМ>:<количество ядер>[,<ip>:<cores>[,...]]`:

   ```bash
   mpirun -np 4 -host localhost:2,<IP-адрес ВМ>:2 task
   ```

   Результат:

   ```bash
   JAC1 STARTED
   0: Time of task=24.539981
   1: Time of task=24.540288
   3: Time of task=24.540619
   2: Time of task=24.540781
   ```

1. По аналогии можно продолжать увеличивать число используемых ВМ и ядер и убедиться, что распределенные вычисления позволяют значительно увеличивать скорость выполнения задачи.

## Удалите созданные ресурсы {#clear-out}

Чтобы перестать платить за развернутый сервер и группу ВМ, достаточно удалить ВМ `master-node` и группу `compute-group`.

Если вы зарезервировали статический публичный IP-адрес специально для этой ВМ:
1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}** в вашем каталоге.
1. Перейдите на вкладку **{{ ui-key.yacloud.vpc.switch_addresses }}**.
1. Найдите нужный IP-адрес, нажмите значок ![ellipsis](../../_assets/options.svg) и выберите пункт **{{ ui-key.yacloud.common.delete }}**.