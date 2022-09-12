# Триггер для {{ container-registry-name }}

[Триггер](../trigger/) для {{ container-registry-name }} запускает [контейнер](../container.md) {{ serverless-containers-name }}, когда с [Docker-образом](../../../container-registry/concepts/docker-image.md) {{ container-registry-full-name }} происходят определенные события. Триггер должен находиться в одном облаке с [реестром](../../../container-registry/concepts/registry.md), на события которого он подписан.

Триггеру для {{ container-registry-name }} необходим [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md) для вызова контейнера.

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

## Роли, необходимые для корректной работы триггера для {{ container-registry-name }} {#roles}

Для создания триггера вам необходимо:
* Разрешение на сервисный аккаунт, от имени которого триггер выполняет операцию. Это разрешение входит в роли [iam.serviceAccounts.user](../../../iam/concepts/access-control/roles.md#sa-user), [editor](../../../iam/concepts/access-control/roles.md#editor) и выше.
* Роль `{{ roles-cr-puller }}` на реестр, события которого триггер обрабатывает.
* Сервисному аккаунту назначить роль `serverless.containers.invoker` на каталог с контейнером, который вызывает триггер.

Подробнее об [управлении доступом](../../security/index.md).

## Формат сообщения от триггера {{ container-registry-name }} {#ymq-format}

После того как триггер сработает, он отправит в контейнер сообщение следующего вида:

```json
{
  "messages": [
  {
    "event_metadata": {
      "cloud_id": "b1gvlrnl************",
      "created_at": "2020-09-07T11:09:14Z",
      "event_id": "crtpk611************",
      "event_type": "yandex.cloud.events.containerregistry.CreateImage",
      "folder_id": "b1g88tfl************",
      "tracing_context": {
        "parent_span_id": "-1491579************",
        "span_id": "-7232663************",
        "trace_id": "70e7************"
      }
    },
    "details": {
      "image_digest": "sha256:45f8f740272f1f2a053eade37d8d************************************",
      "image_id": "crti2c9b************",
      "registry_id": "crt2504s************",
      "repository_name": "crt2504s************/ubuntu",
      "tag": "latest"
    }
  }]
}
```

## См. также {#see-also_}

* [Триггер для {{ container-registry-name }}, который запускает функцию {{ sf-name }}](../../../functions/concepts/trigger/cr-trigger.md).