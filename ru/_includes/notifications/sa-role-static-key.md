Для аутентификации в {{ cns-name }} используется [статический ключ доступа](../../iam/concepts/authorization/access-key.md). Этот ключ выпускается на [сервисный аккаунт](../../iam/concepts/users/service-accounts.md), и все действия выполняются от имени этого сервисного аккаунта.

Чтобы получить статический ключ доступа:
1. [Создайте](../../iam/operations/sa/create.md) сервисный аккаунт.
1. [Назначьте](../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту [роль](../../iam/roles-reference.md#editor) `editor` на каталог.
1. Для сервисного аккаунта [создайте](../../iam/operations/sa/create-access-key.md) статический ключ доступа.

    Сохраните идентификатор и секретный ключ.
