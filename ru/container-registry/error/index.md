---
title: Решение проблем в {{ container-registry-full-name }}
description: На странице приведены часто возникающие ошибки и способы их решения.
---

# Решение проблем в {{ container-registry-name }}

В списке ниже приведены часто возникающие ошибки и способы их решения:

* `docker login is not supported with yc credential helper`

  **Почему возникла ошибка**: если вы используете [Docker credential helper](../operations/authentication.md#cred-helper), нельзя [аутентифицироваться](../operations/authentication.md) в {{ container-registry-name }} с помощью `docker login`. Эту ошибку можно также увидеть в [{{ coi }}](../../cos/concepts/index.md), где credential helper используется для аутентификации от имени привязанного к [виртуальной машине](../../compute/concepts/vm.md) [сервисного аккаунта](../../iam/concepts/users/service-accounts.md).

  **Как исправить**: аутентифицируйтесь в [реестре](../concepts/registry.md), используя Docker credential helper, или [отключите Docker credential helper](../operations/authentication.md#ch-not-use).

* `Got permission denied while trying to connect to the Docker daemon socket`

  **Почему возникла ошибка**: Docker-демон по умолчанию требует прав `root`-пользователя для выполнения команд.

  **Как исправить**: выполняйте команды, используя `sudo`, или [настройте права для других пользователей операционной системы](https://docs.docker.com/install/linux/linux-postinstall/#manage-docker-as-a-non-root-user).

* `name unknown: Registry <...> not found`

  **Почему возникла ошибка**: не указан или указан неверно идентификатор реестра. При использовании команд Docker CLI необходимо указывать полное имя [Docker-образа](../concepts/docker-image.md), включающее в себя идентификатор реестра. Подробнее об этом читайте в разделе [{#T}](../concepts/repository.md).

  **Как исправить**: проверьте корректность указанного уникального идентификатора реестра, [посмотрев список реестров](../operations/registry/registry-list.md).

* `Error response from daemon: pull access denied for <{{ registry }}/идентификатор_реестра/имя_Docker-образа>, repository does not exist or may require 'docker login': denied: Permission denied ; requestId = <идентификатор_запроса>`

  **Почему возникла ошибка**: для [IP-адреса](../../vpc/concepts/address.md), с которого идет запрос на скачивание Docker-образа, нет разрешения на скачивание (PULL).

  **Как исправить**: [добавьте](../operations/registry/registry-access.md) разрешающие правила для этого IP-адреса в настройках реестра или удалите все правила и повторите попытку.

* `InvalidImageName`

  **Почему возникла ошибка**: некорректное имя Docker-образа.

  **Как исправить**: имя репозитория должно представлять собой [URI](https://ru.wikipedia.org/wiki/URI), частью которого является имя Docker-образа. Имя Docker-образа должно быть задано в определенном формате. Подробнее в спецификации [OCI Distribution Specification](https://github.com/opencontainers/distribution-spec/blob/main/spec.md#pull).

* `invalid reference format`

  **Почему возникла ошибка**: некорректный тег Docker-образа.
  
  **Как исправить**: имя репозитория должно представлять собой [URI](https://ru.wikipedia.org/wiki/URI), частью которого является тег Docker-образа. Тег должен быть задан в определенном формате. Подробнее в спецификации [OCI Distribution Specification](https://github.com/opencontainers/distribution-spec/blob/main/spec.md#pull).

* `Error response from daemon: unauthorized: Authentication problem ; requestId = <идентификатор_запроса>`
  
  `unauthorized: Authentication problem ; requestId = <идентификатор_запроса>`

  **Почему возникла ошибка**:
  * вы пытаетесь загрузить (PULL) или отправить (PUSH) Docker-образ в {{ container-registry-name }}, но вы не аутентифицированы. Для выполнения операций с образами в {{ container-registry-name }} необходимо сначала аутентифицироваться.
  * Docker не может вызвать утилиту [docker-credential-yc](../operations/authentication.md#cred-helper), например, потому что путь к исполняемому файлу отсутствует в переменной окружения `PATH`.
  
  **Как исправить**:
  * [аутентифицируйтесь](../operations/authentication.md) в {{ container-registry-name }}.
  * убедитесь, что путь до исполняемого файла `yc` добавлен в переменную окружения `PATH`.

* `unauthorized: Password is invalid - must be JSON key ; requestId = <идентификатор_запроса>`

  **Почему возникла ошибка**: в параметре `--username` команды `docker login` указан тип токена `json_key`, но переданный пароль не является [авторизованным ключом](../../iam/concepts/authorization/key.md) сервисного аккаунта в формате JSON. Ключ мог быть передан не целиком или искажен оболочкой при передаче через конвейер.

  **Как исправить**: убедитесь, что передается содержимое JSON-файла целиком, включая поля `id`, `service_account_id` и `private_key`. Передавайте ключ из файла, а не вставкой в консоль.

* `unauthorized: Password is invalid - must be OAuth token ; requestId = <идентификатор_запроса>`

  **Почему возникла ошибка**: реестр получил тип токена `oauth`, а переданный пароль им не является. Ошибка также возникает, если ранее сохраненные учетные данные с типом `oauth` не были перезаписаны: `docker login` сохраняет их на той машине, где выполнена команда, и при работе с удаленным Docker-демоном используются учетные данные со стороны клиента, а не хоста с демоном.

  **Как исправить**: выполните `docker logout {{ registry }}` и аутентифицируйтесь заново на той машине, где запускается Docker CLI.

* `Error saving credentials: error storing credentials - err: exit status 1, out: 'The stub received bad data.'`

  **Почему возникла ошибка**: ошибка возникает в Windows при аутентификации [с помощью ключа сервисного аккаунта](../operations/authentication.md#sa-json). Учетные данные сохраняются в Диспетчере учетных данных Windows, размер секрета в котором ограничен, а JSON-ключ занимает несколько килобайт.

  **Как исправить**: сохраните учетные данные в конфигурационном файле Docker вместо внешнего хранилища. Удалите поле `credsStore` из файла `%USERPROFILE%\.docker\config.json` и убедитесь, что блок `auths` не пуст — если он пуст, Docker CLI подставляет хранилище по умолчанию даже если поле `credsStore` удалено:

  ```json
  {"auths":{"{{ registry }}":{}}}
  ```

* `Permission denied`

  **Почему возникла ошибка**: недостаточно прав для выполнения операции.

  **Как исправить**: проверьте наличие необходимых [ролей](../security/index.md) у [сервисного аккаунта](../../iam/concepts/users/service-accounts.md) или [пользователя](../../iam/concepts/users/accounts.md), от имени которого вы выполняете операцию.
  
