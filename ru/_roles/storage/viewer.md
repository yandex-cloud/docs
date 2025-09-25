Роль `storage.viewer` позволяет читать данные в бакетах, просматривать информацию о бакетах и объектах в них, а также о каталоге и квотах сервиса Object Storage.

{% cut "Пользователи с этой ролью могут:" %}

* просматривать список [бакетов](../../storage/concepts/bucket.md);
* просматривать списки [объектов](../../storage/concepts/object.md) в бакетах, информацию о таких объектах и их содержимое;
* просматривать информацию о назначенных [правах доступа](../../iam/concepts/access-control/index.md) к бакетам и объектам в них;
* просматривать информацию о конфигурации [CORS](../../storage/concepts/cors.md) бакетов;
* просматривать информацию о конфигурации [хостинга статических сайтов](../../storage/concepts/hosting.md) бакетов;
* просматривать информацию о [протоколе](../../storage/concepts/bucket.md#bucket-https) обращения к бакету;
* просматривать настройки [логирования](../../storage/concepts/server-logs.md) действий с бакетами;
* просматривать настройки [версионирования](../../storage/concepts/versioning.md) бакетов;
* просматривать настройки [шифрования](../../storage/concepts/encryption.md) бакетов;
* просматривать информацию о [классе хранилища](../../storage/concepts/storage-class.md#default-storage-class) по умолчанию для бакета;
* просматривать [метки](../../storage/concepts/tags.md) бакетов;
* просматривать информацию о регионе, в котором расположен бакет;
* просматривать информацию о конфигурации [жизненных циклов](../../storage/concepts/lifecycles.md) объектов;
* просматривать списки версий объектов и информацию о таких версиях;
* просматривать информацию о [блокировках версий объектов](../../storage/concepts/object-lock.md);
* просматривать [метки](../../storage/concepts/tags.md#object-tags) объектов и версий объектов;
* просматривать информацию о текущих [составных загрузках](../../storage/concepts/multipart.md) объектов и их частях;
* просматривать статистику [облака](../../resource-manager/concepts/resources-hierarchy.md#cloud), [каталога](../../resource-manager/concepts/resources-hierarchy.md#folder) и сервиса Object Storage;
* просматривать информацию о [квотах](../../storage/concepts/limits.md#storage-quotas) сервиса Object Storage;
* просматривать информацию о каталоге.

{% endcut %}
