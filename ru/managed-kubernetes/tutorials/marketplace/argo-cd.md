# Интеграция с Argo CD

[Argo CD](https://argo-cd.readthedocs.io) — декларативный инструмент для непрерывной доставки в {{ k8s }} по модели GitOps.

В этом руководстве описана интеграция [инстанса {{ mgl-full-name }}](../../../managed-gitlab/concepts/index.md#instance), [кластера {{ managed-k8s-name }}](../../concepts/index.md#kubernetes-cluster) и установленных в кластере [Argo CD](/marketplace/products/yc/argo-cd) и [{{ GLR }}](/marketplace/products/yc/gitlab-runner), который выполняет сборку [Docker-контейнеров](/blog/posts/2022/03/docker-containers) с помощью инструмента [Kaniko](https://github.com/GoogleContainerTools/kaniko).

Чтобы интегрировать Argo CD с {{ managed-k8s-name }} и {{ mgl-name }}:
1. [{#T}](#create-gitlab).
1. [{#T}](#configure-gitlab).
1. [{#T}](#runners).
1. [{#T}](#setup-repo).
1. [{#T}](#deploy-argo).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

### Подготовьте инфраструктуру {#deploy-infrastructure}

{% list tabs %}

- Вручную

  1. Если у вас еще нет [сети](../../../vpc/concepts/network.md#network), [создайте ее](../../../vpc/operations/network-create.md).
  1. Если у вас еще нет [подсетей](../../../vpc/concepts/network.md#subnet), [создайте их](../../../vpc/operations/subnet-create.md) в [зонах доступности](../../../overview/concepts/geo-scope.md), где будут созданы кластер {{ managed-k8s-name }} и [группа узлов](../../concepts/index.md#node-group).
  1. [Создайте сервисные аккаунты](../../../iam/operations/sa/create.md):
     * Сервисный аккаунт для ресурсов {{ k8s }} с [ролью](../../../iam/concepts/access-control/roles.md) [{{ roles-editor }}](../../../iam/concepts/access-control/roles.md#editor) на [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создается кластер {{ managed-k8s-name }}.
     * Сервисный аккаунт для узлов {{ managed-k8s-name }} с ролями [{{ roles-cr-puller }}](../../../iam/concepts/access-control/roles.md#cr-images-puller) и [{{ roles-cr-pusher }}](../../../iam/concepts/access-control/roles.md#cr-images-pusher.md). От его имени узлы {{ managed-k8s-name }} будут загружать в [реестр](../../../container-registry/concepts/registry.md) собранные в {{ GL }} [Docker-образы](../../../container-registry/concepts/docker-image.md), а также скачивать их для запуска [подов](../../concepts/index.md#pod).

     {% note tip %}

     Вы можете использовать один и тот же сервисный аккаунт для управления кластером {{ managed-k8s-name }} и его группами узлов.

     {% endnote %}

  1. [Создайте кластер {{ managed-k8s-name }}](../../operations/kubernetes-cluster/kubernetes-cluster-create.md) и [группу узлов](../../operations/node-group/node-group-create.md). При создании кластера {{ managed-k8s-name }} укажите ранее созданные сервисные аккаунты для ресурсов и узлов.
  1. [Настройте группы безопасности](../../operations/connect/security-groups.md) для работы кластера {{ managed-k8s-name }}.
  1. [Настройте группу безопасности по умолчанию](../../../managed-gitlab/operations/connect.md) для работы [инстанса {{ mgl-name }}](../../../managed-gitlab/concepts/index.md#instance).
  1. [Создайте реестр {{ container-registry-full-name }}](../../../container-registry/operations/registry/registry-create.md).
  1. [Сохраните идентификатор созданного реестра](../../../container-registry/operations/registry/registry-list.md#registry-get) — он понадобится для следующих шагов.

- С помощью {{ TF }}

  1. {% include [terraform-install-without-setting](../../../_includes/mdb/terraform/install-without-setting.md) %}
  1. {% include [terraform-authentication](../../../_includes/mdb/terraform/authentication.md) %}
  1. {% include [terraform-setting](../../../_includes/mdb/terraform/setting.md) %}
  1. {% include [terraform-configure-provider](../../../_includes/mdb/terraform/configure-provider.md) %}

  1. Скачайте в ту же рабочую директорию файл конфигурации кластера {{ managed-k8s-name }} [k8s-argocd.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/managed-kubernetes/k8s-argocd.tf). В файле описаны:
     * [Сеть](../../../vpc/concepts/network.md#network).
     * [Подсеть](../../../vpc/concepts/network.md#subnet).
     * [Группа безопасности](../../../vpc/concepts/security-groups.md) и [правила](../../operations/connect/security-groups.md), необходимые для работы кластера {{ managed-k8s-name }}, группы узлов, инстанса {{ mgl-name }} и [реестра {{ container-registry-name }}](../../../container-registry/concepts/registry.md):
       * Правила для служебного трафика.
       * Правила для доступа к API {{ k8s }} и управления кластером {{ managed-k8s-name }} с помощью `kubectl` через порты 443 и 6443.
       * Правила для подключения к Git-репозиторию по протоколу [SSH](../../../glossary/ssh-keygen.md) через порт 22.
       * Правила, разрешающие HTTP- и HTTPS-трафик через порты 80 и 443.
       * Правила для подключения к {{ container-registry-name }} через порт 5050.
     * Кластер {{ managed-k8s-name }}.
     * [Сервисный аккаунт](../../../iam/concepts/users/service-accounts.md) для ресурсов и узлов {{ managed-k8s-name }}.
     * Реестр {{ container-registry-name }}.
  1. Укажите в файле конфигурации:
     * [Идентификатор каталога](../../../resource-manager/operations/folder/get-id.md).
     * [Версию {{ k8s }}](../../concepts/release-channels-and-updates.md) для кластера {{ managed-k8s-name }} и групп узлов.
     * CIDR кластера {{ managed-k8s-name }}.
     * Имя сервисного аккаунта для ресурсов и узлов {{ managed-k8s-name }}.
     * Имя реестра {{ container-registry-name }}.
  1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

     ```bash
     terraform validate
     ```

     Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.
  1. Создайте необходимую инфраструктуру:

     {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

     {% include [explore-resources](../../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

### Установите дополнительные зависимости {#prepare}

Установите в локальном окружении:
* [Интерфейс командной строки {{ yandex-cloud }} (YC CLI)](../../../cli/operations/install-cli.md).
* [Утилиту потоковой обработки JSON-файлов `jq`](https://stedolan.github.io/jq/).
* [Менеджер пакетов Helm]({{ links.helm.install }}).
* {% include [kubectl-install-links](../../../_includes/managed-kubernetes/kubectl-install.md) %}

{% include [create-gitlab](../../../_includes/managed-gitlab/create-gitlab.md) %}

{% include [Create a project](../../../_includes/managed-gitlab/initialize.md) %}

{% include [create glr](../../../_includes/managed-gitlab/k8s-runner.md) %}

## Подготовьте репозиторий приложения для развертывания {#setup-repo}

1. Получите [авторизованный ключ](../../../iam/concepts/authorization/key.md) для созданного ранее сервисного аккаунта с ролями `{{ roles-cr-puller }}` и `{{ roles-cr-pusher }}`:

   ```bash
   yc iam key create --service-account-name <имя_сервисного_аккаунта_для_узлов> -o key.json
   ```

1. Сохраните содержимое этого ключа — оно потребуется на следующем шаге:

   ```bash
   cat key.json | base64
   ```

1. Создайте [переменные окружения {{ GL }}](https://docs.gitlab.com/ee/ci/variables/README.html):
   1. На панели слева в {{ GL }} перейдите в раздел **Settings** и во всплывающем списке выберите пункт **CI/CD**.
   1. Нажмите кнопку **Expand** напротив пункта **Variables**.
   1. Добавьте переменные окружения:
      * `CI_REGISTRY` — адрес созданного ранее реестра в формате `{{ registry }}/<идентификатор_реестра>`.
      * `CI_REGISTRY_USER` — `json_key`.
      * `CI_REGISTRY_PASSWORD` — вывод команды `cat key.json | base64`.

      Для добавления переменной:
      1. Нажмите кнопку **Add variable**.
      1. В появившемся окне в поле **Key** укажите имя переменной, в поле **Value** — значение переменной.
      1. Нажмите кнопку **Add variable**.
1. Настройте доступ к репозиторию:
   1. [Сгенерируйте новую пару SSH-ключей](../../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) или используйте существующую.
   1. [Добавьте публичную часть SSH-ключа в настройки учетной записи {{ GL }}](https://docs.gitlab.com/ee/user/ssh.html#add-an-ssh-key-to-your-gitlab-account).
1. Клонируйте репозиторий:

   ```bash
   git clone git@<имя_инстанса>.gitlab.yandexcloud.net:<имя_пользователя-администратора>/gitlab-test.git
   ```

1. Клонируйте репозиторий [yc-webinar-gitops-argo-crossplane](https://github.com/yandex-cloud-examples/yc-webinar-gitops-argo-crossplane) на рабочую машину:

   ```bash
   git clone git@github.com:yandex-cloud-examples/yc-webinar-gitops-argo-crossplane.git
   ```

1. Скопируйте в директорию `gitlab-test` все файлы из директории `yc-webinar-gitops-argo-crossplane/02-argocd/app`, включая скрытые:

   ```bash
   cp -rT <путь_к_директории_app> <путь_к_директории_gitlab-test>
   ```

1. Зафиксируйте изменения в `gitlab-test` и отправьте их в репозиторий:

   ```bash
   git add . && \
   git commit -m "Add app src and CI" && \
   git push
   ```

1. Запустится сценарий сборки. Чтобы посмотреть его выполнение, выберите в выпадающем меню пункт **Build** → **Pipelines**. Дождитесь успешного завершения обоих этапов сборки.
1. Откройте завершенную сборку и скопируйте строку из лога, она понадобится на следующем этапе:

   ```text
   INFO[0025] Pushing image to {{ registry }}/<идентификатор_реестра>/<имя_пользователя-администратора>/gitlab-test:main.<номер_коммита>
   ```

## Разверните приложение с помощью Argo CD {#deploy-argo}

### Установите Argo CD в кластер {{ managed-k8s-name }} {#install}

1. Установите Argo CD согласно [инструкции](../../operations/applications/argo-cd.md).

   {% include [Install kubectl](../../../_includes/managed-kubernetes/note-node-group-internet-access.md) %}

1. Настройте переадресацию порта сервиса ArgoCD на локальный компьютер:

   ```bash
   kubectl port-forward service/<название_приложения_Argo_CD>-argocd-server \
     --namespace <пространство_имен> 8080:443
   ```

1. Получите пароль администратора из секрета {{ k8s }}:

   ```bash
   kubectl --namespace <пространство_имен> get secret argocd-initial-admin-secret \
     --output jsonpath="{.data.password}" | base64 -d
   ```

1. Откройте в браузере консоль Argo CD по адресу `https://127.0.0.1:8080`.
1. Авторизуйтесь в консоли, используя имя пользователя `admin` и пароль, полученный на предыдущем шаге.

### Добавьте репозиторий {{ GL }} в Argo CD {#create}

1. На панели слева в {{ GL }} перейдите в раздел **Settings** и во всплывающем списке выберите пункт **Access Tokens**.
1. Задайте параметры нового токена:
   * **Token name** — `argocd`.
   * **Select a role** — `Maintainer`.
   * **Select scopes** — `read_repository`.
1. Нажмите кнопку **Create project access token**.
1. Скопируйте значение созданного токена.
1. В консоли Argo CD перейдите в раздел **Settings** → **Repositories**.
1. Нажмите кнопку **Connect Repo Using HTTPS**.
1. В открывшейся форме задайте параметры:
   * **Repository URL** — URL репозитория вида `https://<имя_инстанса_{{ GL }}>.gitlab.yandexcloud.net/<имя_пользователя-администратора>/gitlab-test.git`.
   * **Username** — `gitlab-ci-token`.
   * **Password** — токен {{ GL }}, сгенерированный ранее.
1. Нажмите кнопку **Connect**.
1. В консоли Argo CD перейдите в раздел **Applications** и нажмите кнопку **Create Application**.
1. В открывшейся форме задайте параметры:
   * **Application Name** — `gitlab-test`.
   * **Project** — `default`.
   * **Sync policy** — `Automatic`, затем выберите опции **Prune resources** и **Self Heal**.
   * **Sync options** — выберите опцию `Auto-Create Namespace`.
   * **Repository URL** — укажите URL репозитория вида `https://<имя_инстанса_{{ GL }}>.gitlab.yandexcloud.net/<имя_пользователя-администратора>/gitlab-test.git`.
   * **Path** — `.helm`.
   * **Cluster URL** — `https://kubernetes.default.svc`.
   * **Namespace** — `gitlab-test`.
   * **image.repository** — `{{ registry }}/<идентификатор_реестра>/<имя_пользователя-администратора>/gitlab-test`.
   * **image.tag** — `main.<номер_коммита>`.
1. Нажмите кнопку **Create** и дождитесь завершения синхронизации.
1. Для проверки запуска приложения выполните команду в кластере {{ managed-k8s-name }}:

   ```bash
   kubectl get all -n gitlab-test
   ```

   Результат:

   ```text
   NAME                               READY   STATUS    RESTARTS   AGE
   pod/gitlab-test-67c8d58bc4-6w4q7   1/1     Running   0          2m26s
   pod/gitlab-test-67c8d58bc4-sldpc   1/1     Running   0          2m26s

   NAME                  TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)   AGE
   service/gitlab-test   ClusterIP   10.96.186.223   <none>        80/TCP    2m26s

   NAME                          READY   UP-TO-DATE   AVAILABLE   AGE
   deployment.apps/gitlab-test   2/2     2            2           2m26s

   NAME                                     DESIRED   CURRENT   READY   AGE
   replicaset.apps/gitlab-test-67c8d58bc4   2         2         2       2m26s
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
1. Проверьте, что количество подов приложения в кластере {{ managed-k8s-name }} увеличилось:

   ```bash
   kubectl get pod -n gitlab-test
   ```

   Результат:

   ```text
   NAME                               READY   STATUS    RESTARTS   AGE
   pod/gitlab-test-67c8d58bc4-6w4q7   1/1     Running   0          15m
   pod/gitlab-test-67c8d58bc4-7hmcn   1/1     Running   0          10m
   pod/gitlab-test-67c8d58bc4-sldpc   1/1     Running   0          15m

   NAME                  TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)   AGE
   service/gitlab-test   ClusterIP   10.96.186.223   <none>        80/TCP    15m

   NAME                          READY   UP-TO-DATE   AVAILABLE   AGE
   deployment.apps/gitlab-test   3/3     3            3           15m

   NAME                                     DESIRED   CURRENT   READY   AGE
   replicaset.apps/gitlab-test-67c8d58bc4   3         3         3       15m
   ```

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:
1. [Удалите созданные Docker-образы](../../../container-registry/operations/docker-image/docker-image-delete.md).
1. Удалите кластер {{ managed-k8s-name }} и реестр {{ container-registry-name }}:

   {% list tabs %}

   - Вручную

     1. [Удалите кластер {{ managed-k8s-name }}](../../operations/kubernetes-cluster/kubernetes-cluster-delete.md).
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

1. [Удалите созданную виртуальную машину {{ GL }}](../../../compute/operations/vm-control/vm-delete.md) или инстанс {{ mgl-name }}.
