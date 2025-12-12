Загрузите файл с образом в сервис {{ objstorage-name }} и получите ссылку на загруженный образ:

1. Если у вас еще нет [бакета](../../storage/concepts/bucket.md) в {{ objstorage-name }}, [создайте](../../storage/operations/buckets/create.md) его с ограниченным доступом.
1. Загрузите образ в ваш бакет, например, [через консоль управления](../../storage/operations/objects/upload.md), с помощью [AWS CLI](../../storage/tools/aws-cli.md) или [WinSCP](../../storage/tools/winscp.md). В терминах {{ objstorage-name }} загружаемый файл образа будет называться _объектом_.
1. [Получите](../../storage/operations/objects/link-for-download.md) подписанную [ссылку](../../storage/concepts/pre-signed-urls.md) на скачивание образа из бакета. Используйте эту ссылку при создании образа в {{ compute-name }}.