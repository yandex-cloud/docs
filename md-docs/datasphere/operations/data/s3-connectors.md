# Подключение к хранилищу S3

Вы можете управлять подключением к объектному хранилищу [S3](../../../glossary/s3.md) в интерфейсе {{ ml-platform-name }} на странице проекта с помощью ресурса **{{ ui-key.yc-ui-datasphere.resources.s3 }}**.

Чтобы подключиться к объектному хранилищу из кода ноутбука, воспользуйтесь инструкцией [{#T}](connect-to-s3.md).

{% note info %}

Старайтесь не использовать хранилище S3 в режиме [FUSE](https://ru.wikipedia.org/wiki/FUSE_(модуль_ядра)) для работы в бакете с одноуровневыми (нерекурсивными) каталогами с большим количеством файлов. Такой сценарий использования вызывает существенное снижение производительности хранилища.

{% endnote %}

## Перед началом работы {#before-begin}

Получите ключ доступа у вашего S3-провайдера. Чтобы сделать это в [{{ objstorage-full-name }}](../../../storage/index.md):

1. [Создайте сервисный аккаунт](../../../iam/operations/sa/create.md).
1. [Назначьте](../../../iam/operations/sa/assign-role-for-sa.md) созданному аккаунту [роль](../../../storage/security/index.md), которая разрешит либо только чтение, либо чтение и запись.
1. [Создайте ключ доступа](../../../iam/operations/authentication/manage-access-keys.md#create-access-key) для сервисного аккаунта.

## Создать коннектор S3 {#create}

1. Выберите нужный проект в своем сообществе или на [главной странице]({{ link-datasphere-main }}) {{ ml-platform-name }} во вкладке **{{ ui-key.yc-ui-datasphere.main-page.recent-projects }}**.
1. (Опционально) В правом верхнем углу нажмите кнопку **{{ ui-key.yc-ui-datasphere.common.create-resource }}**. Во всплывающем окне выберите **{{ ui-key.yc-ui-datasphere.resources.secret }}** и [создайте секрет](secrets.md#create) с секретной частью статического ключа доступа для сервисного аккаунта. Вы также сможете создать секрет при создании подключения S3.
1. В правом верхнем углу нажмите кнопку **{{ ui-key.yc-ui-datasphere.common.create-resource }}**. Во всплывающем окне выберите **{{ ui-key.yc-ui-datasphere.resources.s3 }}**.
1. Заполните поля:
   * **{{ ui-key.yc-ui-datasphere.common.name }}** — имя создаваемого коннектора. Требования к имени:

     * Длина — от 3 до 63 символов.
     * Может содержать строчные и заглавные буквы латинского и русского алфавита, цифры, дефисы, подчеркивания и пробелы.
     * Первый символ должен быть буквой. Последний символ не может быть дефисом, подчеркиванием или пробелом.

   * (Опционально) **{{ ui-key.yc-ui-datasphere.common.description }}** создаваемого коннектора.
   * **{{ ui-key.yc-ui-datasphere.common.endpoint }}** — хост хранилища. Для {{ objstorage-name }} это `https://{{ s3-storage-host }}/`.
   * **{{ ui-key.yc-ui-datasphere.common.bucket }}** — имя бакета в хранилище.

     {% note warning %}

     Не используйте для подключения бакеты, содержащие точку в имени. [Подробнее о бакетах](../../../storage/concepts/bucket.md).

     {% endnote %}

   * **{{ ui-key.yc-ui-datasphere.new-s3-page.mount-name }}** — название тома при монтировании бакета в файловую систему проекта. Требования к названию:

     * длина — от 3 до 63 символов;
     * может содержать строчные буквы латинского алфавита, цифры и дефисы;
     * первый символ — буква, последний — не дефис.

   * **{{ ui-key.yc-ui-datasphere.new-s3-page.access-key-id }}**, который используется для подключения к хранилищу.
   * **{{ ui-key.yc-ui-datasphere.new-s3-page.static-access-key }}** — выберите из списка [секрет](../../concepts/secrets.md), содержащий секретную часть статического ключа доступа, или создайте новый секрет.
   * **{{ ui-key.yc-ui-datasphere.new-s3-page.mode }}** — режим доступа к объектному хранилищу: **{{ ui-key.yc-ui-datasphere.s3-page.mode-read }}** или **{{ ui-key.yc-ui-datasphere.s3-page.mode-read-write }}**.
1. Нажмите кнопку **{{ ui-key.yc-ui-datasphere.common.create }}**.

{% note info %}

Если к проекту привязана [подсеть](../../../vpc/concepts/network.md#subnet), то у нее должен быть [настроен NAT-шлюз](../../../vpc/operations/create-nat-gateway.md). Подсеть должна находиться в [зоне доступности](../../../overview/concepts/geo-scope.md), в которой создано сообщество.

{% endnote %}

## Подключить хранилище S3 к проекту {#mount}

Перейдите на страницу коннектора S3 и нажмите кнопку **{{ ui-key.yc-ui-datasphere.common.activate }}**. После активации бакет будет доступен в интерфейсе {{ jlab }}Lab в файловом менеджере в папке `/s3/`, и его можно будет просматривать как файловую систему.

## Использовать хранилище S3 в проекте {#usage}

Вы можете обращаться к файлам в подключенном бакете из кода проекта. Выберите нужный файл в подключенном хранилище S3 во вкладке **S3 Mounts** ![S3 Mounts](../../../_assets/datasphere/bucket.svg), нажмите на него правой кнопкой мыши и выберите **Copy path**. Путь к файлу будет скопирован в буфер обмена. Вставьте скопированный путь в нужное место проекта.

## Отключить хранилище S3 {#unmount}

1. На странице проекта в разделе **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}** нажмите **{{ ui-key.yc-ui-datasphere.resources.s3 }}**.
1. Выберите коннектор и перейдите на страницу ресурса.
1. Нажмите кнопку **{{ ui-key.yc-ui-datasphere.common.deactivate }}** в правом верхнем углу страницы.

Вы сможете повторно подключить хранилище S3 к проекту, когда это будет необходимо.

## Поделиться коннектором S3 {#share}

{% note info %}

Делиться ресурсами можно только в рамках одной организации между сообществами, созданными в одной [зоне доступности](../../../overview/concepts/geo-scope.md).

{% endnote %}

1. Выберите нужный проект в своем сообществе или на [главной странице]({{ link-datasphere-main }}) {{ ml-platform-name }} во вкладке **{{ ui-key.yc-ui-datasphere.main-page.recent-projects }}**.
1. В блоке **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}** нажмите ![dataset](../../../_assets/console-icons/bucket.svg) **{{ ui-key.yc-ui-datasphere.resources.s3 }}**.
1. Выберите нужный коннектор S3 в списке.
1. Перейдите на вкладку **{{ ui-key.yc-ui-datasphere.common.access }}**.
1. Включите опцию видимости напротив названия сообщества, с которым нужно поделиться коннектором S3.

Чтобы коннектор S3 стал доступен для работы в другом проекте, администратор проекта должен [добавить](../projects/use-shared-resource.md) его на вкладке **{{ ui-key.yc-ui-datasphere.common.shared-with-project-resources }}**.

## Удалить коннектор S3 {#delete}

Вы можете удалить только [деактивированный](#unmount) коннектор, недоступный в сообществе.

1. Выберите нужный проект в своем сообществе или на [главной странице]({{ link-datasphere-main }}) {{ ml-platform-name }} во вкладке **{{ ui-key.yc-ui-datasphere.main-page.recent-projects }}**.
1. В блоке **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}** нажмите ![secret](../../../_assets/console-icons/bucket.svg)**{{ ui-key.yc-ui-datasphere.resources.s3 }}**.
1. В строке с нужным хранилищем S3 нажмите ![options](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yc-ui-datasphere.common.delete }}**.
1. Нажмите **{{ ui-key.yc-ui-datasphere.common.submit }}**.

Отобразится сообщение о том, что секрет удален.

{% note warning %}

Фактически [удаление ресурсов](../../../overview/concepts/data-deletion.md) может занимать до 72 часов.

{% endnote %}