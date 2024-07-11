1. Установите ACL на виртуальной машине `fileserver-tutorial`:

   {% list tabs group=operating_system %}

   - Ubuntu {#ubuntu}

     ```bash
     sudo apt install acl
     ```

   {% endlist %}

1. Создайте на ВМ `fileserver-tutorial` директорию `remote` и файл test.txt:

   {% list tabs group=operating_system %}

   - Ubuntu {#ubuntu}

     ```bash
     sudo mkdir /<имя_папки>/remote
     sudo setfacl -m u:<имя_вашего_пользователя>:rwx /<имя_папки>/remote
     echo "Hello world!" > /<имя_папки>/remote/test.txt
     ```

   {% endlist %}

1. Подключите по NFS сетевой диск к вашему компьютеру и проверьте доступность тестового файла:

   {% list tabs group=operating_system %}

   - Linux/macOS {#linux-macos}

     Если необходимо, установите утилиту для работы с сетевыми дисками:

     ```bash
     sudo apt-get install nfs-common
     ```

     Создайте точку монтирования:

     ```bash
     sudo mkdir /remote-test-dir
     ```

     Подключите сетевой диск:

     ```bash
     sudo mount -t nfs <публичный_IP-адрес_виртуальной_машины>:/<имя_папки> /remote-test-dir
     ```

     В результате в указанной точке монтирования должны быть доступны тестовая директория и файл.

   - Windows {#windows}

     1. Запустите утилиту **cmd.exe**. Для этого нажмите сочетание клавиш **Windows** + **R** и выполните команду `cmd`.
     1. В командной строке выполните команду:

        ```bash
        net use x: \\<публичный_IP-адрес_ВМ>\имя_папки
        ```

     В результате появится диск **X** с тестовой директорией и файлом.

   {% endlist %}