# Docker-образы

Вы можете самостоятельно настроить окружение проекта {{ ml-platform-name }} с помощью [_Docker-образа_](https://docs.docker.com/engine/reference/commandline/image/), собрав в него произвольный набор ПО, библиотек, переменных окружения и конфигурационных файлов. Docker-образ, примененный для проекта, будет использоваться при запуске кода во всех его ноутбуках.

Созданные Docker-образы нельзя изменить.

Как и другие ресурсы {{ ml-platform-name }}, Docker-образ можно [опубликовать](../operations/user-images.md#share) в сообществе, чтобы использовать его в нескольких проектах. Для этого вам минимально необходимы роли `Editor` в проекте и `Developer` в сообществе, в котором вы хотите его опубликовать. Открыть доступ можно на вкладке **{{ ui-key.yc-ui-datasphere.common.access }}** на странице просмотра Docker-образа. Ресурс, доступный для сообщества, появится на странице сообщества в разделе **{{ ui-key.yc-ui-datasphere.spaces-page.community-resources }}**.

Подробнее о работе с Docker-образами — в разделе [{#T}](../operations/user-images.md).

## Требования к Docker-образу {#requirements}

{% include [python-disclaimer](../../_includes/datasphere/python-disclaimer.md) %}

Чтобы Docker-образ запускался и корректно работал в {{ ml-platform-name }}, он должен содержать:
* установку Python 3.7, 3.8, 3.9 или 3.10;
* установку pip;
* пользователя `--uid 1000 jupyter`.

{% include [Docker hub limits](../../_includes/datasphere/dockerhub-limits.md) %}

{% note info %}

Шаблоны Docker-образов, представленные в {{ ml-platform-name }}, уже удовлетворяют требованиям. Если вы загружаете образ из стороннего источника или пишете свой, добавьте в него необходимые команды.

{% endnote %}

#### См. также {#see-also}

* [{#T}](../operations/user-images.md)