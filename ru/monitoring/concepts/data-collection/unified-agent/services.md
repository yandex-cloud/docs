---
title: Служебные секции
description: 'Из статьи вы узнаете про служебные секции: status, main_thread_pool, agent_log, system и flow_control.'
---

# Служебные секции

## Секция status {#status}

Секция содержит конфигурацию просмотра статуса {{ unified-agent-short-name }}.

```yaml
status:  # необязательно
  # Просмотр статуса можно отключить, установив значение false.
  enabled: true  # необязательный, по умолчанию true

  # Хост для просмотра статуса, null/пустая строка/:: — на всех интерфейсах.
  # По умолчанию, из соображений безопасности, сервис статуса доступен только локально.
  host: localhost  # необязательный

  # Порт для просмотра статуса.
  port: 16301  # обязательный
```

## Секция main_thread_pool {#main_thread_pool}
Секция содержит конфигурацию потоков выполнения.

Описание параметров:

```yaml
main_thread_pool:  # необязательно
  # Число потоков.
  threads: 1  # необязательный, по умолчанию 1
```

## Секция agent_log {#agent_log}
Секция содержит настройки логов самого агента. Могут быть переопределены через параметры командной строки.

Описание параметров:

```yaml
agent_log:  # необязательный
  # Уровень логирования.
  # Возможные значения: EMERG, ALERT, CRITICAL_INFO, ERROR, WARNING, NOTICE, INFO, DEBUG, RESOURCES.
  priority: NOTICE  # необязательный, по умолчанию NOTICE

  # Писать логи в указанный файл.
  file: cerr  # необязательный, по умолчанию cerr (стандартный поток ошибок)

  # Ограничить скорость записи логов указанным значением.
  # Превышение будет отбрасываться, число отброшенных таким образом байт отражается в счетчике DroppedBytes в группе agent-log.
  rate_limit_bytes: null  # необязательно, по умолчанию не задан
```

## Секция system {#system}
Разные системные настройки.

Описание параметров:

```yaml
system:  # необязательный
  # Заблокировать вытеснение из памяти исполняемого кода агента с помощью системного вызова mlock.
  # Может помочь уменьшить задержки, так как при исполнении не будет major page faults для подгрузки кода с диска.
  lock_executable_in_memory: false  # необязательный, по умолчанию false

  # Установить лимит на объем используемой памяти с помощью системного вызова setrlimit.
  memory_limit: null  # необязательный, по умолчанию не задан
```

## Секция flow_control {#flow_control}
Секция содержит конфигурацию механизма работы с сессиями. Настройки позволяют сконфигурировать различные ограничения сессий и поведение при достижении этих ограничений.

Секцию `flow_control` можно указывать для входов и для ссылок на хранилища `storage_ref`.

Описание параметров:

```yaml
flow_control:  # необязательный
  # Настройки буфера сессии.
  # Ограничение может быть выражено в байтах и в штуках сообщений.
  # При превышении любого из них срабатывает логика, заданная в атрибуте action.
  # Ограничение в штуках может быть полезно, когда на вход поступает много мелких сообщений, каждое из которых приводит к созданию большого выходного сообщения.
  inflight:
    # Размер буфера в байтах.
    limit: 10mb  # необязательный, по умолчанию 10mb

    # Размер буфера в штуках сообщений.
    limit_messages: null  # необязательный, по умолчанию не задан

    # Поведение при заполнении буфера:
    #   * backpressure — приостановить прием новых сообщений до освобождения буфера;
    #   * drop — отбрасывать новые сообщения, если они не помещаются в буфер.
    action: backpressure  # необязательный, по умолчанию backpressure

  # Ограничение на частоту создания новых сессий, в штуках новых сессий в секунду.
  # При превышении ограничения метод StartSession вернет TStartSessionResult::Throttled в поле Status.
  # Для хранилищ значение по умолчанию: отсутствует.
  # Для входов значение по умолчанию: 5.
  new_sessions_rate_limit: 5 # необязательный, по умолчанию 5 для input-ов, не поддерживается для storage_ref
```
