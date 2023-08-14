# Подключение к хранилищу S3

Вы можете управлять подключением к объектному хранилищу [S3](../../../glossary/s3.md) в интерфейсе {{ ml-platform-name }} на странице проекта с помощью ресурса **{{ ui-key.yc-ui-datasphere.resources.s3 }}**.

Чтобы подключиться к объектному хранилищу из кода ноутбука, воспользуйтесь инструкцией [{#T}](connect-to-s3.md).

{% include [fuse-disclaimer](../../../_includes/datasphere/fuse-disclaimer.md) %}

## Перед началом работы {#before-begin}

1. Получите ключ доступа у вашего S3-провайдера. Чтобы сделать это в [{{ objstorage-full-name }}](../../storage/):
  1. [Создайте сервисный аккаунт](../../../iam/operations/sa/create.md).
  1. [Назначьте](../../../iam/operations/sa/assign-role-for-sa.md) созданному аккаунту [роль](../../../storage/security/), которая разрешит либо только чтение, либо чтение и запись.
  1. [Создайте ключ доступа](../../../iam/operations/sa/create-access-key.md) для сервисного аккаунта.

## Создать коннектор S3 {#create}

1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
1. (Опционально) В правом верхнем углу нажмите кнопку **{{ ui-key.yc-ui-datasphere.common.create-resource }}**. Во всплывающем окне выберите **{{ ui-key.yc-ui-datasphere.resources.secret }}** и [создайте секрет](secrets.md#create) с секретной частью статического ключа доступа для сервисного аккаунта. Вы также сможете создать секрет при создании подключения S3.
1. В правом верхнем углу нажмите кнопку **{{ ui-key.yc-ui-datasphere.common.create-resource }}**. Во всплывающем окне выберите **{{ ui-key.yc-ui-datasphere.resources.s3 }}**.
1. Заполните поля:
   * **{{ ui-key.yc-ui-datasphere.common.name }}** — имя создаваемого коннектора.
   * (Опционально) **{{ ui-key.yc-ui-datasphere.common.description }}** создаваемого коннектора.
   * **{{ ui-key.yc-ui-datasphere.common.endpoint }}** — хост хранилища. Для {{ objstorage-name }} это `https://{{ s3-storage-host }}/`.
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

## Поделиться коннектором S3 {#share}

1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
1. В блоке **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}** нажмите ![dataset](../../../_assets/datasphere/dataset.svg) **{{ ui-key.yc-ui-datasphere.resources.s3 }}**.
1. Выберите нужный коннектор S3 в списке.
1. Перейдите на вкладку **{{ ui-key.yc-ui-datasphere.common.access }}**.
1. Включите опцию видимости напротив названия сообщества, с которым нужно поделиться коннектором S3.

## Удалить коннектор S3 {#delete}

Вы можете удалить только [деактивированный](#unmount) коннектор, недоступный в сообществе.

1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
1. В блоке **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}** нажмите ![secret](../../../_assets/datasphere/jupyterlab/secret.svg)**{{ ui-key.yc-ui-datasphere.resources.s3 }}**.
1. В списке коннекторов S3 выберите тот, который хотите удалить. Нажмите ![options](../../../_assets/options.svg) и выберите **{{ ui-key.yc-ui-datasphere.common.delete }}**.
1. Нажмите **{{ ui-key.yc-ui-datasphere.common.submit }}**.

Отобразится сообщение о том, что секрет удален. 
