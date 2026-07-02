[Документация Yandex Cloud](../../index.md) > [Yandex Managed Service for GitLab](../index.md) > [Практические руководства](index.md) > Интеграция с Argo CD

# Интеграция с Argo CD


[Argo CD](https://argo-cd.readthedocs.io) — декларативный инструмент для непрерывной доставки в Kubernetes по модели GitOps.

В этом руководстве описана интеграция [инстанса Yandex Managed Service for GitLab](../concepts/index.md#instance), [кластера Managed Service for Kubernetes](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) и установленных в кластере [Argo CD](https://yandex.cloud/ru/marketplace/products/yc/argo-cd) и [GitLab Runner](https://yandex.cloud/ru/marketplace/products/yc/gitlab-runner), который выполняет сборку [Docker-контейнеров](https://yandex.cloud/ru/blog/posts/2022/03/docker-containers) с помощью инструмента [Kaniko](https://github.com/GoogleContainerTools/kaniko).

Чтобы интегрировать Argo CD с Managed Service for Kubernetes и Managed Service for GitLab:

1. [Создайте инстанс GitLab](#create-gitlab).
1. [Настройте GitLab](#configure-gitlab).
1. [Создайте GitLab Runner](#runners).
1. [Подготовьте репозиторий приложения для развертывания](#setup-repo).
1. [Разверните приложение с помощью Argo CD](#deploy-argo).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки описываемого решения входят:

* Плата за кластер Managed Service for Kubernetes: использование мастера и исходящий трафик ([тарифы Managed Service for Kubernetes](../../managed-kubernetes/pricing.md)).
* Плата за узлы кластера (ВМ): использование вычислительных ресурсов, операционной системы и хранилища ([тарифы Compute Cloud](../../compute/pricing.md)).
* Плата за публичные IP-адреса, если они назначены узлам кластера ([тарифы Virtual Private Cloud](../../vpc/pricing.md#prices-public-ip)).
* Плата за NAT-шлюз, если он используется вместо публичных IP-адресов для узлов кластера ([тарифы Virtual Private Cloud](../../vpc/pricing.md#nat-gateways)).
* Плата за [использование хранилища](../../container-registry/pricing.md) Container Registry.
* Плата за инстанс GitLab. Она зависит от способа создания инстанса:

   * Managed Service for GitLab: оплачиваются ресурсы ВМ, хранение данных и резервных копий, объем исходящего трафика ([тарифы Managed Service for GitLab](../pricing.md)).
   * ВМ с образом GitLab: оплачиваются ресурсы ВМ, образ GitLab, публичный IP-адрес для ВМ ([тарифы Compute Cloud](../../compute/pricing.md) и [Virtual Private Cloud](../../vpc/pricing.md#nat-gateways)).


## Перед началом работы {#before-you-begin}

### Подготовьте инфраструктуру {#deploy-infrastructure}

{% list tabs group=instructions %}

- Вручную {#manual}

  1. Если у вас еще нет [сети](../../vpc/concepts/network.md#network), [создайте ее](../../vpc/operations/network-create.md).
  1. Если у вас еще нет [подсетей](../../vpc/concepts/network.md#subnet), [создайте их](../../vpc/operations/subnet-create.md) в [зонах доступности](../../overview/concepts/geo-scope.md), где будут созданы кластер Managed Service for Kubernetes и [группа узлов](../../managed-kubernetes/concepts/index.md#node-group).
  1. [Создайте сервисные аккаунты](../../iam/operations/sa/create.md):
     * Сервисный аккаунт для ресурсов Kubernetes с [ролями](../../managed-kubernetes/security/index.md#yc-api) `k8s.clusters.agent` и `vpc.publicAdmin` на [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создается кластер Managed Service for Kubernetes.
     * Сервисный аккаунт для узлов Managed Service for Kubernetes с ролями [container-registry.images.puller](../../container-registry/security/index.md#container-registry-images-puller) и [container-registry.images.pusher](../../container-registry/security/index.md#container-registry-images-pusher). От его имени узлы Managed Service for Kubernetes будут загружать в [реестр](../../container-registry/concepts/registry.md) собранные в GitLab [Docker-образы](../../container-registry/concepts/docker-image.md), а также скачивать их для запуска [подов](../../managed-kubernetes/concepts/index.md#pod).

     {% note tip %}

     Вы можете использовать один и тот же сервисный аккаунт для управления кластером Managed Service for Kubernetes и его группами узлов.

     {% endnote %}

  1. [Создайте группы безопасности](../../managed-kubernetes/operations/connect/security-groups.md) для кластера Managed Service for Kubernetes и входящих в него групп узлов.

        {% note warning %}
        
        От настройки групп безопасности зависит работоспособность и доступность кластера, а также запущенных в нем сервисов и приложений.
        
        {% endnote %}

  1. [Создайте группу безопасности](../operations/configure-security-group.md) для работы [инстанса Managed Service for GitLab](../concepts/index.md#instance).
  1. [Создайте кластер Managed Service for Kubernetes](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) и [группу узлов](../../managed-kubernetes/operations/node-group/node-group-create.md). При создании кластера Managed Service for Kubernetes укажите ранее созданные сервисные аккаунты для ресурсов и узлов и группы безопасности для кластера.
  1. [Создайте реестр Yandex Container Registry](../../container-registry/operations/registry/registry-create.md).
  1. [Сохраните идентификатор созданного реестра](../../container-registry/operations/registry/registry-list.md#registry-get) — он понадобится для следующих шагов.

- Terraform {#tf}

  1. Если у вас еще нет Terraform, [установите его](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  1. [Получите данные для аутентификации](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials). Вы можете добавить их в переменные окружения или указать далее в файле с настройками провайдера.
  1. [Настройте и инициализируйте провайдер](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Чтобы не создавать конфигурационный файл с настройками провайдера вручную, [скачайте его](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).
  1. Поместите конфигурационный файл в отдельную рабочую директорию и [укажите значения параметров](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Если данные для аутентификации не были добавлены в переменные окружения, укажите их в конфигурационном файле.

  1. Скачайте в ту же рабочую директорию файл конфигурации кластера Managed Service for Kubernetes [k8s-argocd.tf](https://github.com/yandex-cloud-examples/yc-mk8s-argo-cd/blob/main/k8s-argocd.tf). В файле описаны:
     * [Сеть](../../vpc/concepts/network.md#network).
     * [Подсеть](../../vpc/concepts/network.md#subnet).
     * Кластер Managed Service for Kubernetes.
     * [Сервисный аккаунт](../../iam/concepts/users/service-accounts.md) для ресурсов и узлов Managed Service for Kubernetes.
     * Реестр Container Registry.
     * [Группы безопасности](../../vpc/concepts/security-groups.md), которые содержат [необходимые правила](../../managed-kubernetes/operations/connect/security-groups.md) для кластера Managed Service for Kubernetes и входящих в него групп узлов.

        В этих группах безопасности также присутствуют правила, необходимые для работы инстанса Managed Service for GitLab и [реестра Container Registry](../../container-registry/concepts/registry.md).

        {% note warning %}
        
        От настройки групп безопасности зависит работоспособность и доступность кластера, а также запущенных в нем сервисов и приложений.
        
        {% endnote %}

  1. Укажите в файле конфигурации:
     * [Идентификатор каталога](../../resource-manager/operations/folder/get-id.md).
     * [Версию Kubernetes](../../managed-kubernetes/concepts/release-channels-and-updates.md) для кластера Managed Service for Kubernetes и групп узлов.
     * CIDR кластера Managed Service for Kubernetes.
     * Имя сервисного аккаунта для ресурсов и узлов Managed Service for Kubernetes.
     * Имя реестра Container Registry.
  1. Проверьте корректность файлов конфигурации Terraform с помощью команды:

     ```bash
     terraform validate
     ```

     Если в файлах конфигурации есть ошибки, Terraform на них укажет.
  1. Создайте необходимую инфраструктуру:

     1. Выполните команду для просмотра планируемых изменений:
     
        ```bash
        terraform plan
        ```
     
        Если конфигурации ресурсов описаны верно, в терминале отобразится список изменяемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут изменены.
     
     1. Если вас устраивают планируемые изменения, внесите их:
        1. Выполните команду:
     
           ```bash
           terraform apply
           ```
     
        1. Подтвердите изменение ресурсов.
        1. Дождитесь завершения операции.

     В указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления](https://console.yandex.cloud).

{% endlist %}

{% note warning %}

Не изменяйте и не удаляйте ресурсы Virtual Private Cloud, которые используются кластером Managed Service for Kubernetes. Это может привести к некорректной работе кластера и невозможности его последующего удаления.

{% endnote %}

### Установите дополнительные зависимости {#prepare}

Установите в локальном окружении:
* [Интерфейс командной строки Yandex Cloud (YC CLI)](../../cli/operations/install-cli.md).
* [Утилиту потоковой обработки JSON-файлов `jq`](https://stedolan.github.io/jq/).
* [Менеджер пакетов Helm](https://helm.sh/ru/docs/intro/install/).
* [Установите kubectl](https://kubernetes.io/ru/docs/tasks/tools/install-kubectl) и [настройте его на работу с созданным кластером](../../managed-kubernetes/operations/connect/index.md#kubectl-connect).

## Создайте инстанс GitLab {#create-gitlab}

Создайте [инстанс Managed Service for GitLab](../concepts/index.md#instance) или [виртуальную машину](../../compute/concepts/vm.md) с [образом](../../compute/concepts/image.md) GitLab в той же [облачной сети](../../vpc/concepts/network.md#network), где расположен [кластер Managed Service for Kubernetes](../../managed-kubernetes/concepts/index.md#kubernetes-cluster).

{% list tabs group=gl_installation %}

- Инстанс Managed Service for GitLab {#instance-mgl}

  Создайте инстанс Managed Service for GitLab [согласно инструкции](../quickstart.md#instance-create).

- ВМ с образом GitLab {#gl-image-vm}

  Запустите GitLab на ВМ с [публичным IP-адресом](../../vpc/concepts/address.md#public-addresses).

  1. На странице [каталога](../../resource-manager/concepts/resources-hierarchy.md#folder) в [консоли управления](https://console.yandex.cloud) нажмите кнопку **Создать ресурс** и выберите `Виртуальная машина`.
  1. В блоке **Образ загрузочного диска** в поле **Поиск продукта** введите `Gitlab` и выберите публичный образ [GitLab](https://yandex.cloud/ru/marketplace/products/yc/gitlab).
  1. В блоке **Расположение** выберите [зону доступности](../../overview/concepts/geo-scope.md), в которой будет находиться ВМ. Если вы не знаете, какая зона доступности вам нужна, оставьте выбранную по умолчанию.
  1. В блоке **Вычислительные ресурсы** перейдите на вкладку `Своя конфигурация` и укажите необходимую [платформу](../../compute/concepts/vm-platforms.md), количество vCPU и объем RAM:
  
      * **Платформа** — `Intel Ice Lake`.
      * **vCPU** — `4`.
      * **Гарантированная доля vCPU** — `100%`.
      * **RAM** — `8 ГБ`.
  
  1. В блоке **Сетевые настройки**:
      
      * В поле **Подсеть** выберите сеть и подсеть, к которым нужно подключить ВМ. Если нужной [сети](../../vpc/concepts/network.md#network) или [подсети](../../vpc/concepts/network.md#subnet) еще нет, [создайте их](../../vpc/operations/subnet-create.md).
      * В поле **Публичный IP-адрес** оставьте значение `Автоматически`, чтобы назначить ВМ случайный внешний IP-адрес из пула Yandex Cloud, или выберите статический адрес из списка, если вы зарезервировали его заранее.
  
  1. В блоке **Доступ** выберите вариант **SSH-ключ** и укажите данные для доступа на ВМ:
  
      * В поле **Логин** введите имя пользователя. Не используйте имя `root` или другие имена, зарезервированные ОС. Для выполнения операций, требующих прав суперпользователя, используйте команду `sudo`.
      * В поле **SSH-ключ** выберите SSH-ключ, сохраненный в вашем профиле [пользователя организации](../../organization/concepts/membership.md).
        
        Если в вашем профиле нет сохраненных SSH-ключей или вы хотите добавить новый ключ:
        
        1. Нажмите кнопку **Добавить ключ**.
        1. Задайте имя SSH-ключа.
        1. Выберите вариант:
        
            * `Ввести вручную` — вставьте содержимое открытого [SSH](../../glossary/ssh-keygen.md)-ключа. Пару SSH-ключей необходимо [создать](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) самостоятельно.
            * `Загрузить из файла` — загрузите открытую часть SSH-ключа. Пару SSH-ключей необходимо создать самостоятельно.
            * `Сгенерировать ключ` — автоматическое создание пары SSH-ключей.
            
              При добавлении сгенерированного SSH-ключа будет создан и загружен архив с парой ключей. В ОС на базе Linux или macOS распакуйте архив в папку `/home/<имя_пользователя>/.ssh`. В ОС Windows распакуйте архив в папку `C:\Users\<имя_пользователя>/.ssh`. Дополнительно вводить открытый ключ в консоли управления не требуется.
        
        1. Нажмите кнопку **Добавить**.
        
        SSH-ключ будет добавлен в ваш профиль пользователя организации. Если в организации [отключена](../../organization/operations/os-login-access.md) возможность добавления пользователями SSH-ключей в свои профили, добавленный открытый SSH-ключ будет сохранен только в профиле пользователя внутри создаваемого ресурса.
  
  1. В блоке **Общая информация** задайте имя ВМ: `ci-tutorial-gitlab`.
  1. Нажмите кнопку **Создать ВМ**.
  
  Создание ВМ может занять несколько минут. Когда ВМ перейдет в статус `RUNNING` и запустится GitLab, настройте его.

{% endlist %}

## Настройте GitLab {#configure-gitlab}

Чтобы настроить GitLab и подготовить процесс непрерывной интеграции ([Continuous Integration](https://yandex.cloud/ru/blog/posts/2022/10/ci-cd), CI), создайте новый проект и введите параметры для аутентификации в CI:

{% list tabs group=gl_installation %}

- Инстанс Managed Service for GitLab {#instance-mgl}

  1. Авторизуйтесь в веб-интерфейсе [инстанса Managed Service for GitLab](../concepts/index.md#instance).
  1. Нажмите кнопку **Create a project**.
  1. Нажмите кнопку **Create blank project**.
  1. Заполните поля:
     * **Project name** — `gitlab-test`.
     * **Project URL** — выберите пользователя-администратора в поле рядом с FQDN инстанса Managed Service for GitLab.

     Остальные поля оставьте без изменений.
  1. Нажмите кнопку **Create project**.

- ВМ с образом GitLab {#gl-image-vm}

  1. На странице сервиса Yandex Compute Cloud выберите созданную [ВМ](../../compute/concepts/vm.md) и скопируйте ее [публичный IP-адрес](../../vpc/concepts/address.md#public-addresses).
  1. [Подключитесь](../../compute/operations/vm-connect/ssh.md) к ВМ по протоколу SSH.
  1. Получите пароль администратора GitLab с помощью команды ВМ:

     ```bash
     sudo cat /etc/gitlab/initial_root_password
     ```

  1. Скопируйте пароль из строки `Password` (исключая пробелы) в буфер обмена или отдельный файл.
  1. Откройте в браузере ссылку `http://<публичный_IP-адрес_ВМ>`. Откроется веб-интерфейс GitLab.
  1. Войдите в систему с учетной записью администратора:
     * **Username or email** — `root`.
     * **Password** — пароль, скопированный ранее.

     Если вы не можете войти, [сбросьте пароль учетной записи администратора](https://docs.gitlab.com/security/reset_user_password/#reset-your-root-password).
  1. [Смените пароль учетной записи администратора](https://docs.gitlab.com/user/profile/user_passwords/#change-your-password).
  1. Повторно войдите в систему с учетной записью администратора, используя новый пароль.
  1. Выберите **Create a project**.
  1. Задайте имя проекта: `gitlab-test`.
  1. Нажмите кнопку **Create project**.

{% endlist %}

## Создайте GitLab Runner {#runners}

Чтобы запускать задачи сборки в [кластере Yandex Managed Service for Kubernetes](../../managed-kubernetes/concepts/index.md#kubernetes-cluster), создайте [GitLab Runner](https://docs.gitlab.com/runner/install/kubernetes/). Для этого установите приложение GitLab Runner согласно [инструкции](../../managed-kubernetes/operations/applications/gitlab-runner.md).

После установки вы можете запускать автоматизированные сборки внутри своего [кластера Managed Service for Kubernetes](../../managed-kubernetes/concepts/index.md#kubernetes-cluster).

Подробнее про установку и настройку GitLab Runner читайте в [документации GitLab](https://docs.gitlab.com/runner/install/).

## Подготовьте репозиторий приложения для развертывания {#setup-repo}

1. Получите [авторизованный ключ](../../iam/concepts/authorization/key.md) для созданного ранее сервисного аккаунта с ролями `container-registry.images.puller` и `container-registry.images.pusher`:

   ```bash
   yc iam key create --service-account-name <имя_сервисного_аккаунта_для_узлов> -o key.json
   ```

1. Сохраните содержимое этого ключа — оно потребуется на следующем шаге:

   ```bash
   cat key.json | base64
   ```

1. Создайте [переменные окружения GitLab](https://docs.gitlab.com/ee/ci/variables/):
   1. На панели слева в GitLab перейдите в раздел **Settings** и во всплывающем списке выберите пункт **CI/CD**.
   1. Нажмите кнопку **Expand** напротив пункта **Variables**.
   1. Добавьте переменные окружения:
      * `CI_REGISTRY` — адрес созданного ранее реестра в формате `cr.yandex/<идентификатор_реестра>`.
      * `CI_REGISTRY_USER` — `json_key`.
      * `CI_REGISTRY_PASSWORD` — вывод команды `cat key.json | base64`.

      Для добавления переменной:
      1. Нажмите кнопку **Add variable**.
      1. В появившемся окне в поле **Key** укажите имя переменной, в поле **Value** — значение переменной.
      1. Нажмите кнопку **Add variable**.
1. Настройте доступ к репозиторию:
   1. [Сгенерируйте новую пару SSH-ключей](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) или используйте существующую.
   1. [Добавьте публичную часть SSH-ключа в настройки учетной записи GitLab](https://docs.gitlab.com/ee/user/ssh.html#add-an-ssh-key-to-your-gitlab-account).
1. Клонируйте репозиторий:

   ```bash
   git clone git@<имя_инстанса>.gitlab.yandexcloud.net:<имя_пользователя-администратора>/gitlab-test.git
   ```

1. Клонируйте репозиторий [yc-webinar-gitops-argo-crossplane](https://github.com/yandex-cloud-examples/yc-webinar-gitops-argo-crossplane) на рабочую машину:

   ```bash
   git clone https://github.com/yandex-cloud-examples/yc-webinar-gitops-argo-crossplane.git
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

1. Запустится сценарий сборки. Чтобы посмотреть его выполнение, на панели слева в GitLab выберите **Build** → **Pipelines**. Дождитесь успешного завершения обоих этапов сборки.
1. Откройте завершенную сборку и скопируйте строку из лога, она понадобится на следующем этапе:

   ```text
   INFO[0025] Pushing image to cr.yandex/<идентификатор_реестра>/<имя_пользователя-администратора>/gitlab-test:main.<номер_коммита>
   ```

## Разверните приложение с помощью Argo CD {#deploy-argo}

### Установите Argo CD в кластер Managed Service for Kubernetes {#install}

1. Установите Argo CD согласно [инструкции](../../managed-kubernetes/operations/applications/argo-cd.md).

   {% note warning %}
   
   Группам узлов Kubernetes требуется доступ в интернет для скачивания образов и компонентов.
   
   Предоставить доступ в интернет можно следующими способами:
   * Назначить каждому узлу в группе [публичный IP адрес](../../vpc/concepts/address.md#public-addresses).
   * [Настроить виртуальную машину в качестве NAT-инстанса](../../tutorials/routing/nat-instance/index.md).
   * [Настроить NAT-шлюз](../../vpc/operations/create-nat-gateway.md).
   
   {% endnote %}

1. Получите пароль администратора из секрета Kubernetes:

   ```bash
   kubectl --namespace <пространство_имен> get secret argocd-initial-admin-secret \
     --output jsonpath="{.data.password}" | base64 -d
   ```

1. Настройте переадресацию порта сервиса ArgoCD на локальный компьютер:

   ```bash
   kubectl port-forward service/<название_приложения_Argo_CD>-argocd-server \
     --namespace <пространство_имен> 8080:443
   ```

1. Откройте в браузере консоль Argo CD по адресу `https://127.0.0.1:8080`.
1. Авторизуйтесь в консоли, используя имя пользователя `admin` и полученный ранее пароль.

### Добавьте репозиторий GitLab в Argo CD {#create}

1. На панели слева в GitLab перейдите в раздел **Settings** и во всплывающем списке выберите пункт **Access Tokens**.
1. Задайте параметры нового токена:
   * **Token name** — `argocd`.
   * **Select a role** — `Maintainer`.
   * **Select scopes** — `read_repository`.
1. Нажмите кнопку **Create project access token**.
1. Скопируйте значение созданного токена.
1. В консоли Argo CD перейдите в раздел **Settings** → **Repositories**.
1. Нажмите кнопку **Connect Repo** и выберите в списке **VIA HTTPS**.

   {% note info %}

   Если при подключении репозитория вы получаете ошибку `FATA[0000] rpc error: code = Unknown desc = error testing repository connectivity: authorization failed`, включите доступ в GitLab по протоколу HTTP(S).

   Чтобы включить доступ, на панели слева в GitLab выберите **Admin → Settings → General**. В блоке **Visibility and access controls** найдите настройку **Enabled Git access protocols** и выберите в списке пункт, разрешающий доступ по протоколу HTTP(S).

   [Подробнее в документации GitLab](https://docs.gitlab.com/administration/settings/visibility_and_access_controls/#configure-enabled-git-access-protocols).

   {% endnote %}

1. В открывшейся форме задайте параметры:
   * **Repository URL** — URL репозитория вида `https://<имя_инстанса_GitLab>.gitlab.yandexcloud.net/<имя_пользователя-администратора>/gitlab-test.git`.
   * **Username** — `gitlab-ci-token`.
   * **Password** — токен GitLab, сгенерированный ранее.
1. Нажмите кнопку **Connect**.
1. В консоли Argo CD перейдите в раздел **Applications** и нажмите кнопку **Create Application**.
1. В открывшейся форме задайте параметры:
   * **Application Name** — `gitlab-test`.
   * **Project** — `default`.
   * **Sync policy** — `Automatic`, затем выберите опции **Prune resources** и **Self Heal**.
   * **Sync options** — выберите опцию `Auto-Create Namespace`.
   * **Repository URL** — укажите URL репозитория вида `https://<имя_инстанса_GitLab>.gitlab.yandexcloud.net/<имя_пользователя-администратора>/gitlab-test.git`.
   * **Path** — `.helm`.
   * **Cluster URL** — `https://kubernetes.default.svc`.
   * **Namespace** — `gitlab-test`.
   * **image.repository** — `cr.yandex/<идентификатор_реестра>/<имя_пользователя-администратора>/gitlab-test`.
   * **image.tag** — `main.<номер_коммита>`.
1. Нажмите кнопку **Create** и дождитесь завершения синхронизации.
1. Для проверки запуска приложения выполните команду в кластере Managed Service for Kubernetes:

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
1. Проверьте, что количество подов приложения в кластере Managed Service for Kubernetes увеличилось:

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
1. [Удалите созданные Docker-образы](../../container-registry/operations/docker-image/docker-image-delete.md).
1. Удалите кластер Managed Service for Kubernetes и реестр Container Registry:

   {% list tabs group=instructions %}

   - Вручную {#manual}

     1. [Удалите кластер Managed Service for Kubernetes](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).
     1. [Удалите реестр Container Registry](../../container-registry/operations/registry/registry-delete.md).
     1. [Удалите созданные подсети](../../vpc/operations/subnet-delete.md) и [сети](../../vpc/operations/network-delete.md).
     1. [Удалите созданные сервисные аккаунты](../../iam/operations/sa/delete.md).

   - Terraform {#tf}

     1. В терминале перейдите в директорию с планом инфраструктуры.
     
         {% note warning %}
     
         Убедитесь, что в директории нет Terraform-манифестов с ресурсами, которые вы хотите сохранить. Terraform удаляет все ресурсы, которые были созданы с помощью манифестов в текущей директории.
     
         {% endnote %}
     
     1. Удалите ресурсы:
     
         1. Выполните команду:
     
             ```bash
             terraform destroy
             ```
     
         1. Подтвердите удаление ресурсов и дождитесь завершения операции.
     
         Все ресурсы, которые были описаны в Terraform-манифестах, будут удалены.

   {% endlist %}

1. [Удалите созданную виртуальную машину GitLab](../../compute/operations/vm-control/vm-delete.md) или инстанс Managed Service for GitLab.