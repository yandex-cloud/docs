---
noIndex: true
---

# Workaround для загрузки образов с Docker Hub

## Описание проблемы {#issue-description}

При попытке загрузить образ командой `docker pull` отображается сообщение об ошибке:

```bash
docker: Error response from daemon: 
error parsing HTTP 403 response body: invalid character '<' 
looking for beginning of value: 
"<html><body><h1>403 Forbidden</h1>\nSince Docker is a US company, 
we must comply with US export control regulations. 
In an effort to comply with these, we now block all IP addresses 
that are located in Cuba, Iran, North Korea, Republic of Crimea, Sudan, and Syria. 
If you are not in one of these cities, countries, or regions and are blocked, 
please reach out to https://hub.docker.com/support/contact/\n</body></html>\n".
See 'docker run --help'.
```

## Решение {#issue-resolution}

Вы можете воспользоваться одним из этих методов:

{% list tabs %}

- Добавить зеркала в конфигурацию Docker


    Вы можете добавить в конфигурацию Docker альтернативные реестры Docker-образов.
    Для этого откройте файл с конфигурацией Docker и укажите в нем список URL-адресов (зеркал внутри блока `registry-mirrors`) через запятую, например:

    ```
    "registry-mirrors": ["https://mirror.gcr.io", "https://registry.docker-cn.com", "https://c.163.com/"] 

    ```

    Путь к конфигурационному файлу Docker зависит от используемой на хосте операционной системы и наличия прав суперпользователя:

    #|
    ||

    Операционная система

    |

    Путь к файлу конфиуграции

    ||
    ||

    Linux (с правами `root`)

    |

    `/etc/docker/daemon.json`

    ||
    ||

    Linux (без прав `root`)

    |

    `~/.config/docker/daemon.json`

    ||
    ||

    Windows

    |

    `%ProgramData%\docker\config\daemon.json`

    ||
    |#

- {{ GL }} Dependency proxy 

    {% note alert %}
    
    Использование сторонних зеркал может быть сопряжено с рисками атак на цепочки поставок. Владелец зеркала может контролировать содержимое популярных образов и подменять образы на другие по своему усмотрению. 

    {{ yandex-cloud }} не несет ответственность за содержимое внешних зеркал.

    {% endnote %}

    Вы также можете воспользоваться Dependency proxy, предоставляемым сервисом {{ GL }}. Для этого понадобится сначала создать новую [группу](https://docs.gitlab.com/ee/user/group/), затем, внутри это группы выпустить новый ключ API с правами `read_registry`.

    Чтобы после этого скачать нужный вам образ утилитой Docker, воспользуйтесь командой следующего вида:

    ```
    docker pull gitlab.com/<GROUP_NAME>/dependency_proxy/containers/hello-world:latest
    ```

- Публичное зеркало {{ container-registry-name }}

    Вы можете скачать большую часть популярных Docker-образов, используя наше зеркало, работающее внутри {{ yandex-cloud }}.

    Для этого используйте команду следующего вида:

    ```
    docker pull {{ registry }}/mirror/hello-world
    ```

- Приватный реестр {{ container-registry-name }}

    1. Используйте команду из способа выше для скачивания Docker-образа на вашу локальную машину.
    1. Загрузите полученный Docker-образ в приватный реестр {{ container-registry-full-name }} [по этой инструкции](../../../container-registry/operations/docker-image/docker-image-push.md).
    Не забудьте заменить в вашей CI/CD-cистеме ссылки для скачивания Docker-образов на новые.

{% endlist %}

{% note warning %}

В ближайшее время будет доступен DaemonSet для {{ managed-k8s-name }}, перенаправляющий запросы в реестр `dockerhub.com` на другое зеркало.

О готовности DaemonSet мы сообщим в этом руководстве дополнительно.

{% endnote %}

## DaemonSet для {{ managed-k8s-name }}

Наша команда поддержки подготовила манифест объекта DaemonSet для кластеров {{ k8s }}. Этот DaemonSet создает внутри кластера привилегированный под, который обновляет конфигурацию `containerd` таким образом, чтобы запросы к реестру `hub.docker.io` перенаправлялись на `cr.yandex/mirror`.

Текст манифеста следует скопировать в файл с расширением YAML и применить к кластеру с помощью команды `kubectl apply -f filename.yaml`:

```yaml

# Создаем Namespace
---
apiVersion: v1
kind: Namespace
metadata:
  name: docker-mirror

# Создаем объект ConfigMap конфига config.toml для containerd
# В секции [plugins."io.containerd.grpc.v1.cri".registry.mirrors."docker.io"]
# определяем зеркала. Список endpoint можно пополнять
---
apiVersion: v1
data:
  config.toml: |
    oom_score = -999
    version = 2

    [debug]
      level = "info"

    [plugins]
      [plugins."io.containerd.grpc.v1.cri".cni]
          bin_dir = "/home/kubernetes/cni/bin"
          conf_dir = "/etc/cni/net.d"

      [plugins."io.containerd.runtime.v1.linux"]
          runtime = "/home/kubernetes/bin/runc"
          shim = "/home/kubernetes/bin/containerd-shim"

      [plugins."io.containerd.grpc.v1.cri"]
          stream_server_address = "127.0.0.1"
          enable_tls_streaming = false
          sandbox_image = "{{ registry }}/crpsjg1coh47p81vh2lc/pause:3.9"
          [plugins."io.containerd.grpc.v1.cri".containerd]
              snapshotter = "overlayfs"

      [plugins."io.containerd.grpc.v1.cri".registry]
        [plugins."io.containerd.grpc.v1.cri".registry.mirrors]
          [plugins."io.containerd.grpc.v1.cri".registry.mirrors."docker.io"]
            endpoint = ["https://{{ registry }}/v2/mirror/io/docker","https://mirror.gcr.io"]
kind: ConfigMap
metadata:
  name: configtoml
  namespace: docker-mirror

# Ниже – манифест DaemonSet для запуска привилегированных подов, каждый из которых копирует config.toml
# В etc/containerd/config.toml на каждой и однократно перезапускает containerd.
# Добавили секцию, чтобы DaemonSet смог запускаться на нодах с taint. 
---
apiVersion: "apps/v1"
kind: DaemonSet
metadata:
  name: docker-mirror
  namespace: docker-mirror
  labels:
    app: docker-mirror
    version: 1v
spec:
  selector:
    matchLabels:
      app: docker-mirror
  template:
    metadata:
      labels:
        app: docker-mirror
    spec:
      schedulerName: default-scheduler
      priorityClassName: system-node-critical
      hostPID: true
      hostIPC: true
      containers:
      - name: config-updater
        image: {{ registry }}/yc/mk8s-openssl:stable
        command:
          - sh
          - -c
          - |
             cp /tmp/config.toml /host/etc/containerd/config.toml &&
             ps -x -o pid= -o comm= | awk '$2 ~ "^(containerd|dockerd)$" { print $1 }' | xargs kill
             sleep infinity
        imagePullPolicy: IfNotPresent
        securityContext:
          privileged: true
        resources:
          limits:
            memory: 200Mi
          requests:
            cpu: 100m
            memory: 200Mi
        volumeMounts:
        - name: containerd-config
          mountPath: /host/etc/containerd
        - name: config
          mountPath: /tmp
      volumes:
      - name: containerd-config
        hostPath:
          path: /etc/containerd
      - name: config
        configMap:
          name: configtoml
```