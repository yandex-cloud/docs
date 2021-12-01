## Разработка контейнера на Go

С помощью сервиса {{ serverless-containers-name }} вы можете запускать приложения, написанные на [Go](https://golang.org/).

## Подготовка Docker-образ контейнера {#prepare}

Docker-образ — исполняемый пакет, который содержит все необходимое для запуска приложения: код, среду выполнения, библиотеки, переменные окружения и файлы конфигурации. Приложение должно принимать HTTP-запросы на порт, переданный в переменной окружения `PORT`.

Пример приложения на Go:

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

Пример Dockerfile:

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

Чтобы подготовить Docker-образ контейнера:

1. [Создайте](../../../container-registry/operations/registry/registry-create.md) реестр.
2. [Создайте и соберите](../../../container-registry/operations/docker-image/docker-image-create.md) Docker-образ на основе [Dockerfile](https://docs.docker.com/engine/reference/builder/). 
3. [Загрузите](../../../container-registry/operations/docker-image/docker-image-push.md) Docker-образ в реестр.

