# Устранение ошибки `user container exec format error`


## Описание проблемы {#issue-description}

При попытке запуска контейнера в Serverless Containers в его логах отображается сообщение об ошибке:

```
"errorMessage":"user container finished with error: fork/exec /usr/local/bin/python3: exec format error","errorType":"UserCodeError"}
```

## Решение {#issue-resolution}

Рекомендуем собрать контейнер с явно указанной архитектурой `--platform=linux/amd64`.

Подробнее среда выполнения контейнеров Serverless Containers описана [в соответствующем разделе документации](../../../serverless-containers/concepts/runtime.md)

## Если проблема осталась {#if-issue-still-persists}

Если вышеописанные действия не помогли решить проблему, [создайте запрос в техническую поддержку](https://center.yandex.cloud/support). При создании запроса укажите следующую информацию:

1. Идентификатор контейнера Serverless Containers.
1. Полный текст сообщения об ошибке из лога запуска контейнера.