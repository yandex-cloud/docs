# Устранение ошибки TestsFailure


## Описание проблемы {#issue-description}

При сборке Docker-образа возникает ошибка тестирования: 
```
TestsFailure:It is not possible to start the docker container for testing.
Make sure that the requirements from the documentation are satisfied.
```

## Решение {#issue-resolution}

Тесты корректности проверяют, можно ли на таком образе запустить работу проекта. Возможные ошибки:
1. Образ предназначен для запуска сервиса (например, веб-приложения), а не для запуска внутри среды Jupyter, а не для запуска Jupyter. 
2. Ошибка возникает из-за того, что в докере нет пользователя `jupyter`. Установить его можно командой:
```
RUN useradd -ms /bin/bash --uid 1000 jupyter
```

## Если проблема осталась {#if-issue-still-persists}

Если вышеописанные действия не помогли решить проблему, [создайте запрос в техническую поддержку]({{ link-console-support }}).

При создании запроса приложите ваш Dockerfile для анализа.