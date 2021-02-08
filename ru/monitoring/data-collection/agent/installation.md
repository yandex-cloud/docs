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

## Продвинутая установка Docker-образа { #advanced-docker }

Конфигурационный файл

При помощи управления переменными окружения, переданными при запуске Docker-образа, можно **управлять**

```yaml
status:
  port: "${UA_STATUS_PORT:-16241}"
  host: null

agent_log:
  priority: "${UA_LOG_PRIORITY:-NOTICE}"

storages:
  - name: main
    plugin: fs
    config:
      directory: /var/lib/yandex/unified_agent/main
      max_partition_size: 100mb
      max_segment_size: 10mb

channels:
  - name: cloud_monitoring
    channel:
      pipe:
        - storage_ref:
            name: main
      output:
        plugin: yc_metrics
        config:
          folder_id: "$FOLDER_ID"
          iam:
            cloud_meta: {}

routes:
  - input:
      plugin: linux_metrics
      config:
        namespace: sys
        proc_directory: "${PROC_DIRECTORY:-/proc}"
        sys_directory: "${SYS_DIRECTORY:-/sys}"
        resources:
          cpu: "${UA_LINUX_RESOURCE_CPU:-basic}"
          memory: "${UA_LINUX_RESOURCE_MEMORY:-basic}"
          network: "${UA_LINUX_RESOURCE_NETWORK:-basic}"
          storage: "${UA_LINUX_RESOURCE_STORAGE:-basic}"
          io: "${UA_LINUX_RESOURCE_IO:-basic}"
          kernel: "${UA_LINUX_RESOURCE_KERNEL:-basic}"
    channel:
      channel_ref:
        name: cloud_monitoring

  - input:
      plugin: agent_metrics
      config:
        namespace: ua
    channel:
      pipe:
        - filter:
            plugin: filter_metrics
            config:
              match: "\"{scope=health}\""
      channel_ref:
        name: cloud_monitoring

import:
  - /etc/yandex/unified_agent/conf.d/*.yml
```

## Что дальше {#next-steps}

- [Изучите концепции Unified Agent](concepts.md)
- [Узнайте подробнее о конфигурировании Unified Agent](configuration.md)
- [Ознакомьтесь с рекомендациями по эксплуатации Unified Agent](best-practices.md)
