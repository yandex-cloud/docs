# Создание базы данных

Создайте [базу данных](../concepts/databases.md#database) с помощью сервиса {{ ydb-full-name }} в консоли управления {{ yandex-cloud }}.

## Перед началом работы {#before-you-begin}

Доступ к сервису предоставляется по заявке. Чтобы оформить заявку:
1. Войдите в [консоль управления](https://console.cloud.yandex.ru). Если вы еще не зарегистрированы, перейдите в консоль управления и следуйте инструкциям.
1. [На странице биллинга](https://console.cloud.yandex.ru/billing) убедитесь, что у вас подключен [платежный аккаунт](../../billing/concepts/billing-account.md), и он находится в статусе `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md#create_billing_account).
1. Если у вас еще нет каталога, [создайте его](../../resource-manager/operations/folder/create.md).
1. Перейдите на [страницу сервиса {{ ydb-short-name }}](https://cloud.yandex.ru/services/ydb) и нажмите кнопку **Запросить доступ**.
1. Выберите облако, в котором планируете работать с сервисом, и нажмите кнопку **Отправить**. Как только заявка будет одобрена, на вашу электронную почту придет письмо с подтверждением.
1. Откройте письмо и нажмите кнопку **Начать тестирование**. Вы будете перенаправлены в [консоль {{ yandex-cloud }}](https://console.cloud.yandex.ru/) и сможете начать работу с сервисом.

## Создайте базу данных {#control-plane}

{% if audience == "internal" %}

1. Чтобы создать базу данных, перейдите в [консоль управления](https://ydb.yandex-team.ru).

    {% include [iam](../../_includes/iam/owner-warning.md) %}

1. Нажмите кнопку **Create database**.

    ![Create database](../_assets/db_ui_create_database_button.png)

1. В поле **Cluster** выберите кластер *ydb-ru*.

    Остальные поля будут заполнены автоматически, в том числе будет автоматически выбран аккаунт *home*, создана директория с вашим именем пользователя и база данных с именем *mydb*.

    Пример создания новой базы данных:

    ![Create new database](../_assets/db_ui_create_home_database.png)

1. Нажмите кнопку **Create**.

    Появится страница с сообщением об успешном создании базы данных.

    ![New database entrance](../_assets/db_ui_entrance_home_database.png)

{% else if audience == "external" %}

{% include [create-db-via-console](../_includes/create-db-via-console.md) %}

{% endif %}