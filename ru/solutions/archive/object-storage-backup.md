# Резервное копирование в Object Storage через Acronis Backup Gateway

## Создать публичную корзину {#create-public-bucket}

Чтобы создать корзину для резервного копирования:

1. Перейдите в [консоль управления](https://console.cloud.yandex.ru) Яндекс.Облака и выберите каталог, в котором будете выполнять операции.
1. На странице каталога нажмите кнопку **Создать ресурс** и выберите **Корзина**.
1. В поле **Имя** введите имя корзины, например, `backup`. 

   Имя должно удовлетворять требованиям:
   
   [!INCLUDE [bucket-name-reqs](../../_includes/bucket-name-reqs.md)]
   
1. Укажите максимальный размер корзины в ГБ.
1. Выберите **Публичный** доступ к корзине.
1. Нажмите кнопку **Создать корзину**.

## Настроить Acronis Backup Gateway

Чтобы настроить Acronis Backup Gateway для работы с Object Storage:

1. В Acronis Storage откройте меню **Services** и выберите пункт **Acronis Backup Gateway**.
1. Нажмите кнопку **Create Gateway**.
1. Выберит тип хранилища **Public Cloud**.
1. В списке **ABGW private** выберите сетевой интерфейс с ролью **ABGW private**.
1. В блоке **Public cloud parameters** задайте следующие настройки:
    1. Выберите тип провайдера **AuthV2 compatible**.
    1. В поле **Endpoint URL** укажите `storage.api.cloud.yandex.net`.
    1. Получите [статический ключ](../../storage/operations/security/get-static-key.md) и выберите его для аутентификации.
    1. Укажите корзину `backup` для хранения резервных копий.
1. Заполните регистрационные данные вашего аккаунта Acronis.
1. Нажмите кнопку **DONE**.

## Проверить резервное копирование

1. Настройте резервное копирование в Acronis Backup по [инструкции](https://www.acronis.com/ru-ru/support/documentation/BackupService/index.html#33507.html).
1. Выполните резервное копирование по [инструкции](https://www.acronis.com/ru-ru/support/documentation/BackupService/index.html#33512.html).