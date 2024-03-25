# Получение данных для аутентификации

Чтобы аутентифицироваться в {{ yandex-cloud }} и управлять базами данных YDB с помощью {{ TF }} можно использовать [сервисный аккаунт](../../iam/concepts/users/service-accounts.md), [аккаунт на Яндексе](../../iam/concepts/index.md#passport) или [федеративный аккаунт](../../iam/concepts/index.md#saml-federation). Также для аутентификации и работы {{ TF }} с YDB понадобится интерфейс командной строки Yandex Cloud. Если у вас еще нет yc — установите его, следуя [инструкции](../../cli/quickstart.md#install).

Сервисный аккаунт можно создать и настроить, следуя следующей инструкции:
1. В консоли управления выберите каталог, в котором хотите создать сервисный аккаунт.
![folder_choice](./_includes/_screenshots/_create_iam_acc/01.png)
<br/>

1. На вкладке **Сервисные аккаунты** нажмите кнопку `Создать сервисный аккаунт`.
![create_iam_account](./_includes/_screenshots/_create_iam_acc/02.png)
<br/>

1. Введите имя сервисного аккаунта:
    * Длина имени — от 3 до 63 символов;
    * Имя может содержать строчные буквы латинского алфавита, цифры и дефисы;
    * Первым символом имени должна быть буква, а последним символом не должен быть дефис.
1. Назначьте сервисному аккаунту роли, необходимые для управления ресурсами YDB: `admin`, `ydb.admin`.
![finish_create_iam](./_includes/_screenshots/_create_iam_acc/03.png)

1. Нажмите кнопку **Создать**.

Перейдите в **Сервисный аккаунт** и создайте авторизованный ключ для аутентификации {{ TF }} в {{ yandex-cloud }}:
1. Нажмите на кнопку `Создать новый ключ` и выберете пункт `Создать авторизованный ключ`.
![create_key_pair_step_1](./_includes/_screenshots/_create_key_pair/01.png)
<br/>

1. Введите **Описание ключа** (опционально) и нажмите кнопку **Создать**. 
![create_key_pair_step_1](./_includes/_screenshots/_create_key_pair/02.png)
<br/>

1. Нажмите кнопку **Скачать файл с ключом** к себе на локальную машину.
![create_key_pair_step_1](./_includes/_screenshots/_create_key_pair/03.png)
<br/>

Теперь, последний шаг по настройке аутентификации — создание специального профиля для подключения к {{ yandex-cloud }} на локальной машине с помощью yc CLI. 

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

{{ TF }} будет использовать заданные переменные окружения для аутентификации, поэтому нужно обратить внимание на то, что время жизни `IAM-токена` не более 12 часов. После истечения времени жизни токена, {{ TF }} будет выдавать ошибку аутентификации. В таком случае нужно обновить переменную окружения – выполнить повторно команду export `YC_TOKEN=$(yc iam create-token)`. 

Процесс получения нового токена можно автоматизировать с помощью `crontab`: введите `crontab -e` и введите `0 * * * * export YC_TOKEN=$(yc iam create-token)`. Теперь `crontab` будет самостоятельно каждый час обновлять токен в рамках текущей сессии, а чтобы токен обновлялся при открытии новой сессии нужно выполнить одну из команд:
```bash
echo "export YC_TOKEN=$(yc iam create-token)" >> ~/.bashrc # Команда для bash оболочки
echo "export YC_TOKEN=$(yc iam create-token)" >> ~/.zshrc # Команда для zsh оболочки
```

На этом настройка аутентификации закончена. Можно [устанавливать и настраивать](./install.md) {{ TF }}.