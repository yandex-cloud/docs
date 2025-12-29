{% list tabs group=operating_system %}

- Linux/macOS {#linux}

  * С помощью [файла](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html) `credentials`, который нужно поместить в директорию `~/.aws/`:

      1. Создайте директорию:

          ```bash
          mkdir ~/.aws
          ```

      1. Создайте файл `credentials` со следующим содержимым:

          ```text
          [default]
          aws_access_key_id = <идентификатор_ключа>
          aws_secret_access_key = <секретный_ключ>
          ```

          Если файл с ключом находится в другом месте, передайте путь к нему в параметре `--shared-config` при монтировании бакета:

          ```bash
          geesefs \
            --shared-config <путь_к_файлу_с_ключом> \
            <имя_бакета> <точка_монтирования>
          ```

          Структура файла с ключом должна быть аналогична `~/.aws/credentials`.

  * С помощью переменных окружения:

    ```bash
    export AWS_ACCESS_KEY_ID=<идентификатор_ключа>
    export AWS_SECRET_ACCESS_KEY=<секретный_ключ>
    ```

  {% note info %}

  Вы можете использовать команду `geesefs` с правами суперпользователя (`sudo`). В этом случае обязательно передавайте информацию о ключе либо в параметре `--shared-config`, либо с помощью переменных окружения.

  {% endnote %}

- Windows {#windows}

  * С помощью [файла](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html) `credentials`, который нужно поместить в папку `users/<текущий_пользователь>/.aws/`:

    ```text
    [default]
    aws_access_key_id = <идентификатор_ключа>
    aws_secret_access_key = <секретный_ключ>
    ```

    Если файл с ключом находится в другом месте, передайте путь к нему в параметре `--shared-config` при монтировании бакета:

    ```cmd
    geesefs ^
      --shared-config <путь_к_файлу_с_ключом> ^
      <имя_бакета> <точка_монтирования>
    ```

    Структура файла с ключом должна быть аналогична `~/.aws/credentials`.

    В качестве точки монтирования укажите существующую папку.

  * С помощью переменных окружения:

    ```cmd
    set AWS_ACCESS_KEY_ID=<идентификатор_ключа>
    set AWS_SECRET_ACCESS_KEY=<секретный_ключ>
    ```

{% endlist %}

При работе с GeeseFS на виртуальной машине {{ compute-name }}, к которой [привязан сервисный аккаунт](../../compute/operations/vm-connect/auth-inside-vm.md#link-sa-with-instance), вы можете включить упрощенную аутентификацию, без статического ключа доступа. Для этого при монтировании бакета используйте параметр `--iam`.