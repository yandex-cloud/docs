1. Посмотрите описание команды CLI для создания бакета:

    ```bash
    yc storage bucket create --help
    ```

1. Создайте бакет в каталоге по умолчанию:

    ```bash
    yc storage bucket create --name <имя_бакета>
    ```

    Где `--name` — имя бакета. Обязательный параметр. Подробнее см. [Правила именования бакетов](../../storage/concepts/bucket.md#naming).

    
    По умолчанию бакет с точкой в имени доступен только по протоколу HTTP. Чтобы поддержать для бакета протокол HTTPS, [загрузите](../../storage/operations/hosting/certificate.md) собственный сертификат безопасности в {{ objstorage-name }}.


    Результат:

    ```text
    name: example
    folder_id: b1gmit33ngp6********
    anonymous_access_flags:
    read: false
    list: false
    default_storage_class: STANDARD
    versioning: VERSIONING_DISABLED
    max_size: "53687091200"
    acl: {}
    created_at: "2022-12-16T14:05:12.196007Z"
    ```

    {% cut "Опциональные параметры" %}

    * `--default-storage-class` — [класс хранилища](../../storage/concepts/storage-class.md). Доступные значения:
    * `standard` — стандартное хранилище. Устанавливается по умолчанию.
    * `cold` — холодное хранилище.
    * `ice` — ледяное хранилище.

    Более <q>холодные</q> классы предназначены для длительного хранения [объектов](../../storage/concepts/object.md), работать с которыми планируется реже. Чем <q>холоднее</q> хранилище, тем дешевле хранить в нем данные, но тем дороже их читать и записывать.

    * `--max-size` — максимальный размер бакета в байтах. Значение по умолчанию — `0` (без ограничений).
    * Параметры для включения [публичного доступа](../../storage/security/public-access.md) к бакету:
    * `--public-read` — включить публичный доступ на чтение объектов в бакете.
    * `--public-list` — включить публичный доступ на просмотр списка объектов в бакете.
    * `--public-config-read` — включить публичный доступ на чтение настроек в бакете.

    По умолчанию публичный доступ к бакету выключен.

    {% include [public-access-warning](./security/public-access-warning.md) %}

    * Параметры для настройки [ACL](../../storage/concepts/acl.md) бакета:
    * `--acl` — предопределенный ACL. Список возможных значений см. в разделе [Предопределенные ACL](../../storage/concepts/acl.md#predefined-acls). Нельзя использовать одновременно с параметром `--grants`.
    * `--grants` — настройки разрешений для отдельных пользователей, [сервисных аккаунтов](../../iam/concepts/users/service-accounts.md), [групп пользователей](../../organization/concepts/groups.md) и [публичных групп](../../storage/concepts/acl.md#public-groups) (группа всех пользователей интернета, группа всех аутентифицированных пользователей {{ yandex-cloud }}). Нельзя использовать одновременно с параметром `--acl`. Значение параметра указывается в формате: `grant-type=<тип_получателя_разрешения>,grantee-id=<идентификатор_получателя>,permission=<тип_разрешения>`, где:
        * `grant-type` — тип получателя разрешения. Возможные значения:
        * `grant-type-account` — пользователь, [сервисный аккаунт](../../iam/concepts/users/service-accounts.md) или [группа пользователей](../../organization/concepts/groups.md);
        * `grant-type-all-authenticated-users` — [публичная группа](../../storage/concepts/acl.md#public-groups) всех аутентифицированных пользователей {{ yandex-cloud }};
        * `grant-type-all-users` — публичная группа всех пользователей интернета.
        * `grantee-id` — идентификатор пользователя, сервисного аккаунта или группы пользователей, которым нужно дать разрешение. Указывается, только если `grant-type=grant-type-account`.
        * `permission` — тип разрешения ACL. Возможные значения: `permission-full-control`, `permission-write`, `permission-read`. Подробнее о разрешениях см. в разделе [Виды разрешений](../../storage/concepts/acl.md#permissions-types).

        Чтобы настроить несколько разрешений, укажите параметр `--grants` несколько раз.

    По умолчанию для каждого нового бакета создается пустой ACL.

    {% endcut %}

    Подробнее о команде `yc storage bucket create` см. в [Справочнике YC CLI](../../cli/cli-ref/storage/cli-ref/bucket/create.md).