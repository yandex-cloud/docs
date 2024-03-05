# Однонодовый файловый сервер

Вы научитесь создавать однонодовый файловый сервер с помощью [Samba](https://www.samba.org/) и [NFS](https://docs.microsoft.com/ru-ru/windows-server/storage/nfs/nfs-overview), а также подключаться к нему с компьютеров на Linux, macOS и Windows.

Чтобы создать однонодовый файловый сервер:
1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте виртуальную машину для файлового сервера](#create-vm).
1. [Настройте Samba и NFS](#setup-samba-nfs).
1. [Протестируйте работу файлового сервера](#test-file-server).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

Также инфраструктуру для однонодового файлового сервера можно развернуть через {{ TF }} с помощью [готового файла конфигурации](#terraform).

## Перед началом работы {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки статического сайта входит:
* Плата за постоянно запущенную [ВМ](../../compute/concepts/vm.md) (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md)).
* Плата за использование динамического или статического [публичного IP-адреса](../../vpc/concepts/address.md#public-addresses) (см. [тарифы {{ vpc-full-name }}](../../vpc/pricing.md)).

## Создайте облачные сети и подсети {#before-you-begin}

Перед тем, как создавать ВМ:
1. Перейдите в [консоль управления]({{ link-console-main }}) {{ yandex-cloud }} и выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будете выполнять операции.
1. Убедитесь, что в выбранном каталоге есть [сеть](../../vpc/concepts/network.md#network) с [подсетью](../../vpc/concepts/network.md#subnet), к которой можно подключить ВМ. Для этого на странице каталога выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**. Если в списке есть сеть — нажмите на нее, чтобы увидеть доступные подсети. Если ни одной подсети или сети нет, [создайте их](../../vpc/quickstart.md).

## Создайте ВМ для файлового сервера {#create-vm}

Чтобы создать ВМ:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. На странице каталога в [консоли управления]({{ link-console-main }}) нажмите кнопку **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** и выберите **{{ ui-key.yacloud.iam.folder.dashboard.value_compute }}**.
  1. В поле **{{ ui-key.yacloud.compute.instances.create.field_name }}** введите имя ВМ — `fileserver-tutorial`.
  1. Выберите [зону доступности](../../overview/concepts/geo-scope.md), в которой будет находиться ВМ.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** перейдите на вкладку **{{ ui-key.yacloud.compute.instances.create.image_value_marketplace }}** и выберите публичный образ [Ubuntu](/marketplace?tab=software&search=Ubuntu&categories=os).
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_storages_ru }}** нажмите **{{ ui-key.yacloud.compute.instances.create.label_add-disk }}**. В окне **{{ ui-key.yacloud.compute.instances.create-disk.label_title }}** укажите параметры [диска](../../compute/concepts/disk.md) для хранения данных:
     * **{{ ui-key.yacloud.compute.disk-form.field_name }}** — `fileserver-tutorial-disk`.
     * **{{ ui-key.yacloud.compute.disk-form.field_type }}** — `{{ ui-key.yacloud.compute.instances.create-disk.value_network-ssd }}`.
     * **{{ ui-key.yacloud.compute.disk-form.field_size }}** — `100 {{ ui-key.yacloud.common.units.label_gigabyte }}`.
     * **{{ ui-key.yacloud.compute.disk-form.field_source }}** — `{{ ui-key.yacloud.compute.disk-form.value_source-none }}`.

     Нажмите **{{ ui-key.yacloud.compute.instances.create-disk.button_create }}**.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_platform }}**:
     * Выберите [платформу](../../compute/concepts/vm-platforms.md).
     * Укажите необходимое количество vCPU и объем RAM.

     Рекомендованные значения для файлового сервера:
     * **{{ ui-key.yacloud.component.compute.resources.field_core-fraction }}** — `100%`.
     * **{{ ui-key.yacloud.component.compute.resources.field_cores }}** — `8` или больше.
     * **{{ ui-key.yacloud.component.compute.resources.field_memory }}** — `56 {{ ui-key.yacloud.common.units.label_gigabyte }}` или больше.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_network }}** выберите, к какой подсети будет подключена ВМ при создании.
  1. Укажите данные для доступа на ВМ:
     * В поле **{{ ui-key.yacloud.compute.instances.create.field_user }}** введите имя пользователя.
     * В поле **{{ ui-key.yacloud.compute.instances.create.field_key }}** вставьте содержимое файла открытого ключа. Пару ключей для подключения по [SSH](../../glossary/ssh-keygen.md) необходимо [создать самостоятельно](../../compute/operations/images-with-pre-installed-software/operate.md#creating-ssh-keys).
  1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

- {{ TF }} {#tf}

  См. раздел [Как создать инфраструктуру с помощью {{ TF }}](#terraform).

{% endlist %}

Создание ВМ может занять несколько минут. Когда ВМ перейдет в статус `RUNNING`, вы можете [настроить NFS и Samba](#setup-samba-nfs).

При создании ВМ назначаются IP-адрес и имя хоста (FQDN). Эти данные можно использовать для доступа по SSH.

## Настройте Samba и NFS {#setup-samba-nfs}

После того как ВМ `fileserver-tutorial` перейдет в статус `RUNNING`, выполните:
1. В блоке **{{ ui-key.yacloud.compute.instance.overview.section_network }}** на странице ВМ в [консоли управления]({{ link-console-main }}) найдите публичный IP-адрес ВМ.
1. [Подключитесь](../../compute/operations/vm-connect/ssh.md) к ВМ по протоколу SSH.

   Рекомендуемый способ аутентификации при подключении по SSH — с помощью пары ключей. Не забудьте настроить использование созданной пары ключей: закрытый ключ должен соответствовать открытому ключу, переданному на ВМ.
1. Скачайте и установите Samba:

   {% list tabs group=operating_system %}

   - Ubuntu {#ubuntu}

     ```bash
     sudo apt-get update
     sudo apt-get install nfs-kernel-server samba
     ```

   {% endlist %}

1. Подготовьте и смонтируйте файловую систему на диске:

   ```bash
   sudo mkfs -t ext4 -L data /dev/vdb
   ```

1. Подготовьте и смонтируйте папку для хранения данных на диске:

   ```bash
   sudo mkdir /имя_папки
   echo "LABEL=data /имя_папки ext4 defaults 0 0" | sudo tee -a /etc/fstab
   sudo mount /имя_папки
   ```

1. Задайте конфигурацию NFS в файле `/etc/exports`. Вы можете отредактировать файл с помощью утилиты `nano`:

   ```bash
   sudo nano /etc/exports
   ```

   Добавьте в файл следующие строки:

   ```bash
   /имя_папки <IP-адрес>(rw,no_subtree_check,fsid=100)
   /имя_папки 127.0.0.1(rw,no_subtree_check,fsid=100)
   ```

   Где `<IP-адрес>` – IP-адрес компьютера, к которому вы будете подключать по NFS сетевой диск с данными.
1. Задайте конфигурацию Samba в файле `/etc/samba/smb.conf`. Вы можете отредактировать файл с помощью утилиты `nano`:

   ```bash
   sudo nano /etc/samba/smb.conf
   ```

   Приведите файл к виду:

   ```
   [global]
      workgroup = WORKGROUP
      server string = %h server (Samba)
      dns proxy = no
      log file = /var/log/samba/log.%m
      max log size = 1000
      syslog = 0
      panic action = /usr/share/samba/panic-action %d
      server role = standalone server
      passdb backend = tdbsam
      obey pam restrictions = yes
      unix password sync = yes
      passwd program = /usr/bin/passwd %u
      passwd chat = *Enter\snew\s*\spassword:* %n\n *Retype\snew\s*\spassword:* %n\n *password\supdated\ssuccessfully* .
      pam password change = yes
      map to guest = bad user
      usershare allow guests = yes
   [printers]
      comment = All Printers
      browseable = no
      path = /var/spool/samba
      printable = yes
      guest ok = no
      read only = yes
      create mask = 0700
   [print$]
      comment = Printer Drivers
      path = /var/lib/samba/printers
      browseable = yes
      read only = yes
      guest ok = no
   [data]
      comment = /имя_папки
      path = /имя_папки
      browseable = yes
      read only = no
      writable = yes
      guest ok = yes
      hosts allow = <IP-адрес> 127.0.0.1
      hosts deny = 0.0.0.0/0
   ```

   Где `<IP-адрес>` в блоке `[data]` – IP-адрес компьютера, к которому вы будете подключать по NFS сетевой диск с данными.
1. Перезапустите NFS и Samba:

   ```bash
   sudo service nfs-kernel-server restart
   sudo service smbd restart
   ```

## Протестируйте работу файлового сервера {#test-file-server}

1. Создайте на ВМ `fileserver-tutorial` директорию `remote` и файл test.txt:

   {% list tabs group=operating_system %}

   - Ubuntu {#ubuntu}

     ```bash
     sudo mkdir /имя_папки/remote
     sudo setfacl -m u:<имя_вашего_пользователя>:xw /имя_папки/remote
     echo "Hello world!" > /имя_папки/remote/test.txt
     ```

   {% endlist %}

1. Подключите по NFS сетевой диск к вашему компьютеру и проверьте доступность тестового файла:

   {% list tabs group=operating_system %}

   - Linux/macOS {#linux-macos}

      Если необходимо, установите утилиту для работы с сетевыми дисками:

      ```bash
      sudo apt-get install nfs-common
      ```

      Создайте точку монтирования:

      ```bash
      sudo mkdir /remote-test-dir
      ```

      Подключите сетевой диск:

      ```bash
      sudo mount -t nfs <публичный_IP-адрес>:/имя_папки /remote-test-dir`
      ```

      В результате в указанной точке монтирования должны быть доступны тестовая директория и файл.

   - Windows {#windows}

     1. Запустите утилиту **cmd.exe**. Для этого нажмите сочетание клавиш **Windows** + **R** и выполните команду `cmd`.
     1. В командной строке выполните команду:

        ```bash
        net use x: \\<публичный_IP-адрес_ВМ>\имя_папки
        ```

     В результате появится диск X с тестовой директорией и файлом.

   {% endlist %}

## Как создать инфраструктуру с помощью {{ TF }} {#terraform}

{% include [terraform-definition](../_tutorials_includes/terraform-definition.md) %}

Чтобы создать однонодовый файловый сервер с помощью {{ TF }}:
1. [Установите {{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform), [получите данные для аутентификации](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials) и укажите источник для установки провайдера {{ yandex-cloud }} (раздел [{#T}](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), шаг 1).
1. Подготовьте файлы с описанием инфраструктуры:

   {% list tabs group=infrastructure_description %}

   - Готовый архив {#ready}

     1. Создайте папку для файлов.
     1. Скачайте [архив](https://{{ s3-storage-host }}/doc-files/single-node-file-server.zip) (1 КБ).
     1. Разархивируйте архив в папку. В результате в ней должны появиться конфигурационный файл `single-node-file-server.tf`.

   - Вручную {#manual}

     1. Создайте папку для файлов.
     1. Создайте в папке конфигурационный файл `single-node-file-server.tf`:

        {% cut "single-node-file-server.tf" %}

        {% include [single-node-file-server-tf-config](../../_includes/archive/single-node-file-server-tf-config.md) %}

        {% endcut %}

   {% endlist %}

   Более подробную информацию о параметрах используемых ресурсов в {{ TF }} см. в документации провайдера:
   * [yandex_vpc_network]({{ tf-provider-resources-link }}/vpc_network)
   * [yandex_vpc_subnet]({{ tf-provider-resources-link }}/vpc_subnet)
   * [yandex_vpc_security_group]({{ tf-provider-resources-link }}/vpc_security_group)
   * [yandex_compute_image]({{ tf-provider-resources-link }}/compute_image)
   * [yandex_compute_instance]({{ tf-provider-resources-link }}/compute_instance)

1. В блоке `metadata` укажите имя пользователя и содержимое SSH-ключа. Подробнее см. в разделе [{#T}](../../compute/concepts/vm-metadata.md).
1. Создайте ресурсы:

   {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}

1. [Настройте Samba и NFS](#setup-samba-nfs).
1. [Протестируйте работу файлового сервера](#test-file-server).

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:
1. [Удалите ВМ](../../compute/operations/vm-control/vm-delete.md);
1. [Удалите статический публичный IP-адрес](../../vpc/operations/address-delete.md), если вы его зарезервировали.