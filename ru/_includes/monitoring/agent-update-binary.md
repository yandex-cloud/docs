1. Удалите существующий бинарный файл агента.
1. Скачайте последнюю версию агента в виде бинарного файла:

    ```bash
    ua_version=$(curl --silent https://{{ s3-storage-host }}/yc-unified-agent/latest-version) \
    bash -c 'curl --silent --remote-name https://{{ s3-storage-host }}/yc-unified-agent/releases/$ua_version/unified_agent && chmod +x ./unified_agent'
    ```

1. После скачивания исполняемого файла с агентом создайте конфигурационный файл, например, с настройками для [поставки системных метрик Linux](../../monitoring/operations/unified-agent/linux_metrics.md). Подробнее про конфигурацию агента см. в разделе [{#T}](../../monitoring/concepts/data-collection/unified-agent/configuration.md).


1. Переместите скачанный файл в папку `/bin/unified_agent`.
1. [Перезапустите](../../monitoring/concepts/data-collection/unified-agent/run-and-stop.md#run) агент.

Чтобы узнать все доступные версии агента, выполните команду:

```(bash)
curl --silent https://{{ s3-storage-host }}/yc-unified-agent/all-versions
```