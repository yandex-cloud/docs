# Хранение Docker-образов в Yandex Container Registry

# Хранение Docker-образов из Yandex Managed Service for GitLab в Yandex Container Registry


В GitLab интегрирован сервис [Container Registry](https://docs.gitlab.com/ee/user/packages/container_registry/). Он позволяет хранить Docker-образы для каждого проекта в GitLab.

Вместо GitLab Container Registry вы можете использовать [Yandex Container Registry](../../container-registry/index.md). Этот сервис позволяет хранить Docker-образы в облаке и распространять их между управляемыми сервисами Yandex Cloud, например, [Yandex Managed Service for Kubernetes](../../managed-kubernetes/index.md) или [Yandex Managed Service for GitLab](../index.md).

Использование Yandex Container Registry для хранения образов из проектов GitLab обладает несколькими преимуществами:

* GitLab Container Registry хранит образы и теги на диске [инстанса GitLab](../concepts/index.md#instance). Когда место на диске заканчивается, возникает ошибка с HTTP-кодом 500, инстанс становится недоступным. Восстановить его можно только через обращение в техническую поддержку.

   Yandex Container Registry хранит образы и теги в [реестрах](../../container-registry/concepts/registry.md), для которых выделяются [отдельные квоты](../../container-registry/concepts/limits.md). Поэтому накопление Docker-образов и тегов не влияет на место на диске инстанса.

* Образы в Yandex Container Registry остаются доступными, даже если Managed Service for GitLab недоступен.

* Yandex Container Registry поддерживает [сканер уязвимостей Docker-образов](../../container-registry/concepts/vulnerability-scanner.md). С его помощью можно обнаружить уязвимости и устранить их до развертывания приложения. Подробнее о сканировании см. в [блоге Yandex Cloud](https://yandex.cloud/ru/blog/posts/2023/04/vulnerability-scanner-and-yandex-container-registry).

Чтобы настроить хранение Docker-образов из Managed Service for GitLab в Yandex Container Registry:

1. [Создайте инстанс GitLab](#create-gitlab).
1. [Настройте GitLab](#configure-gitlab).
1. [Создайте тестовое приложение](#app-create).
1. [Создайте GitLab Runner](#runners).
1. [Создайте переменные окружения GitLab](#add-variables).
1. [Создайте файл конфигурации сценария CI](#add-ci).
1. [Проверьте результат](#check-result).
1. [Включите политику автоматического удаления Docker-образов](#lifecycle-policy).
1. (Опционально) [Отсканируйте Docker-образы на наличие уязвимостей](#vulnerability-scanner).

Если инстанс Yandex Managed Service for GitLab уже настроен для непрерывной интеграции ([Continuous Integration](https://yandex.cloud/ru/blog/posts/2022/10/ci-cd), CI), убедитесь, что [инфраструктура для хранения Docker-образов](#deploy-infrastructure) подготовлена. Затем начните настройку с [создания переменных окружения](#add-variables).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

{% note info %}

По умолчанию GitLab Container Registry отключен при создании инстанса Managed Service for GitLab.

{% endnote %}

## Перед началом работы {#before-you-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входит плата за следующие ресурсы:

* Диски и постоянно запущенные виртуальные машины (см. [тарифы Yandex Compute Cloud](../../compute/pricing.md)).
* Использование динамического публичного IP-адреса (см. [тарифы Yandex Virtual Private Cloud](../../vpc/pricing.md#prices-public-ip)).
* Хранение созданных Docker-образов и сканер уязвимостей, если вы его [активируете](#vulnerability-scanner) (см. [тарифы Container Registry](../../container-registry/pricing.md)).
* Использование мастера Managed Service for Kubernetes (см. [тарифы Managed Service for Kubernetes](../../managed-kubernetes/pricing.md)).

### Подготовьте инфраструктуру {#deploy-infrastructure}

{% list tabs group=instructions %}

- Вручную {#manual}

   1. Если у вас еще нет [сети](../../vpc/concepts/network.md#network), [создайте ее](../../vpc/operations/network-create.md).
   1. Если у вас еще нет [подсетей](../../vpc/concepts/network.md#subnet), [создайте их](../../vpc/operations/subnet-create.md) в [зонах доступности](../../overview/concepts/geo-scope.md), где будут созданы [кластер Yandex Managed Service for Kubernetes](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) и [группа узлов](../../managed-kubernetes/concepts/index.md#node-group).
   1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md) `account-for-container-registry` с [ролями](../../iam/concepts/access-control/roles.md) на каталог:

      * `editor`
      * `container-registry.images.pusher`
      * `container-registry.images.puller`

   1. [Создайте кластер Managed Service for Kubernetes](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md#kubernetes-cluster-create) с базовым мастером и [группу узлов](../../managed-kubernetes/operations/node-group/node-group-create.md). При создании кластера укажите созданный ранее сервисный аккаунт.
   1. Настройте группу безопасности для работы [кластера Managed Service for Kubernetes](../../managed-kubernetes/operations/connect/security-groups.md) и [инстанса Managed Service for GitLab](../operations/configure-security-group.md).

   1. [Создайте реестр Yandex Container Registry](../../container-registry/operations/registry/registry-create.md).

- Terraform {#tf}

   1. Если у вас еще нет Terraform, [установите его](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
   1. [Получите данные для аутентификации](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials). Вы можете добавить их в переменные окружения или указать далее в файле с настройками провайдера.
   1. [Настройте и инициализируйте провайдер](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Чтобы не создавать конфигурационный файл с настройками провайдера вручную, [скачайте его](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).
   1. Поместите конфигурационный файл в отдельную рабочую директорию и [укажите значения параметров](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Если данные для аутентификации не были добавлены в переменные окружения, укажите их в конфигурационном файле.

   1. Скачайте в ту же рабочую директорию файл конфигурации [container-registry-and-gitlab.tf](https://github.com/yandex-cloud-examples/yc-gitlab-cr-integration/blob/main/container-registry-and-gitlab.tf).

      В этом файле описаны:

      * [Сеть](../../vpc/concepts/network.md#network).
      * [Подсеть](../../vpc/concepts/network.md#subnet).
      * [Группа безопасности](../../vpc/concepts/security-groups.md) и правила, необходимые для работы инстанса Managed Service for GitLab и [кластера Yandex Managed Service for Kubernetes](../../managed-kubernetes/concepts/index.md#kubernetes-cluster).
      * Кластер Managed Service for Kubernetes с базовым мастером.
      * [Группа узлов для кластера](../../managed-kubernetes/concepts/index.md#node-group).
      * [Сервисный аккаунт](../../iam/concepts/users/service-accounts.md), необходимый для работы кластера и группы узлов Managed Service for Kubernetes.
      * Реестр Yandex Container Registry.

   1. Укажите в файле `container-registry-and-gitlab.tf`:

      * [Идентификатор облака](../../resource-manager/operations/cloud/get-id.md).
      * [Идентификатор каталога](../../resource-manager/operations/folder/get-id.md).
      * [Версию Kubernetes](../../managed-kubernetes/concepts/release-channels-and-updates.md) для кластера и групп узлов Managed Service for Kubernetes.

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
            * `Загрузить из файла` — загрузите открытую часть SSH-ключа. Пару SSH-ключей необходимо создать самостоятельно.
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

## Создайте тестовое приложение {#app-create}

Создайте тестовое приложение, которое можно будет развернуть в кластере Managed Service for Kubernetes. Для этого добавьте в проект `Dockerfile`:

   1. Авторизуйтесь в GitLab.
   1. Откройте проект GitLab.
   1. В строке навигации по репозиторию нажмите кнопку ![image](../../_assets/console-icons/plus.svg) и в выпадающем меню выберите пункт **New file**.
   1. Назовите файл `Dockerfile` и добавьте в него код:

      ```Dockerfile
      FROM alpine:3.10
      CMD echo "Hello"
      ```

   1. Напишите комментарий к коммиту в поле **Commit message**: `Dockerfile for a test application`.
   1. Нажмите кнопку **Commit changes**.

## Создайте GitLab Runner {#runners}

Чтобы запускать задачи сборки в [кластере Yandex Managed Service for Kubernetes](../../managed-kubernetes/concepts/index.md#kubernetes-cluster), создайте [GitLab Runner](https://docs.gitlab.com/runner/install/kubernetes/). Для этого установите приложение GitLab Runner согласно [инструкции](../../managed-kubernetes/operations/applications/gitlab-runner.md).

После установки вы можете запускать автоматизированные сборки внутри своего [кластера Managed Service for Kubernetes](../../managed-kubernetes/concepts/index.md#kubernetes-cluster).

Подробнее про установку и настройку GitLab Runner читайте в [документации GitLab](https://docs.gitlab.com/runner/install/).

## Создайте переменные окружения GitLab {#add-variables}

Чтобы разрешить сервису Managed Service for GitLab сохранять Docker-образы и их теги в Yandex Container Registry, создайте [переменные окружения GitLab](https://docs.gitlab.com/ee/ci/variables/index.html):

1. Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

   По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

1. Создайте [авторизованный ключ](../../iam/concepts/authorization/key.md) для сервисного аккаунта `account-for-container-registry`, [созданного ранее](#before-you-begin):

   ```bash
   yc iam key create --service-account-name account-for-container-registry -o key.json
   ```

   Ключ сохраняется в файле `key.json` в папке, где была запущена команда.

1. Откройте свой проект в GitLab.

1. На панели слева перейдите в раздел **Settings** и во всплывающем списке выберите пункт **CI/CD**.

1. Разверните раздел **Variables**.

1. Добавьте переменные окружения с выключенной опцией защиты:

   | **Переменная**        | **Ее значение**                    |
   | --------------------- | ---------------------------------- |
   | `CI_REGISTRY`         | `cr.yandex/<идентификатор_реестра>`. Укажите идентификатор созданного ранее реестра Yandex Container Registry. |
   | `CI_REGISTRY_KEY`     | Содержимое файла `key.json`.       |

   Для добавления переменной:

   1. Нажмите кнопку **Add variable**.
   1. Для переменной `CI_REGISTRY_KEY` в поле **Visibility** выберите вариант **Visible**.

      {% note warning %}

      Файл `key.json` содержит пробелы и переносы строк, маскирование которых не поддерживается в GitLab. При этом в приведенном [примере CI-пайплайна](#add-ci), переменная `CI_REGISTRY_KEY` в явном виде не выводится, поэтому ее маскирование не требуется.

      {% endnote %}

   1. В появившемся окне в поле **Key** укажите имя переменной, в поле **Value** — значение переменной.
   1. Выключите опцию **Protect variable**.
   1. Нажмите кнопку **Add variable**.

## Создайте файл конфигурации сценария CI {#add-ci}

Для сборки образов из Dockerfile без Docker используется [kaniko](https://github.com/GoogleContainerTools/kaniko).

Чтобы публиковать Docker-образы из проекта GitLab в Yandex Container Registry, создайте сценарий CI:

1. Откройте проект `gitlab-test`.
1. В строке навигации по репозиторию нажмите кнопку ![image](../../_assets/console-icons/plus.svg) и в выпадающем меню выберите пункт **New file**.
1. Назовите файл `.gitlab-ci.yml`. Добавьте в него шаги сборки Docker-образа и его загрузки в Yandex Container Registry:

   {% cut ".gitlab-ci.yml" %}

   ```yaml
   build:
      stage: build
      # Использование kaniko для создания контейнера внутри контейнера для большей безопасности.
      image:
         name: gcr.io/kaniko-project/executor:debug
         entrypoint: [""]
      script:
         - mkdir -p /kaniko/.docker
         # Отправка образа контейнера в реестр. Образ отмечен хэшем коммита.
         - echo "{\"auths\":{\"$CI_REGISTRY\":{\"auth\":\"$(echo -n "json_key:${CI_REGISTRY_KEY}" | base64 | tr -d '\n' )\"}}}" > /kaniko/.docker/config.json
         - >-
            /kaniko/executor
            --context "${CI_PROJECT_DIR}"
            --dockerfile "${CI_PROJECT_DIR}/Dockerfile"
            --destination "${CI_REGISTRY}/${CI_PROJECT_PATH}:${CI_COMMIT_SHORT_SHA}"
   ```

   {% endcut %}

   Файл содержит переменные:

   * `CI_REGISTRY` и `CI_REGISTRY_KEY` — добавлены в GitLab на [предыдущем шаге](#add-variables).
   * `CI_PROJECT_DIR`, `CI_PROJECT_PATH` и `CI_COMMIT_SHORT_SHA` — [предопределены в GitLab](https://docs.gitlab.com/ee/ci/variables/predefined_variables.html).

1. Напишите комментарий к коммиту в поле **Commit message**: `Create a CI pipeline`.
1. Нажмите кнопку **Commit changes**.

## Проверьте результат {#check-result}

После каждого коммита запускается сценарий сборки. Чтобы проверить результаты его выполнения:

1. На панели слева в проекте `gitlab-test` выберите пункт **Build**, в выпадающем меню выберите пункт **Pipelines**.

1. Убедитесь, что этап `build` принимает статус `passed`. Это означает, что сценарий CI выполнился успешно.

1. Перейдите в [консоль управления](https://console.yandex.cloud/), затем откройте реестр Yandex Container Registry.

   При успешном выполнении сценария появляется новый репозиторий в реестре. Он пополняется Docker-образами из проекта GitLab при каждом коммите.

## Включите политику автоматического удаления Docker-образов {#lifecycle-policy}

Чтобы не хранить устаревшие Docker-образы и их теги, используйте [политику автоматического удаления Docker-образов](../../container-registry/concepts/lifecycle-policy.md). Она применяется к образам в [репозитории Container Registry](../../container-registry/concepts/repository.md) и позволяет своевременно очищать место в нем. Так вы не переплачиваете за [хранение устаревших образов](../../container-registry/pricing.md#prices-storage).

Чтобы создать политику, [следуйте инструкции](../../container-registry/operations/lifecycle-policy/lifecycle-policy-create.md).

Особенности работы с политикой:

* Внешние Container Registry и политика удаления образов [влияют на производительность сценариев CI](https://docs.gitlab.com/ee/user/packages/container_registry/reduce_container_registry_storage.html#use-with-external-container-registries).

* Для политики действует [лимит](../../container-registry/concepts/limits.md#container-registry-limits) на максимальное количество образов, которые можно проверить за один запуск политики. Если количество образов в репозитории Container Registry превышает этот лимит, запустите политику несколько раз. Так будут проверены все образы.

## Отсканируйте Docker-образы на наличие уязвимостей {#vulnerability-scanner}

Чтобы отслеживать уязвимости Docker-образов, вы можете дополнительно активировать [сканер уязвимостей](../../container-registry/concepts/vulnerability-scanner.md) в Yandex Container Registry. Сканер сравнивает версии пакетов, установленных в образах, с базами уязвимостей [CVE](https://cve.mitre.org/).

Чтобы включить сканирование, дополните сценарий CI в своем проекте GitLab:

1. Откройте проект `gitlab-test`.
1. Откройте файл `.gitlab-ci.yml`.
1. Добавьте в него шаги сканирования Docker-образа на наличие уязвимостей:

   {% cut ".gitlab-ci.yml" %}

   ```yaml
   stages:
      - build
      - test

   <блок_build_добавленный_ранее_в_файл>

   container_scanning_free_yc:
      stage: test
      # Использование утилиты jq для поиска идентификатора и записи логов.
      image: 
         name: pindar/jq
         entrypoint: [""]
      artifacts:
         when: always
         paths:
            - gl-container-scanning-report-yc.json
      variables:
         # Укажите идентификатор созданного ранее реестра.
         CI_REGISTRY_ID: "<идентификатор_реестра>"
      script:
         - export CI_COMMIT_SHORT_SHA=${CI_COMMIT_SHORT_SHA}
         # Установка Yandex Cloud CLI.
         - curl https://storage.yandexcloud.net/yandexcloud-yc/install.sh | bash -s -- -a && cp /root/yandex-cloud/bin/yc /usr/bin/
         # Начало сканирования.
         - echo "Scanning image ${CI_REGISTRY}/${CI_PROJECT_PATH}:${CI_COMMIT_SHORT_SHA}..."
         - export IMAGE_ID=$(yc container image list --registry-id $CI_REGISTRY_ID --format=json | jq -r --arg CI_COMMIT_SHORT_SHA $CI_COMMIT_SHORT_SHA '.[] | select(.tags[0]==$CI_COMMIT_SHORT_SHA) | .id ')
         # Запись логов.
         - export SCAN_RESULT=$(yc container image scan $IMAGE_ID --format=json)
         - export CRIT_VULN=$(echo $SCAN_RESULT | jq -r '.vulnerabilities.critical // 0')
         - export HIGH_VULN=$(echo $SCAN_RESULT | jq -r '.vulnerabilities.high // 0')
         - export SCAN_ID=$(echo $SCAN_RESULT | jq -r '.id')
         - echo "Scan results:"
         - yc container image list-vulnerabilities --scan-result-id="${SCAN_ID}" --format json | jq -r '.[] | select(.severity=="CRITICAL", .severity=="HIGH")'
         - yc container image list-vulnerabilities --scan-result-id="${SCAN_ID}" --format json | jq -r '.[] | select(.severity=="CRITICAL", .severity=="HIGH")' > gl-container-scanning-report-yc.json
         # Проверка результата.
         - (( SUM = $CRIT_VULN + $HIGH_VULN )) && (( RES = (SUM >= 1) )) && echo $RES && echo "image has $CRIT_VULN critical vulnerabilities and $HIGH_VULN high vulnerabilities" && exit 1 || echo "image has no high or critical vulnerabilities" exit 0
   ```

   {% endcut %}

1. Напишите комментарий к коммиту в поле **Commit message**: `Turn on a vulnerability scanner`.
1. Нажмите кнопку **Commit changes**. После этого запустится обновленный сценарий.

Чтобы убедиться, что сканирование образов прошло успешно:

1. На панели слева в проекте `gitlab-test` выберите пункт **Build**, в выпадающем меню выберите пункт **Pipelines**.
1. Убедитесь, что этапы `build` и `test` принимают статус `passed`. Это означает, что сценарий CI выполнился успешно.
1. Перейдите в [консоль управления](https://console.yandex.cloud/), затем откройте реестр Yandex Container Registry.
1. Откройте репозиторий с Docker-образами из проекта GitLab.
1. Перейдите в папку с названием проекта GitLab.
1. Убедитесь, что в столбце **Статус сканирования** указано **Готово**.
1. В столбце **Дата последнего сканирования** нажмите ссылку со временем сканирования.

   Откроются результаты сканирования. Если в образе выявлены уязвимости, они отображаются в полученных результатах.

## Удалите созданные ресурсы {#clear-out}

Если созданные ресурсы вам больше не нужны, удалите их:

1. [Удалите инстанс Managed Service for GitLab](../operations/instance/instance-delete.md) или [созданную виртуальную машину с образом GitLab](../../compute/operations/vm-control/vm-delete.md).
1. [Удалите все Docker-образы](../../container-registry/operations/docker-image/docker-image-delete.md) из реестра Container Registry.

Остальные ресурсы удалите в зависимости от способа их создания:

{% list tabs group=instructions %}

- Вручную {#manual}

   1. [Удалите кластер Managed Service for Kubernetes](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).
   1. Если вы зарезервировали для кластера Managed Service for Kubernetes публичный IP-адрес, [удалите его](../../vpc/operations/address-delete.md).
   1. [Удалите сервисные аккаунты](../../iam/operations/sa/delete.md).
   1. [Удалите реестр Container Registry](../../container-registry/operations/registry/registry-delete.md).
   1. [Удалите подсети](../../vpc/operations/subnet-delete.md) и [сеть](../../vpc/operations/network-delete.md).

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