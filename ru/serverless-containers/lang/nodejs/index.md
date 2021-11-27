## Контейнер oбработчик запросов на Node.js

С помощью сервиса {{ serverless-containers-name }} вы можете запускать приложения, написанные на [Node.js](https://nodejs.org/en/docs/).

## Подготовка Docker-образ контейнера {#prepare}

Docker-образ — исполняемый пакет, который содержит все необходимое для запуска приложения: код, среду выполнения, библиотеки, переменные окружения и файлы конфигурации. Приложение должно принимать HTTP-запросы на порт, переданный в переменной окружения `PORT`.

Пример приложения на JavaScript и express:

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
  console.log(`Container listening at http://localhost:${process.env.PORT}`);
});

```

Чтобы подготовить Docker-образ контейнера:

1. [Создайте](../../../container-registry/operations/registry/registry-create.md) реестр.
1. [Создайте и соберите](../../../container-registry/operations/docker-image/docker-image-create.md) Docker-образ на основе [Dockerfile](https://docs.docker.com/engine/reference/builder/). Пример Dockerfile:

    ```
    FROM node:14-alpine
    RUN apk add --no-cache libc6-compat

    WORKDIR /app

    COPY ./dist .

    RUN npm install

    CMD [ "node", "index.js" ]
    ```

1. [Загрузите](../../../container-registry/operations/docker-image/docker-image-push.md) Docker-образ в реестр.

