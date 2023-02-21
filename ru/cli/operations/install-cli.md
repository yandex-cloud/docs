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
    curl https://{{ s3-storage-host }}{{ yc-install-path }} | bash -s -- -h
    Usage: install [options...]
    Options:
     -i [INSTALL_DIR]    Installs to specified dir.
     -r [RC_FILE]        Automatically modify RC_FILE with PATH modification and shell completion.
     -n                  Don't modify rc file and don't ask about it.
     -a                  Automatically modify default rc file with PATH modification and shell completion.
     -h                  Prints help.
    ```
    
    Примеры использования:  
    - Установка CLI в `/opt/yc`, без изменений в файле `.bashrc`:
    
        ```
        curl https://{{ s3-storage-host }}{{ yc-install-path }} | \
            bash -s -- -i /opt/yc -n
        ```
    - Установка CLI в директорию по умолчанию, в файл `.bashrc` добавляются `completion` и `PATH`:  
        
        ```
        curl https://{{ s3-storage-host }}{{ yc-install-path }} | \
            bash -s -- -a
        ``` 

{% endlist %}

