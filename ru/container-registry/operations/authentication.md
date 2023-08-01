# Аутентифицироваться в {{ container-registry-name }}

Перед началом работы с {{ container-registry-name }}, необходимо аутентифицироваться для соответствующего интерфейса:
* Для **Консоли управления** минимально необходимая [роль](../../iam/concepts/access-control/roles.md) на [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder) — `viewer`.
* Для **Docker CLI** или **{{ managed-k8s-full-name }}** минимально необходимая роль на [реестр](../concepts/registry.md) или [репозиторий](../concepts/repository.md) — `container-registry.images.puller`.

Назначьте нужную роль пользователю {{ yandex-cloud }} или [сервисному аккаунту](../../iam/concepts/users/service-accounts.md). Ознакомьтесь со [способами аутентификации](#method) и выберите подходящий.

Подробнее про роли читайте в разделе [{#T}](../security/index.md).

## Способы аутентификации {#method}

Вы можете аутентифицироваться:


* Как пользователь:
  * [С помощью OAuth-токена](#user-oauth) (срок жизни **год**).
  * [С помощью {{ iam-full-name }}-токена](#user-iam) (срок жизни не больше **{{ iam-token-lifetime }}**).



* Как сервисный аккаунт:
  * [С помощью авторизованных ключей](#sa-json) (неограниченный срок жизни).
  * [С помощью {{ iam-name }}-токена](#sa-iam) (срок жизни не больше **{{ iam-token-lifetime }}**).
  * [С помощью секрета сервисного аккаунта](#k8s-secret) внешнего [кластера {{ k8s }}](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) или внешней [группы узлов](../../managed-kubernetes/concepts/index.md#node-group), которыми управляет {{ managed-k8s-name }}.
* [С помощью хранилища учетных данных Docker Credential helper](#cred-helper).

Команда для аутентификации выглядит следующим образом:

```bash
docker login \
  --username <тип_токена> \
  --password <токен> \
  {{ registry }}
```

Где:
* `username` — тип токена. Допустимые значения: `oauth`, `iam` или `json_key`.
* `password` — тело токена.
* `{{ registry }}` — эндпоинт, к которому будет обращаться [Docker](/blog/posts/2022/03/docker-containers) при работе с реестром образов. Если его не указать, запрос пойдет в сервис по умолчанию — [Docker Hub](https://hub.docker.com).

## Аутентифицироваться как пользователь {#user}


### Аутентификация с помощью OAuth-токена {#user-oauth}

{% note info %}

{% include [oauth-token-lifetime](../../_includes/oauth-token-lifetime.md) %}

{% endnote %}

1. Если у вас еще нет OAuth-токена, получите его по [ссылке]({{ link-cloud-oauth }}).
1. Выполните команду:

   ```bash
   docker login \
     --username oauth \
     --password <OAuth-токен> \
     {{ registry }}
   ```


### Аутентификация с помощью {{ iam-name }}-токена {#user-iam}

{% note info %}

{% include [iam-token-note](../../_includes/iam/iam-token-note.md) %}

{% endnote %}

1. [Получите {{ iam-name }}-токен](../../iam/operations/iam-token/create.md).
1. Выполните команду:

   ```bash
   docker login \
     --username iam \
     --password <{{ iam-name }}-токен> \
     {{ registry }}
   ```

## Аутентифицироваться как сервисный аккаунт {#sa}

### Аутентификация с помощью авторизованных ключей {#sa-json}

{% include [disclaimer](../../_includes/iam/authorized-keys-disclaimer.md) %}

Ваши программы могут получать доступ к ресурсам {{ yandex-cloud }} с помощью сервисных аккаунтов. Получите файл с [авторизованными ключами](../../iam/concepts/users/service-accounts.md#sa-key) для вашего сервисного аккаунта, используя [{{ yandex-cloud }} CLI](../../cli/).

{% include [cli-install](../../_includes/cli-install.md) %}

1. Получите и сохраните в файл `key.json` авторизованные ключи для вашего сервисного аккаунта:

   ```bash
   yc iam key create --service-account-name default-sa -o key.json
   ```

   Результат:

   ```text
   id: aje8a87g4e...
   service_account_id: aje3932acd...
   created_at: "2019-05-31T16:56:47Z"
   key_algorithm: RSA_2048
   ```

1. Выполните команду:

   ```bash
   cat key.json | docker login \
     --username json_key \
     --password-stdin \
     {{ registry }}
   ```

   Где:
   * Команда `cat key.json` записывает содержимое файла с ключом в поток вывода.
   * Флаг `--password-stdin` позволяет читать пароль из потока ввода.

   Результат:

   ```text
   Login Succeeded
   ```

### Аутентификация с помощью {{ iam-name }}-токена {#sa-iam}

{% note info %}

{% include [iam-token-note](../../_includes/iam/iam-token-note.md) %}

{% endnote %}

1. [Получите {{ iam-name }}-токен](../../iam/operations/iam-token/create-for-sa.md).
1. Выполните команду:

   ```bash
   docker login \
     --username iam \
     --password <{{ iam-name }}-токен> \
     {{ registry }}
   ```

### Аутентификация с помощью секрета {{ k8s }} {#k8s-secret}

{% note info %}

Эта инструкция применима только к внешним кластерам {{ k8s }}, а также к [внешним узлам](../../managed-kubernetes/concepts/external-nodes.md), которыми управляет {{ managed-k8s-name }}.

Чтобы узел, размещенный в [{{ compute-full-name }}](../../compute/), смог пройти аутентификацию, [назначьте роль](../../iam/operations/roles/grant.md) `container-registry.images.puller` сервисному аккаунту этого узла.

{% endnote %}

{% include [cli-install](../../_includes/cli-install.md) %}

Ресурсы {{ k8s }} могут получать доступ к объектам {{ container-registry-name }} с помощью [секретов {{ k8s }}](../../managed-kubernetes/concepts/encryption.md), создаваемых на основе ключей [сервисных аккаунтов](../../iam/concepts/users/service-accounts.md).

Чтобы подготовить такой секрет:
1. Получите и сохраните в файл `key.json` [авторизованный ключ](../../iam/concepts/users/service-accounts.md#sa-key) для вашего сервисного аккаунта:

   ```bash
   yc iam key create --service-account-name <имя_сервисного_аккаунта> -o key.json
   ```

1. Выполните команду аутентификации:

   ```bash
   cat key.json | docker login \
     --username json_key \
     --password-stdin \
     {{ registry }}
   ```

   Результат:

   ```text
   Login Succeeded
   ```

   В случае ошибок см. раздел [{#T}](../error/index.md).
1. Убедитесь, что полученный ключ имеет нужный формат. Для этого откройте конфигурационный файл Docker:

   ```bash
   cat $HOME/.docker/config.json
   ```

   Результат:

   ```json
   {
     "auths": {
       "{{ registry }}": {
         "auth": "anNvbl9rZXk
         ...
         tXG4iCn0="
       }
     }
   }
   ```

   {% note info %}

   Ранее настроенный доступ к Docker может препятствовать получению ключа в нужном формате. Чтобы получить корректный ключ, [отключите Credential helper](#ch-not-use) или удалите уже существующий файл `$HOME/.docker/config.json`.

   {% endnote %}

1. Создайте секрет в вашем кластере {{ k8s }}:

   ```bash
   kubectl create secret generic <имя_секрета> \
     --namespace=<пространство_имен> \
     --from-file=.dockerconfigjson=$HOME/.docker/config.json \
     --type=kubernetes.io/dockerconfigjson
   ```

   В качестве [пространства имен](../../managed-kubernetes/concepts/index.md#namespace) можно указать, например, `kube-system`. {{ managed-k8s-name }} использует это пространство имен после создания группы узлов.
1. Используйте секрет для создания [подов](../../managed-kubernetes/concepts/index.md#pod) или контроллеров Deployment, например:

   ```yaml
   ---
   apiVersion: v1
   kind: Pod
   metadata:
     name: <имя_пода>
     namespace: <пространство_имен>
   spec:
     containers:
       - name: <имя_вашего_контейнера>
         image: <имя_образа_в_контейнере>
     imagePullSecrets:
     - name: <имя_секрета>
   ```

   При создании секретов и подов указывайте для них одинаковое пространство имен в параметре `namespace`. Иначе возникнет ошибка аутентификации.

Подробнее см. в [документации {{ k8s }}](https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/).

## Аутентифицироваться с помощью Docker Credential helper {#cred-helper}

Docker Engine может хранить учетные данные пользователя во внешнем хранилище. Это безопаснее, чем хранить их в конфигурационном файле Docker. Чтобы использовать хранилище учетных данных, необходима внешняя программа — [Docker Credential helper](https://docs.docker.com/engine/reference/commandline/login/#credential-helpers).

В состав {{ yandex-cloud }} CLI входит утилита `docker-credential-yc`, которая выступает в роли Docker Credential helper для {{ yandex-cloud }}. Она хранит учетные данные пользователя и позволяет работать с приватными реестрами {{ yandex-cloud }}, не выполняя команду `docker login`. Этот способ аутентификации поддерживает использование от имени пользователя и от имени сервисного аккаунта.

### Настройка Credential helper {#ch-setting}

{% include [cli-install](../../_includes/cli-install.md) %}

{% include [default-catalogue](../../_includes/default-catalogue.md) %}

1. Сконфигурируйте Docker для использования `docker-credential-yc`:

   ```bash
   yc container registry configure-docker
   ```

   Результат:

   ```text
   Credential helper is configured in '/home/<user>/.docker/config.json'
   ```

   Настройки сохраняются в профиле текущего пользователя.

   {% note warning %}

   Credential helper работает только при использовании Docker без `sudo`. О том, как настроить запуск Docker от имени текущего пользователя без использования `sudo` читайте в [официальной документации](https://docs.docker.com/engine/install/linux-postinstall/#manage-docker-as-a-non-root-user).

   {% endnote %}

1. Проверьте, что Docker сконфигурирован.

   В конфигурационном файле `${HOME}/.docker/config.json` должна появиться строка:

   ```json
   "{{ registry }}": "yc"
   ```

1. Docker готов к использованию, например, для [загрузки Docker-образов](../operations/docker-image/docker-image-push.md).

### Дополнительные опции Credential helper {#ch-feature}

#### Использовать Credential helper для другого профиля {{ yandex-cloud }} CLI {#ch-profile}

Вы можете использовать Credential helper для другого профиля, не переключая текущий, с помощью команды:

```bash
yc container registry configure-docker --profile <имя_профиля>
```

Подробнее об управлении профилями читайте в [пошаговых инструкциях {{ yandex-cloud }} CLI](../../cli/operations/index.md#profile).

#### Не использовать Credential helper {#ch-not-use}

Чтобы не использовать Credential helper при аутентификации, удалите в конфигурационном файле `${HOME}/.docker/config.json` из блока `credHelpers` строку домена `{{ registry }}`.