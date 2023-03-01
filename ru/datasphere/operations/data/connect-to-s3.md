# Подключение к хранилищу S3

Вы можете управлять подключением к объектному хранилищу {% if lang == "ru" and audience != "internal" %}[S3](../../../glossary/s3.md){% else %}S3{% endif %} в интерфейсе {{ ml-platform-name }} на странице проекта с помощью ресурса **{{ ui-key.yc-ui-datasphere.resources.s3 }}**.

{% note info %}

Старайтесь не использовать хранилище S3 в режиме [FUSE]{% if lang == "ru" %}(https://ru.wikipedia.org/wiki/FUSE_(модуль_ядра)){% endif %}{% if lang == "en" %}(https://en.wikipedia.org/wiki/Filesystem_in_Userspace){% endif %} для работы в бакете с одноуровневыми (нерекурсивными) каталогами с большим количеством файлов. Такой сценарий использования вызывает существенное снижение производительности хранилища.

{% endnote %}

## Перед началом {#before-begin}

1. Получите ключ доступа у вашего S3-провайдера. Чтобы сделать это в {{ objstorage-full-name }}:
  1. [Создайте сервисный аккаунт](../../../iam/operations/sa/create.md).
  1. [Назначьте](../../../iam/operations/sa/assign-role-for-sa.md) созданному аккаунту [роль](../../../storage/security/), которая разрешит либо только чтение, либо чтение и запись.
  1. [Создайте ключ доступа](../../../iam/operations/sa/create-access-key.md) для сервисного аккаунта.

## Создать коннектор S3 {#create}

Чтобы создать коннектор S3:

1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
1. Если вы создаете подключение к бакету {{ objstorage-name }}, в настройках проекта [укажите](../projects/update.md) сервисный аккаунт, от имени которого {{ ml-platform-name }} будет подключаться к нему.
1. (Опционально) В правом верхнем углу нажмите кнопку **{{ ui-key.yc-ui-datasphere.common.create-resource }}**. Во всплывающем окне выберите **{{ ui-key.yc-ui-datasphere.resources.secret }}** и [создайте секрет](secrets.md#create) с секретной частью статического ключа доступа для сервисного аккаунта. Вы также сможете создать секрет при создании подключения S3.
1. В правом верхнем углу нажмите кнопку **{{ ui-key.yc-ui-datasphere.common.create-resource }}**. Во всплывающем окне выберите **{{ ui-key.yc-ui-datasphere.resources.s3 }}**.
1. Заполните поля:
   * **{{ ui-key.yc-ui-datasphere.common.name }}** — имя создаваемого коннектора.
   * (Опционально) **{{ ui-key.yc-ui-datasphere.common.description }}** создаваемого коннектора.
   * **{{ ui-key.yc-ui-datasphere.common.endpoint }}** — хост хранилища. Для {{ objstorage-full-name }} это `https://{{ s3-storage-host }}/`.
   * **{{ ui-key.yc-ui-datasphere.common.bucket }}** — имя бакета в хранилище.

     {% note warning %}

     Не используйте для подключения бакеты, содержащие точку в имени. [Подробнее о бакетах](../../../storage/concepts/bucket.md).

     {% endnote %}

   * **{{ ui-key.yc-ui-datasphere.new-s3-page.mount-name }}** — название тома при монтировании бакета в файловую систему проекта.
   * **{{ ui-key.yc-ui-datasphere.new-s3-page.access-key-id }}**, который используется для подключения к хранилищу. 
   * **{{ ui-key.yc-ui-datasphere.new-s3-page.static-access-key }}** — выберите из списка [секрет](../../concepts/secrets.md), содержащий секретную часть статического ключа доступа, или создайте новый секрет.
   * **{{ ui-key.yc-ui-datasphere.new-s3-page.mode }}** — режим доступа к объектному хранилищу: **{{ ui-key.yc-ui-datasphere.s3-page.mode-read }}** или **{{ ui-key.yc-ui-datasphere.s3-page.mode-read-write }}**.
   * **{{ ui-key.yc-ui-datasphere.common.backend }}** — режим бэкенда: **{{ ui-key.yc-ui-datasphere.common.default }}**, **{{ ui-key.yc-ui-datasphere.new-s3-page.backend-geesefs }}** или **{{ ui-key.yc-ui-datasphere.new-s3-page.backend-s3fs }}**.
1. Нажмите кнопку **{{ ui-key.yc-ui-datasphere.common.create }}**.

## Подключить хранилище S3 к проекту {#mount}

Перейдите на страницу коннектора S3 и нажмите кнопку **{{ ui-key.yc-ui-datasphere.common.activate }}**. После активации бакет будет доступен в интерфейсе {{ jlab }}Lab в списке на вкладке **S3 Mounts** ![S3 Mounts](../../../_assets/datasphere/bucket.svg), и его можно будет просматривать как файловую систему.

## Использовать хранилище S3 в проекте {#usage}

Вы можете обращаться к файлам в подключенном бакете из кода проекта. Выберите нужный файл в подключенном хранилище S3 во вкладке **S3 Mounts** ![S3 Mounts](../../../_assets/datasphere/bucket.svg), нажмите на него правой кнопкой мыши и выберите **Copy path**. Путь к файлу будет скопирован в буфер обмена. Вставьте скопированный путь в нужное место проекта.

## Отключить хранилище S3 {#unmount}

1. На странице проекта в разделе **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}** нажмите **{{ ui-key.yc-ui-datasphere.resources.s3 }}**. 
1. Выберите коннектор и перейдите на страницу ресурса.
1. Нажмите кнопку **{{ ui-key.yc-ui-datasphere.common.deactivate }}** в правом верхнем углу страницы.

Вы сможете повторно подключить хранилище S3 к проекту, когда это будет необходимо.