# Как выбрать подходящий способ аутентификации в Yandex Cloud

Пользователи и [сервисные аккаунты](../users/service-accounts.md) получают разрешения на выполнение действий с ресурсами Yandex Cloud вместе с [ролями](../../roles-reference.md) на эти ресурсы. Сервис Identity and Access Management проверяет наличие необходимых разрешений, когда пользователь или сервисный аккаунт выполняет операцию с ресурсом Yandex Cloud.

Подробнее о назначении ролей и проверке списка разрешений читайте в разделе [Как устроено управление доступом в Yandex Cloud](../access-control/index.md).

{% note info %}

Создание сервисных аккаунтов и их [ключей](../users/service-accounts.md#sa-key) может быть запрещено [политиками авторизации](../access-control/access-policies.md) на уровне [каталога](../../../resource-manager/concepts/resources-hierarchy.md#folder), [облака](../../../resource-manager/concepts/resources-hierarchy.md#cloud) или [организации](../../../organization/concepts/organization.md).

{% endnote %}

Для аутентификации используйте подходящий тип учетных данных:

* [IAM-токен](iam-token.md) — рекомендуемый и наиболее безопасный тип. Подходит для большинства операций, например для [создания виртуальной машины](../../../compute/operations/vm-create/create-linux-vm.md). Не работает в отдельных сервисах или API, где предполагается использование других типов учетных данных.

    Можно настроить автоматический перевыпуск IAM-токенов с помощью [refresh-токенов](refresh-token.md) для пользователей с любым типом [аккаунта](../users/accounts.md). Это позволит им работать в [Yandex Cloud CLI](../../../cli/index.md) без необходимости повторно аутентифицироваться в браузере по истечении срока жизни IAM-токена.
* [API-ключ](api-key.md) — применяется для [сервисов](api-key.md#supported-services), которые не поддерживают аутентификацию с помощью IAM-токенов. API-ключ можно ограничить по [сроку и области действия](api-key.md#scoped-api-keys).
* [Статический ключ доступа](access-key.md) — подходит для аутентификации в сервисах с AWS-совместимым API, например в [Yandex Object Storage](../../../storage/index.md) и [Yandex Managed Service for YDB](../../../ydb/index.md). На основе статического ключа можно создать [временный ключ доступа](sts.md) к бакетам Object Storage.
* [Авторизованный ключ](key.md) — применяется в сценариях, где нужно контролировать все этапы получения IAM-токена. Это может потребоваться при получении IAM-токена для [сервисного аккаунта](../../operations/iam-token/create-for-sa.md#via-jwt). Авторизованный ключ используется непосредственно для аутентификации только приложениями из [Yandex Cloud Marketplace](https://yandex.cloud/ru/marketplace).
* [OAuth-токен](oauth-token.md) — используется для получения IAM-токена от имени пользователя с [аккаунтом на Яндексе](../users/accounts.md#passport).
* [ID-токен](id-token.md) — используется для аутентификации сервисного аккаунта Yandex Cloud в сторонних системах с поддержкой [OIDC](https://ru.wikipedia.org/wiki/OpenID). Не подходит для аутентификации внутри Yandex Cloud.
* [Cookie](cookie.md) — используется только для служебных целей.


#### См. также {#see-also}

[Аккаунты в Yandex Cloud](../users/accounts.md)