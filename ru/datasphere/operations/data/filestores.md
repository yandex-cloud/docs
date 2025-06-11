# Работа с файловыми хранилищами

[Файловое хранилище](../../concepts/filestores.md) {{ ml-platform-name }} позволяет хранить большие объемы информации и получать к ним доступ из ноутбуков.

## Создать файловое хранилище {#create}

1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
1. В блоке **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}** нажмите ![filestore](../../../_assets/console-icons/cube.svg) **{{ ui-key.yc-ui-datasphere.resources.filestore }}**.
1. Нажмите **{{ ui-key.yc-ui-datasphere.filestore.create-filestore }}**.
1. В открывшемся окне в поле **{{ ui-key.yc-ui-datasphere.common.name }}** задайте имя файлового хранилища.

   {% include [описание](../../../_includes/name-format-2.md) %}

1. В поле **{{ ui-key.yc-ui-datasphere.filestore.mount-path-key-value }}** введите имя, которое будет использоваться при подключении к файловому хранилищу. Имя при подключении должно содержать только буквы латинского алфавита и цифры, а также начинаться со слеша, например `/filestore`.
1. В поле **Объём хранилища, ГБ** задайте нужный размер хранилища. Внизу окна будет отображаться итоговая стоимость хранилища в месяц.
1. Нажмите **{{ ui-key.yc-ui-datasphere.common.create }}**. Откроется страница с информацией о созданном файловом хранилище.

## Подключить файловое хранилище к проекту {#mount}

Перейдите на страницу файлового хранилища и нажмите кнопку **{{ ui-key.yc-ui-datasphere.common.activate }}**. После активации файловое хранилище будет доступно в интерфейсе {{ jlab }}Lab в файловом менеджере в папке `/filestore/`, и его можно будет просматривать как файловую систему.

## Использовать файловое хранилище в проекте {#usage}

Вы можете обращаться к файлам хранилища из кода проекта. Нажмите правой кнопкой мыши на нужный файл и выберите **Copy path**. Путь к файлу будет скопирован в буфер обмена. Вставьте скопированный путь в нужное место проекта.

## Отключить файловое хранилище {#deactivate}

1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
1. В блоке **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}** нажмите ![filestore](../../../_assets/console-icons/cube.svg) **{{ ui-key.yc-ui-datasphere.resources.filestore }}**.
1. В строке с нужным файловым хранилищем нажмите значок ![options](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yc-ui-datasphere.common.deactivate }}**.

## Изменить файловое хранилище {#change}

1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
1. В блоке **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}** нажмите ![filestore](../../../_assets/console-icons/cube.svg) **{{ ui-key.yc-ui-datasphere.resources.filestore }}**.
1. В строке с нужным файловым хранилищем нажмите ![options](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yc-ui-datasphere.common.edit }}**.
1. Измените файловое хранилище: отредактируйте имя, имя при подключении и добавьте описание.
1. Нажмите **{{ ui-key.yc-ui-datasphere.common.save }}**.

## Поделиться файловым хранилищем {#share}

{% include [zones](../../../_includes/datasphere/zones.md) %}

Чтобы поделиться файловым хранилищем в сообществе, понадобятся роли `Editor` в проекте и `Developer` в сообществе. Подробнее о ролях, действующих в {{ ml-platform-name }}, см. в разделе [{#T}](../../security/index.md).

1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
1. В блоке **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}** нажмите ![filestore](../../../_assets/console-icons/cube.svg) **{{ ui-key.yc-ui-datasphere.resources.filestore }}**.
1. Выберите нужное файловое хранилище в списке.
1. Перейдите на вкладку **{{ ui-key.yc-ui-datasphere.common.access }}**.
1. Включите опцию видимости напротив названия сообщества, в котором нужно поделиться файловым хранилищем.

Чтобы файловое хранилище стало доступно для работы в другом проекте, редактор проекта должен [добавить](../projects/use-shared-resource.md) его на вкладке **{{ ui-key.yc-ui-datasphere.common.shared-with-project-resources }}**.

{% include [filestore-upload-warning](../../../_includes/datasphere/filestore-upload-warning.md) %}

## Удалить файловое хранилище {#delete}

1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
1. В блоке **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}** нажмите ![filestore](../../../_assets/console-icons/cube.svg) **{{ ui-key.yc-ui-datasphere.resources.filestore }}**.
1. В строке с нужным файловым хранилищем нажмите ![options](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yc-ui-datasphere.common.delete }}**.
1. Нажмите **{{ ui-key.yc-ui-datasphere.common.submit }}**.

Отобразится сообщение о том, что файловое хранилище удалено.

{% include [deletion-time](../../../_includes/datasphere/deletion-time.md) %}