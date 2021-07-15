# Начало работы

В этой инструкции вы [подготовите](#prepare) Docker-образ контейнера в {{ container-registry-name }} и [добавите](#deploy) его в {{ serverless-containers-name }}.

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

1. Создайте контейнер:

	```
	yc serverless container create --name <имя контейнера>
	```

	Результат:

	```
	id: bba3fva6ka5g********
	folder_id: b1gqvft7kjk3********
	created_at: "2021-07-09T14:49:00.891Z"
	name: my-container
	url: https://bba3fva6ka5g********.containers.yandexcloud.net/
	status: ACTIVE
	```

2. Загрузите версию контейнера:

	{% note info %}

	Для загрузки версии сделайте образ публичным или передайте в команде [идентификатор сервисного аккаунта](../iam/operations/sa/get-id.md), у которого есть права на скачивание образа.

	{% endnote %}

	```
	yc serverless container revision deploy\
	  --container-name <имя контейнера> \
	  --image <тег Docker-образа> \
	  --cores 1 \
	  --memory 1GB \
	  --service-account-id <идентификатор сервисного аккаунта>
	```

	Результат:

	```
	id: bbajn5q2d74c********
	container_id: bba3fva6ka5g********
	created_at: "2021-07-09T15:04:55.135Z"
	image:
	  image_url: cr.yandex/crpd3cicopk7********/test-container:latest
	  image_digest: sha256:de8e1dce7ceceeafaae122f7670084a1119c961cd9ea1795eae92bd********
	resources:
	  memory: "1073741824"
	  cores: "1"
	execution_timeout: 3s
	service_account_id: ajeqnasj95o7********
	status: ACTIVE
	```

## Проверьте результат

После создания контейнера вы получите эндпоинт. Отправьте HTTP-запрос к эндпоинту, передав [IAM-токен](../iam/concepts/authorization/iam-token.md) в заголовке `Authorization`:

```
curl -H "Authorization: Bearer $(yc iam create-token)" https://bba3fva6ka5g********.containers.yandexcloud.net/hello
```

Результат:

```
Hello world!
```
