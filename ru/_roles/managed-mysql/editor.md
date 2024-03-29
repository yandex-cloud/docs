Роль `managed-mysql.editor` позволяет управлять кластерами MySQL® и просматривать их логи, а также получать информацию о квотах и операциях с ресурсами сервиса.

Пользователи с этой ролью могут:
* просматривать информацию о [кластерах](../../managed-mysql/concepts/index.md) MySQL®, а также создавать, изменять, удалять, запускать и останавливать их;
* просматривать информацию о [хостах](../../managed-mysql/concepts/instance-types.md) кластеров MySQL®, а также создавать, изменять и удалять их;
* просматривать информацию о базах данных MySQL®, а также создавать, изменять и удалять их;
* просматривать информацию о [пользователях](../../managed-mysql/concepts/user-rights.md) MySQL®, а также создавать, изменять и удалять их;
* просматривать информацию о [резервных копиях](../../managed-mysql/concepts/backup.md) БД MySQL®, а также создавать и удалять их;
* просматривать информацию об алертах MySQL®, а также создавать, изменять и удалять их;
* просматривать логи работы кластеров MySQL®;
* просматривать информацию о результатах диагностики производительности кластеров MySQL®;
* просматривать информацию о [квотах](../../managed-mysql/concepts/limits.md#mmy-quotas) сервиса Managed Service for MySQL®;
* просматривать информацию об операциях с ресурсами сервиса Managed Service for MySQL®.

Включает разрешения, предоставляемые ролью `managed-mysql.viewer`.

Для создания кластеров MySQL® дополнительно необходима роль `vpc.user`.