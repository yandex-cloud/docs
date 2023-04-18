# Выбрать версию Python

По умолчанию в проектах {{ ml-platform-short-name }} используется Python 3.8. Чтобы изменить версию для проекта:

1. {% include [include](../../../_includes/datasphere/ui-find-project.md) %}
1. В разделе **Ресурсы проекта** выберите ![docker](../../../_assets/datasphere/docker.svg) **Docker-образ**.
1. Выберите шаблон [Docker-образа](../../concepts/docker.md) с нужной версией Python.
1. Нажмите **Активировать**.

{% note warning %}

Системный образ Python 3.7 не работает с [конфигурациями](../../concepts/configurations.md) g2.x (GPU A100).

{% endnote %}