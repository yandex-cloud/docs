[Документация Yandex Cloud](../../../index.md) > [Yandex API Gateway](../../index.md) > [Концепции](../index.md) > [Триггер](index.md) > Триггер для Container Registry

# Триггер для Container Registry, который отправляет сообщения в WebSocket-соединения

[Триггер](index.md) для Container Registry отправляет сообщения в [WebSocket-соединения](../extensions/websocket.md), когда с [Docker-образом](../../../container-registry/concepts/docker-image.md) Container Registry происходят определенные события. Триггер должен находиться в одном облаке с [реестром](../../../container-registry/concepts/registry.md), на события которого он подписан.

Триггеру для Container Registry необходим [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md) для отправки сообщений в WebSocket-соединения.

О том, как создать триггер для Container Registry, читайте в инструкции [Создать триггер для Container Registry, который отправляет сообщения в WebSocket-соединения](../../operations/trigger/cr-trigger-create.md).

## События для настройки триггера {#event}

События с Docker-образами, которые можно отслеживать с помощью триггера:
* [Создание Docker-образа](../../../container-registry/operations/docker-image/docker-image-push.md).
* [Удаление Docker-образа](../../../container-registry/operations/docker-image/docker-image-delete.md).
* Создание тега Docker-образа.
* Удаление тега Docker-образа.

Docker-образ всегда загружается с тегом (если тег не указан, Docker автоматически подставит тег `latest`), поэтому событие `CreateImage` всегда идет в паре с `CreateImageTag`. Docker-образу можно добавить произвольное количество тегов, загрузив тот же образ с другими тегами. В этом случае произойдет только событие `CreateImageTag`, без `CreateImage`.

Тег может переходить от одного Docker-образа к другому. Это происходит при загрузке нового Docker-образа с тегом, который уже используется в другом Docker-образе. В таком случае произойдет событие `CreateImage` для нового Docker-образа, а изменение тега спровоцирует два события: `DeleteImageTag` (удаление тега у старого Docker-образа) и `CreateImageTag` (присвоение тега новому Docker-образу).

При удалении Docker-образа удаляются все его теги. Поэтому удаление Docker-образа всегда вызывает событие `DeleteImage`, а также столько событий `DeleteImageTag`, сколько тегов было у Docker-образа в момент удаления.

### Фильтрация событий {#filter}

События фильтруются с помощью тегов и имен загружаемых Docker-образов. Если одновременно используются имя и тег, фильтрация происходит по принципу логического `И`: чтобы триггер сработал, образ должен подходить и по имени, и по тегу.

## Группирование событий {#batching}

Настройки группирования позволяют отправлять в WebSocket-соединения сразу несколько событий. Эти настройки задают ограничение сверху по размеру группы событий и по времени ее накопления. Например, если размер группы событий равен 3, то в WebSocket-соединения могут отправляться группы, в которых содержится от 1 до 3 событий.

## Роли, необходимые для корректной работы триггера для Container Registry {#roles}

* Для создания триггера вам необходимы:
    * Разрешение на сервисный аккаунт, от имени которого триггер выполняет операцию. Это разрешение входит в роли [iam.serviceAccounts.user](../../../iam/security/index.md#iam-serviceAccounts-user), [editor](../../../iam/roles-reference.md#editor) и выше.
    * Роль `container-registry.images.puller` на реестр, события которого триггер обрабатывает.
* Для работы триггера сервисному аккаунту необходима роль `api-gateway.websocketBroadcaster` на каталог, в котором находится API-шлюз.

Подробнее об [управлении доступом](../../security/index.md).

## Формат сообщения от триггера Container Registry {#format}

После того как триггер сработает, он отправит в WebSocket-соединения следующее сообщение:

```json
{
  "messages": [
  {
    "event_metadata": {
      "cloud_id": "b1gvlrnlw2e6********",
      "created_at": "2020-09-07T11:09:14Z",
      "event_id": "crtpk611vb7g********",
      "event_type": "yandex.cloud.events.containerregistry.CreateImage",
      "folder_id": "b1g88tfl0pl8********",
      "tracing_context": {
        "parent_span_id": "-14915794679********",
        "span_id": "-72326631357********",
        "trace_id": "70e7m4n2********"
      }
    },
    "details": {
      "image_digest": "sha256:45f8f740272f1f2a053eade37d8d45f8f740272f1f2a053eade37d8d********",
      "image_id": "crti2c9bpk61********",
      "registry_id": "crt2504svlrn********",
      "repository_name": "crt2504s1gvl********/ubuntu",
      "tag": "latest"
    }
  }]
}
```

## Полезные ссылки {#see-also}

* [Триггер для Container Registry, который запускает контейнер Serverless Containers](../../../serverless-containers/concepts/trigger/cr-trigger.md)
* [Триггер для Container Registry, который запускает функцию Cloud Functions](../../../functions/concepts/trigger/cr-trigger.md)