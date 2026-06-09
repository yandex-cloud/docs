# Общие вопросы про Serverless Containers

#### Я могу получить логи моей работы в сервисах? {#logs}

Да, вы можете запросить информацию о работе с вашими ресурсами из логов сервисов Yandex Cloud. Для этого обратитесь в [техническую поддержку](https://center.yandex.cloud/support).

#### Почему при попытке отправить запрос к API сервиса возвращается ошибка `Illegal duration format`? {#illegal-duration}

При отправке API-запроса, тело которого содержит параметры в формате `type.googleapis.com/google.protobuf.Duration`, сервис может вернуть ошибку:

```text
Illegal duration format; duration must end with 's' for type type.googleapis.com/google.protobuf.Duration
```

Передавать значения в этом формате необходимо с добавлением суффикса `s`.

Например:

```json
{
  "timeout": "120s"
}
```