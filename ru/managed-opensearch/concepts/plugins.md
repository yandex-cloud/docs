# Плагины {{ OS }}

{{ mos-name }} содержит ряд [предустановленных плагинов]({{ os.docs }}/install-and-configure/install-opensearch/plugins/#bundled-plugins). Также при создании или изменении кластера в {{ mos-short-name }} вы можете указать желаемый список [дополнительных плагинов](#opensearch), и они будут автоматически установлены в кластер.

## Дополнительные плагины {{ OS }} {#opensearch}

Полный список поддерживаемых дополнительных плагинов:

* analysis-icu

    Добавляет модуль Lucene ICU с расширенной поддержкой Unicode и использованием библиотек [ICU](https://icu.unicode.org/). Модуль предоставляет улучшенный анализ азиатских языков, нормализацию Unicode, преобразование регистра Unicode, поддержку сопоставления и транслитерацию.

* analysis-kuromoji

    Добавляет модуль анализа Lucene kuromoji для японского языка.

* analysis-nori

    Добавляет модуль анализа Lucene nori для корейского языка. Использует словарь [mecab-ko-dic](https://bitbucket.org/eunjeon/mecab-ko-dic/src/master/).

* analysis-phonetic

    Предоставляет фильтры лексем, которые преобразуют выражения в их фонетическое представление с помощью Soundex, Metaphone и других алгоритмов.

* analysis-smartcn

    Добавляет модуль анализа Smart Chinese от Lucene для китайского или смешанного китайско-английского текста.

* analysis-stempel

    Добавляет модуль анализа Stempel от Lucene для польского языка.

* analysis-ukrainian

    Добавляет морфологический модуль анализа UkrainianMorfologikAnalyzer от Lucene для украинского языка. Использует проект [Morfologik](https://github.com/morfologik/morfologik-stemming).

* ingest-attachment

    Извлекает вложения файлов в распространенных форматах (таких как PPT, XLS и PDF) с помощью библиотеки извлечения текста [Apache Tika™](https://tika.apache.org/).

* mapper-annotated-text

    Индексирует текст, представляющий собой комбинацию обычного текста и специальной разметки. Такая комбинация используется для идентификации объектов, таких как люди или организации.

* mapper-murmur3

    Вычисляет хеш значений полей по индексному времени и хранит их в индексе.

* mapper-size

    Предоставляет поле метаданных `_size`, которое индексирует размер в байтах исходного поля `_source`.

* repository-azure

    Добавляет поддержку [хранилища Azure Blob]({{ ms.docs }}/azure/storage/blobs/storage-blobs-introduction) в качестве репозитория [снапшотов](https://cloud.yandex.ru/docs/glossary/snapshot).

* repository-gcs

    Добавляет поддержку службы [Google Cloud Storage](https://cloud.google.com/storage/) в качестве репозитория снапшотов.

* repository-hdfs

    Добавляет поддержку файловой системы HDFS в качестве репозитория снапшотов.

* repository-s3

    Добавляет поддержку [AWS S3](https://aws.amazon.com/s3/) в качестве репозитория снапшотов.

* transport-nio

    Серверно-клиентская неблокируемая сетевая библиотека, созданная с помощью Netty.

Подробнее см. в [документации {{ OS }}]({{ os.docs }}/install-and-configure/install-opensearch/plugins/#additional-plugins).
