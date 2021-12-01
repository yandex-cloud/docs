# Начало работы

В этой инструкции вы [подготовите](#prepare) Docker-образ контейнера в {{ container-registry-full-name }} и [добавите](#deploy) его в {{ serverless-containers-name }}.

## Подготовьте Docker-образ контейнера {#prepare}

Docker-образ — исполняемый пакет, который содержит все необходимое для запуска приложения: код, среду выполнения, библиотеки, переменные окружения и файлы конфигурации. Приложение должно принимать HTTP-запросы на порт, переданный в переменной окружения `PORT`.

Чтобы подготовить Docker-образ контейнера:

1. [Создайте](../container-registry/operations/registry/registry-create.md) реестр.
2. [Создайте и соберите](../container-registry/operations/docker-image/docker-image-create.md) Docker-образ на основе [Dockerfile](https://docs.docker.com/engine/reference/builder/). 
3. [Загрузите](../container-registry/operations/docker-image/docker-image-push.md) Docker-образ в реестр.

### Примеры приложений и Dockerfile

{% list tabs %}

- Node.js

    **Приложение**

    ```js
    import express from "express";

    const app = express();
    app.use(express.urlencoded({ extended: true }));
    app.use(express.json());

    app.post("/", (req, res) => {

        console.log("Say hello from Serverless Docker Node Container!");

        return res.send("Success!");
    });

    app.listen(process.env.PORT, () => {
        console.log(`App listening at http://localhost:${process.env.PORT}`);
    });
    ```

    **Dockerfile**

    ```
    FROM node:14-alpine
    # Подробнее о libc6-compat: https://github.com/nodejs/docker-node/tree/b4117f9333da4138b03a546ec926ef50a31506c3#nodealpine.
    RUN apk add --no-cache libc6-compat
    WORKDIR /app
    COPY ./dist .
    RUN npm ci
    CMD [ "node", "index.js" ]
    ```

- Go

    **Приложение**

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

    **Dockerfile**

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

{% endlist %}

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
