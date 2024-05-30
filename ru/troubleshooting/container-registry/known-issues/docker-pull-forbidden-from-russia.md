---
noIndex: true
---

# Workaround для загрузки образов с DockerHub

## Описание проблемы

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

## Решение

Вы можете воспользоваться одним из этих методов:

{% list tabs %}

- Добавить зеркала в конфигурацию Docker


    Вы можете добавить в конфигурацию Docker альтернативные реестры docker-образов.
    Для этого откройте файл с конфигурацией  Docker   укажите в нем список URL-адресов зеркал внутри блока
    `registry-mirrors` через запятую, например:

    ```
    "registry-mirrors": ["https://daocloud.io", "https://c.163.com/", "https://registry.docker-cn.com", "https://mirror.gcr.io"] 
    ```

    Путь к конфигурационному файлу Docker зависит от используемой на хосте операционной системы (и наличия прав суперпользователя):

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

- Gitlab Dependency proxy 

    Вы также можете воспользоваться Dependency proxy, предоставляемым сервисом GitLab.
    Для этого понадобится сначала создать новую [группу](https://docs.gitlab.com/ee/user/group/), затем, внутри это группы выпустить новый ключ API с правами `read_registry`.

    Чтобы после этого скачать нужный вам образ утилитой Docker, воспользуйтесь командой следующего вида:

    ```
    docker pull gitlab.com/<GROUP_NAME>/dependency_proxy/containers/hello-world:latest
    ```

- Публичное зеркало Container Registry

    Вы можете скачать большую часть популярных Docker-образов, используя наше зеркало, работающее внутри Yandex Cloud.

    Для этого используйте команду следующего вида:

    ```
    docker pull cr.yandex/mirror/hello-world
    ```

- Приватный реестр Container Registry

    1. Используйте команду из способа выше для скачивания Docker-образа на вашу локальную машину.
    2. Загрузите полученный Docker-образ в  в приватный реестр Yandex Container Registry [по этой инструкции](https://yandex.cloud/ru/docs/container-registry/operations/docker-image/docker-image-push).

    Не забудьте заменить в вашей CI/CD-cистеме ссылки для скачивания docker-образов на новые.

{% endlist %}

{% note warning "Обратите внимание" %}

В ближайшее время будет доступен DaemonSet для Managed Service for Kubernetes, перенаправляющий запросы в реестр `dockerhub.com` на другое зеркало.\
О готовности DaemonSet мы сообщим в этом руководстве дополнительно.

{% endnote %}
