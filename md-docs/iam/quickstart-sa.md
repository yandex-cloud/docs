# Как начать работать с сервисными аккаунтами

Сервис IAM позволяет вам создавать [_сервисные аккаунты_](concepts/users/service-accounts.md) — дополнительные аккаунты, с помощью которых программы могут выполнять операции в Yandex Cloud. Сервисные аккаунты бесплатны и позволяют гибко управлять доступами ваших программ. Подробнее в разделе [Сервисные аккаунты](concepts/users/service-accounts.md).

Эта инструкция для [владельцев облака](../resource-manager/concepts/resources-hierarchy.md#owner) и пользователей с ролью [администратора](roles-reference.md#admin) на облако или каталог. Пользователи с ролью [`editor`](roles-reference.md#editor) тоже могут создавать сервисные аккаунты, но не могут назначать роли, поэтому не смогут разрешить сервисному аккаунту выполнение операций в Yandex Cloud.

{% note info %}

Создание сервисных аккаунтов и их [ключей](concepts/users/service-accounts.md#sa-key) может быть запрещено [политиками авторизации](concepts/access-control/access-policies.md) на уровне [каталога](../resource-manager/concepts/resources-hierarchy.md#folder), [облака](../resource-manager/concepts/resources-hierarchy.md#cloud) или [организации](../organization/concepts/organization.md).

{% endnote %}

Проверка наличия необходимых ролей описана в разделе [Перед началом работы](#before-you-begin).

Вы научитесь:

* [Создавать сервисные аккаунты и назначать им роли](#create-sa).
* [Выполнять операции в CLI](#run-operation-from-sa).
* [Удалять сервисные аккаунты](#delete-sa).

## Перед началом работы {#before-you-begin}

1. Войдите в [консоль управления](https://console.yandex.cloud). Если вы еще не зарегистрированы, перейдите в консоль управления и следуйте инструкциям.
1. Убедитесь, что у вас есть нужные [роли](concepts/access-control/roles.md):

    1. В консоли управления на панели сверху нажмите ![image](../_assets/console-icons/layout-side-content-left.svg) или ![image](../_assets/console-icons/chevron-down.svg) и выберите нужное облако.
    1. Перейдите на вкладку **Права доступа**.
    1. В строке поиска введите свою учетную запись.
    1. Проверьте, что для вашей учетной записи указаны роли:

        * владельца (`organization-manager.organizations.owner`) или администратора (`organization-manager.admin`) организации;
        * владельца (`resource-manager.clouds.owner`) или администратора (`admin`) облака.

1. На странице [**Yandex Cloud Billing**](https://center.yandex.cloud/billing/accounts) убедитесь, что у вас подключен [платежный аккаунт](../billing/concepts/billing-account.md) и он находится в статусе `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../billing/quickstart/index.md#create_billing_account).

## Создайте сервисный аккаунт {#create-sa}

Чтобы создать сервисный аккаунт и назначить ему роли:

1. В [консоли управления](https://console.yandex.cloud) на панели сверху нажмите ![image](../_assets/console-icons/layout-side-content-left.svg) или ![image](../_assets/console-icons/chevron-down.svg) и выберите нужный [каталог](../resource-manager/concepts/resources-hierarchy.md#folder).
1. На панели слева нажмите ![image](../_assets/console-icons/dots-9.svg) и выберите **Identity and Access Management**.
1. Нажмите кнопку **Создать сервисный аккаунт**.
1. Введите имя сервисного аккаунта.

   Требования к формату имени:

   * длина — от 3 до 63 символов;
   * может содержать строчные буквы латинского алфавита, цифры и дефисы;
   * первый символ — буква, последний — не дефис.

   Имя сервисного аккаунта должно быть уникальным в рамках облака.

1. Чтобы назначить сервисному аккаунту [роль](concepts/access-control/roles.md) на текущий каталог, нажмите **Добавить роль** и выберите роль, например `editor`.

   Чтобы назначить роль на другой ресурс, воспользуйтесь CLI или API по инструкции [Назначение роли сервисному аккаунту](operations/sa/assign-role-for-sa.md).

1. Нажмите кнопку **Создать**.

{% note info %}

Использовать созданный вами сервисный аккаунт могут и другие пользователи. Для этого [назначьте](operations/sa/set-access-bindings.md#assign-role-to-sa) им необходимые [роли](security/index.md#service-roles) на этот аккаунт.

{% endnote %}

## Настройте CLI для работы от имени сервисного аккаунта {#run-operation-from-sa}

От имени сервисного аккаунта вы можете выполнять операции через интерфейс командной строки Yandex Cloud (CLI), API и другие инструменты, которые поддерживают аутентификацию с сервисным аккаунтом.

Настройте CLI для работы от имени сервисного аккаунта:

1. Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../cli/quickstart.md#install).
1. По умолчанию используется каталог, указанный при [создании](../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.
1. Получите список доступных сервисных аккаунтов в каталоге по умолчанию:

    ```bash
    yc iam service-account list
    ```

    Результат:

    ```bash
    +----------------------+----------+--------+
    |          ID          |   NAME   | LABELS |
    +----------------------+----------+--------+
    | ajeb9l33h6mu******** | my-robot |        |
    +----------------------+----------+--------+
    ```

1. Создайте [авторизованный ключ](concepts/authorization/key.md) для вашего сервисного аккаунта и запишите его в файл:

    ```bash
    yc iam key create --output <путь_к_файлу_ключа> --service-account-name <имя_сервисного_аккаунта>
    ```

    Где:

    * `--output` — путь к файлу для записи авторизованного ключа в формате JSON. Обязательный параметр.
    * `--service-account-name` — имя сервисного аккаунта.

     Например:

     ```bash
     yc iam key create --output key.json --service-account-name my-service-account
     ```

     Результат:

     ```bash
     id: aje4lue48687********
     service_account_id: ajeb9l33h6m********
     created_at: "2024-08-01T11:58:52.313177213Z"
     key_algorithm: RSA_2048
     ```

    Подробнее о команде `yc iam key create` читайте в [справочнике CLI](../cli/cli-ref/iam/cli-ref/service-account/create.md).

1. Создайте профиль, который будет использоваться для выполнения операций от имени сервисного аккаунта:

    ```bash
    yc config profile create <имя_профиля>
    ```

1. Укажите в конфигурации профиля авторизованный ключ сервисного аккаунта:

    ```bash
    yc config set service-account-key <путь_к_файлу_ключа>
    ```

Теперь вы можете выполнять операции от имени сервисного аккаунта, например посмотреть список каталогов, доступных этому аккаунту:

```bash
yc resource-manager folder list
```

## Удалите сервисный аккаунт {#delete-sa}

Если сервисный аккаунт больше не нужен, удалите его:

1. В [консоли управления](https://console.yandex.cloud) на панели сверху нажмите ![image](../_assets/console-icons/layout-side-content-left.svg) или ![image](../_assets/console-icons/chevron-down.svg) и выберите нужный [каталог](../resource-manager/concepts/resources-hierarchy.md#folder).
1. На панели слева нажмите ![image](../_assets/console-icons/dots-9.svg) и выберите **Identity and Access Management**.
1. На панели слева выберите ![FaceRobot](../_assets/console-icons/face-robot.svg) **Сервисные аккаунты**.
1. В строке с нужным сервисным аккаунтом нажмите значок ![image](../_assets/console-icons/ellipsis.svg) и выберите **Удалить**.
1. В открывшемся окне нажмите кнопку **Удалить**.

## Что дальше {#what-is-next}

* [Пошаговые инструкции](operations/index.md) помогут вам решить конкретные задачи, возникающие при использовании Identity and Access Management.
* [Подробнее про сервисные аккаунты](concepts/users/service-accounts.md) написано в концепциях.
* Посмотрите [рекомендации по безопасному использованию сервисных аккаунтов](best-practices/using-iam-securely.md#use-sa).
* Используйте [чеклист безопасности аутентификации и авторизации](../security/domains/iam-checklist.md).