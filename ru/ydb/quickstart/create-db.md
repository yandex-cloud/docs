# Создание базы данных

Создайте [базу данных](../concepts/databases.md#database) с помощью сервиса {{ ydb-full-name }} в консоли управления {{ yandex-cloud }}.

## Перед началом работы {#before-you-begin}

Чтобы начать работать в {{ yandex-cloud }}:

1. Войдите в [консоль управления]({{ link-console-main }}). Если вы еще не зарегистрированы, перейдите в консоль управления и следуйте инструкциям.
1. [На странице биллинга]({{ link-console-billing }}) убедитесь, что у вас подключен {% if deploy != "arc" %}[платежный аккаунт](../../billing/concepts/billing-account.md){% else %}платежный аккаунт{% endif %}, и он находится в статусе `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, {% if deploy != "arc" %}[создайте его](../../billing/quickstart/index.md#create_billing_account){% else %}создайте его{% endif %}.
1. Если у вас еще нет каталога, {% if deploy != "arc" %}[создайте его](../../resource-manager/operations/folder/create.md){% else %}создайте его{% endif %}.

## Создайте базу данных {#control-plane}

{% if audience == "internal" %}

1. Чтобы создать базу данных, перейдите в [консоль управления](https://ydb.yandex-team.ru).

    {% if deploy != "arc" %}

    {% include [iam](../../_includes/iam/owner-warning.md) %}

    {% endif %}

1. Нажмите кнопку **Create database**.

    ![Create database](../../_assets/ydb/db_ui_create_database_button.png)

1. В поле **Cluster** выберите кластер *ydb-ru*.

    Остальные поля будут заполнены автоматически, в том числе будет автоматически выбран аккаунт *home*, создана директория с вашим именем пользователя и база данных с именем *mydb*.

    Пример создания новой базы данных:

    ![Create new database](../../_assets/ydb/db_ui_create_home_database.png)

1. Нажмите кнопку **Create**.

    Появится страница с сообщением об успешном создании базы данных.

    ![New database entrance](../../_assets/ydb/db_ui_entrance_home_database.png)

{% else if audience == "external" %}

Вы можете создать базу данных в бессерверной (Serverless) конфигурации или с выделенными серверами (Dedicated). Подробнее о различиях в конфигурациях читайте в разделе [{#T}](../concepts/serverless_and_dedicated.md).

{% note info %}

Для работы в режиме совместимости с Amazon DynamoDB используйте бессерверную (Serverless) конфигурацию БД.

{% endnote %}

{% include [create-db-via-console](../_includes/create-db-via-console.md) %}

{% endif %}
