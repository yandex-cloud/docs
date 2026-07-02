[Документация Yandex Cloud](../../../index.md) > [Yandex API Gateway](../../index.md) > [Концепции](../index.md) > [Триггер](index.md) > Триггер для Data Streams

# Триггер для Data Streams, который отправляет сообщения в WebSocket-соединения

[Триггер](index.md) для Data Streams отправляет сообщения в [WebSocket-соединения](../extensions/websocket.md) при отправке данных в [поток](../../../data-streams/concepts/glossary.md#stream-concepts).

Триггеру для Data Streams необходимы [сервисные аккаунты](../../../iam/concepts/users/service-accounts.md) для управления потоком и отправки сообщений в WebSocket-соединения. Вы можете использовать один и тот же сервисный аккаунт для обеих операций.

О том, как создать триггер для Data Streams, читайте в инструкции [Создать триггер для Data Streams, который отправляет сообщения в WebSocket-соединения](../../operations/trigger/data-streams-trigger-create.md).

## Группирование сообщений {#batching}

Настройки группирования позволяют передавать в WebSocket-соединения сразу несколько сообщений. Эти настройки задают ограничение сверху по размеру группы сообщений и по времени ее накопления. Например, если размер группы сообщений равен 3, то в WebSocket-соединения могут поступать группы, в которых содержится от 1 до 3 сообщений.

## Роли, необходимые для корректной работы триггера для Data Streams {#roles}

* Для создания триггера вам необходимо разрешение на сервисный аккаунт, от имени которого триггер выполняет операцию. Это разрешение входит в роли [iam.serviceAccounts.user](../../../iam/concepts/access-control/roles.md#sa-user), [editor](../../../iam/concepts/access-control/roles.md#editor) и выше.
* Для работы триггера сервисным аккаунтам необходимы роли:
    * `api-gateway.websocketBroadcaster` на каталог, в котором находится API-шлюз;
    * `yds.admin` на поток, при отправке данных в который вызывается триггер.

## Формат сообщения от триггера для Data Streams {#format}

Триггер для Data Streams принимает и отправляет сообщения только в формате [JSON](https://ruwikipedia.org/wiki/JSON).

После того как триггер сработает, он отправит в WebSocket-соединения сообщение с массивом `messages`:

```json
{
   "messages":[
      {
         "key1":"value1"
      },
      {
         "key2":"value2"
      }
   ]
}
```

## Полезные ссылки {#see-also}

* [Триггер для Data Streams, который запускает контейнер Serverless Containers](../../../serverless-containers/concepts/trigger/data-streams-trigger.md)
* [Триггер для Data Streams, который запускает функцию Cloud Functions](../../../functions/concepts/trigger/data-streams-trigger.md)