# Статические ключи доступа, совместимые с AWS API


{% note info %}

Создание статических ключей доступа сервисных аккаунтов может быть запрещено [политиками авторизации](../access-control/access-policies.md) на уровне [каталога](../../../resource-manager/concepts/resources-hierarchy.md#folder), [облака](../../../resource-manager/concepts/resources-hierarchy.md#cloud) или [организации](../../../organization/concepts/organization.md).

{% endnote %}

Статический ключ доступа необходим для аутентификации [сервисного аккаунта](../users/service-accounts.md) в [AWS-совместимых API](#supported-services).

Статический ключ состоит из двух частей:

* Идентификатор ключа.
* Секретный ключ.

Обе части используются в запросах к AWS-совместимому API. Идентификатор ключа указывается в открытом виде. Секретным ключом подписывают параметры запроса. Сам секретный ключ в запросе не указывается.

Секретный ключ пользователь хранит самостоятельно. Yandex Cloud дает доступ к ключу только в процессе [создания статического ключа](../../operations/authentication/manage-access-keys.md#create-access-key).

Срок действия статического ключа не ограничен.

{% note alert %}

Исключите доступ третьих лиц к секретному ключу. Храните ключ в надежном месте. Если ключ стал известен третьим лицам, [перевыпустите](../../operations/compromised-credentials.md#access-key-reissue) его.

{% endnote %}

Чтобы обеспечивать безопасность и контроль над доступом к ресурсам, отслеживать случаи несанкционированного использования ключей, а также удалять неиспользуемые ключи без риска нарушить работу сервисов Yandex Cloud, вы можете отслеживать даты последнего использования ключей доступа сервисных аккаунтов. Информация доступна на странице сервисного аккаунта в [консоли управления](https://console.yandex.cloud), а также в поле `last_used_at` при вызове методов управления ключами доступа через API.

Помимо статических ключей доступа, для работы с Yandex Object Storage вы можете использовать временные ключи [Security Token Service](sts.md) также совместимые с AWS API.

## Формат статического ключа {#access-key-format}

### Идентификатор ключа {#key-id}

Состоит из 25 символов и всегда начинается с букв `YC`. Остальными символами могут быть:

* буквы латинского алфавита;
* цифры;
* символы `_`, `-`.

Пример идентификатора ключа: `YCchbYEDdcsYFBnxSWbcjDJDn`.

### Секретный ключ {#private-key}

Состоит из 40 символов и всегда начинается с букв `YC`. Остальными символами могут быть:

* буквы латинского алфавита;
* цифры;
* символы `_`, `-`.

Пример секретного ключа: `YCVdheub7w9bImcGAnd3dZnf08FRbvjeUFvehGvc`.

Чтобы ознакомиться с примером использования секретного ключа и его идентификатора в AWS-совместимом API, смотрите раздел [AWS Command Line Interface](../../../storage/tools/aws-cli.md#config-files).

## Сервисы, поддерживающие этот способ аутентификации {#supported-services}

Статические ключи доступа в качестве способа аутентификации поддерживают несколько сервисов:

* [Object Storage](../../../storage/s3/index.md)
* [Message Queue](../../../message-queue/api-ref/index.md)
* [Managed Service for YDB](../../../ydb/docapi/tools/aws-setup.md)
* [Yandex Data Streams](../../../data-streams/index.md)
* [Yandex Cloud Postbox](../../../postbox/aws-compatible-api/index.md)

## Примеры использования {#examples}

* [Использование секрета Yandex Lockbox для хранения статического ключа доступа](../../tutorials/static-key-in-lockbox/index.md)

#### Полезные ссылки {#see-also}

* [Создать статический ключ доступа](../../operations/authentication/manage-access-keys.md#create-access-key)
* [Как выбрать подходящий способ аутентификации в Yandex Cloud](index.md)
* [Security Token Service](sts.md)
* [Использование секрета Yandex Lockbox для хранения статического ключа доступа](../../tutorials/static-key-in-lockbox/index.md)