# CyberDuck

[CyberDuck](https://cyberduck.io/) — это графический клиент для работы с облачными хранилищами, в том числе совместимыми с [Amazon S3 API](../../glossary/s3.md). CyberDuck доступен для macOS и Windows, а также в виде [консольного клиента](https://duck.sh/) для Linux.

## Подготовка к работе {#before-you-begin}

{% include [aws-tools-prepare-with-bucket](../../_includes/aws-tools/aws-tools-prepare-with-bucket.md) %}

{% include [access-bucket-sa](../../_includes/storage/access-bucket-sa.md) %}

## Установка {#installation}

[Скачайте](https://cyberduck.io/download/) дистрибутив CyberDuck для вашей операционной системы и запустите его.

## Подключение {#connection}

{% list tabs group=operating_system %}

- Windows {#windows}

  1. Запустите CyberDuck.
  1. Нажмите кнопку **Open Connection**.
  1. Выберите тип подключения — **Amazon S3**.
  1. Укажите параметры подключения:
      * **Server** — `{{ s3-storage-host }}`.

        Чтобы подключиться к определенному бакету, откройте вкладку **More options** и в поле **Path** укажите имя вашего бакета.
      * **Port** — `443`.
      * **Access Key ID** — идентификатор статического ключа, [полученный ранее](#before-you-begin).
      * **Secret Access Key** — содержимое статического ключа, [полученное ранее](#before-you-begin).
  1. Нажмите кнопку **Connect**.

- macOS {#macos}

  1. Запустите CyberDuck.
  1. Нажмите кнопку **Open Connection**.
  1. Выберите тип подключения — **Amazon S3**.
  1. Укажите параметры подключения:
      * **Server** — `{{ s3-storage-host }}`.

        Чтобы подключиться к определенному бакету, в поле **Server** укажите `<имя_бакета>.{{ s3-storage-host }}`. Таким образом можно подключится только к бакету, в имени которого не содержится точка. Для бакетов с точкой в имени воспользуйтесь [альтернативной инструкцией](#alternative-connection).
      * **Port** — `443`.
      * **Access Key ID** — идентификатор статического ключа, [полученный ранее](#before-you-begin).
      * **Secret Access Key** — содержимое статического ключа, [полученное ранее](#before-you-begin).
  1. Нажмите кнопку **Connect**.

  Чтобы подключиться к бакету, в имени которого содержится точка, например `example.com`: {#alternative-connection}
  1. Загрузите конфигурацонный файл [Deprecated path style requests](https://profiles.cyberduck.io/S3%20(Deprecated%20path%20style%20requests).cyberduckprofile) (Подробнее см. в [документации Cyberduck](https://docs.cyberduck.io/protocols/s3/#connecting-using-deprecated-path-style-requests)).
      
      Некоторые браузеры автоматически открывают конфигурационный файл в новой вкладке. Чтобы загрузить конфигурационный файл, нажмите на ссылку для загрузки правой кнопкой, выберите **Загрузить файл по ссылке как...** (**Download Linked File As...**) и нажмите **Сохранить** (**Save**).
  1. Откройте конфигурационный файл.
  1. Укажите параметры подключения, аналогично стандартному способу.
  1. Раскройте блок **More Options** и в поле **Path** укажите имя вашего бакета.
  1. Закройте окно с параметрами.
  1. Двойным нажатием откройте созданное подключение.

{% endlist %}


После подключения откроется бакет, созданный ранее.

{% note info %}

CyberDuck работает с {{ objstorage-name }} как с иерархической файловой системой. Это значит, что ключи объектов, загруженных через CyberDuck, будут иметь вид пути к файлу, например `prefix/subprefix/picture.jpg`.

{% endnote %}

Подробности о работе CyberDuck с S3-совместимыми хранилищами см. в [документации CyberDuck](https://docs.cyberduck.io/protocols/s3/).
