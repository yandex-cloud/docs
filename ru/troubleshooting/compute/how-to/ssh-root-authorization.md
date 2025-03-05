# Как подключиться по SSH от root с паролем или ключом


## Описание сценария {#case-description}

Необходимо подключиться по SSH от root с паролем или ключом. 

## Решение {#case-resolution}

{% list tabs %}

- Подключение с ключом

    При подключении с ключом файл `/root/.ssh/authorized_keys` должен содержать только ключ. Все, что перед ключом, нужно удалить.

- Подключение с паролем

    Для подключения по SSH с паролем нужно:

    1. Создать пароль для root командой `sudo passwd root`.

    1. Файл `/root/.ssh/authorized_keys` должен быть пустым либо содержать только ключ. Если ключ не подходит, то файл запросит пароль.

    1. Файл `/etc/ssh/sshd_config.d/50-cloud-init.conf` должен содержать:

    ```
    PasswordAuthentication yes
    PermitRootLogin yes
    ```

{% endlist %}
