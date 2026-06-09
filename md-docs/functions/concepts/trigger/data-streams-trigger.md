# Триггер для Data Streams, который вызывает функцию Cloud Functions

 [Триггер](index.md) для Data Streams запускает [функцию](../function.md) Cloud Functions при отправке данных в [поток](../../../data-streams/concepts/glossary.md#stream-concepts). 

Триггеру для Data Streams необходимы [сервисные аккаунты](../../../iam/concepts/users/service-accounts.md) для управления потоком и вызова функции. Вы можете использовать один и тот же сервисный аккаунт для обеих операций.

О том, как создать триггер для Data Streams, читайте в инструкции [Создать триггер для Data Streams, который вызывает функцию Cloud Functions](../../operations/trigger/data-streams-trigger-create.md).

## Группирование сообщений {#batching}

Настройки группирования позволяют передавать в функцию сразу несколько сообщений. Эти настройки задают ограничение сверху по размеру группы сообщений и по времени ее накопления. Например, если размер группы сообщений равен 3, то в функцию могут поступать группы, в которых содержится от 1 до 3 сообщений.

## Роли, необходимые для корректной работы триггера для Data Streams {#roles}

* Для создания триггера вам необходимо разрешение на сервисный аккаунт, от имени которого триггер выполняет операцию. Это разрешение входит в роли [iam.serviceAccounts.user](../../../iam/concepts/access-control/roles.md#sa-user), [editor](../../../iam/concepts/access-control/roles.md#editor) и выше.
* Для работы триггера сервисным аккаунтам необходимы роли:
    * `functions.functionInvoker` на функцию, которую вызывает триггер;
    * `yds.admin` на поток, при отправке данных в который вызывается триггер.

## Формат сообщения от триггера для Data Streams {#format}

Триггер для Data Streams принимает и отправляет сообщения только в формате [JSON](https://ruwikipedia.org/wiki/JSON).

После того как триггер сработает, он отправит в функцию сообщение с массивом `messages`:

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

## Примеры использования {#examples}

* [Передача событий Yandex Cloud Postbox в Yandex Data Streams и их анализ с помощью Yandex DataLens](../../tutorials/events-from-postbox-to-yds.md)

## См. также {#see-also}

* [Триггер для Data Streams, который вызывает контейнер Serverless Containers](../../../serverless-containers/concepts/trigger/data-streams-trigger.md)
* [Триггер для Data Streams, который отправляет сообщения в WebSocket-соединения](../../../api-gateway/concepts/trigger/data-streams-trigger.md)