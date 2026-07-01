# Управление жизненным циклом MLOps с помощью ML Registry в Yandex Managed Service for GitLab

В течение жизненного цикла модели машинного обучения выполняются разработка, обучение модели, оценка качества и внедрение модели. В данном руководстве рассматриваются возможности платформы GitLab для хранения и версионирования ML‑артефактов, которые возникают при экспериментах с ML-моделью, в инфраструктуре Yandex Cloud. В экспериментах меняются гиперпараметры модели — настройки, которые задаются до начала обучения модели и определяют ее архитектуру, стратегию обучения и общее поведение. В отличие от параметров модели (весов, коэффициентов), которые подбираются в процессе обучения на данных, гиперпараметры не изменяются автоматически — их выбирает исследователь или ML-инженер.

Жизненный цикл разработки и тестирования модели в среде GitLab отображен на схеме:

![mlops-pipeline](../../_assets/architecture/mlops.svg)

В качестве среды разработки и тестирования используется виртуальная машина DSVM. Масштабируемый управляемый сервис [Yandex Managed Service for GitLab](../index.md) обеспечивает работу инстанса GitLab с предустановленным пакетом [ML Registry](https://docs.gitlab.com/user/project/ml/model_registry/). Благодаря этому вы можете пользоваться следующими инструментами MLOps:

* Реестр моделей (Model Registry) для логирования метрик, анализа экспериментов по применению модели и оценки качества.
* Каталог экспериментов (Model Experiments) для управления хранением и версионированием модели.

Для интеграции модели с ML Registry используется [библиотека Python API](https://mlflow.org/docs/latest/api_reference/python_api/index.html) платформы MLFlow.

Кроме сервиса Managed Service for GitLab, для работы с исходным кодом модели используется сервис [Yandex Compute Cloud](../../compute/index.md), а для сетевой инфраструктуры — [Yandex Virtual Private Cloud](../../vpc/index.md).

## Системная архитектура {#architecture}

### Сеть {#network}

В инфраструктуре решения создается [облачная сеть](../../vpc/concepts/network.md#network) Virtual Private Cloud `net-gitlab`.

#### Подсети {#subnets}

В сети `net-gitlab` создается [подсеть](../../vpc/concepts/network.md#subnet) в выбранной [зоне доступности](../../overview/concepts/geo-scope.md) для размещения инстанса Managed Service for GitLab и ВМ.

#### Группы безопасности {#security-groups}

Сетевой доступ к ресурсам инфраструктуры разграничен с помощью [группы безопасности](../../vpc/concepts/security-groups.md). [Подробнее о настройке правил группы безопасности для Managed Service for GitLab](../operations/configure-security-group.md).

#### Адреса ресурсов {#addresses}

В создаваемой инфраструктуре используются [публичный IP-адрес](../../vpc/concepts/address.md#public-addresses) для создаваемой ВМ и URL-адрес инстанса GitLab в домене `gitlab.yandexcloud.net`.

### Managed Service for GitLab {#gitlab}

[Инстанс GitLab](../concepts/index.md) развертывается в ВМ под управлением [сервиса Managed Service for GitLab](../index.md). Доступ к инстансу осуществляется по его адресу через стандартный веб-интерфейс GitLab.

Чтобы выполнять задания GitLab CI/CD, для инстанса Managed Service for GitLab создается и настраивается GitLab Runner.

### Compute Cloud {#compute}

Для локального тестирования и загрузки изменений в репозиторий с исходным кодом модели используется виртуальная машина [Data Science Virtual Machine](../../compute/operations/dsvm/index.md). Отдельная ВМ может использоваться для развертывания GitLab Runner.

## Тестовая модель {#sample-ml}

Тестовая ML-модель, развертываемая в этом руководстве, симулирует цикл разработки и версионирования модели кредитного конвейера. Модель адаптирована для использования в облачной инфраструктуре.

Чтобы развернуть среду разработки модели в облачной среде Yandex Cloud:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте инфраструктуру](#deploy).
1. [Создайте проект и настройте окружение](#project).
1. [Создайте эксперимент и версию модели](#experiment).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-you-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).

### Необходимые платные ресурсы {#paid-resources}

* Сервис Managed Service for GitLab: использование вычислительных ресурсов инстанса (виртуальной машины) и объем хранилища данных инстанса ([тарифы Managed Service for GitLab](../managed-gitlab/pricing.md)). В зависимости от того, где развернут GitLab Runner, может тарифицироваться ВМ Compute Cloud для установки GitLab Runner.
* Виртуальные машины: использование вычислительных ресурсов, хранилища, публичного IP-адреса и операционной системы ([тарифы Compute Cloud](../compute/pricing.md)).
* Сервис Object Storage: использование для хранения резервных копий Managed Service for GitLab ([тарифы Object Storage](../storage/pricing.md)).

## Создайте инфраструктуру {#deploy}

{% note info %}

Прежде чем приступать к созданию инфраструктуры, [убедитесь](../../quota-manager/operations/list-quotas.md), что в вашем [облаке](../../resource-manager/concepts/resources-hierarchy.md#cloud) достаточно свободных [квот](../../quota-manager/concepts/index.md) на ресурсы.

{% endnote %}

{% list tabs group=instructions %}

- Вручную {#manual}

  1. [Создайте сеть](../../vpc/operations/network-create.md) с именем `net-gitlab`. При создании сети отключите опцию **Создать подсети**.
  1. В сети `net-gitlab` [создайте](../../vpc/operations/subnet-create.md) подсеть в зоне доступности `ru-central1-a` со следующими параметрами:
      * **Имя** — `subnet-gitlab-a`.
      * **Зона доступности** — `ru-central1-a`.
      * **CIDR** — `10.16.0.0/24`.
  1. В сети `net-gitlab` [создайте группу безопасности](../../vpc/operations/security-group-create.md) с именем `gitlab-sg` для работы [инстанса Managed Service for GitLab](../concepts/index.md#instance) и ВМ. Настройте правила в этой группе безопасности [по инструкции](../operations/configure-security-group.md).
  1. [Создайте](../../iam/operations/sa/create.md) сервисный аккаунт `gitlab-sa` и [назначьте](../../iam/operations/sa/assign-role-for-sa.md) ему [роли](../../iam/concepts/access-control/roles.md) `compute.admin`, `vpc.admin` и `iam.serviceAccounts.user`.
  1. [Создайте и активируйте инстанс GitLab](../operations/instance/instance-create.md) любой подходящей конфигурации. При создании инстанса укажите созданные ранее подсеть и группу безопасности.
  1. [Создайте ВМ из образа DSVM](../../compute/operations/dsvm/quickstart.md) с именем `vm-mlops` в зоне доступности `ru-central1-a` и созданной ранее подсети. При создании ВМ укажите созданную ранее группу безопасности.

- Terraform {#tf}

    1. Если у вас еще нет Terraform, [установите его](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
    1. [Получите данные для аутентификации](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials). Вы можете добавить их в переменные окружения или указать далее в файле с настройками провайдера.
    1. [Настройте и инициализируйте провайдер](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Чтобы не создавать конфигурационный файл с настройками провайдера вручную, [скачайте его](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).
    1. Поместите конфигурационный файл в отдельную рабочую директорию и [укажите значения параметров](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Если данные для аутентификации не были добавлены в переменные окружения, укажите их в конфигурационном файле.

    1. Скачайте в ту же рабочую директорию файл конфигурации [ml-ops-managed-gitlab.tf](https://github.com/yandex-cloud-examples/yc-ml-ops-managed-gitlab/blob/main/ml-ops-managed-gitlab.tf).

        В этом файле описаны:

        * [сеть](../../vpc/concepts/network.md#network);
        * [подсеть](../../vpc/concepts/network.md#subnet);
        * [группа безопасности](../../vpc/concepts/security-groups.md) и правила, необходимые для работы инстанса Managed Service for GitLab;
        * инстанс Managed Service for GitLab;
        * ВМ с образом [DSVM](https://yandex.cloud/ru/marketplace/products/yc/dsvm);
        * сервисный аккаунт.

    1. Укажите в файле `ml-ops-managed-gitlab.tf` значения параметров:

        * `instance_name` — название инстанса GitLab;
        * `instance_login` — логин администратора инстанса GitLab;
        * `instance_email` — адрес электронной почты администратора;
        * `instance_domain` — доменное имя инстанса в формате `<имя>.gitlab.yandexcloud.net`.
        * `vm_username` и `vm_public_key` — логин и абсолютный путь к [публичному ключу](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys), которые будут использоваться для доступа к ВМ.
        * `sa_folder_id` — идентификатор каталога, в котором создается сервисный аккаунт.

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

## Создайте проект и настройте окружение {#project}

1. [Создайте проект GitLab](https://docs.gitlab.com/ee/user/project/), выберите на стартовой странице **Import project** и укажите настройки импорта:

   * **Import project from** — **Repository by URL**.
   * **Git Repository URL** — `https://github.com/yandex-cloud-examples/yc-ml-ops-managed-gitlab.git`
   * **Project name** — `gitlab-mlflow`.

1. Разверните [раннер](../concepts/index.md#runners) для созданного проекта GitLab с помощью [инструкции](install-gitlab-runner.md). При развертывании укажите [созданные ранее](#deploy) компоненты инфраструктуры:

   * Если вы устанавливаете раннер на ВМ вручную, при создании ВМ выберите подсеть `subnet-gitlab-a` и группу безопасности `gitlab-sg`.
   * При создании раннера с помощью Консоли управления укажите сервисный аккаунт `gitlab-sa` и группу безопасности `gitlab-sg`.

### Настройте переменные окружения {#variables}

1. Откройте проект GitLab `gitlab-mlflow`.
1. На панели слева перейдите в раздел **Settings** и во всплывающем списке выберите пункт **Access Tokens**.
1. Задайте параметры нового токена:
   * **Token name** — `mlflow`.
   * **Select a role** — `Maintainer`.
   * **Select scopes** — `api`, `manage_runner`, `read_repository`, `write_repository`.
1. Нажмите кнопку **Create project access token**.
1. Скопируйте значение созданного токена.
1. Выберите слева вкладку **Settings**, а во всплывающем списке — **CI/CD**.
1. В разделе **Variables** нажмите кнопку **Expand**.
1. Добавьте переменные окружения:
      * `MLFLOW_TRACKING_TOKEN` — созданный токен.
      * `MLFLOW_TRACKING_URI` — `https://<адрес_инстанса_GitLab>.gitlab.yandexcloud.net/api/v4/projects/4/ml/mlflow`.
      * `REPO_TOKEN` — созданный токен.

      Для добавления переменной:
      * Нажмите кнопку **Add variable**.
      * В появившемся окне в поле **Key** укажите имя переменной, в поле **Value** — значение переменной.
      * Нажмите кнопку **Add variable**.

## Создайте эксперимент и версию модели {#experiment}

1. [Подключитесь](../../compute/operations/vm-connect/ssh.md) к ВМ `vm-mlops` по [SSH](../../glossary/ssh-keygen.md).
1. [Добавьте](https://docs.gitlab.com/user/ssh/) SSH-ключ для безопасного доступа к GitLab.
1. [Склонируйте](https://docs.gitlab.com/topics/git/clone/) репозиторий проекта `gitlab-mlflow` с помощью SSH.

1. Перейдите в директорию с репозиторием и создайте ветку `mlops-experiment-1`:

   ```bash
   git checkout -b mlops-experiment-1
   ```

1. Внесите изменения в параметры модели в файле `loan_prediction.py`, например поменяйте параметр `RANDOM_SEED`.
1. Загрузите изменения на GitLab:

   ```bash
   git add -A
   git commit -m "Change model parameter"
   git push
   ```

1. Откройте проект GitLab `gitlab-mlflow` и [создайте мерж-реквест](https://docs.gitlab.com/user/project/merge_requests/creating_merge_requests/) из созданной ветки. Автоматически будет создан сценарий обучения и тестирования измененной модели.

1. Запустите сценарий:
    1. На панели слева выберите пункт **Build**.
    1. В выпадающем списке выберите пункт **Pipelines**.
    1. Нажмите кнопку ![image](../../_assets/console-icons/play-fill.svg) в колонке **Actions** и выберите **trigger_train**.

    Дождитесь завершения работы сценария.

1. Создайте реестр версий модели:
   1. На панели слева выберите пункт **Deploy**.
   1. В выпадающем списке выберите пункт **Model Registry**.
   1. Нажмите кнопку **Create/import model** и выберите **Create new model**.
   1. Укажите имя модели `loan-prediction-demo` и нажмите кнопку **Create**.

1. Проверьте результаты эксперимента:
   1. На панели слева выберите пункт **Analyze**.
   1. В выпадающем списке выберите пункт **Model Experiments**.
   1. Выберите в списке справа эксперимент `Loan_prediction` и перейдите на вкладку **Runs**. В списке отображаются все методы для обучения модели, их параметры и результаты обучения.
   1. Нажмите на элемент списка в колонке **Name**. На вкладке **Artifacts** отображаются артефакты обучения выбранного метода модели.
   1. Нажмите кнопку **Promote run** для регистрации версии модели. Выберите в поле **Model** модель `loan-prediction-demo` из выпадающего списка, укажите в поле **Version** версию `0.0.1` и нажмите кнопку **Promote**. В реестр версий будет добавлена новая версия и все артефакты ее обучения.

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

{% list tabs group=instructions %}

- Вручную {#manual}

    1. [Удалите инстанс GitLab](../operations/instance/instance-delete.md).
    1. [Удалите ВМ](../../compute/operations/vm-control/vm-delete.md).

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

## Полезные ссылки {#see-also}

* [Machine Learning Model Experiments](https://docs.gitlab.com/user/project/ml/experiment_tracking/)
* [Model Registry](https://docs.gitlab.com/user/project/ml/model_registry/)