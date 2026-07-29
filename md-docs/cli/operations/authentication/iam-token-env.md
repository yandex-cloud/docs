[Документация Yandex Cloud](../../../index.md) > [Интерфейс командной строки](../../index.md) > [Пошаговые инструкции](../index.md) > Аутентификация > IAM-токен из переменной окружения

# Аутентификация в Yandex Cloud CLI с IAM-токеном из переменной окружения

[IAM-токен](../../../iam/concepts/authorization/iam-token.md) — это уникальная последовательность символов, которая подтверждает личность пользователя или сервисного аккаунта и используется для аутентификации в Yandex Cloud. IAM-токен действует не больше 12 часов.

Аутентификацию с IAM-токеном из переменной окружения `YC_IAM_TOKEN` удобно использовать в скриптах, CI/CD-процессах, автоматических тестах, контейнерах и временных рабочих окружениях, где не подходит интерактивная аутентификация или хранение учетных данных в профиле CLI. Для автоматизации используйте IAM-токен [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md) с необходимыми [ролями](../../../iam/roles-reference.md). Настройте получение нового IAM-токена до истечения срока действия текущего.

{% note warning %}

Не добавляйте IAM-токен в исходный код и не выводите его в логи. Для CI/CD-процессов храните токен в защищенном хранилище секретов.

Если токен больше не нужен или был скомпрометирован, [отзовите его](../../../iam/operations/iam-token/revoke-iam-token.md).

{% endnote %}

## Перед началом работы {#before-you-begin}

1. [Установите Yandex Cloud CLI](../install-cli.md).
1. Получите IAM-токен.

    
    * [Аккаунт на Яндексе](../../../iam/operations/iam-token/create.md)
    * [Сервисный аккаунт](../../../iam/operations/iam-token/create-for-sa.md)
    * [Федеративный аккаунт](../../../iam/operations/iam-token/create-for-federation.md)
    * [Аккаунт локального пользователя](../../../iam/operations/iam-token/create-for-local.md)


## Аутентифицируйтесь с IAM-токеном {#authenticate}

1. Добавьте IAM-токен в переменную окружения `YC_IAM_TOKEN`:

    {% list tabs group=operating_system %}

    - macOS/Linux {#linux-macos}

      ```bash
      export YC_IAM_TOKEN="<IAM-токен>"
      ```

    - Windows (PowerShell) {#windows}

      ```powershell
      $env:YC_IAM_TOKEN = "<IAM-токен>"
      ```

    {% endlist %}

    Переменная будет доступна в текущем сеансе командной оболочки и запущенных из него процессах. 
    
    {% note warning %}
    
    Значение из переменной окружения `YC_IAM_TOKEN` переопределяет учетные данные для аутентификации, заданные в профиле CLI.

    {% endnote %}

1. Выполните команду CLI, например получите список виртуальных машин в каталоге:

    ```bash
    yc compute instance list
    ```

## Удалите IAM-токен из переменной окружения {#delete-token}

Чтобы в CLI снова использовались учетные данные из профиля, удалите переменную окружения `YC_IAM_TOKEN`:

{% list tabs group=operating_system %}

- macOS/Linux {#linux-macos}

  ```bash
  unset YC_IAM_TOKEN
  ```

- Windows (PowerShell) {#windows}

  ```powershell
  Remove-Item Env:YC_IAM_TOKEN
  ```

{% endlist %}

{% note warning %}

Удаление переменной окружения не прекращает действие IAM-токена.

{% endnote %}

#### Полезные ссылки {#see-also}


* [IAM-токен](../../../iam/concepts/authorization/iam-token.md)
* [Получение IAM-токена для аккаунта на Яндексе](../../../iam/operations/iam-token/create.md)
* [Получение IAM-токена для сервисного аккаунта](../../../iam/operations/iam-token/create-for-sa.md)
* [Получение IAM-токена для федеративного аккаунта](../../../iam/operations/iam-token/create-for-federation.md)
* [Получение IAM-токена для аккаунта локального пользователя](../../../iam/operations/iam-token/create-for-local.md)
* [Отзыв IAM-токена](../../../iam/operations/iam-token/revoke-iam-token.md)


* [Аутентификация в Yandex Cloud CLI с аккаунтом на Яндексе](user.md)
* [Аутентификация в Yandex Cloud CLI от имени сервисного аккаунта](service-account.md)
* [Аутентификация в Yandex Cloud CLI от имени федеративного пользователя](federated-user.md)
* [Аутентификация в Yandex Cloud CLI от имени локального пользователя](local-user.md)
* [Аутентификация в Yandex Cloud CLI на сервере без графического интерфейса](auth-without-gui.md)
* [Решение проблем с Yandex Cloud CLI](../../error.md)