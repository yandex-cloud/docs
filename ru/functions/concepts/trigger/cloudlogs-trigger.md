# Триггер для {{ cloud-logs-name }}

Триггер для {{ cloud-logs-name }} запускает функцию, когда в [лог-группу](../../../functions/concepts/log-group.md) поступают сообщения. Триггер должен находиться в одном каталоге с лог-группами, на которые он подписан.

Триггеру для {{ cloud-logs-name }} необходим [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md) для вызова функции.

## Батчинг {#batching}

Настройки батчинга позволяют передавать в функцию сразу несколько сообщений. Эти настройки задают ограничение сверху по размеру группы сообщений и по времени ее накопления. Например, если размер группы сообщений равен 3, то в функцию могут поступать группы, в которых содержится от 1 до 3 сообщений.

## Роли, необходимые для корректной работы триггера для {{ cloud-logs-name }} {#roles}

- Для создания триггера вам необходимо разрешение на сервисный аккаунт, от имени которого триггер выполняет операцию. Это разрешение входит в роли [iam.serviceAccounts.user](../../../iam/concepts/access-control/roles.md#sa-user), [editor](../../../iam/concepts/access-control/roles.md#editor) и выше.
- Для работы триггера сервисному аккаунту необходима роль `{{ roles-functions-ivoker }}` на каталог с функцией, которую вызывает триггер.

Подробнее об [управлении доступом](../../security/index.md).

## Формат сообщения от триггера {{ cloud-logs-name }} {#ymq-format}

После того, как триггер сработает, он отправит в функцию сообщение следующего вида: 

```json

{
  "messages": [
    {
      "event_metadata": {
        "event_id": "564ab7ff-5890-4eca-b8ab-************",
        "event_type": "yandex.cloud.events.serverless.triggers.CloudLogsMessageBatch",
        "created_at": {
          "seconds": 1599563113,
          "nanos": 647071528
        }
      },
      "details": {
        "messages": [
          {
            "log_group_id": "eol1fphr************",
            "log_stream_name": "log-stream-name",
            "message": "message-1",
            "timestamp": "2020-09-08T11:05:10Z"
          },
          {
            "log_group_id": "eol1fphr************",
            "log_stream_name": "log-stream-name",
            "message": "message-2",
            "timestamp": "2020-09-08T11:05:10Z"
          }
        ]
      }
    }
  ]
}