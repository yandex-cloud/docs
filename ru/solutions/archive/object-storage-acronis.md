# Резервное копирование в [!KEYREF objstorage-full-name] через Acronis Backup Gateway

Чтобы настроить резервное копирование в [!KEYREF objstorage-name] через Acronis Backup Gateway:
1. [Создайте публичную корзину](#create-public-bucket)
1. [Настройте Acronis Backup Gateway](#configure-acronis)
1. [Протестируйте резервное копирование](#test-backup)


## 1. Создайте публичную корзину {#create-public-bucket}

Чтобы создать корзину для резервного копирования:

[!INCLUDE [create-public-bucket](../_solutions_includes/create-public-bucket.md)]

## 2. Настройте Acronis Backup Gateway {#configure-acronis}

Чтобы настроить Acronis Backup Gateway для работы с [!KEYREF objstorage-name]:

1. В Acronis Storage откройте меню **Services** и выберите пункт **Acronis Backup Gateway**.
1. Нажмите кнопку **Create Gateway**.
1. Выберите тип хранилища **Public Cloud**.
1. В списке **ABGW private** выберите сетевой интерфейс с ролью **ABGW private**.
1. В блоке **Public cloud parameters** задайте следующие настройки:
    1. Выберите тип провайдера **AuthV2 compatible**.
    1. В поле **Endpoint URL** укажите `[!KEYREF s3-storage-host]`.
    1. Получите [статический ключ](../../iam/operations/sa/create-access-key.md) и укажите его для аутентификации.
    1. Укажите корзину `backup` для хранения резервных копий.
1. В блоке **Registration** укажите данные вашего аккаунта Acronis.
1. Нажмите кнопку **DONE**.

## 3. Протестируйте резервное копирование {#test-backup}

1. Настройте резервное копирование в Acronis Backup по [инструкции](https://www.acronis.com/ru-ru/support/documentation/BackupService/index.html#33507.html).
1. Выполните резервное копирование по [инструкции](https://www.acronis.com/ru-ru/support/documentation/BackupService/index.html#33512.html).
