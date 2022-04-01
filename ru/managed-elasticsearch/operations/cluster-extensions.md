# Управление расширениями {{ ES }}

При создании или изменении кластера в {{ mes-short-name }} вы можете указать желаемый список расширений (plugins), и они будут автоматически установлены в кластер. Полный список доступных расширений [приведен ниже](#elasticsearch).

## Получить список установленных расширений {#list}

{% list tabs %}

* CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы получить список расширений кластера, выполните команду:

    ```bash
    {{ yc-mdb-es }} cluster get <идентификатор или имя кластера>
    ```

    Включенные расширения будут перечислены в списке `plugins`.

    Идентификатор и имя кластера можно [получить со списком кластеров в каталоге](cluster-list.md#list-clusters).

* API

    Воспользуйтесь методом API [list](../api-ref/Extension/list.md) и передайте в запросе идентификатор кластера в параметре `clusterId`.

    Идентификатор кластера можно [получить со списком кластеров в каталоге](cluster-list.md#list-clusters).

{% endlist %}

## Изменить список установленных расширений {#update}

{% list tabs %}

* CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы изменить расширения кластера, передайте их список в параметре `--plugins` команды CLI. При этом расширения, не упомянутые в списке, будут выключены.

    ```bash
    {{ yc-mdb-es }} cluster update <идентификатор или имя кластера> \
       --plugins=<имя расширения 1>,...,<имя расширения N>
    ```

    Идентификатор и имя кластера можно [получить со списком кластеров в каталоге](cluster-list.md#list-clusters).

* Terraform

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).

    1. Добавьте к описанию кластера {{ mes-name }} в блоке `config` поле `plugins` со списком расширений:

        ```hcl
        resource "yandex_mdb_elasticsearch_cluster" "<имя кластера>" {
          ...
          config {
            ...
            plugins = [ "<список имен расширений>" ]
            ...
          }
          ...
        }
        ```

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-mes }}).

* API

    Воспользуйтесь методом API [update](../api-ref/Cluster/update.md) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
    * Список расширений в параметре `configSpec.elasticsearchSpec.plugins`. Расширения, не упомянутые в списке, будут выключены.
    * Список полей конфигурации кластера, подлежащих изменению (в данном случае — `configSpec.elasticsearchSpec.plugins`) в параметре `updateMask`. Если не задать этот параметр, метод API сбросит на значения по умолчанию все настройки кластера, которые не были явно указаны в запросе.

{% endlist %}

## Поддерживаемые расширения {{ ES }} {#elasticsearch}

Полный список поддерживаемых расширений:

* [analysis-icu](https://www.elastic.co/guide/en/elasticsearch/plugins/current/analysis-icu.html)

    Добавляет модуль Lucene ICU с расширенной поддержкой Unicode и использованием библиотек ICU. Модуль предоставляет улучшенный анализ азиатских языков, нормализацию Unicode, преобразование регистра Unicode, поддержку сопоставления и транслитерацию.

* [analysis-kuromoji](https://www.elastic.co/guide/en/elasticsearch/plugins/current/analysis-kuromoji.html)

    Добавляет модуль анализа Lucene kuromoji для японского языка.

* [analysis-nori](https://www.elastic.co/guide/en/elasticsearch/plugins/current/analysis-nori.html)

    Добавляет модуль анализа Lucene nori для корейского языка.

* [analysis-phonetic](https://www.elastic.co/guide/en/elasticsearch/plugins/current/analysis-phonetic.html)

    Предоставляет фильтры лексем, которые преобразуют выражения в их фонетическое представление с помощью Soundex, Metaphone и других алгоритмов.

* [analysis-smartcn](https://www.elastic.co/guide/en/elasticsearch/plugins/current/analysis-smartcn.html)

    Добавляет модуль анализа Smart Chinese от Lucene для китайского или смешанного китайско-английского текста.

* [analysis-stempel](https://www.elastic.co/guide/en/elasticsearch/plugins/current/analysis-stempel.html)

    Добавляет модуль анализа Stempel от Lucene для польского языка.

* [analysis-ukrainian](https://www.elastic.co/guide/en/elasticsearch/plugins/current/analysis-ukrainian.html)

    Добавляет морфологический модуль анализа UkrainianMorfologikAnalyzer от Lucene для украинского языка.

* [ingest-attachment](https://www.elastic.co/guide/en/elasticsearch/plugins/current/ingest-attachment.html)

    Извлекает вложения файлов в распространенных форматах (таких как PPT, XLS и PDF) с помощью библиотеки извлечения текста Apache Tika™.

* [mapper-annotated-text](https://www.elastic.co/guide/en/elasticsearch/plugins/current/mapper-annotated-text.html)

    Индексирует текст, представляющий собой комбинацию обычного текста и специальной разметки. Такая комбинация используется для идентификации объектов, таких как люди или организации.

* [mapper-murmur3](https://www.elastic.co/guide/en/elasticsearch/plugins/current/mapper-murmur3.html)

    Вычисляет хеш значений полей по индексному времени и хранит их в индексе.

* [mapper-size](https://www.elastic.co/guide/en/elasticsearch/plugins/current/mapper-size.html)

    Предоставляет поле метаданных `_size`, которое индексирует размер в байтах исходного поля `_source`.

* [repository-azure](https://www.elastic.co/guide/en/elasticsearch/plugins/current/repository-azure.html)

    Добавляет поддержку хранилища Azure Blob в качестве репозитория снапшотов.

* [repository-gcs](https://www.elastic.co/guide/en/elasticsearch/plugins/current/repository-gcs.html)

    Добавляет поддержку службы Google Cloud Storage в качестве репозитория снапшотов.

* [repository-hdfs](https://www.elastic.co/guide/en/elasticsearch/plugins/current/repository-hdfs.html)

    Добавляет поддержку файловой системы HDFS в качестве репозитория снапшотов.

* [repository-s3](https://www.elastic.co/guide/en/elasticsearch/reference/current/repository-s3.html)

    Добавляет поддержку AWS S3 в качестве репозитория снапшотов.

* [store-smb](https://www.elastic.co/guide/en/elasticsearch/plugins/current/store-smb.html)

    Устраняет ошибки в Windows SMB и Java на Windows.

* transport-nio

    Серверно-клиентская неблокируемая сетевая библиотека, созданная с помощью Netty.

Подробнее см. в [документации {{ ES }}](https://www.elastic.co/guide/en/elasticsearch/plugins/current/index.html).
