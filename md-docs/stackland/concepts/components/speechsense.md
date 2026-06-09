# SpeechSense

Yandex SpeechSense — платформа анализа речи в составе Stackland. Платформа распознает и анализирует аудиозаписи разговоров, извлекает из них текст, классифицирует обращения и формирует аналитические отчеты.

SpeechSense не входит в базовую поставку Stackland и лицензируется отдельно.

## Архитектура {#architecture}

SpeechSense состоит из трех подкомпонентов:

* **YandexGPT for SpeechSense** — обработка естественного языка и генерация текста. Используется для суммаризации разговоров и классификации обращений. Требует GPU.
* **SpeechKit** — распознавание и синтез речи. Преобразует аудиозаписи в текст. Требует GPU.
* **SpeechSense** — речевая аналитика, обработка данных и веб-интерфейс. Координирует работу YandexGPT и SpeechKit, предоставляет UI для работы с результатами анализа.

## Требования к инфраструктуре {#infrastructure}

### GPU {#gpu-requirements}

Для работы SpeechSense необходимы узлы с GPU NVIDIA®:

* YandexGPT Pro — 2 × NVIDIA® H100.
* SpeechKit STT Backend — 1 × NVIDIA® A100.
* SpeechKit Embeddings — 1 × NVIDIA® H100.

Перед установкой SpeechSense включите компонент [«Поддержка NVIDIA® GPU»](gpu.md).

### Ресурсы {#resource-requirements}

TA-services работают без GPU, но требуют достаточного количества CPU и оперативной памяти. Рекомендуемые ресурсы для TA-services — не менее 32 vCPU и 64 ГБ RAM суммарно.

## Зависимости {#dependencies}

SpeechSense использует следующие компоненты Stackland:

* [Managed Service for PostgreSQL](postgresql.md) — хранение метаданных и состояния.
* [Managed Service for ClickHouse®](clickhouse.md) — аналитические запросы и хранение больших объемов данных.
* [Managed Service for Apache Kafka®](kafka.md) — обработка потоковых данных.
* [Object Storage](storage.md) — хранение аудиофайлов и моделей.
* [«Поддержка NVIDIA® GPU»](gpu.md) — управление GPU-ресурсами.
* [Identity and Access Management](iam.md) — аутентификация и авторизация пользователей.

При включении SpeechSense контроллер автоматически проверяет наличие зависимостей и создает необходимые кластеры баз данных, топики Apache Kafka® и сертификаты.

## Конфигурация {#configuration}

Управление компонентом SpeechSense осуществляется через кастомный ресурс `SpeechsenseConfig`.

Пример:

```yaml
apiVersion: stackland.yandex.cloud/v1alpha1
kind: SpeechsenseConfig
metadata:
  name: default
spec:
  enabled: true
  settings:
    s3: # Опционально. Заполните, если нужно использовать внешнее хранилище
      endpoint: "<адрес_объектного_хранилища>"
      accessKeyID: "<идентификатор_ключа>"
      secretAccessKey: "<секретный_ключ>"
```

Где:

* `enabled` — включает или отключает компонент.
* `settings.s3.endpoint` — адрес Object Storage.
* `settings.s3.accessKeyID` — идентификатор ключа доступа к хранилищу.
* `settings.s3.secretAccessKey` — секретный ключ доступа к хранилищу.

## См. также {#see-also}

* [Загрузить образы SpeechSense](../../operations/speechsense/install-images.md) — загрузка образов SpeechSense.
* [Настроить и активировать SpeechSense](../../operations/speechsense/configure.md) — настройка и активация SpeechSense.
* [Отключить SpeechSense](../../operations/speechsense/disable.md) — отключение SpeechSense.
* [«Поддержка NVIDIA® GPU»](gpu.md) — управление GPU в кластере.