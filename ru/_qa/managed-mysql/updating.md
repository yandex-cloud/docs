
#### Можно ли управлять кластером с помощью команд SQL? {#sql-control}

Существуют ограничения на управление кластером с помощью команд SQL. Подробнее см. в разделе [{#T}](../../managed-mysql/concepts/sql-limits.md).

#### Как уменьшить размер диска? {#reduce-size}

Уменьшить размер хранилища кластера невозможно.

Вы можете [создать](../../managed-mysql/operations/cluster-create.md) новый кластер с хранилищем меньшего размера и [перенести](../../managed-mysql/tutorials/data-migration.md) в него данные.

#### Как увеличить размера диска? {#increase-size}

Увеличение размера недоступно для [хранилища](../../managed-mysql/concepts/storage.md) на нереплицируемых SSD-дисках: воспользуйтесь инструкцией в разделе [Изменение кластера](../../managed-mysql/operations/update.md#change-disk-size).

Чтобы увеличить размер хранилища на нереплицируемых SSD-дисках, [восстановите кластер из резервной копии](../../managed-mysql/operations/cluster-backups.md#restore) и задайте нужный размер.

Тип диска можно проверить в [консоли управления]({{ link-console-main }}). Для этого на странице кластера в блоке **{{ ui-key.yacloud.mdb.cluster.overview.section_resource }}** найдите параметр **{{ ui-key.yacloud.mdb.cluster.overview.label_hdd }}**.


#### Как изменить тип диска? {#modify-type}

Чтобы изменить тип диска, [восстановите](../../managed-mysql/operations/cluster-backups.md#restore) кластер из резервной копии.

#### Почему не добавляется/не удаляется хост? {#not-add-delete}

Количество хостов в кластерах ограничено [квотами](../../managed-mysql/concepts/limits.md#mmy-quotas). Перед добавлением хоста проверьте используемые ресурсы: откройте страницу [Квоты]({{ link-console-quotas }}) и найдите блок **{{ ui-key.yacloud.iam.folder.dashboard.label_mdb }}**.

Удалить хост можно при условии, что он не является единственным хостом в кластере. Чтобы заменить единственный хост, сначала создайте новый хост, затем удалите старый.

В кластерах с локальным типом диска настроена отказоустойчивая конфигурация из 3 хостов. Меньшее количество хостов недопустимо.

#### Как переключить мастер (manual failover)? {#manual-failover}

В отказоустойчивом кластере из нескольких хостов вы можете переключить роль мастера с текущего хоста-мастера на хост-реплику. После этой операции текущий хост-мастер станет хостом-репликой для нового мастера.

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. Перейдите на страницу кластера и выберите вкладку **{{ ui-key.yacloud.mysql.cluster.switch_hosts }}**.
   1. Нажмите **{{ ui-key.yacloud.mdb.cluster.hosts.button_manual-failover }}**.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   Чтобы переключить мастер:

   1. Посмотрите описание команды CLI для переключения мастера:

      ```bash
      {{ yc-mdb-my }} cluster start-failover --help
      ```

   1.  Выполните команду `{{ yc-mdb-my }} cluster start-failover`.

{% endlist %}

#### Как перезагрузить хост? {#host-reboot}

Перезагрузить отдельный хост кластера невозможно. Для перезагрузки хостов [остановите и запустите кластер](../../managed-mysql/operations/cluster-stop.md).
