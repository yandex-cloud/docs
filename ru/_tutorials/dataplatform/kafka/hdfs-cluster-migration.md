# Миграция кластера {{ dataproc-name }} с файловой системой HDFS в другую зону доступности


Подкластеры каждого кластера {{ dataproc-name }} находятся в одной [облачной сети](../../../vpc/concepts/network.md#network) и одной [зоне доступности](../../../overview/concepts/geo-scope.md). Вы можете перенести кластер в другую зону доступности. Процесс переноса зависит от типа кластера:

* Ниже описано, как перенести кластеры с файловой системой HDFS.
* О миграции [легковесных кластеров](../../../data-proc/concepts/index.md#light-weight-clusters) читайте в [инструкции](../../../data-proc/operations/migration-to-an-availability-zone.md).

{% include [zone-d-host-restrictions](../../../_includes/mdb/ru-central1-d-broadwell.md) %}

Чтобы перенести кластер с файловой системой HDFS:

1. [Создайте кластер через импорт в {{ TF }}](#create).
1. [Скопируйте данные в новый кластер](#copy).
1. [Удалите первоначальный кластер](#delete).

Перед началом работы [создайте подсеть](../../../vpc/operations/subnet-create.md) в зоне доступности, в которую вы переносите кластер.

## Создайте кластер через импорт в {{ TF }} {#create}

Чтобы в другой зоне доступности создать кластер {{ dataproc-name }}, настройки которого совпадают с настройками первоначального кластера, импортируйте конфигурацию первоначального кластера в {{ TF }}:

{% list tabs group=instructions %}

* {{ TF }} {#tf}

   1. {% include [terraform-install-without-setting](../../../_includes/mdb/terraform/install-without-setting.md) %}
   1. {% include [terraform-authentication](../../../_includes/mdb/terraform/authentication.md) %}
   1. {% include [terraform-setting](../../../_includes/mdb/terraform/setting.md) %}
   1. {% include [terraform-configure-provider](../../../_includes/mdb/terraform/configure-provider.md) %}
   1. В той же рабочей директории разместите файл с расширением `.tf` и содержимым:

      ```hcl
      resource "yandex_dataproc_cluster" "old" { }
      ```

   1. Запишите идентификатор первоначального кластера в переменную окружения:

      ```bash
      export DATAPROC_CLUSTER_ID=<идентификатор_кластера>
      ```

      Идентификатор можно запросить вместе со [списком кластеров в каталоге](../../../data-proc/operations/cluster-list.md#list).

   1. Импортируйте настройки первоначального кластера в конфигурацию {{ TF }}:

      ```bash
      terraform import yandex_dataproc_cluster.old ${DATAPROC_CLUSTER_ID}
      ```

   1. Получите импортированную конфигурацию:

      ```bash
      terraform show
      ```

   1. Скопируйте ее из терминала и вставьте в файл с расширением `.tf`.
   1. Расположите файл в новой директории `imported-cluster`.
   1. Измените скопированную конфигурацию так, чтобы из нее можно было создать новый кластер:

      * Укажите новое имя кластера в строке `resource` и параметре `name`.
      * Удалите параметры `created_at`, `host_group_ids`, `id` и `subcluster_spec.id`.
      * Измените зону доступности в параметре `zone_id`.
      * Укажите идентификатор новой подсети, созданной в нужной зоне доступности, в параметрах `subnet_id` в блоках `subcluster_spec`.
      * Измените формат SSH-ключа в параметре `ssh_public_keys`. Исходный формат:

         ```hcl
         ssh_public_keys = [
           <<-EOT
             <ключ>
           EOT,
         ]
         ```

         Требуемый формат:

         ```hcl
         ssh_public_keys = [
           "<ключ>"
         ]
         ```

   1. В директории `imported-cluster` [получите данные для аутентификации](../../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials).
   1. В этой же директории [настройте и инициализируйте провайдер](../../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Чтобы не создавать конфигурационный файл с настройками провайдера вручную, [скачайте его](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).
   1. Поместите конфигурационный файл в директорию `imported-cluster` и [укажите значения параметров](../../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Если данные для аутентификации не были добавлены в переменные окружения, укажите их в конфигурационном файле.
   1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

      ```bash
      terraform validate
      ```

      Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

   1. Создайте необходимую инфраструктуру:

      {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

      {% include [explore-resources](../../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

## Скопируйте данные в новый кластер {#copy}

1. Убедитесь, что над HDFS-файлами и директориями, которые вы хотите скопировать, не выполняются какие-либо операции или задания (jobs).

   Чтобы посмотреть список запущенных операций и заданий:

   1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_data-proc }}**.
   1. Нажмите на имя первоначального кластера и выберите вкладку **{{ ui-key.yacloud.dataproc.switch_operations }}**, затем — **{{ ui-key.yacloud.mdb.cluster.switch_jobs }}**.

   {% note info %}

   Пока вы не завершили миграцию, не запускайте операции или задания, которые изменяют копируемые HDFS-файлы и директории.

   {% endnote %}

1. [Подключитесь по SSH](../../../data-proc/operations/connect.md#data-proc-ssh) к хосту-мастеру первоначального кластера.
1. Получите список директорий и файлов, которые надо скопировать в новый кластер:

   ```bash
   hdfs dfs -ls /
   ```

   Вместо символа `/` можно указать нужную вам директорию.

1. Чтобы протестировать копирование данных в новый кластер {{ dataproc-name }}, создайте тестовые директории:

   ```bash
   hdfs dfs -mkdir /user/foo &&\
   hdfs dfs -mkdir /user/test
   ```

   В примере ниже для демонстрации копируются только тестовые директории `/user/foo` и `/user/test`.

1. Подключитесь по SSH к хосту-мастеру нового кластера.
1. Создайте файл `srclist`:

   ```bash
   nano srclist
   ```

1. Добавьте в него список директорий, предназначенных для переноса:

   ```text
   hdfs://<FQDN_первоначального_кластера>:8020/user/foo
   hdfs://<FQDN_первоначального_кластера>:8020/user/test
   ```

   В команде укажите FQDN хоста-мастера первоначального кластера. О том, как получить FQDN, читайте в [инструкции](../../../data-proc/operations/connect.md#fqdn).

1. Поместите файл `srclist` в HDFS-директорию `/user`:

   ```bash
   hdfs dfs -put srclist /user
   ```

1. Создайте директорию, куда будут скопированы данные. В примере это директория `copy`, вложенная в `/user`.

   ```bash
   hdfs dfs -mkdir /user/copy
   ```

1. Скопируйте данные между кластерами с помощью утилиты [DistCp](https://hadoop.apache.org/docs/current/hadoop-distcp/DistCp.html):

   ```bash
   hadoop distcp -f hdfs://<FQDN_нового_кластера>:8020/user/srclist \
   hdfs://<FQDN_нового_кластера>:8020/user/copy
   ```

   В команде укажите FQDN хоста-мастера нового кластера.

   В результате в директорию `/user/copy` будут скопированы все директории и файлы, указанные в списке `srclist`.

   Если копируется большой объем данных, используйте в команде флаг `-m <максимальное_количество_одновременных_копий>`, чтобы ограничить потребление пропускной способности сети. Подробнее см. в [документации DistCp](https://hadoop.apache.org/docs/r3.2.2/hadoop-distcp/DistCp.html#Command_Line_Options).

   Объем копируемых данных можно посмотреть в веб-интерфейсе HDFS. Чтобы открыть его:

   1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_data-proc }}**.
   1. Нажмите на имя первоначального кластера.
   1. На его странице, в разделе **{{ ui-key.yacloud.mdb.cluster.overview.section_ui-proxy }}**, перейдите по ссылке **HDFS Namenode UI**.

   В поле **DFS Used** указан объем данных в HDFS в первоначальном кластере.

1. Проверьте, что данные скопировались:

   ```bash
   hdfs dfs -ls /user/copy
   ```

Таким образом можно скопировать все нужные данные. Для этого в `srclist` укажите требуемые директории и файлы.

## Удалите первоначальный кластер {#delete}

О том, как это сделать, читайте в [инструкции](../../../data-proc/operations/cluster-delete.md).
