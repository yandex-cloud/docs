# Начало работы

В этой инструкции вы [подготовите](#prepare) Docker-образ контейнера в {{ container-registry-full-name }} и [добавите](#deploy) его в {{ serverless-containers-name }}.

## Подготовьте Docker-образ контейнера {#prepare}

Docker-образ — исполняемый пакет, который содержит все необходимое для запуска приложения: код, среду выполнения, библиотеки, переменные окружения и файлы конфигурации. Приложение должно принимать HTTP-запросы на порт, переданный в переменной окружения `PORT`.

Пример приложения на [Go](https://golang.org/):

```golang
package main

import (
	"net/http"
	"os"
)

func main() {
	portStr := os.Getenv("PORT")
	http.ListenAndServe(":" + portStr, hwHandler{})
}

type hwHandler struct{}

func (hwHandler) ServeHTTP(writer http.ResponseWriter, request *http.Request) {
	writer.WriteHeader(200)
	_, _ = writer.Write([]byte("Hello world!"))
}
```

Чтобы подготовить Docker-образ контейнера:

1. [Создайте](../container-registry/operations/registry/registry-create.md) реестр.
1. [Создайте и соберите](../container-registry/operations/docker-image/docker-image-create.md) Docker-образ на основе [Dockerfile](https://docs.docker.com/engine/reference/builder/). Пример Dockerfile:

    ```
    FROM golang:latest AS build
    RUN mkdir /app
    ADD . /app/
    WORKDIR /app
    RUN go build -a -tags netgo -ldflags '-w -extldflags "-static"' -o server-app *.go

    FROM scratch
    COPY --from=build /app/server-app /server-app
    ENTRYPOINT ["/server-app"]
    ```

1. [Загрузите](../container-registry/operations/docker-image/docker-image-push.md) Docker-образ в реестр.

## Добавьте образ в {{ serverless-containers-name }} {#deploy}

### Создайте контейнер {#create-container}

{% include [create-container](../_includes/serverless-containers/create-container.md) %}

### Создайте ревизию контейнера {#create-revision}

{% include [create-revision](../_includes/serverless-containers/create-revision.md) %}

## Вызовите контейнер {#invoke}

После создания контейнера вы получите ссылку для вызова. [Как узнать ее.](./operations/invoke.md#link) Сделайте HTTPS-запрос, передав [IAM-токен](../iam/concepts/authorization/iam-token.md) в заголовке `Authorization`:

```
curl -H "Authorization: Bearer $(yc iam create-token)" https://bba3fva6ka5g********.containers.yandexcloud.net/hello
```

Результат:

```
Hello world!
```
