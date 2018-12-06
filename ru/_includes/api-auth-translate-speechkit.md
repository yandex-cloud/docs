# Авторизация в API

Запросы к API могут выполнять пользователи от имени аккаунта Яндекс.Паспорта или сервисного аккаунта.

**Чтобы воспользоваться API:**

1. Зарегистрируйтесь в Яндекс.Облаке.

   Подробнее читайте в разделе [Начало работы](../billing/quickstart/index.md) документации про Биллинг.
1. Определите необходимые [роли](../iam/concepts/access-control/roles.md) для аккаунта, от имени которого будут выполняться запросы к API. Выберите один из вариантов:
    * роль `resource-manager.cloud.owner` на облако;
    * пара ролей `resource-manager.cloud.member` на облако и `admin` на облако или каталог;
    * пара ролей `resource-manager.cloud.member` на облако и `editor` на облако или каталог.

1. Назначьте выбранные роли на аккаунт:
    * [Инструкция](../resource-manager/operations/cloud/set-access-bindings.md), как назначить роль на облако.
    * [Инструкция](../resource-manager/operations/folder/set-access-bindings.md), как назначить роль на облако.

1. Если у вас уже есть каталог в Яндекс.Облаке, откройте страницу этого каталога в консоли управления.

    > [!NOTE]
    >
    > Если вы назначили пользователю роль `admin` или `editor` на определенный каталог, на этом шаге выберите именно этот каталог.
    >

    Если каталога нет, создайте его:

    [!INCLUDE [create-folder](create-folder.md)]

1. Получите идентификатор каталога, например из в URL страницы каталога в консоли управления. В URL `https://console.cloud.yandex.ru/folders/b5gfc3ntettogerelqed7p` идентификатор каталога — это `b5gfc3ntettogerelqed7p`.
1. Получите IAM-токен:
    * [Инструкция](../iam/operations/iam-token/create.md) для аккаунта Яндекс.Паспорта.
    * [Инструкция](../iam/operations/iam-token/create-for-sa.md) для сервисного аккаунта.
1. В каждом API запросе к сервису передавайте:
    * IAM-токен в заголовке `Authorization` в формате `Authorization: Bearer <IAM-token>`.
    * Идентификатор каталога в параметре `folderId` в теле запроса в формате `folderId=<folder id>`.


