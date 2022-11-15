# Выбрать версию Python

По умолчанию в проектах {{ ml-platform-short-name }} используется Python 3.8. Чтобы изменить версию для проекта:

1. {% include [include](../../../_includes/datasphere/ui-before-begin.md) %}
1. Перейдите во вкладку ![docker](../../../_assets/datasphere/docker.svg) **Docker images**.
1. Выберите шаблон [Docker-образа](../../concepts/docker.md) с нужной версией Python. 
1. Нажмите **Set image to project**.

{% note warning %}

Системный образ Python 3.7 не работает с [конфигурациями](../../concepts/configurations.md) g2.x (GPU A100).

{% endnote %}