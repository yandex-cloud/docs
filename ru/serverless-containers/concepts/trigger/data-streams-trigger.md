# Триггер для {{ yds-full-name }}

{% if audience == "external" %} Триггер для {{ yds-full-name }} запускает [контейнер](../container.md) {{ serverless-containers-name }} при отправке данных в [поток](../../../data-streams/concepts/glossary.md#stream-concepts). {% endif %}

## Роли, необходимые для корректной работы триггера для {{ yds-name }} {#roles}

* Для создания триггера вам необходимо разрешение на сервисный аккаунт, от имени которого триггер выполняет операцию. Это разрешение входит в роли [iam.serviceAccounts.user](../../../iam/concepts/access-control/roles#sa-user), [editor](../../../iam/concepts/access-control/roles#editor) и выше.
* Для работы триггера сервисному аккаунту необходима роль:
    * `serverless.containers.invoker` на контейнер, который вызывает триггер.
    * `yds.admin` на поток, при отправке данных в который вызывается триггер.

## Формат сообщения от триггера для {{ yds-name }} {#format}

После того как триггер сработает, он отправит в контейнер сообщение. Формат сообщения зависит от источника и представляет собой массив `messages`:

```
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

## См. также {#see-also_}

* [Триггер для {{ yds-name }}, который запускает функцию {{ sf-name }}](../../../functions/concepts/trigger/data-streams-trigger.md).