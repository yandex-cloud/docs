# Установка и запуск

{{unified-agent-full-name}} распространяется в виде:
- Docker-образа;
- deb-пакета;
- бинарного исполняемого файла, собранного под архитектуру x86-64 / amd64 для Linux-совместимых операционных систем.

Чтобы установить {{unified-agent-short-name}} выполните следующие шаги:

{% list tabs %}

- Docker-образ

  Docker-образ опубликован в репозитории cr.yandex с названием `unified_agent`, тег `latest`.

  Пример команды для запуска:

  {% include [ua-docker-install](../../../_includes/monitoring/ua-docker-install.md) %}

- deb-пакет

  Deb-пакет Unified Agent опубликован в репозитории TBD.

- Бинарный файл

  Архив с бинарным файлом можно скачать по адресу TBD.

{% endlist %}

## Что дальше {#next-steps}

- [Изучите концепции Unified Agent](../concepts.md)
- [Узнайте подробнее о конфигурировании Unified Agent](../configuration.md)
- [Ознакомьтесь с рекомендациями по эксплуатации Unified Agent](../best-practices.md)
