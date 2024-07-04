---
title: "Вопросы и ответы про {{ container-registry-full-name }}"
description: "На странице представлены вопросы и ответы про {{ container-registry-name }}."
---

# Вопросы и ответы про {{ container-registry-name }}

#### Почему тег `latest` отсутствует или установлен не на последнем загруженном Docker-образе? {#latest}

Потому что вы указали другой [тег](../concepts/docker-image.md#version) при загрузке [Docker-образа](../concepts/docker-image.md).

Docker-клиент подставляет тег `latest` автоматически, если Docker-образ создается и загружается без тега. Также можно указать тег `latest` явно.

{% include [latest-info](../../_includes/container-registry/info-about-latest.md) %}

#### Как сделать реестр публичным? {#public-registry}

Можно выдать [роль](../../iam/concepts/access-control/roles.md) [container-registry.images.puller](../security/index.md#container-registry-images-puller) на ваш [реестр](../concepts/registry.md) для системной группы [allUsers](../../iam/concepts/access-control/system-group.md).

{% note alert %}

При этом все Docker-образы из этого реестра станут доступны без [аутентификации](../operations/authentication.md).

Не назначайте системной группе роли `container-registry.images.pusher`, `editor` и `admin` на реестр. Это позволит любому, кто узнает идентификатор вашего реестра, пользоваться им.

{% endnote %} 

#### У меня возникла ошибка. Что делать? {#error}

Ознакомьтесь с информацией в разделе [{#T}](../error/index.md), где перечислены часто встречающиеся ошибки и способы их решения.

{% include [logs](../../_qa/logs.md) %}

#### Что означает ошибка "Got permission denied while trying to connect to the Docker daemon socket at unix:///var/run/docker.sock"? {#permission-denied}

Вы запускаете команды не от пользователя `root`.

Можете использовать `sudo` или настроить [non-root доступ](https://docs.docker.com/engine/install/linux-postinstall/#manage-docker-as-a-non-root-user).

#### Как можно диагностировать работу Credential helper? {#cred-helper}

* Проверьте, от какого пользователя операционной системы и на каком хосте запускаются команды [CLI](../../cli/). Это должен быть пользователь, для которого сконфигурирован [Credential helper](../operations/authentication.md#cred-helper) и от имени которого была запущена команда `yc container registry configure-docker`. Соответствующая запись при этом появляется в файле `/home/<user>/.docker/config.json`. Если вы выполняете действия на [виртуальной машине](../../compute/concepts/vm.md), на ней тоже должен быть настроен Credential helper.
* Проверьте, есть ли Credential helper в `PATH` при вызове команд. Когда происходит аутентификация в {{ container-registry-name }} при помощи Credential helper, Docker обращается к бинарному файлу `docker-credential-yc`. Необходимо, чтобы этот бинарный файл был в `PATH` для пользователя, который работает с Docker. Например, если Docker используется с `sudo`, то и `configure-docker` должен вызываться с `sudo`. Проверить можно командой `echo {{ registry }} | docker-credential-yc get` или `echo {{ registry }} | sudo docker-credential-yc get`, если команды вызываются из-под `sudo`. Если все работает, вывод будет вида `{"Username":"iam","Secret":"***<IAM-токен>***"}`.
* Если команды работают в интерактивном режиме, но не работают в неинтерактивном, проверьте файл `.bashrc`. Программы `yc` и `docker-credential-yc` устанавливаются в директорию, которая обычно недоступна в дефолтном `PATH`. В файл `.bashrc` при этом прописываются следующие строки:

  ```text
  # The next line updates PATH for {{ yandex-cloud }} CLI
  if [ -f '/home/<user>/yandex-cloud/path.bash.inc' ]; then source '/home/<user>/yandex-cloud/path.bash.inc'; fi
  ```

  В начале файла `.bashrc` есть условие, что прописанные там команды не выполняются в неинтерактивном режиме. Из-за этого команды могут работать при заходе на ВМ вручную, но не работать по [SSH](../../glossary/ssh-keygen.md).

#### Что означает ошибка "Error response from daemon: pull access denied for <cr.yandex/идентификатор_реестра/имя_Docker-образа>, repository does not exist or may require 'docker login': denied: Permission denied ; requestId = <идентификатор_запроса>"? {#permission-denied-ip}

Для [IP-адреса](../../vpc/concepts/address.md), с которого идет запрос на скачивание Docker-образа, нет разрешения на скачивание (PULL).

[Добавьте разрешающие правила](../operations/registry/registry-access.md) для этого IP-адреса в настройках реестра или удалите все правила и повторите попытку.