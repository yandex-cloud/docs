Роль `managed-trino.admin` позволяет управлять кластерами Trino и выполнять операции с ними, а также просматривать информацию о квотах сервиса Managed Service for Trino.

Пользователи с этой ролью могут:
* просматривать информацию о кластерах Trino, а также создавать, изменять, запускать, останавливать и удалять их;
* использовать веб-интерфейс Trino;
* отправлять запросы к API Trino;
* просматривать информацию о квотах сервиса Managed Service for Trino.

Включает разрешения, предоставляемые ролью `managed-trino.editor`.

Для создания кластеров Trino дополнительно необходима роль `vpc.user`.
