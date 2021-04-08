# Подключение к кластеру {{ dataproc-name }}

После того, как вы создали кластер {{ dataproc-name }}, вы можете подключиться к хосту главного подкластера.

Хостам кластера нельзя назначить публичный IP-адрес, поэтому для подключения к ним нужно использовать виртуальную машину, которая расположена в той же сети {{ yandex-cloud }}.

1. [Создайте новую виртуальную машину](../../compute/operations/vm-create/create-linux-vm.md) при необходимости.
1. Подключитесь к виртуальной машине [по протоколу SSH](../../compute/operations/vm-connect/ssh.md).
1. Также с помощью SSH, подключитесь к хосту главного подкластера с вашей виртуальной машины.

## SSH-подключение к хосту {{ dataproc-name }} {#data-proc-ssh}

Чтобы подключиться к хосту {{ dataproc-name }} с виртуальной машины, на ней должен быть доступен SSH-ключ, который вы указали при создании кластера {{ dataproc-name }}. Вы можете скопировать ключ на ВМ или подключаться к ней с запущенным SSH-агентом.

1. Запустите SSH-агент локально:

    ```bash
    $ eval `ssh-agent -s`
    ```

1. Добавьте нужный ключ в список доступных агенту:
 
   ```bash
   $ ssh-add ~/.ssh/example-key
   ```

1. Откройте SSH-соединение с хостом {{ dataproc-name }} для пользователя `root`, например:

   ```bash
   $ ssh root@rc1b-dataproc-m-fh4y4nur0i0uqqkz.mdb.yandexcloud.net

   root@rc1b-dataproc-m-fh4y4nur0i0uqqkz:~#
   ```
   
1. Проверьте, что команды Hadoop выполняются, например:

    ```bash
    ~# hadoop version
    
    Hadoop 2.8.5
    Subversion https://github.yandex-team.ru/mdb/bigtop.git -r 78508f2a4b4f3dc8b3d295ccb50a45a4d24e81b5
    Compiled by robot-pgaas-ci on 2019-04-16T10:35Z
    Compiled with protoc 2.5.0
    From source with checksum 9942ca5c745417c14e318835f420733
    This command was run using /usr/lib/hadoop/hadoop-common-2.8.5.jar
    ```
