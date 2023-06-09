# Начало работы с {{ serverless-containers-name }}

В этой инструкции вы [подготовите](#prepare) [Docker-образ](../../container-registry/concepts/docker-image.md) контейнера в {{ container-registry-full-name }} и [добавите](#deploy) его в {{ serverless-containers-name }}.

## Подготовьте Docker-образ контейнера {#prepare}

Docker-образ — исполняемый пакет, который содержит все необходимое для запуска приложения: код, среду выполнения, библиотеки, переменные окружения и файлы конфигурации.

{% include [port-variable-note.md](../../_includes/serverless-containers/port-variable-note.md) %}

Чтобы подготовить Docker-образ контейнера:
1. [Создайте](../../container-registry/operations/registry/registry-create.md) реестр.
1. [Создайте и соберите](../../container-registry/operations/docker-image/docker-image-create.md) Docker-образ на основе [Dockerfile](https://docs.docker.com/engine/reference/builder/).
1. [Загрузите](../../container-registry/operations/docker-image/docker-image-push.md) Docker-образ в реестр.

### Примеры приложений и Dockerfile {#examples}

{% list tabs %}

- Node.js

    **index.js**

    ```js
    const express = require('express');

    const app = express();
    app.use(express.urlencoded({ extended: true }));
    app.use(express.json());

    app.get("/hello", (req, res) => {
        var ip = req.headers['x-forwarded-for']
        console.log(`Request from ${ip}`);
        return res.send("Hello!");
    });

    app.listen(process.env.PORT, () => {
        console.log(`App listening at port ${process.env.PORT}`);
    });
    ```

    **Dockerfile**

    ```
    FROM node:16-slim

    WORKDIR /app
    RUN npm install express
    COPY ./index.js .

    CMD [ "node", "index.js" ]
    ```

- Python

    **index.py**

    ```python
    import os
    from sanic import Sanic
    from sanic.response import text

    app = Sanic(__name__)

    @app.after_server_start
    async def after_server_start(app, loop):
        print(f"App listening at port {os.environ['PORT']}")

    @app.route("/hello")
    async def hello(request):
        ip = request.headers["X-Forwarded-For"]
        print(f"Request from {ip}")
        return text("Hello!")

    if __name__ == "__main__":
        app.run(host='0.0.0.0', port=int(os.environ['PORT']), motd=False, access_log=False)
    ```

    **Dockerfile**

    ```
    FROM python:3.10-slim

    WORKDIR /app
    RUN pip install --no-cache-dir --prefer-binary sanic
    COPY ./index.py .

    CMD [ "python", "index.py" ]
    ```

- Go

    **index.go**

    ```golang
    package main

    import (
        "fmt"
        "net/http"
        "os"
    )

    func main() {
        portStr := os.Getenv("PORT")
        fmt.Printf("App listening at port %s\n", portStr)
        http.Handle("/hello", hwHandler{})
        http.ListenAndServe(":"+portStr, nil)
    }

    type hwHandler struct{}

    func (hwHandler) ServeHTTP(writer http.ResponseWriter, request *http.Request) {
        ip := request.Header.Get("X-Forwarded-For")
        fmt.Printf("Request from %s\n", ip)
        writer.WriteHeader(200)
        _, _ = writer.Write([]byte("Hello!"))
    }
    ```

    **Dockerfile**

    ```
    FROM golang:latest AS build

    WORKDIR /app
    ADD index.go .
    RUN go build -a -tags netgo -ldflags '-w -extldflags "-static"' -o server-app *.go

    FROM scratch
    COPY --from=build /app/server-app /server-app

    ENTRYPOINT ["/server-app"]
    ```

{% endlist %}

## Добавьте образ в {{ serverless-containers-name }} {#deploy}

### Создайте контейнер {#create-container}

{% include [create-container](../../_includes/serverless-containers/create-container.md) %}

### Создайте ревизию контейнера {#create-revision}

{% include [create-revision](../../_includes/serverless-containers/create-revision.md) %}

## Вызовите контейнер {#invoke}

После создания контейнера вы получите ссылку для вызова. [Как узнать ее.](../operations/invoke.md#link) Сделайте HTTPS-запрос, передав [IAM-токен](../../iam/concepts/authorization/iam-token.md) в заголовке `Authorization`:

```
curl -H "Authorization: Bearer $(yc iam create-token)" https://bba3fva6ka5g********.containers.yandexcloud.net/hello
```

Результат:

```
Hello!
```

## Что дальше {#whats-next}

* Изучите [концепции сервиса](../concepts/invoke.md).
