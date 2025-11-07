Чтобы проверить работу интеграции {{ objstorage-full-name }} с Nextcloud на одном хосте:

1. На вашем локальном компьютере откройте браузер и в адресной строке введите публичный IPv4-адрес виртуальной машины, на которой развернут Nextcloud:

    ```text
    http://<публичный_IP-адрес_ВМ>
    ```
1. Аутентифицируйтесь в Nextcloud с помощью логина и пароля, созданных при настройке решения на предыдущем этапе.
1. В левой части верхнего меню выберите ![folder-fill](../../../_assets/console-icons/folder-fill.svg) **Files**.
1. В меню слева выберите **External storage** и выберите **AmazonS3**.
1. Нажмите ![plus](../../../_assets/console-icons/plus.svg) **New** и выберите ![arrow-shape-up-from-line](../../../_assets/console-icons/arrow-shape-up-from-line.svg) **Upload files**, чтобы загрузить в хранилище файл с локального компьютера.
1. Выберите файл на локальном компьютере и загрузите его в хранилище.

    Загруженный файл отобразится в хранилище `AmazonS3` Nextcloud.
1. В сервисе {{ objstorage-full-name }} [убедитесь](../../../storage/operations/objects/list.md), что файл был загружен в бакет.