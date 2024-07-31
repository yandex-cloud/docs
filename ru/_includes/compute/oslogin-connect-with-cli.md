1. [Включите](../../organization/operations/os-login-access.md) доступ по OS Login на уровне организации.

    Чтобы подключиться к ВМ по OS Login c SSH-сертификатом через YC CLI, включите опцию **{{ ui-key.yacloud_org.form.oslogin-settings.title_ssh-certificate-settings }}**.

1. Посмотрите описание команды CLI для подключения к ВМ:

    ```bash
    yc compute ssh --help
    ```

1. Получите список всех ВМ в каталоге по умолчанию:

    ```bash
    yc compute instance list
    ```

    Результат:

    ```text
    +----------------------+-----------------+---------------+---------+----------------------+
    |          ID          |       NAME      |    ZONE ID    | STATUS  |     DESCRIPTION      |
    +----------------------+-----------------+---------------+---------+----------------------+
    | fhm0b28lgf********** | first-instance  | {{ region-id }}-a | RUNNING | my first vm via CLI  |
    | fhm9gk85nj********** | second-instance | {{ region-id }}-a | RUNNING | my second vm via CLI |
    +----------------------+-----------------+---------------+---------+----------------------+
    ```

1. Подключитесь к ВМ:

      Для подключения по OS login используйте имя ВМ:

      ```bash
      yc compute ssh \
        --name <имя_ВМ>
      ```

      При подключении по OS Login вместо имени ВМ можно указать ее идентификатор:

      ```bash
      yc compute ssh \
        --id <идентификатор_ВМ>
      ```
      
      Для подключения по OS login по внутреннему IP-адресу используйте параметр `--internal-address`:
      
      ```bash
      yc compute ssh \
        --name <имя_ВМ> \
        --internal-address
      ```