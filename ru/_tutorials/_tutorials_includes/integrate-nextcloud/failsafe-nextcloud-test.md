Чтобы проверить работу интеграции {{ objstorage-full-name }} с Nextcloud в отказоустойчивой конфигурации:

1. На вашем локальном компьютере откройте браузер и в адресной строке введите имя вашего домена, например:

    ```text
    https://example.com
    ```
1. Аутентифицируйтесь в Nextcloud с помощью логина и пароля, созданных при настройке решения.
1. В левой части верхнего меню выберите ![folder-fill](../../../_assets/console-icons/folder-fill.svg) **Files**.
1. В меню слева выберите **External storage** и выберите **AmazonS3**.
1. Убедитесь, что вы видите загруженный на предыдущем этапе проверки файл.
1. Скачайте загруженный ранее файл. Для этого в строке с именем файла нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![arrow-down](../../../_assets/console-icons/arrow-down.svg) **Download**.
1. Удалите файл. Для этого в строке с именем файла нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![trash-bin](../../../_assets/console-icons/trash-bin.svg) **Delete file**.
1. В сервисе {{ objstorage-full-name }} [убедитесь](../../../storage/operations/objects/list.md), что файл был удален из бакета.