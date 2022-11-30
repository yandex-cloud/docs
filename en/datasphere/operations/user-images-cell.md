# Run a Docker container in a separate cell

You can set up a separate environment in any notebook cell by running a {% if lang == "ru" %}[Docker container](https://cloud.yandex.ru/blog/posts/2022/03/docker-containers){% else %}Docker container{% endif %} in it. You can utilize this method if you need to use a utility distributed as a Docker image or a programming language other than Python. The image to launch can be located in any open Docker image registry.

{% note info %}

Custom images [created in a project](user-images.md) are not available to run in a cell.

{% endnote %}

To start a container, enter the following command in a notebook cell:

```bash
#!:docker-run <image name>
```

If you need to add computing resources, specify a [configuration](../concepts/configurations.md) prefix, such as:

```bash
#!g1.1:docker-run <image name>
```

For example, the <https://hub.docker.com/_/golang> public image provides access to Go utilities. To run the `go version` command in this image, run a cell with the following code:


```bash
#!:docker-run golang go version
```

Result:

```text
go version go1.16.6 linux/amd64
```
