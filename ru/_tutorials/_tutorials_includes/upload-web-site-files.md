1. В блоке **Сеть** на странице виртуальной машины в [консоли управления]({{ link-console-main }}) найдите публичный IP-адрес виртуальной машины.
1. [Подключитесь](../../compute/operations/vm-connect/ssh.md) к виртуальной машине по протоколу SSH.
1. Выдайте права на запись для вашего пользователя на директорию `/var/www/html`:

   {% list tabs group=operating_system %}

   - Ubuntu {#ubuntu}

     ```bash
     sudo chown -R "$USER":www-data /var/www/html
     ```

   - CentOS {#centos}

     ```bash
     sudo chown -R "$USER":apache /var/www/html
     ```

   {% endlist %}


1. Загрузите на ВМ файлы веб-сайта с помощью [протокола SCP](https://ru.wikipedia.org/wiki/SCP).

   {% list tabs group=operating_system %}

   - Linux/macOS {#linux-macos}

     Используйте утилиту командной строки `scp`:

     ```bash
     scp -r <путь_до_директории_с_файлами> <имя_пользователя_ВМ>@<IP-адрес_виртуальной_машины>:/var/www/html
     ```

   - Windows {#windows}

     С помощью программы [WinSCP](https://winscp.net/eng/download.php) скопируйте локальную директорию с файлами в директорию `/var/www/html` на ВМ.

   {% endlist %}
