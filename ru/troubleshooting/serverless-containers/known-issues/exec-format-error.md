# Устранение ошибки user container exec format error


## Описание проблемы {#issue-description}

* При попытке запуска контейнера в {{ serverless-containers-name }} в логах контейнера отображается сообщение об ошибке:

```

"errorMessage":"user container finished with error: fork/exec /usr/local/bin/python3: exec format error","errorType":"UserCodeError"}

```

## Решение {#issue-resolution}

Попробуйте собрать контейнер с явно указанной архитектурой `--platform=linux/amd64`.
Более подробно среда выполнения контейнеров {{ serverless-containers-name }} описана [в соответствующем материале документации](../../../serverless-containers/concepts/runtime.md)


## Если проблема осталась {#if-issue-still-persists}

Если вышеописанные действия не помогли решить проблему, [создайте запрос в техническую поддержку]({{ link-console-support }}).
При создании запроса просим указать следующую информацию:

1. Иденитификатор контейнера {{ serverless-containers-name }}.
2. Полный текст сообщения об ошибке из лога запуска контейнера.
