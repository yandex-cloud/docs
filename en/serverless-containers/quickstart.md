# Getting started

In this tutorial, you'll [prepare](#prepare) a Docker image for a container in {{ container-registry-name }} and [add](#deploy) it to {{ serverless-containers-name }}.

## Prepare a Docker image for a container {#prepare}

A Docker image is an executable package that contains everything you need to run an application: code, runtime environment, libraries, environment variables, and configuration files. Your application must accept HTTP requests to the port passed in the `PORT` environment variable.

A sample application in [Go](https://golang.org/):

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

To prepare a container's Docker image:

1. [Create](../container-registry/operations/registry/registry-create.md) a registry.
1. [Create and build](../container-registry/operations/docker-image/docker-image-create.md) a Docker image based on [Dockerfile](https://docs.docker.com/engine/reference/builder/). Dockerfile example:

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

1. [Push](../container-registry/operations/docker-image/docker-image-push.md) the Docker image to the registry.

## Add the image to {{ serverless-containers-name }} {#deploy}

1. Create a container:
    
	```
    yc serverless container create --name <container name>
    ```

	Result:

	```
	id: bba3fva6ka5g********
	folder_id: b1gqvft7kjk3********
	created_at: "2021-07-09T14:49:00.891Z"
	name: my-container
	url: https://bba3fva6ka5g********.containers.yandexcloud.net/
	status: ACTIVE
	```

1. Upload a container version:

	{% note info %}

	To upload the version, make the image public or pass the [ID of the service account](../iam/operations/sa/get-id.md) with permission to pull the image in the command.

	{% endnote %}

	```
	yc serverless container revision deploy\
	  --container-name <container name> \
	  --image <Docker image tag> \
	  --cores 1 \
	  --memory 1GB \
	  --service-account-id <service account ID>
	```

	Result:

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

## Check the results

After creating the container, you'll get an endpoint. Send an HTTP request to the endpoint by passing the [IAM token](../iam/concepts/authorization/iam-token.md) in the `Authorization` header:

```
curl -H "Authorization: Bearer $(yc iam create-token)" https://bba3fva6ka5g********.containers.yandexcloud.net/hello
```

Result:

```
Hello world!
```
