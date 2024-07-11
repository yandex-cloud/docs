# История изменений в {{ sf-full-name }}

## Май — июнь 2024 {#may-june-2024}

### Обновления {#updates}

* Добавлена поддержка параметра `concurrency` в CLI, API и {{ TF }}.

### Исправления и улучшения {#fixes-improvements}

* Исправлена ошибка, возникающая при создании версий функции со средой выполнения `golang`, которые используют пакет [opentracing-go](github.com/opentracing/opentracing-go).

## Апрель 2024 {#april-2024}

### Обновления {#updates}

* Добавлена поддержка [выделения оперативной памяти для директории /tmp](operations/function/allocate-memory-tmp.md) для версии функции, объем памяти которой не менее 1 ГБ.

### Исправления и улучшения {#fixes-improvements}

* Исправлена ошибка импорта `yandex_function_scaling_policy` в {{ TF }}.
* Удалено требование для [пользовательской сети](concepts/networking#user-network) иметь подсеть в зоне доступности `ru-central1-c` в связи с [выводом этой зоны из эксплуатации](../overview/concepts/ru-central1-c-deprecation).

## Март 2024 {#march-2024}

### Обновления {#updates}

* Добавлена поддержка редактирования всех параметров триггеров в {{ TF }}.
* [Монтирование бакетов {{ objstorage-full-name }}](concepts/mounting.md) в функцию перешло на [стадию General Availability](../overview/concepts/launch-stages.md).

### Исправления и улучшения {#fixes-improvements}

* Максимальный размер группы в [триггере для {{ message-queue-full-name }}](concepts/trigger/ymq-trigger.md) увеличен до 1000 сообщений.

## Январь — февраль 2024 {#jan-feb-2024}

### Обновления {#updates}

* Добавлена поддержка [монтирования бакетов {{ objstorage-full-name }}](concepts/mounting.md) в функцию в CLI и {{ TF }}.
* Добавлена поддержка настроек логирования для функции в {{ TF }}.

### Исправления и улучшения {#fixes-improvements}

* Исправлена ошибка отображения квоты на количество тегов функции.
