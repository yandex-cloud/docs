# Получение данных для аутентификации

Чтобы аутентифицироваться в Yandex Cloud и управлять базами данных YDB с помощью Terraform, можно использовать [сервисный аккаунт](../../iam/concepts/users/service-accounts.md), [аккаунт на Яндексе](../../iam/concepts/users/accounts.md#passport), [локальный](../../iam/concepts/users/accounts.md#local) или [федеративный](../../iam/concepts/users/accounts.md#saml-federation) аккаунт. Также для аутентификации и работы Terraform с YDB понадобится интерфейс командной строки Yandex Cloud. Если у вас еще нет CLI — установите его, следуя [инструкции](../../cli/quickstart.md#install).

Сервисный аккаунт можно [создать](../../iam/operations/sa/create.md) и настроить, следуя следующей инструкции:

1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором хотите создать сервисный аккаунт.
1. В списке сервисов выберите **Identity and Access Management**.
1. Нажмите кнопку **Создать сервисный аккаунт**.
1. Введите имя сервисного аккаунта:
    * Длина имени — от 3 до 63 символов;
    * Имя может содержать строчные буквы латинского алфавита, цифры и дефисы;
    * Первым символом имени должна быть буква, а последним символом не должен быть дефис.
1. Назначьте сервисному аккаунту роли, необходимые для управления ресурсами YDB: `admin`, `ydb.admin`.
![finish_create_iam](_includes/_screenshots/_create_iam_acc/03.png)

1. Нажмите кнопку **Создать**.

Перейдите в **Сервисный аккаунт** и создайте авторизованный ключ для аутентификации Terraform в Yandex Cloud:
1. Нажмите на кнопку `Создать новый ключ` и выберете пункт `Создать авторизованный ключ`.
![create_key_pair_step_1](_includes/_screenshots/_create_key_pair/01.png)
<br/>

1. Введите **Описание ключа** (опционально) и нажмите кнопку **Создать**. 
![create_key_pair_step_1](_includes/_screenshots/_create_key_pair/02.png)
<br/>

1. Нажмите кнопку **Скачать файл с ключом** к себе на локальную машину.
![create_key_pair_step_1](_includes/_screenshots/_create_key_pair/03.png)
<br/>

Теперь, последний шаг по настройке аутентификации — создание специального профиля для подключения к Yandex Cloud на локальной машине с помощью Yandex Cloud CLI.

Выполните следующие команды:
1. Создайте профиль `yc` для выполнения операций от имени сервисного аккаунта. Укажите имя профиля: `yc config profile create <имя_профиля>`. В терминал будет выведено следующие сообщение: `Profile '<имя_профиля>' created and activated.`
1. Задайте конфигурацию профиля следующими командами:
    ```bash
    yc config set service-account-key <загруженный_ключ>
    yc config set cloud-id <идентификатор_облака>
    yc config set folder-id <идентификатор_каталога>
    ```

Описание значения параметров команд:
* `service-account-key` — файл с авторизованным ключом сервисного аккаунта в формате JSON.
* `cloud-id` — [идентификатор облака](../../resource-manager/operations/cloud/get-id.md).
* `folder-id` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md).

Добавьте аутентификационные данные в переменные окружения:

{% list tabs group=programming_language %}

- Bash {#bash}

    ```bash
    export YC_TOKEN=$(yc iam create-token)
    export YC_CLOUD_ID=$(yc config get cloud-id)
    export YC_FOLDER_ID=$(yc config get folder-id)
    ```

- PowerShell {#powershell}

    ```powershell
    $Env:YC_TOKEN=$(yc iam create-token)
    $Env:YC_CLOUD_ID=$(yc config get cloud-id)
    $Env:YC_FOLDER_ID=$(yc config get folder-id)
    ```
{% endlist %}    

Terraform будет использовать заданные переменные окружения для аутентификации, поэтому нужно обратить внимание на то, что время жизни `IAM-токена` не более 12 часов. После истечения времени жизни токена, Terraform будет выдавать ошибку аутентификации. В таком случае нужно обновить переменную окружения — выполнить повторно команду export `YC_TOKEN=$(yc iam create-token)`. 

Процесс получения нового токена можно автоматизировать с помощью `crontab`: введите `crontab -e` и введите `0 * * * * export YC_TOKEN=$(yc iam create-token)`. Теперь `crontab` будет самостоятельно каждый час обновлять токен в рамках текущей сессии, а чтобы токен обновлялся при открытии новой сессии нужно выполнить одну из команд:
```bash
echo "export YC_TOKEN=$(yc iam create-token)" >> ~/.bashrc # Команда для bash оболочки
echo "export YC_TOKEN=$(yc iam create-token)" >> ~/.zshrc # Команда для zsh оболочки
```

На этом настройка аутентификации закончена. Можно [устанавливать и настраивать](install.md) Terraform.