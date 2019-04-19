## Перед началом работы

Перейдите в [консоль](https://console.cloud.yandex.ru) Яндекс.Облака и выберите каталог, в котором будете выполнять операции. Если такого каталога нет, создайте его:

---

**[!TAB Консоль управления]**

[!INCLUDE [create-folder](create-folder.md)]

**[!TAB CLI]**

[!INCLUDE [cli-install](cli-install.md)]

1. Посмотрите описание команды создания каталога:

    ```
    $ yc resource-manager folder create --help
    ```

2. Создайте новый каталог:

    * с именем и без описания:
        ```
        $ yc resource-manager folder create \
            --name new-folder
        ```

        [!INCLUDE [name-format](name-format.md)]

    * с именем и описанием:

        ```
        $ yc resource-manager folder create \
            --name new-folder \
            --description "my first folder with description"
        ```

**[!TAB API]**

Чтобы создать каталог, воспользуйтесь методом [create](../resource-manager/api-ref/Folder/create.md) для ресурса [Folder](../resource-manager/api-ref/Folder/index.md) сервиса [!KEYREF resmgr-full-name].

---
