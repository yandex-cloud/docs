# Авторизация в API

Запросы к API могут выполнять пользователи от имени аккаунта на Яндексе или сервисного аккаунта.

**Чтобы воспользоваться API:**

1. Зарегистрируйтесь в Яндекс.Облаке.

   Подробнее читайте в разделе [Начало работы](../billing/quickstart/index.md) документации про Биллинг.
1. Определите необходимые [роли](../iam/concepts/access-control/roles.md) для аккаунта, от имени которого будут выполняться запросы к API. Выберите один из вариантов:
    * роль `resource-manager.cloud.owner` на облако;
    * пара ролей `resource-manager.cloud.member` на облако и `admin` на облако или каталог;
    * пара ролей `resource-manager.cloud.member` на облако и `editor` на облако или каталог.

    Для сервисного аккаунта необязательно назначать роль `resource-manager.cloud.member`.

1. Назначьте выбранные роли аккаунту:
    * [Инструкция](../resource-manager/operations/cloud/set-access-bindings.md), как назначить роль на облако.
    * [Инструкция](../resource-manager/operations/folder/set-access-bindings.md), как назначить роль на каталог.

1. Если у вас уже есть каталог в Яндекс.Облаке, откройте страницу этого каталога в консоли управления.

    {% note info %}

    Если вы назначили пользователю роль `admin` или `editor` на определенный каталог, на этом шаге выберите именно этот каталог.

    {% endnote %}

    Если каталога нет, создайте его:

    {% include [create-folder](create-folder.md) %}

1. Получите идентификатор каталога, например из URL страницы каталога в консоли управления:
    ```
    https://console.cloud.yandex.ru/folders/b5gfc3ntettogerelqed7p
    ```
    `b5gfc3ntettogerelqed7p` — это идентификатор каталога.
1. Получите IAM-токен:
    * [Инструкция](../iam/operations/iam-token/create.md) для аккаунта на Яндексе.
    * [Инструкция](../iam/operations/iam-token/create-for-sa.md) для сервисного аккаунта.
1. В каждом API запросе к сервису передавайте:
    * IAM-токен в заголовке `Authorization` в формате `Authorization: Bearer <IAM-token>`.
    * Идентификатор каталога в параметре `folderId` в теле запроса в формате `folderId=<folder id>`.


