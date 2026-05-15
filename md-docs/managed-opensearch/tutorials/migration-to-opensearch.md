# Миграция данных из Elasticsearch

# Миграция данных из Elasticsearch в Yandex Managed Service for OpenSearch


{% note info %}

Сервис Yandex Managed Service for Elasticsearch недоступен с 11 апреля 2024 года.

{% endnote %}


Перенести данные из кластера-источника Elasticsearch в кластер-приемник Yandex Managed Service for OpenSearch можно с помощью трех механизмов:

* [Сервиса Yandex Data Transfer](../../data-transfer/index.md).

    Этот способ подходит для любых кластеров Elasticsearch.

* [Снапшотов](../../glossary/snapshot.md) (snapshots).

    Этот способ подходит для кластеров Elasticsearch версии не выше 7.11.

    Подробнее о механизме снапшотов см. в [документации OpenSearch](https://opensearch.org/docs/latest/opensearch/snapshots/index/).

* Удаленной [переиндексации](https://opensearch.org/docs/latest/opensearch/reindex-data/) (reindex data).

    С ее помощью можно перенести существующие индексы, псевдонимы (aliases) или потоки данных. Этот способ подходит для всех кластеров Elasticsearch версии 7.


## Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки описываемого решения входят:

* Плата за кластер Managed Service for OpenSearch: использование вычислительных ресурсов, выделенных хостам (в том числе хостам с ролью `MANAGER`), и дискового пространства (см. [тарифы OpenSearch](../pricing.md)).
* Плата за публичные IP-адреса для хостов кластера (см. [тарифы Virtual Private Cloud](../../vpc/pricing.md)).
* Плата за бакет Object Storage: хранение данных и выполнение операций с ними (см. [тарифы Object Storage](../../storage/pricing.md)).


## Миграция с помощью снапшотов {#snapshot}

Чтобы мигрировать данные из кластера-источника Elasticsearch в кластер-приемник Managed Service for OpenSearch с помощью снапшотов:

1. [Создайте снапшот на кластере-источнике](#create-snapshot).
1. [Восстановите снапшот в кластере-приемнике](#restore-snapshot).
1. [Закончите миграцию](#finish-migration-snapshot).

Если используемые ресурсы вам больше не нужны, [удалите их](#clear-out-snapshot).

### Перед началом работы {#before-you-begin-snapshot}

#### Подготовьте инфраструктуру {#deploy-infrastructure-snapshot}

{% list tabs group=instructions %}

- Вручную {#manual}

    1. [Создайте бакет Object Storage](../../storage/operations/buckets/create.md) с ограниченным доступом. Этот бакет будет использоваться в качестве репозитория снапшотов.
    1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md) и [назначьте ему роль](../../iam/operations/sa/assign-role-for-sa.md) `storage.editor`. Сервисный аккаунт необходим для доступа к бакету из кластера-источника и кластера-приемника.

    1. [Создайте статический ключ доступа](../../iam/operations/authentication/manage-access-keys.md#create-access-key) для этого сервисного аккаунта.

        {% note warning %}

        Сохраните **идентификатор ключа** и **секретный ключ**. Они понадобятся позднее.

        {% endnote %}

    1. [Создайте кластер-приемник Managed Service for OpenSearch](../operations/cluster-create.md#create-cluster) нужной вам конфигурации с публичным доступом к группе хостов с ролью `DATA`.

        {% note info %}
        
        Публичный доступ к хостам кластера нужен, если вы планируете подключаться к кластеру через интернет. Этот вариант подключения более простой, и его рекомендуется использовать для прохождения руководства. К хостам без публичного доступа тоже можно подключиться, но только с виртуальных машин Yandex Cloud, расположенных в той же облачной сети, что и кластер.
        
        {% endnote %}

- С помощью Terraform {#tf}

    1. Если у вас еще нет Terraform, [установите его](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
    1. [Получите данные для аутентификации](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials). Вы можете добавить их в переменные окружения или указать далее в файле с настройками провайдера.
    1. [Настройте и инициализируйте провайдер](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Чтобы не создавать конфигурационный файл с настройками провайдера вручную, [скачайте его](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).
    1. Поместите конфигурационный файл в отдельную рабочую директорию и [укажите значения параметров](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Если данные для аутентификации не были добавлены в переменные окружения, укажите их в конфигурационном файле.

    1. Скачайте в ту же рабочую директорию файл конфигурации [es-mos-migration-snapshot.tf](https://github.com/yandex-cloud-examples/yc-elasticsearch-migration-to-managed-opensearch/blob/main/es-mos-migration-snapshot.tf). В файле описаны:

        * [сеть](../../vpc/concepts/network.md#network);
        * [подсеть](../../vpc/concepts/network.md#subnet);
        * [группа безопасности](../../vpc/concepts/security-groups.md) и правила, необходимые для подключения к кластеру Managed Service for OpenSearch;
        * сервисный аккаунт для работы с бакетом Object Storage;
        * бакет Object Storage;
        * кластер-приемник Managed Service for OpenSearch.

    1. Укажите в файле `es-mos-migration-snapshot.tf` переменные:

        * `folder_id` — идентификатор облачного каталога, такой же, как в настройках провайдера.
        * `bucket_name` — имя бакета в соответствии с [правилами именования](../../storage/concepts/bucket.md#naming).
        * `os_admin_password` — пароль администратора OpenSearch.
        * `os_version` — версия OpenSearch.

    1. Проверьте корректность файлов конфигурации Terraform с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, Terraform на них укажет.

    1. Создайте необходимую инфраструктуру:

       1. Выполните команду для просмотра планируемых изменений:
       
          ```bash
          terraform plan
          ```
       
          Если конфигурации ресурсов описаны верно, в терминале отобразится список изменяемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут изменены.
       
       1. Если вас устраивают планируемые изменения, внесите их:
          1. Выполните команду:
       
             ```bash
             terraform apply
             ```
       
          1. Подтвердите изменение ресурсов.
          1. Дождитесь завершения операции.

       В указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления](https://console.yandex.cloud).

{% endlist %}

#### Завершите настройку и проверьте доступ к ресурсам {#complete-setup-snapshot}

1. [Настройте ACL](../../storage/operations/buckets/edit-acl.md) для бакета:

    1. В выпадающем списке **Выберите пользователя** укажите созданный ранее сервисный аккаунт.
    1. Задайте разрешения `READ и WRITE` для выбранного сервисного аккаунта.
    1. Нажмите кнопку **Добавить**.
    1. Нажмите кнопку **Сохранить**.

1. Настройте кластер-источник Elasticsearch:

    1. [Установите плагин](https://www.elastic.co/guide/en/elasticsearch/plugins/7.11/repository-s3.html) `repository-s3` на все хосты кластера.
    
    1. Чтобы плагин `repository-s3` заработал, перезапустите сервисы Elasticsearch и Kibana на всех хостах кластера.
    
    1. Убедитесь, что у кластера-источника Elasticsearch есть доступ в интернет.

1. [Установите SSL-сертификат](../operations/connect/index.md#ssl-certificate).

1. Убедитесь, что вы можете [подключиться к кластеру-приемнику](../operations/connect/index.md) Managed Service for OpenSearch с помощью OpenSearch API и Dashboards.

### Создайте снапшот на кластере-источнике {#create-snapshot}

1. Подключите бакет в качестве репозитория снапшотов на кластере-источнике:

    1. Добавьте сведения о ключе статического доступа в [хранилище ключей](https://www.elastic.co/guide/en/elasticsearch/reference/current/elasticsearch-keystore.html) (keystore) Elasticsearch.
    
       {% note info %}
    
       Выполните процедуру на всех хостах кластера-источника.
    
       {% endnote %}
    
       Добавьте:
    
       * **Идентификатор ключа**:
    
           ```bash
           $ES_PATH/bin/elasticsearch-keystore add s3.client.default.access_key
           ```
    
       * **Секретный ключ**:
    
           ```bash
           $ES_PATH/bin/elasticsearch-keystore add s3.client.default.secret_key
           ```
    
       {% note info %}
    
       Путь к Elasticsearch (`$ES_PATH`) зависит от выбранного способа установки. Найти путь к установленному Elasticsearch можно в [документации по установке](https://www.elastic.co/guide/en/elasticsearch/reference/current/install-elasticsearch.html) (например, для [DEB](https://www.elastic.co/guide/en/elasticsearch/reference/current/deb.html#deb-layout), [RPM](https://www.elastic.co/guide/en/elasticsearch/reference/current/rpm.html#rpm-layout)).
    
       {% endnote %}
    
    1. Загрузите данные из хранилища ключей:
    
       ```bash
       curl --request POST "https://<IP-адрес_или_FQDN_хоста_с_ролью_DATA_в_кластере-источнике>:9200/_nodes/reload_secure_settings"
       ```
    
    1. Зарегистрируйте репозиторий:
    
       ```bash
       curl --request PUT \
            "https://<IP-адрес_или_FQDN_хоста_с_ролью_DATA_в_кластере-источнике>:9200/_snapshot/<имя_репозитория>" \
            --header 'Content-Type: application/json' \
            --data '{
              "type": "s3",
              "settings": {
                "bucket": "<имя_бакета>",
                "endpoint": "storage.yandexcloud.net"
              }
            }'
       ```

    Подробнее о подключении репозитория см. в [документации плагина](https://www.elastic.co/guide/en/elasticsearch/plugins/7.11/repository-s3.html).

    {% note alert %}
    
    Если бакет зарегистрирован в кластере Elasticsearch как репозиторий снапшотов, не изменяйте содержимое бакета вручную — это нарушит работу механизма снапшотов Elasticsearch.
    
    {% endnote %}

1. Запустите создание снапшота в репозитории, созданном на предыдущем шаге. Можно создать снапшот всего кластера или части данных. Подробнее см. в [документации Elasticsearch](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-take-snapshot.html).

    Пример создания снапшота с именем `snapshot_1` для всего кластера:

    ```bash
    curl --request PUT \
         "https://<IP-адрес_или_FQDN_хоста_с_ролью_DATA_в_кластере-источнике>:9200/_snapshot/<имя_репозитория>/snapshot_1?wait_for_completion=false&pretty"
    ```

    Процесс создания снапшота может занять длительное время. Отслеживайте ход выполнения операции [с помощью инструментов Elasticsearch](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-take-snapshot.html#monitor-snapshot), например:

    ```bash
    curl --request GET \
         "https://<IP-адрес_или_FQDN_хоста_с_ролью_DATA_в_кластере-источнике>:9200/_snapshot/<имя_репозитория>/snapshot_1/_status?pretty"
    ```

### Восстановите снапшот в кластере-приемнике {#restore-snapshot}

1. [Настройте доступ к бакету со снапшотами](../operations/s3-access.md#configure-acl) для кластера-приемника. Используйте [созданный ранее](#before-you-begin) сервисный аккаунт.

1. [Подключите к кластеру-приемнику бакет Object Storage](../operations/s3-access.md#register-snapshot-repository) в качестве хранилища снапшотов в режиме только для чтения:

    ```bash
    curl --request PUT \
         "https://admin:<пароль_пользователя_admin>@<идентификатор_хоста_OpenSearch_с_ролью_DATA>.mdb.yandexcloud.net:9200/_snapshot/<имя_репозитория>" \
         --cacert ~/.opensearch/root.crt \
         --header 'Content-Type: application/json' \
         --data '{
           "type": "s3",
           "settings": {
             "bucket": "<имя_бакета>",
             "readonly" : "true",
             "endpoint": "storage.yandexcloud.net"
           }
         }'
    ```

1. Выберите способ восстановления индексов на кластере-приемнике.

    При настройках по умолчанию попытка восстановления индекса завершится неудачей, если в кластере уже открыт индекс с тем же именем. Даже если кластер Managed Service for OpenSearch не содержит пользовательских данных, в нем есть открытые системные индексы (такие как `.apm-custom-link`, `.kibana_*` и другие), что может помешать восстановлению. Чтобы этого избежать, воспользуйтесь одним из способов:

    * Переносите только пользовательские индексы. Существующие системные индексы не переносятся, в процессе импорта участвую только индексы, созданные на кластере-источнике пользователем.

    * Используйте параметры `rename_pattern` и `rename_replacement`. Индексы будут переименовываться по мере их восстановления. Подробнее см. в [документации OpenSearch](https://opensearch.org/docs/latest/opensearch/snapshots/snapshot-restore#conflicts-and-compatibility).

    Пример восстановления снапшота целиком:

    ```bash
    curl --request POST \
         "https://admin:<пароль_пользователя_admin>@<идентификатор_хоста_OpenSearch_с_ролью_DATA>.mdb.yandexcloud.net:9200/_snapshot/<имя_репозитория>/snapshot_1/_restore" \
         --cacert ~/.opensearch/root.crt
    ```

1. Запустите восстановление из снапшота на кластере-приемнике.

    Пример восстановления снапшота с указанием пользовательских индексов, которые нужно восстановить в кластере-приемнике:

    ```bash
    curl --request POST \
         "https://admin:<пароль_пользователя_admin>@<идентификатор_хоста_OpenSearch_с_ролью_DATA>.mdb.yandexcloud.net:9200/_snapshot/<имя_репозитория>/snapshot_1/_restore?wait_for_completion=false&pretty" \
         --cacert ~/.opensearch/root.crt \
         --header 'Content-Type: application/json' \
         --data '{
           "indices": "<список_индексов>"
         }'
    ```

    Где `indices` — список восстанавливаемых индексов через запятую, например `my_index*, my_index_2.*`.

    Процесс восстановления может занять длительное время. Чтобы проверить статус восстановления, выполните команду:

    ```bash
    curl --request GET \
         "https://admin:<пароль_пользователя_admin>@<идентификатор_хоста_OpenSearch_с_ролью_DATA>.mdb.yandexcloud.net:9200/_snapshot/<имя_репозитория>/snapshot_1/_status?pretty" \
         --cacert ~/.opensearch/root.crt
    ```

### Закончите миграцию {#finish-migration-snapshot}

1. Убедитесь, что все нужные индексы перенесены в кластер-приемник Managed Service for OpenSearch, а количество документов в них такое же, как и в кластере-источнике:

    {% list tabs group=programming_language %}

    - Bash {#bash}

      Выполните команду:

      ```bash
      curl \
          --user <имя_пользователя_в_кластере-приемнике>:<пароль_пользователя_в_кластере-приемнике> \
          --cacert ~/.opensearch/root.crt \
          --request GET 'https://<идентификатор_хоста_OpenSearch_с_ролью_DATA>.mdb.yandexcloud.net:9200/_cat/indices?v'
      ```

      В списке должны быть перенесенные индексы из Elasticsearch с количеством документов в столбце `docs.count`.

    - OpenSearch Dashboards {#opensearch}
    
      1. [Подключитесь](../operations/connect/clients.md#dashboards) к кластеру-приемнику с помощью OpenSearch Dashboards.
      1. Выберите общий тенант `Global`.
      1. Откройте панель управления, нажав на значок ![os-dashboards-sandwich](../../_assets/console-icons/bars.svg).
      1. В разделе **OpenSearch Plugins** выберите **Index Management**.
      1. Перейдите в раздел **Indices**.

      В списке должны быть перенесенные индексы из Elasticsearch с количеством документов в столбце **Total documents**.

    {% endlist %}

1. При необходимости [отключите репозиторий снапшотов](https://www.elastic.co/guide/en/elasticsearch/reference/current/delete-snapshot-repo-api.html) на стороне кластера-источника и кластера-приемника.

### Удалите созданные ресурсы {#clear-out-snapshot}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

{% list tabs group=instructions %}

- Вручную {#manual}

    * [Удалите сервисный аккаунт](../../iam/operations/sa/delete.md).
    * [Удалите снапшоты](../../storage/operations/objects/delete.md) из бакета и затем удалите [бакет целиком](../../storage/operations/buckets/delete.md).
    * [Удалите кластер Managed Service for OpenSearch](../operations/cluster-delete.md).

- С помощью Terraform {#tf}

    1. Удалите все объекты из бакета.

    1. В терминале перейдите в директорию с планом инфраструктуры.
    
        {% note warning %}
    
        Убедитесь, что в директории нет Terraform-манифестов с ресурсами, которые вы хотите сохранить. Terraform удаляет все ресурсы, которые были созданы с помощью манифестов в текущей директории.
    
        {% endnote %}
    
    1. Удалите ресурсы:
    
        1. Выполните команду:
    
            ```bash
            terraform destroy
            ```
    
        1. Подтвердите удаление ресурсов и дождитесь завершения операции.
    
        Все ресурсы, которые были описаны в Terraform-манифестах, будут удалены.

{% endlist %}

## Миграция с помощью переиндексации {#reindex}


Чтобы мигрировать данные из кластера-источника Elasticsearch в кластер-приемник Managed Service for OpenSearch с помощью переиндексации:

1. [Настройте кластер-приемник](#configure-target-reindex).
1. [Запустите переиндексацию](#start-reindex).
1. [Проверьте результат](#check-result-reindex).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out-reindex).


### Перед началом работы {#before-you-begin-reindex}


1. Подготовьте инфраструктуру:

    {% list tabs group=instructions %}

    - Вручную {#manual}

        [Создайте кластер-приемник Managed Service for OpenSearch](../operations/cluster-create.md#create-cluster) нужной вам конфигурации с публичным доступом к группе хостов с ролью `DATA`.

        {% note info %}
        
        Публичный доступ к хостам кластера нужен, если вы планируете подключаться к кластеру через интернет. Этот вариант подключения более простой, и его рекомендуется использовать для прохождения руководства. К хостам без публичного доступа тоже можно подключиться, но только с виртуальных машин Yandex Cloud, расположенных в той же облачной сети, что и кластер.
        
        {% endnote %}

    - С помощью Terraform {#tf}

        1. Если у вас еще нет Terraform, [установите его](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
        1. [Получите данные для аутентификации](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials). Вы можете добавить их в переменные окружения или указать далее в файле с настройками провайдера.
        1. [Настройте и инициализируйте провайдер](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Чтобы не создавать конфигурационный файл с настройками провайдера вручную, [скачайте его](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).
        1. Поместите конфигурационный файл в отдельную рабочую директорию и [укажите значения параметров](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Если данные для аутентификации не были добавлены в переменные окружения, укажите их в конфигурационном файле.

        1. Скачайте в ту же рабочую директорию файл конфигурации [es-mos-migration-reindex.tf](https://github.com/yandex-cloud-examples/yc-elasticsearch-migration-to-managed-opensearch/blob/main/es-mos-migration-reindex.tf). В файле описаны:

            * [сеть](../../vpc/concepts/network.md#network);
            * [подсеть](../../vpc/concepts/network.md#subnet);
            * [группа безопасности](../../vpc/concepts/security-groups.md) и правила, необходимые для подключения к кластеру Managed Service for OpenSearch;
            * кластер-приемник Managed Service for OpenSearch.

        1. Укажите в файле `es-mos-migration-reindex.tf` переменные:

            * `os_admin_password` — пароль администратора OpenSearch.
            * `os_version` — версия OpenSearch.

        1. Проверьте корректность файлов конфигурации Terraform с помощью команды:

            ```bash
            terraform validate
            ```

            Если в файлах конфигурации есть ошибки, Terraform на них укажет.

        1. Создайте необходимую инфраструктуру:

           1. Выполните команду для просмотра планируемых изменений:
           
              ```bash
              terraform plan
              ```
           
              Если конфигурации ресурсов описаны верно, в терминале отобразится список изменяемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут изменены.
           
           1. Если вас устраивают планируемые изменения, внесите их:
              1. Выполните команду:
           
                 ```bash
                 terraform apply
                 ```
           
              1. Подтвердите изменение ресурсов.
              1. Дождитесь завершения операции.

           В указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления](https://console.yandex.cloud).

    {% endlist %}

1. Установите SSL-сертификат:

    {% list tabs group=operating_system %}
    
    - Linux (Bash)/macOS (Zsh) {#linux-macos}
    
       ```bash
       mkdir -p ~/.opensearch && \
       wget "https://storage.yandexcloud.net/cloud-certs/CA.pem" \
            --output-document ~/.opensearch/root.crt && \
       chmod 0600 ~/.opensearch/root.crt
       ```
    
       Сертификат будет сохранен в файле `~/.opensearch/root.crt`.
    
    - Windows (PowerShell) {#windows}
    
       ```powershell
       mkdir $HOME\.opensearch; curl.exe -o $HOME\.opensearch\root.crt https://storage.yandexcloud.net/cloud-certs/CA.pem
       ```
    
       Сертификат будет сохранен в файле `$HOME\.opensearch\root.crt`.
    
       Корпоративные политики и антивирус могут блокировать скачивание сертификата. Подробнее читайте в разделе [Вопросы и ответы](../qa/index.md#get-ssl-error).
    
    {% endlist %}

1. Убедитесь, что вы можете [подключиться к кластеру-приемнику](../operations/connect/index.md) Managed Service for OpenSearch с помощью OpenSearch API и Dashboards.


1. Убедитесь, что у кластера-источника Elasticsearch есть доступ в интернет.


1. Создайте в кластере-источнике [пользователя](https://www.elastic.co/guide/en/kibana/current/xpack-security.html#_users_2) с [ролями](https://www.elastic.co/guide/en/kibana/current/xpack-security.html#_roles_2) `monitoring_user` и `viewer`.


### Настройте кластер-приемник {#configure-target-reindex}


1. [Создайте роль](https://opensearch.org/docs/latest/security-plugin/access-control/users-roles/#create-roles) с привилегиями `create_index` и `write` для всех индексов (`*`).

1. [Создайте пользователя](../operations/cluster-users.md) и назначьте ему эту роль.

    {% note tip %}

    В кластерах Managed Service for OpenSearch вы можете использовать переиндексацию от имени пользователя `admin`, имеющего роль `superuser`, но безопаснее для каждой задачи создавать отдельных пользователей с ограниченными привилегиями. Подробнее см. в разделе [Управление пользователями OpenSearch](../operations/cluster-users.md).

    {% endnote %}


### Запустите переиндексацию {#start-reindex}


1. [Получите список хостов](../operations/host-groups.md#list-hosts) кластера-приемника.

1. Для запуска переиндексации выполните запрос к хосту с ролью `DATA` в кластере-приемнике:

    ```bash
    curl --user <имя_пользователя_в_кластере-приемнике>:<пароль_пользователя_в_кластере-приемнике> \
         --cacert ~/.opensearch/root.crt \
         --request POST \
         "https://<идентификатор_хоста_OpenSearch_с_ролью_DATA>.mdb.yandexcloud.net:9200/_reindex?wait_for_completion=false&pretty" \
         --header 'Content-Type: application/json' \
         --data '{
           "source": {
             "remote": {
               "host": "https://<IP-адрес_или_FQDN_хоста_с_ролью_DATA_в_кластере-источнике>:9200",
               "username": "<имя_пользователя_в_кластере-источнике>",
               "password": "<пароль_пользователя_в_кластере-источнике>"
             },
             "index": "<имя_индекса_псевдонима_или_потока_данных_в_кластере-источнике>"
           },
           "dest": {
             "index": "<имя_индекса_псевдонима_или_потока_данных_в_кластере-приемнике>"
           }
         }'
    ```

    Результат:

    ```text
    {
      "task" : "<идентификатор_задачи_переиндексации>"
    }
    ```

    Чтобы перенести несколько индексов, используйте цикл `for`:

    ```bash
    for index in <имена_индексов_псевдонимов_или_потоков_данных_разделенные_пробелами>; do
      curl --user <имя_пользователя_в_кластере-приемнике>:<пароль_пользователя_в_кластере-приемнике> \
           --cacert ~/.opensearch/root.crt \
           --request POST \
           "https://<идентификатор_хоста_OpenSearch_с_ролью_DATA>.mdb.yandexcloud.net:9200/_reindex?wait_for_completion=false&pretty" \
           --header 'Content-Type: application/json' \
           --data '{
             "source": {
               "remote": {
                 "host": "https://<IP-адрес_или_FQDN_хоста_с_ролью_DATA_в_кластере-источнике>:9200",
                 "username": "<имя_пользователя_в_кластере-источнике>",
                 "password": "<пароль_пользователя_в_кластере-источнике>"
               },
               "index": "'$index'"
             },
             "dest": {
               "index": "'$index'"
             }
           }'
    done
    ```

    Результат:

    ```text
    {
      "task" : "<идентификатор_задачи_переиндексации_1>"
    }
    {
      "task" : "<идентификатор_задачи_переиндексации_2>"
    }
    ...
    ```

    Подробнее о параметрах переиндексации см. в [документации OpenSearch](https://opensearch.org/docs/latest/opensearch/reindex-data/#source-index-options).

    Процесс переиндексации может занять длительное время. Чтобы проверить статус операции, выполните команду:

    ```bash
    curl --user <имя_пользователя_в_кластере-приемнике>:<пароль_пользователя_в_кластере-приемнике> \
         --cacert ~/.opensearch/root.crt \
         --request GET \
         "https://<идентификатор_хоста_OpenSearch_с_ролью_DATA>.mdb.yandexcloud.net:9200/_tasks/<идентификатор_задачи_переиндексации>"
    ```

1. Чтобы отменить операцию переиндексации, выполните команду:

    ```bash
    curl --user <имя_пользователя_в_кластере-приемнике>:<пароль_пользователя_в_кластере-приемнике> \
         --cacert ~/.opensearch/root.crt \
         --request POST \
         "https://<идентификатор_хоста_OpenSearch_с_ролью_DATA>.mdb.yandexcloud.net:9200/_tasks/<идентификатор_задачи_переиндексации>/_cancel"
    ```


### Проверьте результат {#check-result-reindex}


Убедитесь, что все нужные индексы перенесены в кластер-приемник Managed Service for OpenSearch, а количество документов в них такое же как и в кластере-источнике:

{% list tabs group=programming_language %}

- Bash {#bash}

  Выполните команду:

  ```bash
  curl \
      --user <имя_пользователя_в_кластере-приемнике>:<пароль_пользователя_в_кластере-приемнике> \
      --cacert ~/.opensearch/root.crt \
      --request GET 'https://<идентификатор_хоста_OpenSearch_с_ролью_DATA>.mdb.yandexcloud.net:9200/_cat/indices?v'
  ```

  В списке должны быть перенесенные индексы из Elasticsearch с количеством документов в столбце `docs.count`.

- OpenSearch Dashboards {#opensearch}

  1. [Подключитесь](../operations/connect/clients.md#dashboards) к кластеру-приемнику с помощью OpenSearch Dashboards.
  1. Выберите общий тенант `Global`.
  1. Откройте панель управления, нажав на значок ![os-dashboards-sandwich](../../_assets/console-icons/bars.svg).
  1. В разделе **OpenSearch Plugins** выберите **Index Management**.
  1. Перейдите в раздел **Indices**.

  В списке должны быть перенесенные индексы из Elasticsearch с количеством документов в столбце **Total documents**.

{% endlist %}


### Удалите созданные ресурсы {#clear-out-reindex}



Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

* [Удалите объекты](../../storage/operations/objects/delete.md) из бакета.
* Удалите ресурсы в зависимости от способа их создания:

    {% list tabs group=instructions %}

    - Вручную {#manual}

        [Удалите кластер Managed Service for OpenSearch](../operations/cluster-delete.md).

    - С помощью Terraform {#tf}

        1. В терминале перейдите в директорию с планом инфраструктуры.
        
            {% note warning %}
        
            Убедитесь, что в директории нет Terraform-манифестов с ресурсами, которые вы хотите сохранить. Terraform удаляет все ресурсы, которые были созданы с помощью манифестов в текущей директории.
        
            {% endnote %}
        
        1. Удалите ресурсы:
        
            1. Выполните команду:
        
                ```bash
                terraform destroy
                ```
        
            1. Подтвердите удаление ресурсов и дождитесь завершения операции.
        
            Все ресурсы, которые были описаны в Terraform-манифестах, будут удалены.

    {% endlist %}

* Если вы зарезервировали для доступа к кластеру публичные статические IP-адреса, освободите и [удалите их](../../vpc/operations/address-delete.md).