# Поставка системных метрик Linux

Для поставки в {{ monitoring-full-name }} системных метрик виртуальных машин, работающих на операционных системах основанных на Linux, используется вход `linux_metrics`.

{% note warning %}

Поставка системных метрик виртуальных машин, работающих на Windows запланирована в будущих релизах {{unified-agent-full-name}}.

**TODO**: добавить идею в сообществе и поставить ссылку

{% endnote %}

1. Установите {{unified-agent-short-name}} в свою виртуальную машину, выполнив в домашнем каталоге следующую команду:

    {% include [ua-docker-install](../../../../_includes/monitoring/ua-docker-install.md) %}

1. Создайте сервисный аккаунт с ролью `editor` в каталоге, в который будут записываться метрики. Подробнее необходимые шагия для этого описаны в разделах [{#T}](../../../../iam/operations/sa/create.md) и [{#T}](../../../../iam/operations/sa/assign-role-for-sa.md).

1. Привявяжите сервисный аккаунт к виртуальной машине, на которой установлен {{unified-agent-short-name}}. Подробнее шаги для этого описаны в разделе [{#T}](../../../../compute/operations/vm-connect/auth-inside-vm.md#link-sa-with-instance).

1. Создайте в домашнем каталоге файл **config.yml** со следующим содержимым, заменив строку `<FOLDER_ID>` на указав идентификатор каталога, в который будут записаны метрики:

    **config.yml:**
    ```yaml
    routes:
      - input:
          plugin: linux_metrics
          config:
            poll_period: 15s
            namespace: sys
        channel:
          output:
            plugin: yc_metrics
            config:
              folder_id: <FOLDER_ID>
              iam:
                cloud_meta: {}
    ```

1. Убедитесь, что метрики поступают в {{ monitoring-full-name }}. Для этого перейдите по адресу [monitoring.cloud.yandex.ru](https://monitoring.cloud.yandex.ru), перейдите в раздел «Обзор метрик» и выберите каталог, в который собираются системные метрики, в строке запроса. Собранные системные метрики имеют в имени префикс `sys`.

## Что дальше {#next-steps}

- [Изучите концепции Unified Agent](../concepts.md)
- [Узнайте подробнее о конфигурировании Unified Agent](../configuration.md)
- [Ознакомьтесь с рекомендациями по эксплуатации Unified Agent](../best-practices.md)
