1. В блоке **Сеть** на странице виртуальной машины в [консоли управления]({{ link-console-main }}) найдите публичный IP-адрес виртуальной машины.
1. [Подключитесь](../../compute/operations/vm-connect/ssh.md) к виртуальной машине по протоколу SSH.
1. Выдайте права на запись для вашего пользователя на директорию `/var/www/html`:

   {% list tabs %}

   - Ubuntu

     ```bash
     sudo chown -R "$USER":www-data /var/www/html
     ```

   - CentOS

     ```bash
     sudo chown -R "$USER":apache /var/www/html
     ```

   {% endlist %}

1. Загрузите на виртуальную машину файлы веб-сайта с помощью протокола SCP.

   {% list tabs %}

   - Linux/macOS

     Используйте утилиту командной строки `scp`:
     ```bash
     scp -r <путь до директории с файлами> <имя пользователя ВМ>@<IP-адрес виртуальной машины>:/var/www/html
     ```

   - Windows

     С помощью программы [WinSCP](https://winscp.net/eng/download.php) скопируйте локальную директорию с файлами в директорию `/var/www/html` на виртуальной машине.

   {% endlist %}
