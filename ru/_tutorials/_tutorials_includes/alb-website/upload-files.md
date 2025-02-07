Чтобы проверить работу веб-сервера, необходимо загрузить файлы сайта на каждую ВМ. Для примера вы можете использовать файл `index.html` из [архива](https://{{ s3-storage-host }}/doc-files/index.html.zip).

Для каждой ВМ в [созданной группе](#create-vms) выполните следующее:
1. На вкладке **{{ ui-key.yacloud.compute.instances.label_title }}** нажмите на имя нужной ВМ в списке.
1. Скопируйте **{{ ui-key.yacloud.compute.instance.overview.label_public-ipv4 }}** из блока **{{ ui-key.yacloud.compute.instance.overview.section_network }}**.
1. [Подключитесь](../../../compute/operations/vm-connect/ssh.md#vm-connect) к ВМ по протоколу SSH.
1. Выдайте права на запись для вашего пользователя на директорию `/var/www/html`:

   ```bash
   sudo chown -R "$USER":www-data /var/www/html
   ```

1. Загрузите на ВМ файлы сайта с помощью [протокола SCP](https://ru.wikipedia.org/wiki/SCP).

   {% list tabs group=operating_system %}

   - Linux/macOS {#linux-macos}

     Используйте утилиту командной строки `scp`:

     ```bash
     scp -r <путь_до_директории_с-файлами> <имя_пользователя_ВМ>@<IP-адрес_ВМ>:/var/www/html
     ```

   - Windows {#windows}

     С помощью программы [WinSCP](https://winscp.net/eng/download.php) скопируйте локальную директорию с файлами в директорию `/var/www/html` на ВМ.

   {% endlist %}