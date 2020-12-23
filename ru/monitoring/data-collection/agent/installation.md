# Установка

## Способы установки

Unified Agent распространяется в виде:
- docker-образа;
- deb-пакета;
- бинарного исполняемого файла, собранного под архитектуру x86-64 / amd64.

{% list tabs %}

- Docker-образ

  Docker-образ расположен в репозитории cr.yandex с названием `unified_agent`, тег `latest`.

  Пример команды для запуска:
  ```
  docker run --name ua-agent -v /proc/:/host/proc/:ro -v /sys:/host/sys:ro -v config.yml:/etc/yandex/unified_agent/conf.d/config.yml unified_agent:latest
  ```

- Deb-пакет

  Deb-пакет Unified Agent расположен в репозитории TBD.

- Бинарный файл

  Архив с бинарным файлом расположен по адресу TBD.

{% endlist %}

## Что дальше

- TODO: Ознакомьтесь с рекомендациями по эксплуатации Unified Agent
- TODO: Просмотрите метрики