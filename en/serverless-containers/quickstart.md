# Getting started

In this tutorial, you'll [prepare](#prepare) a Docker image for a container in {{ container-registry-full-name }} and [add](#deploy) it to {{ serverless-containers-name }}.

## Prepare a Docker image for a container {#prepare}

A Docker image is an executable package that contains everything you need to run an application: code, runtime environment, libraries, environment variables, and configuration files. Your application must accept HTTP requests to the port passed in the `PORT` environment variable.

To prepare a container's Docker image:

1. [Create](../container-registry/operations/registry/registry-create.md) a registry.
1. [Create and build](../container-registry/operations/docker-image/docker-image-create.md) a Docker image based on [Dockerfile](https://docs.docker.com/engine/reference/builder/).
1. [Push](../container-registry/operations/docker-image/docker-image-push.md) the Docker image to the registry.

### Sample applications and Dockerfile

{% list tabs %}

- Node.js

    **Application**

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
    # Learn more about libc6-compat: https://github.com/nodejs/docker-node/tree/b4117f9333da4138b03a546ec926ef50a31506c3#nodealpine.
    RUN apk add --no-cache libc6-compat
    WORKDIR /app
    COPY ./dist .
    RUN npm ci
    CMD [ "node", "index.js" ]
    ```

- Go

    **Application**

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

## Add the image to {{ serverless-containers-name }} {#deploy}

### Create a container {#create-container}

{% include [create-container](../_includes/serverless-containers/create-container.md) %}

### Create a container revision {#create-revision}

{% include [create-revision](../_includes/serverless-containers/create-revision.md) %}

## Invoke the container {#invoke}

After creating the container, you'll get the invocation link. [How to get it.](./operations/invoke.md#link) Send an HTTPS request by passing an [IAM token](../iam/concepts/authorization/iam-token.md) in the `Authorization` header:

```
curl -H "Authorization: Bearer $(yc iam create-token)" https://bba3fva6ka5g********.containers.yandexcloud.net/hello
```

Result:

```
Hello world!
```
