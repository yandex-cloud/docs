# Установка CLI

Вы можете устанавливать CLI в разных режимах: 
- [Интерактивная установка CLI](#interactive)
- [Неинтерактивная установка CLI](#non-interactive)

## Интерактивная установка CLI {#interactive}

{% include [install-cli](../../_includes/cli/install-cli.md) %}

Для дальнейшей работы с CLI [создайте профиль](profile/profile-create.md).

## Неинтерактивная установка CLI {#non-interactive}

Для использования CLI в скриптах можно использовать флаги для неинтерактивной установки: 

{% list tabs %}

- Bash

    Выполните команду: 
    
    ```
    $ curl https://storage.yandexcloud.net/yandexcloud-yc/install.sh | bash -s -- -h
    Usage: install [options...]
    Options:
     -i [INSTALL_DIR]    Installs to specified dir.
     -r [RC_FILE]        Automatically modify RC_FILE with PATH modification and shell completion.
     -n                  Don't modify rc file and don't ask about it.
     -a                  Automatically modify default rc file with PATH modification and shell completion.
     -h                  Prints help.
    ```
    
    Примеры использования:  
    - Установка CLI в `/opt/yandex-cloud`, без изменений в файле `.bashrc`:
    
        ```
        curl https://storage.yandexcloud.net/yandexcloud-yc/install.sh | \
            bash -s -- -i /opt/yandex-cloud -n
        ```
    - Установка CLI в директорию по умолчанию, в файл `.bashrc` добавляются `completion` и `PATH`:  
        
        ```
        curl https://storage.yandexcloud.net/yandexcloud-yc/install.sh | \
            bash -s -- -a
        ``` 

{% endlist %}

