При установке {{ unified-agent-short-name }} выполняются действия:

* Установка исполняемого файла `unified_agent`.

* Установка базового файла конфигурации `/etc/yc/unified_agent/config.yml`. В конфигурации настроена отправка [базовых метрик виртуальной машины](../../monitoring/concepts/data-collection/unified-agent/inputs.md#linux_metrics_input) и [метрик здоровья агента](../../monitoring/concepts/data-collection/unified-agent/inputs.md#agent_metrics_input). Отправка метрик [тарифицируется](../../monitoring/pricing.md).

    Дополнительно можно [настроить](../../monitoring/concepts/data-collection/unified-agent/configuration.md) поставку собственных метрик или [логов в {{ cloud-logging-name }}](../../monitoring/concepts/data-collection/unified-agent/outputs.md#yc_logs_output).

* Конфигурация системы инициализации, добавление нового сервиса `unified-agent`. Сервис запускается при старте системы.

* Создание пользователя `unified_agent` с uid `1515` и одноименной группы с gid `1515`.

    Если данные uid или gid недоступны (заняты), пользователь и группа создаются без указания явного uid и gid.

* Создание и настройка доступа к директории для пользовательской конфигурации `/etc/yandex/unified_agent/conf.d`.

* Создание и настройка доступа к директории для пользовательского хранилища `/var/lib/yandex/unified_agent`.