# Поставка системных метрик Linux

Для поставки в {{ monitoring-full-name }} системных метрик виртуальных машин, работающих на Linux-совместимых операционных системах, используется вход `linux_metrics`. Подробнее работа этого входа описана в разделе [{#T}](../configuration.md#linux_metrics_input).

{% note warning %}

Поставка системных метрик виртуальных машин, работающих на Windows и macOS запланирована в будущих релизах {{unified-agent-full-name}}.

**TODO**: добавить идею в сообществе и поставить ссылку

{% endnote %}

Чтобы настроить {{unified-agent-full-name}} для сбора системных метрик с виртуальной машины Яндекс.Облака, выполните следующие шаги:

1. Настройте сервисный аккаунт, от имени которого будут записываться метрики в {{ monitoring-full-name }}.

   1. Создайте сервисный аккаунт с ролью `editor` в каталоге, куда будут записываться метрики. Подробнее необходимые для этого шаги описаны в разделах [{#T}](../../../../iam/operations/sa/create.md) и [{#T}](../../../../iam/operations/sa/assign-role-for-sa.md).

   1. Привяжите сервисный аккаунт к виртуальной машине, на которой установлен {{unified-agent-short-name}}. Подробнее шаги для этого описаны в разделе [{#T}](../../../../compute/operations/vm-connect/auth-inside-vm.md#link-sa-with-instance).

1. Установите и настройте {{unified-agent-full-name}}.

   1. Установите {{unified-agent-short-name}} в свою виртуальную машину, выполнив в домашнем каталоге следующую команду:

       {% include [ua-docker-install](../../../../_includes/monitoring/ua-docker-install.md) %}

       Другие способы установки агента описаны в разделе [{#T}](../installation.md).

   1. Создайте в домашнем каталоге файл **config.yml** со следующим содержимым, заменив строку `<FOLDER_ID>` на идентификатор каталога, куда будут записываться метрики:

       **config.yml:**
       ```yaml
       status:
         port: 16241
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

1. Убедитесь, что метрики поступают в {{ monitoring-full-name }}.

   1. Перейдите по адресу [monitoring.cloud.yandex.ru](https://monitoring.cloud.yandex.ru), перейдите в раздел «Обзор метрик» и выберите каталог, в который собираются системные метрики, в строке запроса. Собранные системные метрики имеют в имени префикс `sys`.

## Что дальше {#next-steps}

- [Изучите концепции Unified Agent](../concepts.md)
- [Узнайте подробнее о конфигурировании Unified Agent](../configuration.md)
- [Ознакомьтесь с рекомендациями по эксплуатации Unified Agent](../best-practices.md)
