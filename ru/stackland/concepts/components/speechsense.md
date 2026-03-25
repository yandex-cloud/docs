# {{ speechsense-name }}

{{ speechsense-full-name }} — платформа анализа речи в составе {{ stackland-name }}. Платформа распознает и анализирует аудиозаписи разговоров, извлекает из них текст, классифицирует обращения и формирует аналитические отчеты.

{{ speechsense-name }} не входит в базовую поставку {{ stackland-name }} и лицензируется отдельно.

## Архитектура {#architecture}

{{ speechsense-name }} состоит из трех подкомпонентов:

* **YaGPT** — обработка естественного языка и генерация текста. Используется для суммаризации разговоров и классификации обращений. Требует GPU.
* **SpeechKit** — распознавание и синтез речи. Преобразует аудиозаписи в текст. Требует GPU.
* **SppechSense** — речевая аналитика, обработка данных и веб-интерфейс. Координирует работу YaGPT и SpeechKit, предоставляет UI для работы с результатами анализа.

## Требования к инфраструктуре {#infrastructure}

### GPU {#gpu-requirements}

Для работы {{ speechsense-name }} необходимы узлы с GPU {{ nvidia }}:

* YaGPT Pro — 2 × {{ nvidia }} H100.
* SpeechKit STT Backend — 1 × {{ nvidia }} A100.
* SpeechKit Embeddings — 1 × {{ nvidia }} H100.

Перед установкой {{ speechsense-name }} включите компонент [{{ gpu-operator }}](gpu.md).

### Ресурсы {#resource-requirements}

TA-services работают без GPU, но требуют достаточного количества CPU и оперативной памяти. Рекомендуемые ресурсы для TA-services — не менее 32 vCPU и 64 ГБ RAM суммарно.

## Зависимости {#dependencies}

{{ speechsense-name }} использует следующие компоненты {{ stackland-name }}:

* [{{ mpg-name }}](postgresql.md) — хранение метаданных и состояния.
* [{{ mch-name }}](clickhouse.md) — аналитические запросы и хранение больших объемов данных.
* [{{ mkf-name }}](kafka.md) — обработка потоковых данных.
* [{{ objstorage-name }}](storage.md) — хранение аудиофайлов и моделей.
* [{{ gpu-operator }}](gpu.md) — управление GPU-ресурсами.
* [{{ iam-name }}](iam.md) — аутентификация и авторизация пользователей.

При включении {{ speechsense-name }} контроллер автоматически проверяет наличие зависимостей и создает необходимые кластеры баз данных, топики {{ KF }} и сертификаты.

## Конфигурация {#configuration}

Управление компонентом {{ speechsense-name }} осуществляется через кастомный ресурс `SpeechsenseConfig`.

Пример:

{% include notitle [YAML-файл](../../_includes/yamls/components/speechsenseconfig.md) %}

Где:

* `enabled` — включает или отключает компонент.
* `settings.s3.endpoint` — адрес {{ objstorage-name }}.
* `settings.s3.accessKeyID` — идентификатор ключа доступа к хранилищу.
* `settings.s3.secretAccessKey` — секретный ключ доступа к хранилищу.

## См. также {#see-also}

* [{#T}](../../operations/speechsense/install-images.md) — загрузка образов {{ speechsense-name }}.
* [{#T}](../../operations/speechsense/configure.md) — настройка и активация {{ speechsense-name }}.
* [{#T}](../../operations/speechsense/disable.md) — отключение {{ speechsense-name }}.
* [{{ gpu-operator }}](gpu.md) — управление GPU в кластере.
