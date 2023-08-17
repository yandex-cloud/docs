# Подключение собственной геобазы в {{ mch-name }}

Геобаза в {{ CH }} — это текстовые файлы, которые содержат иерархию и имена регионов. Вы можете добавить в {{ CH }} несколько альтернативных геобаз для поддержки разных точек зрения о принадлежности регионов странам. Подробнее читайте в [документации {{ CH }}](https://{{ ch-domain }}/docs/ru/sql-reference/dictionaries/internal-dicts/).

Чтобы подключить к кластеру {{ CH }} собственную геобазу:

1. [Создайте ее](#create).
1. [Загрузите геобазу в {{ objstorage-full-name }}](#upload).
1. [Подключите геобазу к кластеру {{ CH }}](#add).

## Создать геобазу {#create}

1. Создайте файл `regions_hierarchy.txt` с иерархией регионов. Файл должен представлять собой таблицу в [формате TSV](https://ru.wikipedia.org/wiki/TSV) без заголовков и со столбцами:
   * идентификатор региона (UInt32);
   * идентификатор родительского региона (UInt32);
   * тип региона (UInt8):
        * `1` — континент;
        * `3` — страна;
        * `4` — федеральный округ;
        * `5` — область;
        * `6` — город;
   * население (UInt32) — необязательный столбец.
1. Чтобы добавить альтернативную иерархию регионов, создайте файлы `regions_hierarchy_<суффикс>.txt` с аналогичной структурой. Чтобы затем воспользоваться альтернативной геобазой, передайте этот суффикс при вызове функции. Например:

    * `regionToCountry(RegionID)` — использует словарь по умолчанию: `regions_hierarchy.txt`;
    * `regionToCountry(RegionID, 'alt')` — использует словарь с суффиксом `alt`: `regions_hierarchy_alt.txt`.

1. Создайте файл `regions_names.txt` с именами регионов. Файл должен представлять собой таблицу в [формате TSV](https://ru.wikipedia.org/wiki/TSV) без заголовков и со столбцами:

    * идентификатор региона (UInt32);
    * имя региона (String) — не может содержать символы табуляции или переводы строк, даже экранированные.

1. Чтобы добавить в базу имена регионов на других языках, создайте файлы `regions_names_<код языка>.txt` с аналогичной структурой. Например, `regions_names_en.txt` для английского языка и `regions_names_tr.txt` для турецкого.
1. Создайте из файлов геобазы архив в формате `tar`, `tar.gz` или `zip`.

## Загрузить геобазу в {{ objstorage-full-name }} {#upload}

{{ mch-short-name }} работает только с геобазами, которые загружены в {{ objstorage-full-name }} и к которым предоставлен доступ на чтение:


1. [Загрузите](../../storage/operations/objects/upload.md) архив с геобазой в {{ objstorage-full-name }}.

1. Настройте доступ к архиву геобазы, используя [сервисный аккаунт](../../iam/concepts/users/service-accounts.md):

    1. [Подключите сервисный аккаунт к кластеру](s3-access.md#connect-service-account).
    1. [Назначьте аккаунту роль](s3-access.md#configure-acl) `storage.viewer`.
    1. В ACL бакета [добавьте аккаунту разрешение](../../storage/operations/buckets/edit-acl.md) `READ`.

1. [Получите ссылку](s3-access.md#get-link-to-object) на архив с геобазой.


## Подключить геобазу к кластеру {{ CH }} {#add}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ mch-name }}**.
  1. Выберите кластер и нажмите кнопку **Изменить кластер** на панели сверху.
  1. В блоке **Настройки СУБД** нажмите кнопку **Настроить**.
  1. В поле **Geobase uri** укажите ссылку на архив с геобазой в {{ objstorage-full-name }}.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы подключить геобазу:

    1. Посмотрите описание команды CLI для изменения конфигурации кластера:

        ```bash
        {{ yc-mdb-ch }} cluster update-config --help
        ```

    1. Выполните команду, передав ссылку на архив с подключаемой геобазой в параметре `geobase_uri`:

        ```bash
        {{ yc-mdb-ch }} cluster update-config <идентификатор или имя кластера> \
             --set geobase_uri="<ссылка на архив с геобазой в {{ objstorage-name }}>"
        ```

        Идентификатор и имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- {{ TF }}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

    1. Добавьте в настройки кластера {{ mch-name }} параметр `geobase_uri` со ссылкой на архив с подключаемой геобазой в {{ objstorage-full-name }}:

        ```hcl
        resource "yandex_mdb_clickhouse_cluster" "<имя кластера>" {
          ...
          clickhouse {
            config {
              geobase_uri = "<ссылка на архив с геобазой в {{ objstorage-full-name }}>"
              ...
            }
          ...
          }
        ...
        }
        ```

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_clickhouse_cluster).

    {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- API

    Чтобы подключить геобазу к кластеру {{ CH }}, воспользуйтесь методом REST API [update](../api-ref/Cluster/update.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Update](../api-ref/grpc/cluster_service.md#Update) и передайте в запросе ссылку на архив с геобазой в {{ objstorage-name }} в параметре `geobaseUri`.

    {% note warning %}

    Этот метод API сбросит все настройки кластера, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, обязательно передайте название полей, подлежащих изменению, в параметре `updateMask`.

    {% endnote %}

{% endlist %}

