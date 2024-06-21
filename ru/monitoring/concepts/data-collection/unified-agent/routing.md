# Маршрутизация

К маршрутизации сообщений можно отнести маршруты, каналы и цепочки преобразования.

## Секция routes {#routes}
Секция содержит список [маршрутов доставки](index.md#routing).

Маршрут доставки состоит из следующих элементов:

- `input` — [вход](index.md#inputs):
  - `plugin` — плагин [входа](inputs.md);
  - `config` — конфигурация [входа](#inputs);
  - `flow_control` — конфигурация механизма создания сессий входа.
- `channel` — [канал](index.md#channels):
  - `pipe` — цепочка обработки:
    - `filter` – [фильтр](filters.md);
    - `storage` — [хранилище](storage.md).
  - один из элементов:
    - `output` — [выход](outputs.md);
    - `channel_ref` — ссылка на именованный канал;
    - `case` — разветвитель, направляющий входной поток в один или несколько дочерних каналов по условию;
    - `fanout` — разветвитель, безусловно направляющий входной поток во все дочерние каналы.

Пример секции `routes`:

```yaml
routes:
  - input:
      plugin: someinput
    channel:
      pipe:
        - filter:
            plugin: somefilter
            config: ...
        - filter:
            plugin: somefilter
            config: ...
        - storage:
            storage_ref:
              name: mystorage
      output:
        plugin: someoutput
        config: ...

  - input:
      plugin: someinput
    channel:
      pipe:
        - filter:
            plugin: somefilter
            config: ...
      channel_ref:
        name: mychannel

  - input:
      plugin: someinput
    channel:
      pipe:
        - filter:
            plugin: somefilter
            config: ...
      fanout:
        - channel:
            ...
        - channel:
            ...
```

Пример использования элемента `case`:

```yaml
- input:
    plugin: console
  channel:
    # Элемент case направляет входной поток в первый дочерний канал, подходящий по условию when.
    # Сообщение будет отброшено, если для него не удалось найти подходящий channel.
    # Этот факт будет учтен в health-счетчиках (Errors) и pipeline-счетчиках (DroppedMessages/DroppedBytes).
    # В логах агента будет сделана соответствующая запись с уровнем ERROR.
    # Данная ситуация рассматривается как нештатная.
    # Ее можно избежать, если добавить в case последним элементом catch all channel без фильтра when.
    case:
      # Внутри when можно описать условия на соответствие метаданных сообщения и сессии, по аналогии с фильтром match.
      - when:
          message:
            message-key: v1
          session:
            session-key: v2
        channel:
          output:
            plugin: dev_null

      # Внутри when любой из элементов message и session может отсутствовать.
      # Поддерживается свойство continue — не останавливать поиск подходящего канала, если условие when выполнено.
      # Таким образом можно направить входящие сообщения в несколько подходящих каналов.
      - when:
          message:
            message-key: v1
        channel:
          output:
            plugin: dev_null
        continue: true

      # Элемент when может отсутствовать, в этом случае входной поток будет безусловно направлен в этот канал, если для него удалось создать сессию — никакой вложенный в него фильтр не отклонил создание сессии.
      - channel:
          output:
            plugin: dev_null
```

## Секция channels {#channels}

[Канал](index.md#channels) можно описать в секции `routes`:`channel` или в отдельной секции `channels`. Перечисленные в отдельной секции каналы можно использовать в маршрутах доставки, обращаясь к ним по имени.

Пример секции `channels`:

```yaml
channels:
  - name: named_channel
    channel:
      # Именованные каналы могут ссылаться на другие именованные каналы.
      channel_ref:
        name: other_named_channel

  - name: other_named_channel
    channel:
      output:
        plugin: dev_null

        # В любой плагин можно добавить идентификатор входа, выхода, хранилища и фильтра.
        # Этот идентификатор будет подставляться в метку plugin_id в мониторинге.
        # Также этим идентификатором будут отмечены соответствующие плагину записи в логе агента.
        id: my_dev_null_output
```

Пример маршрута доставки, использующего именованный канал:

```yaml
- input:
    plugin: console
  channel:
    channel_ref:
      name: named_channel
```

## Секция pipes {#pipes}

[Цепочку обработки](index.md#pipes) можно описать в секции `routes` внутри элемента `channel`:`pipe`, либо в отдельной секции `pipes`. Перечисленные в отдельной секции цепочки можно использовать в каналах, обращаясь к ним по имени.

Пример секции `pipes`:

```yaml
pipes:
  - name: named_pipe
    pipe:
      - filter:
          plugin: batch
          config:
              limit:
                bytes: 100kb
      - filter:
            plugin: assign
            config:
              message:
                - _payload: "{_timestamp:%b %d %H:%M:%S} {_payload}"
```

Пример маршрута доставки, использующего именованную цепочку обработки:

```yaml
- input:
    plugin: console
  channel:
    pipe:
      - pipe_ref:
          name: named_pipe
    output:
      plugin: debug
```
