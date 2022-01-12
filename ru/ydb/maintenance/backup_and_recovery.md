---
sourcePath: overlay/maintenance/backup_and_recovery.md
---

{% include [intro.md](_includes/backup_and_recovery/01_intro.md) %}

{% if audience != "external" %}

В Yandex доступна также работа с резервными копиями в YT.

{% endif %}

{% include [prerequisites.md](_includes/backup_and_recovery/02_prerequisites.md) %}

{% if audience != "external" %}

* пользователь, авторизованный для чтения и записи данных из таблиц, для которых будет создана резервная копия;
* [токен для аутентификации](../getting_started/start_auth.md) пользователя, от имени которого будет выполняться операция.

{% note info "Аутентификация" %}

Для аутентификации в YDB cli используется токен из переменной окружения __YDB_TOKEN__ или из файла `~/.ydb/token`.

{% endnote %}

{% endif %}

{% include [fs_backup_header.md](_includes/backup_and_recovery/04_fs_backup_1_header.md) %}

{% if audience != "external" %}

Строковые данные перед сохранением преобразуются в urlencoded представление с помощью функции [CGIEscape](https://a.yandex-team.ru/arc/trunk/arcadia/util/string/quote.h?rev=5058568#L6-25).

{% endif %}

{% include [fs_backup_body.md](_includes/backup_and_recovery/04_fs_backup_2_body.md) %}

{% include [fs_restore.md](_includes/backup_and_recovery/05_fs_restore.md) %}

{% include [s3_header.md](_includes/backup_and_recovery/06_s3_1_header.md) %}

{% if audience != "external" %}

В этом разделе в качестве системы назначения используется [MDS](https://wiki.yandex-team.ru/mds/) – система хранения данных, доступная в Яндексе и предоставляющая возможность доступа по интерфейсу, совместимому с Amazon S3. Более подробно MDS S3 API [описан в документации](https://wiki.yandex-team.ru/mds/s3-api/).

{% endif %}

{% if audience == "external" %}
В этом разделе в качестве системы назначения используется [Yandex Object Storage](../../storage/).
{% endif %}

{% include [s3_prerequisites.md](_includes/backup_and_recovery/06_s3_2_prerequisites.md) %}

{% if audience != "external" %}

Для сохранения резервной копии базы данных YDB в MDS вам понадобится:

* [квота](https://wiki.yandex-team.ru/mds/s3-api/authorization/#registracijaservisa-klienta) в MDS;
* [предварительно созданный](https://wiki.yandex-team.ru/mds/s3-api/s3-clients/#primery) бакет в MDS;
* [пользователь](https://wiki.yandex-team.ru/mds/s3-api/authorization/#vydachapravrobotuilisotrudniku), обладающий правом на запись в бакет.

{% endif %}

{% if audience == "external" %}
При работе с [Yandex Object Storage](https://cloud.yandex.ru/services/storage) используется [бакет Yandex.Cloud Object Storage](https://cloud.yandex.ru/docs/storage/concepts/bucket).
{% endif %}

{% include [s3_access_keys.md](_includes/backup_and_recovery/06_s3_3_access_keys.md) %}

{% if audience != "external" %}
В [документации к MDS S3 API описана](https://wiki.yandex-team.ru/mds/s3-api/authorization/#sozdanieaccesskey) процедура создания и получения ключей доступа.
{% endif %}

{% include [s3_export.md](_includes/backup_and_recovery/06_s3_4_export.md) %}

{% include [s3_restore.md](_includes/backup_and_recovery/06_s3_5_restore.md) %}

{% if audience != "external" %}
Для подключения бакета можно воспользоваться одним из [клиентов](https://wiki.yandex-team.ru/mds/s3-api/s3-clients/), например s3fs.
{% endif %}

{% include [s3_forget.md](_includes/backup_and_recovery/06_s3_6_forget.md) %}

{% if audience != "external" %}

{% include [yt.md](_includes/backup_and_recovery/77_yt.md) %}

{% endif %}