# История изменений в {{ serverless-containers-full-name }}

## Апрель 2026 {#april-2026}

### Исправления и улучшения {#fixes-improvements}

* Параметр `batch_cutoff` для триггеров в {{ TF }} теперь опциональный, а `terraform plan` больше не предлагает задать нулевые значения для настроек группирования.

## Март 2026 {#march-2026}

### Обновления {#updates}

* Добавлена передача параметров сервиса метаданных контейнера в аудитные логи {{ at-name }}.

### Исправления и улучшения {#fixes-improvements}

* Исправлена работа триггера для {{ container-registry-name }}, который срабатывает при изменении тегов Docker-образов: теперь в сообщении от триггера передается имя добавленного или удаленного тега.
* Исправлены аудитные логи {{ at-name }} триггеров для {{ objstorage-name }} и {{ yds-name }}: устранены ошибки proto-валидации в полях `request_parameters.rule` и `details.trigger_rule`.

## Февраль 2026 {#february-2026}

### Обновления {#updates}

* Добавлена поддержка сервиса {{ serverless-containers-name }} в [калькуляторе цен](https://yandex.cloud/ru/prices).

### Исправления и улучшения {#fixes-improvements}

* Исправлено вычисление [метрик](metrics.md) {{ monitoring-name }}.

## Сентябрь 2025 {#september-2025}

### Обновления {#updates}

* Добавлена поддержка [запуска Docker внутри контейнера](tutorials/serverless-gitlab-runner.md).

## Июль 2025 {#july-2025}

### Обновления {#updates}

* Увеличено количество [пользовательских сетей](concepts/networking.md#user-network) в одном облаке по умолчанию с 1 до 10. Теперь это не лимит, а [квота](concepts/limits.md#serverless-containers-quotas), которую можно изменить по запросу в техническую поддержку.

## Апрель 2025 {#april-2025}

### Исправления и улучшения {#fixes-improvements}

* Более чем в 2 раза ускорена сборка ревизий контейнеров.

## Февраль 2025 {#february-2025}

### Обновления {#updates}

* Добавлена поддержка [настройки параметров сервиса метаданных контейнера](operations/metadata-options.md).

## Декабрь 2024 {#december-2024}

### Обновления {#updates}

* Добавлена поддержка выбора [режима работы контейнера](operations/update-runtime.md#console_1) в консоли управления.

## Ноябрь 2024 {#november-2024}

### Обновления {#updates}

* Добавлена поддержка выбора [режима работы контейнера](operations/update-runtime.md) в CLI, API и {{ TF }}.

## Сентябрь — октябрь 2024 {#sept-oct-2024}

### Обновления {#updates}

* Добавлена поддержка [долгоживущих контейнеров](concepts/long-lived-containers.md).
* Добавлена поддержка отправки [уведомлений о завершении выполнения контейнера](concepts/termination-notifications.md).
* Добавлена поддержка [монтирования эфемерных дисков](concepts/mounting.md#mount-ephemeral-storage).

## Апрель 2024 {#april-2024}

### Исправления и улучшения {#fixes-improvements}

* Удалено требование для [пользовательской сети](concepts/networking.md#user-network) иметь подсеть в зоне доступности `ru-central1-c` в связи с [выводом этой зоны из эксплуатации](../overview/concepts/region.md).

## Март 2024 {#march-2024}

### Обновления {#updates}

* Добавлена поддержка редактирования всех параметров триггеров в {{ TF }}.
* [Монтирование бакетов {{ objstorage-full-name }}](concepts/mounting.md) в контейнер перешло на [стадию General Availability](../overview/concepts/launch-stages.md).

### Исправления и улучшения {#fixes-improvements}

* Максимальный размер группы в [триггере для {{ message-queue-full-name }}](concepts/trigger/ymq-trigger.md) увеличен до 1000 сообщений.

## Январь — февраль 2024 {#jan-feb-2024}

### Обновления {#updates}

* Добавлена поддержка настроек логирования для контейнера в {{ TF }}.
* Добавлена поддержка [монтирования бакетов {{ objstorage-full-name }}](concepts/mounting.md) в контейнер в CLI и {{ TF }}.