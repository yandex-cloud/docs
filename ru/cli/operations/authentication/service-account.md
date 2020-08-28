# Аутентификация от имени сервисного аккаунта

Узнайте как аутентифицироваться в CLI:
- [От имени сервисного аккаунта](#auth-as-sa).
- [От имени сервисного аккаунта изнутри виртуальной машины](#vm-auth-as-sa).

## Перед началом работы {#before-begin}

1. [Аутентифицируйтесь в CLI как пользователь](user.md).
1. Если у вас еще нет сервисного аккаунта, [создайте его](../../../iam/operations/sa/create.md) и [настройте права доступа для него](../../../iam/operations/sa/assign-role-for-sa.md).

## Аутентифицируйтесь от имени сервисного аккаунта {#auth-as-sa}

1. Получите список сервисных аккаунтов, которые существуют в вашем облаке:

    ```
    $ yc iam service-account --folder-id <ID каталога> list
    +----------------------+------------+
    |          ID          |    NAME    |
    +----------------------+------------+
    | aje3932acd0c5ur7dagp | default-sa |
    +----------------------+------------+
    ```
1. Создайте авторизованный ключ для сервисного аккаунта и сохраните его в файл `key.json`:

    ```
    $ yc iam key create --service-account-name default-sa --output key.json
    id: aje83v701b1un777sh40
    service_account_id: aje3932acd0c5ur7dagp
    created_at: "2019-08-26T12:31:25Z"
    key_algorithm: RSA_2048
    ```
1. Добавьте авторизованный ключ сервисного аккаунта в профиль CLI.

    1. Создайте новый профиль CLI:

        ```
        $ yc config profile create sa-profile
        ```
    1. Добавьте авторизованный ключ:

        ```
        $ yc config set service-account-key key.json
        ```
1. Проверьте, что параметры для сервисного аккаунта добавлены верно:

    ```
    $ yc config list
    service-account-key:
      id: aje83v701b1un777sh40
      service_account_id: aje3932acd0c5ur7dagp
      created_at: "2019-08-26T12:31:25Z"
      key_algorithm: RSA_2048
      public_key: |
        -----BEGIN PUBLIC KEY-----
        MIIBIjANBg...
        -----END PUBLIC KEY-----
      private_key: |
        -----BEGIN PRIVATE KEY-----
        MIIEvwIBAD...
        -----END PRIVATE KEY-----
    ```
1. Настройте профиль для запуска команд.

    {% include [add-folder](../../../_includes/cli-add-folder.md) %}


## Аутентифицируйтесь от имени сервисного аккаунта изнутри виртуальной машины {#vm-auth-as-sa}

Для сервисного аккаунта процесс аутентификации изнутри виртуальной машины упрощен:
1. [Привяжите сервисный аккаунт](../../../compute/operations/vm-connect/auth-inside-vm.md#link-sa-with-instance) к виртуальной машине.
1. Аутентифицируйтесь изнутри виртуальной машины:
    1. Подключитесь к виртуальной машине [по SSH](../../../compute/operations/vm-connect/ssh.md) или [по RDP](../../../compute/operations/vm-connect/rdp.md).
    1. {% include [cli-install](../../../_includes/cli-install.md) %}
    1. Создайте новый профиль:

        ```
        yc config profile create my-robot-profile
        ```
1. Настройте профиль для запуска команд.

    {% include [add-folder](../../../_includes/cli-add-folder.md) %}


Подробная информация про работу с {{ yandex-cloud }} из ВМ в разделе [{#T}](../../../compute/operations/vm-connect/auth-inside-vm.md).

#### См. также

- [{#T}](../../concepts/index.md#manage-properties).
- [{#T}](../profile/profile-create.md).
- [{#T}](../profile/profile-activate.md).
- [{#T}](../profile/manage-properties.md).
- [{#T}](../../../compute/operations/vm-connect/auth-inside-vm.md).

