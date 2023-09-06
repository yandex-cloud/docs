1. В блоке **{{ ui-key.yacloud.compute.instance.overview.section_network }}** на странице ВМ в [консоли управления]({{ link-console-main }}) найдите публичный IP-адрес ВМ.
1. [Подключитесь](../../compute/operations/vm-connect/ssh.md) к ВМ по протоколу SSH.
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

1. Загрузите на ВМ файлы веб-сайта с помощью [протокола SCP](https://ru.wikipedia.org/wiki/SCP).

   {% list tabs %}

   - Linux/macOS

     Используйте утилиту командной строки `scp`:

     ```bash
     scp -r <путь до директории с файлами> <имя пользователя ВМ>@<IP-адрес виртуальной машины>:/var/www/html
     ```

   - Windows

     С помощью программы [WinSCP](https://winscp.net/eng/download.php) скопируйте локальную директорию с файлами в директорию `/var/www/html` на ВМ.

   {% endlist %}