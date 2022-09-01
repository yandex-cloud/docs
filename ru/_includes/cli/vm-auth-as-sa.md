Для сервисного аккаунта процесс аутентификации изнутри виртуальной машины упрощен:
1. [Привяжите сервисный аккаунт](../../compute/operations/vm-connect/auth-inside-vm.md#link-sa-with-instance) к виртуальной машине.
1. Аутентифицируйтесь изнутри виртуальной машины:
      1. Подключитесь к виртуальной машине [по SSH](../../compute/operations/vm-connect/ssh.md).
   1. Создайте новый профиль:

      ```
      yc config profile create my-robot-profile
      ```


1. Настройте профиль для запуска команд.

    {% include [add-folder](../cli-add-folder.md) %}
