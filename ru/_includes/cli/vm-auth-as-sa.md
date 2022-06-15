Для сервисного аккаунта процесс аутентификации изнутри виртуальной машины упрощен:
{% if audience != "internal" %}
1. [Привяжите сервисный аккаунт](../../compute/operations/vm-connect/auth-inside-vm.md#link-sa-with-instance) к виртуальной машине.
{% else %}
1. Привяжите сервисный аккаунт к виртуальной машине.
{% endif %}
1. Аутентифицируйтесь изнутри виртуальной машины:
   {% if audience != "internal" %}
   1. Подключитесь к виртуальной машине [по SSH](../../compute/operations/vm-connect/ssh.md) или [по RDP](../../compute/operations/vm-connect/rdp.md).
   {% else %}
   1. Подключитесь к виртуальной машине по SSH или по RDP.
   {% endif %}
   1. Создайте новый профиль:

      ```
      yc config profile create my-robot-profile
      ```

{% if product == "cloud-il" %}
1. Добавьте в профиль CLI доменное имя и порт для запросов к {{ yandex-cloud }}:

   ```
   yc config set endpoint {{ api-host }}:443
   ```   
{% endif %}

1. Настройте профиль для запуска команд.

    {% include [add-folder](../cli-add-folder.md) %}
