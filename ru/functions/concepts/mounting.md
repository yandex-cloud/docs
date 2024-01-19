# Монтирование бакетов в функцию

{% include [read-note](../../_includes/functions/read-note.md) %}

Монтирование бакетов позволяет обращаться к бакетам через интерфейс файловой системы. В настройках версии функции пользователь может указать точку монтирования или несколько. Директория, к которой смонтируется бакет, будет доступна по пути `/function/storage/<точка_монтирования>`.

Смонтировать можно весь бакет или [папку](../../storage/concepts/object#folder).


{% include [roles-for-bucket-mounting](../../_includes/functions/roles-for-bucket-mounting.md) %}

## См. также {#see-also}

* [Монтировать бакеты в функцию](../operations/function/mount-bucket.md)
* [Монтировать бакеты в контейнер](../../serverless-containers/operations/mount-bucket.md)
