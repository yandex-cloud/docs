# Интеграция с Argo CD

[Argo CD](https://argo-cd.readthedocs.io) — декларативный инструмент для непрерывной доставки в {{ k8s }} по модели GitOps.

В этом руководстве описана интеграция [инстанса {{ mgl-full-name }}](../../../managed-gitlab/concepts/index.md#instance), [кластера {{ k8s }}](../../concepts/index.md#kubernetes-cluster) и установленного в кластере [Argo CD](/marketplace/products/yc/argo-cd), который выполняет сборку {% if lang == "ru" %}[Docker-контейнеров](https://cloud.yandex.ru/blog/posts/2022/03/docker-containers){% else %}Docker-контейнеров{% endif %} с помощью инструмента [Kaniko](https://github.com/GoogleContainerTools/kaniko).

Чтобы интегрировать Argo CD с {{ managed-k8s-name }} и {{ mgl-name }}:
1. [{#T}](#k8s-cr-create).
1. [{#T}](#create-gitlab).
1. [{#T}](#configure-gitlab).
1. [{#T}](#runners).
1. [{#T}](#setup-repo).
1. [{#T}](#deploy-argo).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-you-begin}

Для выполнения сценария установите в локальном окружении:

* {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

* [Утилиту потоковой обработки JSON-файлов `jq`](https://stedolan.github.io/jq/).
* [Менеджер пакетов Helm]({{ links.helm.install }}).

## Создайте ресурсы {{ managed-k8s-name }} и {{ container-registry-name }} {#k8s-cr-create}

1. Создайте кластер {{ k8s }} и [реестр](../../../container-registry/concepts/registry.md) {{ container-registry-full-name }}.

   Для выполнения сценария создайте ресурсы {{ managed-k8s-name }}: кластер и [группу узлов](../../concepts/index.md#node-group).

   Для хранения [Docker-образов](../../../container-registry/concepts/docker-image.md) вам понадобится реестр {{ container-registry-name }}.

   {% list tabs %}

   - Вручную

     1. Если у вас еще нет [сети](../../../vpc/concepts/network.md#network), [создайте ее](../../../vpc/operations/network-create.md).
     1. Если у вас еще нет [подсетей](../../../vpc/concepts/network.md#subnet), [создайте их](../../../vpc/operations/subnet-create.md) в [зонах доступности](../../../overview/concepts/geo-scope.md), где будут созданы кластер {{ k8s }} и группа узлов.
     1. [Создайте сервисные аккаунты](../../../iam/operations/sa/create.md):
        * С [ролью](../../../iam/concepts/access-control/roles.md) [{{ roles-editor }}](../../../iam/concepts/access-control/roles.md#editor) на [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создается кластер {{ k8s }}. От его имени будут создаваться ресурсы, необходимые кластеру {{ k8s }}.
        * С ролями [{{ roles-cr-puller }}](../../../iam/concepts/access-control/roles.md#cr-images-puller) и [{{ roles-cr-pusher }}](../../../iam/concepts/access-control/roles.md#cr-images-pusher.md). От его имени узлы будут загружать в реестр собранные в {{ GL }} Docker-образы, а также скачивать их для запуска [подов](../../concepts/index.md#pod).

        {% note tip %}

        Вы можете использовать один и тот же [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md) для управления кластером {{ k8s }} и его группами узлов.

        {% endnote %}

     1. [Создайте кластер {{ k8s }}](../../operations/kubernetes-cluster/kubernetes-cluster-create.md) и [группу узлов](../../operations/node-group/node-group-create.md) со следующими настройками:
        * **Сервисный аккаунт для ресурсов** — созданный ранее сервисный аккаунт с ролью `{{ roles-editor }}`.
        * **Сервисный аккаунт для узлов** — созданный ранее сервисный аккаунт с ролями `{{ roles-cr-puller }}` и `{{ roles-cr-pusher }}`.
        * **Версия {{ k8s }}** — не ниже **1.21**.
        * **Публичный адрес** — `Автоматически`.
        * Отдельные параметры группы узлов:
          * **vCPU** — `4`.
          * **RAM** — `8 ГБ`.
          * **Прерываемая**.
          * **Масштабирование** — `Автоматическое`.
          * **Минимальное кол-во узлов** — `1`.
          * **Максимальное кол-во узлов** — `4`.
          * **Начальное кол-во узлов** — `1`.

         Сохраните идентификатор кластера — он понадобится для следующих шагов.

     1. [Создайте реестр](../../../container-registry/operations/registry/registry-create.md).
     1. [Сохраните идентификатор созданного реестра](../../../container-registry/operations/registry/registry-list.md#registry-get) — он понадобится для следующих шагов.

   - С помощью {{ TF }}

     1. Если у вас еще нет {{ TF }}, [установите его](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
     1. Скачайте [файл с настройками провайдера](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/provider.tf). Поместите его в отдельную рабочую директорию и [укажите значения параметров](../../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider).
     1. Скачайте в ту же рабочую директорию файл конфигурации кластера [k8s-argocd.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/managed-kubernetes/k8s-argocd.tf). В файле описаны:
         * Cеть.
         * Подсеть.
         * [Группа безопасности](../../operations/connect/security-groups.md) и правила, необходимые для работы кластера, группы узлов, инстанса {{ mgl-name }} и контейнера {{ container-registry-name }}:
           * Правила для служебного трафика.
           * Правила для доступа к API {{ k8s }} и управления кластером с помощью `kubectl` через порты 443 и 6443.
           * Правила для подключения к Git-репозиторию по протоколу SSH через порт 22.
           * Правила, разрешающие HTTP- и HTTPS-трафик через порты 80 и 443.
           * Правила для подключения к {{ container-registry-name }} через порт 5050.
         * Кластер {{ k8s }}.
         * Сервисный аккаунт, необходимый для работы кластера и группы узлов {{ k8s }}.
         * Реестр {{ container-registry-name }}.
     1. Укажите в файле конфигурации:
        * [Идентификатор каталога](../../../resource-manager/operations/folder/get-id.md).
        * Версию {{ k8s }} для кластера и групп узлов.
        * CIDR кластера {{ k8s }}.
        * Имя сервисного аккаунта кластера.
        * Имя реестра {{ container-registry-name }}.
     1. Выполните команду `terraform init` в директории с конфигурационными файлами. Эта команда инициализирует провайдер, указанный в конфигурационных файлах, и позволяет работать с ресурсами и источниками данных провайдера.
     1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.
     1. Создайте необходимую инфраструктуру:

        {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

        {% include [explore-resources](../../../_includes/mdb/terraform/explore-resources.md) %}

   {% endlist %}

1. {% include [kubectl-install-links](../../../_includes/managed-kubernetes/kubectl-install.md) %}

{% include [k8s-get-token](../../../_includes/managed-gitlab/k8s-get-token.md) %}

## Создайте инстанс {{ GL }} {#create-gitlab}

{% list tabs %}

- Инстанс {{ mgl-name }}

  Создайте [инстанс {{ mgl-name }}](../../../managed-gitlab/concepts/index.md#instance) [согласно инструкции](../../../managed-gitlab/quickstart.md#instance-create).

- Виртуальная машина с образом {{ GL }}

  Запустите {{ GL }} на ВМ с публичным IP-адресом.

  {% include [create-gitlab](../../../_includes/managed-gitlab/create.md) %}

{% endlist %}

## Настройте {{ GL }} {#configure-gitlab}

{% include [Create a project](../../../_includes/managed-gitlab/initialize.md) %}

## Создайте {{ GLR }} {#runners}

{% include notitle [create glr](../../../_includes/managed-gitlab/k8s-runner.md) %}

## Подготовьте репозиторий приложения для развертывания {#setup-repo}

1. В {{ mgl-name }} создайте новый репозиторий `my-app`:

   {% list tabs %}

   - Инстанс {{ mgl-name }}

     1. Авторизуйтесь в веб-интерфейсе инстанса {{ mgl-name }}.
     1. Перейдите в группу `gitlab-test`.
     1. Нажмите кнопку **Create a project**.
     1. Нажмите кнопку **Create blank project**.
     1. Заполните поля:
        * **Project name** — `my-app`.
        * **Project URL** — выберите `gitlab-test` в поле рядом с FQDN инстанса {{ mgl-name }}.

        Остальные поля оставьте без изменений.
     1. Нажмите кнопку **Create project**.

   - ВМ с образом {{ GL }}

     Чтобы настроить {{ GL }} и подготовить процесс непрерывной интеграции ({% if lang == "ru" %}[Continuous Integration](https://cloud.yandex.ru/blog/posts/2022/10/ci-cd){% else %}Continuous Integration{% endif %}, CI), создайте новый проект и введите параметры для авторизации в CI:
     1. На странице сервиса {{ compute-full-name }} выберите созданную ВМ и найдите ее [публичный IP-адрес](../../../vpc/concepts/address.md#public-addresses).
     1. Откройте в браузере ссылку `http://<публичный IP-адрес ВМ>`. Откроется административная панель {{ GL }}.
     1. Задайте пароль администратора и нажмите кнопку **Change your password**.
     1. Введите логин `root` и пароль администратора.
     1. Нажмите кнопку **Sign in**.
     1. Выберите **Create a project**.
     1. Задайте имя проекта: `my-app`.
     1. Нажмите кнопку **Create project**.

   {% endlist %}

1. Получите [авторизованный ключ](../../../iam/concepts/authorization/key.md) для созданного ранее сервисного аккаунта с ролью {{ roles-cr-pusher }}:

   ```bash
   yc iam key create --service-account-name <имя сервисного аккаунта реестра> -o key.json
   ```

1. Сохраните содержимое этого ключа — оно потребуется на следующем шаге:

   ```bash
   cat key.json | base64
   ```

1. Создайте [переменные окружения {{ GL }}](https://docs.gitlab.com/ee/ci/variables/README.html):
   1. На панели слева в {{ GL }} перейдите в раздел **Settings** и во всплывающем списке выберите пункт **CI/CD**.
   1. Нажмите кнопку **Expand** напротив пункта **Variables**.
   1. Добавьте три переменные окружения:

      Name | Value | Опции
      --- | --- | ---
      CI_REGISTRY | {{ registry }}/<идентификатор реестра> | `no`
      CI_REGISTRY_USER | json_key | `no`
      CI_REGISTRY_PASSWORD | <вывод команды `cat key.json \| base64`> | `Mask variable`

1. Настройте доступ к репозиторию:
   1. [Сгенерируйте новую пару SSH-ключей](../../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) или используйте существующую.
   1. [Добавьте публичную часть SSH-ключа в настройки учетной записи {{ GL }}](https://docs.gitlab.com/ee/user/ssh.html#add-an-ssh-key-to-your-gitlab-account).
1. Клонируйте репозиторий:

   ```bash
   git clone git@<имя инстанса {{ mgl-name }}>.gitlab.yandexcloud.net:gitlab-test/my-app.git
   ```

1. Загрузите архив `app.zip` и распакуйте его.
1. Скопируйте в директорию `my-app` все файлы (включая скрытые) из загруженного архива:

   ```bash
   cp -a <путь к директории с файлами из app.zip> <путь к директории my-app>
   ```

1. Сохраните изменения и отправьте их в репозиторий:

   ```bash
   git add . && \
   git commit -m "Add app src and CI" && \
   git push
   ```

1. Запустится сценарий сборки. Чтобы посмотреть его выполнение, выберите в выпадающем меню пункт **CI/CD** → **Pipelines**. Дождитесь успешного завершения обоих этапов сборки.
1. Откройте завершенную сборку и скопируйте строку из лога, она понадобится на следующем этапе:

   ```text
   INFO[0025] Pushing image to {{ registry }}/<идентификатор реестра>/gitlab-test/my-app:main.<номер коммита>
   ```

## Разверните приложение с помощью Argo CD {#deploy-argo}

### Установите Argo CD в кластер {{ k8s }} {#install}

1. Установите Argo CD, как описано в [инструкции](../../operations/applications/argo-cd.md).
1. Настройте переадресацию порта сервиса `argocd-server` на локальный компьютер и подключитесь к кластеру {{ k8s }}:

   ```bash
   kubectl port-forward svc/<название приложения Argo CD>-argocd-server 8080:443
   ```

1. Получите пароль администратора из секрета {{ k8s }}:

   ```bash
   kubectl get secret argocd-initial-admin-secret \
     -o jsonpath='{.data.password}' | base64 -d
   ```

1. Откройте в браузере консоль Argo CD по адресу `https://127.0.0.1:8080`.
1. Авторизуйтесь в консоли, используя имя пользователя `admin` и пароль, полученный на предыдущем шаге.

### Создайте репозиторий {{ GL }} для Argo CD {#сreate}

1. На панели слева в {{ GL }} перейдите в раздел **Settings** и во всплывающем списке выберите пункт **Access Tokens**.
1. Задайте параметры нового токена:
   * **Token name** — `argocd`.
   * **Select scopes** — `read_repository`.
1. Нажмите кнопку **Create project access token**.
1. Скопируйте значение созданного токена.
1. В консоли Argo CD перейдите в раздел **Settings** → **Repositories**.
1. Нажмите кнопку **Connect Repo Using SSH**.
1. В открывшейся форме задайте параметры:
   * **Repository URL** — URL репозитория вида `https://<имя инстанса {{ GL }}>.gitlab.yandexcloud.net/gitlab-test/my-app.git`.
   * **Username** — `gitlab-ci-token`.
   * **Password** — токен {{ GL }}, сгенерированный ранее.
1. Нажмите кнопку **Connect**.
1. В консоли Argo CD перейдите в раздел **Applications** и нажмите кнопку **Create Application**.
1. В открывшейся форме задайте параметры:
   * **Application Name** — `my-app`.
   * **Project** — `default`.
   * **Sync policy** — `Automatic`, затем выберите опции **Prune resources** и **Self Heal**.
   * **Sync policy** — `Auto-Create Namespace`.
   * **Source** — URL репозитория вида `https://<имя инстанса {{ GL }}>.gitlab.yandexcloud.net/gitlab-test/my-app.git`.
   * **Path** — `.helm`.
   * **Cluster URL** — `https://kubernetes.default.svc`.
   * **Namespace** — `my-app`.
   * **Directory** — выберите `Helm` и в появившейся секции **Parameters** задайте параметры, исходя из значения успешно завершенной сборки {{ GL }}:
     * **image.repository** — `{{ registry }}/<идентификатор реестра>/gitlab-test/my-app`.
     * **image.tag** — `main.<номер коммита>`.
1. Нажмите кнопку **Create** и дождитесь завершения синхронизации.
1. Для проверки запуска приложения выполните команду в кластере {{ k8s }}:

   ```bash
   kubectl get all -n my-app
   ```

### Проверьте автоматическую синхронизацию из репозитория {#check}

1. Перейдите в директорию с [клонированным проектом](#setup-repo) и откройте файл `.helm/values.yaml`.
1. Измените значение параметра `replicaCount` на `3`.
1. Сохраните изменения и отправьте их в репозиторий:

   ```bash
   git add . && \
   git commit -m "Increase replica count" && \
   git push
   ```

1. В консоли Argo CD дождитесь синхронизации приложения.
1. Проверьте, что количество подов приложения в кластере увеличилось:

   ```bash
   kubectl get pod -n my-app
   ```

## Удалите созданные ресурсы {#clear-out}

Если созданные ресурсы вам больше не нужны, удалите их:
1. [Удалите созданные Docker-образы](../../../container-registry/operations/docker-image/docker-image-delete.md).
1. Удалите кластер {{ k8s }} и реестр {{ container-registry-name }}:

   {% list tabs %}

   - Вручную

     1. [Удалите кластер {{ k8s }}](../../operations/kubernetes-cluster/kubernetes-cluster-delete.md).
     1. [Удалите реестр {{ container-registry-name }}](../../../container-registry/operations/registry/registry-delete.md).
     1. [Удалите созданные подсети](../../../vpc/operations/subnet-delete.md) и [сети](../../../vpc/operations/network-delete.md).
     1. [Удалите созданные сервисные аккаунты](../../../iam/operations/sa/delete.md).

   - С помощью {{ TF }}

     1. В командной строке перейдите в директорию, в которой расположен актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.
     1. Удалите конфигурационный файл `k8s-argocd.tf`.
     1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.
     1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

        Все ресурсы, которые были описаны в конфигурационном файле `k8s-argocd.tf`, будут удалены.

   {% endlist %}

1. [Удалите созданную ВМ {{ GL }}](../../../compute/operations/vm-control/vm-delete.md) или инстанс {{ mgl-name }}.