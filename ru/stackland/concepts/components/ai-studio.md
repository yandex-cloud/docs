# {{ ai-studio-name }}

{{ ai-studio-full-name }} — платформа для работы с генеративными моделями и создания AI-агентов в составе {{ stackland-name }}. Позволяет выполнять запросы к языковым моделям, получать эмбеддинги, создавать ассистентов и подключать к ним инструменты.

Модули {{ ai-studio-name }} не входят в базовую поставку {{ stackland-name }} и лицензируются отдельно.

## Состав {#architecture}

{{ ai-studio-name }} состоит из двух компонентов:

* **{{ model-gallery-name }}** — запуск языковых моделей, получение эмбеддингов (Embeddings) и проверка безопасности запросов и ответов (Ethics).
* **{{ agent-atelier-name }}** — создание и запуск AI-агентов и ассистентов на основе моделей из {{ model-gallery-name }}. Позволяет подключать инструменты и готовить датасеты. Дополнительно можно включить Code Interpreter для выполнения кода.

## Требования к инфраструктуре {#infrastructure}

Приведенные ниже ориентиры относятся к {{ ai-studio-name }} в {{ stackland-name }} 26.3. Объем ресурсов зависит от набора одновременно включенных моделей и количества активных сессий.

На этапе развертывания кластера [включите поддержку {{ nvidia }} GPU](gpu.md#enable) для каждого рабочего узла с GPU.

### Минимальная конфигурация кластера {#cluster-configuration}

Минимальная конфигурация кластера для {{ ai-studio-name }} рассчитана на одновременную работу одной модели YandexGPT 5 Lite, Embeddings и Ethics. Ресурсы в таблице указаны на один узел.

| Назначение узлов | Количество | CPU | RAM | Диски | GPU |
| --- | --- | --- | --- | --- | --- |
| Control plane | 3 | 8 vCPU | 16 ГБ | 200 ГБ | — |
| Рабочие узлы без GPU | 3 | 16 vCPU | 64 ГБ | 200 ГБ для системы и 500 ГБ для данных | — |
| Рабочий узел с A100 | 1 | 28 vCPU | 120 ГБ | 279 ГБ для системы и 465 ГБ для данных | 1 × {{ nvidia }} A100 80 GB |
| Рабочий узел с H100 | 1 | 36 vCPU | 288 ГБ | 279 ГБ для системы и 465 ГБ для данных | 2 × {{ nvidia }} H100 80 GB |

Суммарно: 136 vCPU, 648 ГБ RAM, около 4,1 ТБ дискового пространства, один A100 и два H100.

Для запуска других моделей одновременно с этим набором увеличьте ресурсы кластера. Например, чтобы также запустить YandexGPT 5.1 Pro, добавьте еще один узел с двумя H100.

### Ресурсы без учета моделей {#base-services}

При планировании ресурсов для {{ ai-studio-name }} без моделей ориентируйтесь на 24 vCPU, 54 ГБ RAM и 93 ГБ постоянного дискового пространства. Дополнительно требуется место в {{ objstorage-name }} для весов моделей и пользовательских данных.

Эти ресурсы учитываются отдельно от ресурсов моделей, сессий Code Interpreter и остальных компонентов {{ stackland-name }}. При планировании оставьте запас для системных процессов и пиковой нагрузки.

### Ресурсы моделей {#model-resources}

Ресурсы каждой включенной модели добавляются к [ресурсам {{ ai-studio-name }} без учета моделей](#base-services).

| Модель | Запрос CPU | Запрос RAM | Дисковое пространство | GPU |
| --- | --- | --- | --- | --- |
| Embeddings | 8 vCPU | 12 ГБ | — | 1 × A100 80 GB |
| Ethics | 4 vCPU | 4 ГБ | — | 1 × H100 80 GB |
| YandexGPT 5 Lite | 3 vCPU | 6 ГБ | 100 ГБ | 1 × H100 80 GB |
| YandexGPT 5.1 Pro | Требует уточнения | Требует уточнения | 200 ГБ | 2 × H100 80 GB на одном узле |
| Alice 30B | 3 vCPU | Требует уточнения | 100 ГБ | 1 × H100 80 GB |
| Alice Flash | 3 vCPU | Требует уточнения | 100 ГБ | 2 × H100 80 GB на одном узле |

Значения CPU и RAM приведены для [примера конфигурации](#model-gallery-configuration). Прочерк означает, что размер отдельного диска в примере не указан. Требования, отмеченные как «Требует уточнения», определите перед включением модели с учетом своей нагрузки.

Для моделей, которым нужны два GPU, оба ускорителя должны находиться на одном узле.

### Примеры дополнительных моделей {#additional-model-resources}

Ниже приведены примеры ресурсов для моделей обработки изображений (VLM) и распознавания текста (OCR). Их доступность зависит от версии {{ ai-studio-name }}. Таблица служит ориентиром для планирования ресурсов.

| Модель | Запрос CPU | Запрос RAM | Хранение данных | GPU |
| --- | --- | --- | --- | --- |
| Gemma VLM | Требует уточнения | Требует уточнения | Диск 100 ГБ | 1 × H100 80 GB |
| Qwen VLM | Требует уточнения | Требует уточнения | Диск 100 ГБ | 2 × H100 80 GB на одном узле |
| OCR | Требует уточнения | 40 ГБ | {{ objstorage-name }} | 1 × {{ nvidia }} GPU |

Недостающие требования к ресурсам уточните перед развертыванием.

### Code Interpreter {#code-interpreter-resources}

Каждая активная сессия Code Interpreter дополнительно требует примерно 2,1 vCPU, 4,1 ГБ RAM и 5–10 ГБ временного дискового пространства. GPU не требуется. Учитывайте ресурсы всех одновременно активных сессий.

## Зависимости {#dependencies}

Для работы {{ ai-studio-name }} необходимы следующие компоненты {{ stackland-name }}:

* [{{ objstorage-name }}](storage.md) — хранение весов моделей, датасетов и других файлов.
* [{{ mpg-name }}](postgresql.md) — хранение метаданных и состояния сервисов.
* [{{ iam-name }}](iam.md) — аутентификация пользователей, сервисные аккаунты и доступ к хранилищу.
* [{{ gpu-operator }}](gpu.md) — предоставление GPU моделям.
* [{{ certificate-manager-name }}](certificate-manager.md) — выпуск TLS-сертификатов, в том числе для Code Interpreter.
* [Дисковая подсистема](disk-storage.md) — создание постоянных томов.

Сначала включите {{ objstorage-name }} и остальные зависимости, затем {{ model-gallery-name }} и {{ agent-atelier-name }}.

## Конфигурация {#configuration}

Компоненты управляются через кастомные ресурсы `ModelGalleryConfig` и `AgentAtelierConfig` с именем `main`. Оба ресурса работают на уровне кластера, пространство имен указывать не нужно. Параметр `spec.enabled` включает или отключает соответствующий компонент.

### {{ model-gallery-name }} {#model-gallery-configuration}

Пример включает Embeddings, Ethics и YandexGPT 5 Lite. Остальные языковые модели описаны, но отключены. Перед их включением добавьте ресурсы согласно [таблице](#model-resources) или отключите ненужные модели.

{% include notitle [YAML-файл](../../_includes/yamls/components/modelgalleryconfig.md) %}

Где:

* `settings.storageClass` — класс хранилища для постоянных томов. Если не задан, используется класс хранилища по умолчанию, выбранный при [развертывании кластера](../../quickstart.md#configuration) в поле `spec.cluster.storage.defaultStorageClass` ресурса `StacklandClusterConfig`.
* `settings.embeddings.enabled` — включает получение эмбеддингов.
* `settings.ethics.enabled` — включает проверку безопасности запросов и ответов.
* `settings.models` — список языковых моделей. Для включения модели установите `enabled: true`, для отключения — `enabled: false`.
* `nodeSelector` — метки узлов, на которых можно разместить под. Значения метки `nvidia.com/gpu.product` должны соответствовать GPU в вашем кластере.
* `affinity` — дополнительные правила размещения подов. Например, можно [задать предпочтительный узел](#model-affinity-example) для модели.
* `resources.requests` — запросы CPU, RAM и GPU, которые Kubernetes учитывает при размещении контейнера. `resources.limits` — ограничения ресурсов. Для `nvidia.com/gpu` укажите одинаковые значения в `requests` и `limits`.

Для языковых моделей используйте значения `name` и `modelType` из таблицы:

| Модель | `name` | `modelType` |
| --- | --- | --- |
| YandexGPT 5 Lite | `lite` | `yandexgpt-lite` |
| YandexGPT 5.1 Pro | `pro-5-1` | `yandexgpt-pro` |
| Alice 30B | `alice` | `yandexgpt-lite` |
| Alice Flash | `alice-flash` | `yandexgpt-lite` |

#### Пример настройки affinity {#model-affinity-example}

Чтобы задать предпочтительный узел для YandexGPT 5 Lite, замените `affinity: {}` у модели `lite` в `spec.settings.models` на следующую секцию:

```yaml
affinity:
  nodeAffinity:
    preferredDuringSchedulingIgnoredDuringExecution:
      - weight: 100
        preference:
          matchExpressions:
            - key: kubernetes.io/hostname
              operator: In
              values:
                - gpu1.stackland.internal
```

Замените `gpu1.stackland.internal` значением метки `kubernetes.io/hostname` нужного узла. Узнать значения меток можно командой `kubectl get nodes -L kubernetes.io/hostname`.

Правило повышает приоритет указанного узла при размещении пода. Kubernetes может выбрать другой узел, который соответствует `nodeSelector` и имеет свободные ресурсы. Подробнее о правилах размещения — в [документации Kubernetes](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#node-affinity).

### {{ agent-atelier-name }} {#agent-atelier-configuration}

Пример конфигурации с включенным Code Interpreter:

{% include notitle [YAML-файл](../../_includes/yamls/components/agentatelierconfig.md) %}

Где:

* `settings.storageClass` — класс хранилища для постоянных томов. По умолчанию `stackland-other`.
* `settings.codeInterpreter.enabled` — включает Code Interpreter. По умолчанию `false`.
* `settings.codeInterpreter.sessionIdleTTL` — время хранения неактивной сессии до удаления. По умолчанию `2h`.
* `settings.codeInterpreter.sessionHardTTL` — максимальное время жизни сессии независимо от активности. По умолчанию `24h`.

## См. также {#see-also}

* [{#T}](../../operations/ai-studio/install-images.md)
* [{#T}](../../operations/ai-studio/configure.md)
* [{#T}](../../operations/ai-studio/disable.md)
