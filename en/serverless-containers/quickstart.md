# Getting started with {{ serverless-containers-name }}

In this tutorial, you'll [prepare](#prepare) a [Docker image](../container-registry/concepts/docker-image.md) for a container in {{ container-registry-full-name }} and [add](#deploy) it to {{ serverless-containers-name }}.

## Prepare a Docker image for a container {#prepare}

A Docker image is an executable package that contains everything you need to run an application: code, runtime environment, libraries, environment variables, and configuration files.

{% include [port-variable-note.md](../_includes/serverless-containers/port-variable-note.md) %}

To prepare a container's Docker image:
1. [Create](../container-registry/operations/registry/registry-create.md) a registry.
1. [Create and build](../container-registry/operations/docker-image/docker-image-create.md) a Docker image based on [Dockerfile](https://docs.docker.com/engine/reference/builder/).
1. [Push](../container-registry/operations/docker-image/docker-image-push.md) the Docker image to the registry.

### Applications and Dockerfile examples

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
       app.run(host='0.0.0.0', port=os.environ['PORT'], motd=False, access_log=False)
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

## Add the image to {{ serverless-containers-name }} {#deploy}

### Create a container {#create-container}

{% include [create-container](../_includes/serverless-containers/create-container.md) %}

### Create a container revision {#create-revision}

{% include [create-revision](../_includes/serverless-containers/create-revision.md) %}

## Invoke the container {#invoke}

After creating the container, you'll get the invocation link. [Retrieving the link.](./operations/invoke.md#link) Make an HTTPS request by sending an [IAM token](../iam/concepts/authorization/iam-token.md) in the `Authorization` header:

```
curl -H "Authorization: Bearer $(yc iam create-token)" https://bba3fva6ka5g********.containers.yandexcloud.net/hello
```

Result:

```
Hello!
```

## What's next {#whats-next}

* Read about [service concepts](./concepts/invoke.md).