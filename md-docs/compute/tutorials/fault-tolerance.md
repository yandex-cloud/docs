# Настройка отказоустойчивой архитектуры в Yandex Cloud


С помощью этой инструкции вы настроите [отказоустойчивую архитектуру](../../architecture/fault-tolerance.md) в Yandex Cloud и проверите ее работу на различных тестовых сценариях.

Отказоустойчивость — это свойство системы сохранять свою работоспособность после отказа одной или нескольких ее составных частей.

Чтобы настроить и протестировать архитектуру:

1. [Подготовьте облако к работе](#before-begin).
1. [Настройте тестовый стенд](#prepare).
1. [Выполните тестовые сценарии](#run).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).


### Необходимые платные ресурсы {#paid-resources}

* Виртуальные машины: использование вычислительных ресурсов, хранилища, публичных IP-адресов и операционной системы (см. [тарифы Compute Cloud](../pricing.md)).
* Кластер Managed Service for PostgreSQL: выделенные хостам вычислительные ресурсы, объем хранилища и резервных копий (см. [тарифы Managed Service for PostgreSQL](../../managed-postgresql/pricing.md)).
* Публичные IP-адреса, если для хостов кластера включен публичный доступ (см. [тарифы Virtual Private Cloud](../../vpc/pricing.md)).


## Настройте тестовый стенд {#prepare}

Описание тестового стенда:

* Приложение упаковано в [Docker-образ](../../container-registry/concepts/docker-image.md) и загружено в Yandex Container Registry.

  Docker-образы развернуты на четырех ВМ на основе [Container Optimized Image](../../cos/index.md). ВМ объединены в группу и расположены в двух различных [зонах доступности](../../overview/concepts/geo-scope.md).

* Кластер БД работает под управлением сервиса Managed Service for PostgreSQL и состоит из двух хостов, расположенных в различных зонах доступности.
* Нагрузка генерируется приложением [Load Testing Tool](https://yandex.cloud/ru/marketplace/products/yc/load-testing) из Yandex Cloud Marketplace и подается на [Yandex Network Load Balancer](../../network-load-balancer/index.md). Сетевой балансировщик нагрузки распределяет трафик по ВМ.

### Подготовьте контейнеры приложения TodoList {#create-app}

Чтобы подготовить приложение для запуска в Yandex Cloud:

1. Скачайте и распакуйте [репозиторий](https://github.com/glebmish/yandex-cloud-fault-tolerance-demo/archive/master.zip) с исходным кодом демо-приложения, Terraform-спецификациями и скриптом для имитации сбоя приложения.
1. Перейдите в репозиторий:

   ```bash
   cd yandex-cloud-fault-tolerance-demo-master/app
   ```

1. [Аутентифицируйтесь](../../container-registry/operations/authentication.md) в Container Registry:

   ```bash
   yc container registry configure-docker
   ```

1. [Создайте реестр](../../container-registry/operations/registry/registry-create.md):

   ```bash
   yc container registry create --name todo-registry
   ```

1. [Создайте Docker-образ](../../container-registry/operations/docker-image/docker-image-create.md) с тегом `v1`:

   ```bash
   docker build . --tag cr.yandex/<идентификатор_реестра>/todo-demo:v1 --platform linux/amd64
   ```

1. Создайте Docker-образ с тегом `v2` (для проверки сценария обновления приложения):

   ```bash
   docker build . --build-arg COLOR_SCHEME=dark --tag cr.yandex/<идентификатор_реестра>/todo-demo:v2 --platform linux/amd64
   ```

1. [Загрузите Docker-образы](../../container-registry/operations/docker-image/docker-image-push.md) в Container Registry:

   ```bash
   docker push cr.yandex/<идентификатор_реестра>/todo-demo:v1
   docker push cr.yandex/<идентификатор_реестра>/todo-demo:v2
   ```

### Разверните инфраструктуру {#create-environment}

Чтобы подготовить окружение для запуска приложения в Yandex Cloud:

1. [Установите Terraform](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
1. Перейдите в директорию со спецификацией окружения:

   ```bash
   cd ../terraform/app
   ```

1. Инициализируйте Terraform в директории со спецификацией:

   ```bash
   terraform init
   ```

1. Сохраните идентификатор каталога в переменную `YC_FOLDER` и [IAM-токен](../../iam/concepts/authorization/iam-token.md) — в переменную `YC_TOKEN`:

   ```bash
   export YC_FOLDER=<идентификатор_каталога>
   export YC_TOKEN=$(yc iam create-token)
   ```

1. Сгенерируйте ключ для [подключения к виртуальной машине по SSH](../operations/vm-connect/ssh.md):

   ```bash
   ssh-keygen -t ed25519
   ```

1. В файле `app/todo-service.tf` укажите путь к публичному SSH-ключу (значение по умолчанию `~/.ssh/id_ed25519.pub`).
1. Проверьте квоты в облаке, чтобы была возможность развернуть требуемые ресурсы.

   {% cut "Информация о количестве создаваемых ресурсов" %}

   Будут созданы следующие ресурсы:

   * [Сеть](../../vpc/concepts/network.md#network) Virtual Private Cloud с тремя [подсетями](../../vpc/concepts/network.md#subnet) во всех зонах доступности.
   * Два [сервисных аккаунта](../../iam/concepts/users/service-accounts.md):
     * Сервисный аккаунт для управления группой ВМ с ролью `editor`.
     * Сервисный аккаунт для скачивания Docker-образа на ВМ с [ролью](../../iam/concepts/access-control/roles.md) `container-registry.images.puller`.
   * Группа ВМ из четырех ВМ на базе Container Optimized Image в зонах доступности `ru-central1-b` и `ru-central1-d`.
   * Кластер Managed Service for PostgreSQL с двумя хостами в зонах доступности `ru-central1-b` и `ru-central1-d`.
   * Сетевой балансировщик нагрузки для распределения трафика по ВМ группы.

   {% endcut %}

1. Разверните и запустите приложение:

   ```bash
   terraform apply -var yc_folder=$YC_FOLDER -var yc_token=$YC_TOKEN -var user=$USER
   ```

   Где:

   * `yc_folder` — [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет развернуто приложение.
   * `yc_token` — [IAM-токен](../../iam/concepts/authorization/iam-token.md) пользователя, от имени которого будет развернуто приложение.

Для доступа к приложению перейдите по адресу `lb_address`, полученному в результате выполнения `terraform apply`.

### Подготовьте и запустите приложение Load Testing Tool {#create-load-testing-tool}

{% note warning %}

Перед созданием Load Testing Tool [подготовьте контейнеры приложения TodoList](#create-app) и [разверните инфраструктуру](#create-environment).

{% endnote %}

1. Перейдите в директорию со спецификацией Load Testing Tool:

   ```bash
   cd ../tank
   ```

1. Инициализируйте Terraform в директории со спецификацией Load Testing Tool:

   ```bash
   terraform init
   ```

1. В файле `tank/main.tf` укажите путь к публичному и приватному SSH-ключам (значения по умолчанию `~/.ssh/id_ed25519.pub` и `~/.ssh/id_ed25519`).
1. Разверните и запустите ВМ:

   ```bash
   terraform apply -var yc_folder=$YC_FOLDER -var yc_token=$YC_TOKEN -var user=$USER -var overload_token=<overload_token>
   ```

   Где:

   * `yc_folder` — каталог, в котором будет развернуто Load Testing Tool.
   * `yc_token`— IAM-токен пользователя, от имени которого будет развернуто Load Testing Tool.
   * `overload_token` — токен для подключения к `<overload.yandex.net>`. Для получения токена нужно аутентифицироваться, после чего нажать справа вверху на свой профиль и в выпадающем меню выбрать **My api token**.

1. Подключитесь к созданной ВМ по [SSH](../../glossary/ssh-keygen.md). Адрес для подключения указан в выводе команды `terraform apply`:

   ```bash
   ssh <имя_пользователя>@<IP-адрес_ВМ>
   ```

1. Запустите Load Testing Tool:

   ```bash
   sudo yandex-tank -c load.yaml
   ```

1. Перейдите в `<overload.yandex.net>` и найдите там запущенную нагрузку: **Public tests** → **show my tests only**.

## Выполнение сценариев {#run}

### Сбой ВМ {#error-vm}

Как проявляется сбой: недоступна ВМ с приложением.

Возможные причины:

* Падение физического хоста, на котором была запущена ВМ.
* По ошибке удалена ВМ с приложением.

Для имитации сбоя удалите одну из ВМ группы:

{% list tabs %}

- Консоль управления

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог с вашей группой ВМ.
  1. Перейдите в сервис **Compute Cloud**.
  1. На панели слева выберите ![image](../../_assets/compute/vm-group-pic.svg) **Группы виртуальных машин**.
  1. Выберите группу `todo-ig`.
  1. Перейдите на панель **Виртуальные машины**.
  1. В строке с нужной ВМ нажмите значок ![image](../../_assets/options.svg) → **Удалить**.
  1. В открывшемся окне нажмите кнопку **Удалить**.

{% endlist %}

Реакция тестового стенда:

1. Сетевой балансировщик нагрузки и Instance Groups получают информацию о сбое ВМ и выводят ее из балансировки — трафик перестает поступать на эту ВМ и распределяется между оставшимися ВМ в группе.
1. Instance Groups [автоматически восстанавливается](../concepts/instance-groups/autohealing.md):
   1. Удаляет недоступную ВМ (в этом сценарии ВМ уже удалена, шаг будет пропущен).
   1. Создает новую ВМ.
   1. Ожидает запуска приложения на созданной ВМ.
   1. Добавляет ВМ в балансировку.

Балансировщику нагрузки и Instance Groups требуется некоторое время, чтобы обнаружить проблему и отключить подачу трафика на неисправную ВМ. Из-за этого возможно появление ошибок Connection Timeout (HTTP-код `0` на графиках **Quantities** и **HTTP codes** в мониторинге Load Testing Tool).

После выведения недоступной ВМ из балансировки пользовательская нагрузка обрабатывается корректно.

### Сбой приложения {#error-app}

Как проявляется сбой: приложение не отвечает вовремя или работает некорректно с точки зрения пользователя.

Возможные причины:

* Утечка памяти привела к падению приложения.
* Приложение не может продолжить работу из-за потери связности с БД.
* Приложение не успевает обрабатывать запросы из-за большой нагрузки.

В соответствии с настройками [проверки состояния](../concepts/instance-groups/autohealing.md#setting-up-health-checks) Instance Groups опрашивает ВМ группы по HTTP-протоколу. При нормальной работе обращение к конечной точке `/healthy` возвращается HTTP-код `200`. Иначе Instance Groups запускает процедуру восстановления.

Для имитации сбоя в репозитории `yandex-cloud-fault-tolerance-demo-master` запустите скрипт:

```bash
fail_random_host.sh <идентификатор_группы_ВМ>
```

Случайная ВМ из группы начнет возвращать HTTP-код `503`.

Реакция тестового стенда:

1. Instance Groups получает информацию о сбое приложения и выводит ВМ из балансировки — трафик перестает поступать на эту ВМ и распределяется между оставшимися ВМ в группе.
1. Instance Groups [автоматически восстанавливается](../concepts/instance-groups/autohealing.md):
   1. Перезагружает неисправную ВМ.
   1. Ожидает запуска приложения на созданной ВМ.
   1. Добавляет ВМ в балансировку.

Instance Groups несколько раз опрашивает ВМ прежде чем отключить трафик и запустить восстановление. Из-за этого возможно появление ошибок Service Unavailable (HTTP-код `503` на графиках **Quantities** и **HTTP codes** в мониторинге Load Testing Tool).

После выведения неисправной ВМ из балансировки пользовательская нагрузка обрабатывается корректно.

### Отключение зоны доступности {#zone-down}

Как проявляется сбой: недоступны несколько ВМ в одной зоне.

Возможные причины:

* Перебои в работе дата-центра.
* Плановые технические работы в дата-центре.

Чтобы перенести ресурсы в другой дата-центр:

{% list tabs %}

- Консоль управления

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог с вашей группой ВМ.
  1. Перейдите в сервис **Compute Cloud**.
  1. На панели слева выберите ![image](../../_assets/compute/vm-group-pic.svg) **Группы виртуальных машин**.
  1. Выберите группу `todo-ig`.
  1. В правом верхнем углу нажмите **Редактировать**.
  1. В блоке **Распределение** снимите галочку с зоны доступности `ru-central1-b`.
  1. Нажмите кнопку **Сохранить**.

{% endlist %}

Реакция тестового стенда:

1. Instance Groups выводит из балансировки ВМ в зоне доступности `ru-central1-b`.
1. Выведенные ВМ удаляются, одновременно с этим создаются ВМ в зоне `ru-central1-d`.
1. Instance Groups добавляет созданные ВМ в балансировку.

Количество одновременно создаваемых и удаляемых ВМ определяется [политикой развертывания](../concepts/instance-groups/policies/deploy-policy.md).

Во время выведения ВМ из балансировки возможно появление ошибок Connection Timeout (HTTP-код `0` на графиках **Quantities** и **HTTP codes** в мониторинге Load Testing Tool).

После выведения ВМ из балансировки пользовательская нагрузка обрабатывается корректно.

### Обновление приложения {#update-app}

Чтобы обновить приложение:

{% list tabs %}

- Консоль управления

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог с вашей группой ВМ.
  1. Перейдите в сервис **Compute Cloud**.
  1. На панели слева выберите ![image](../../_assets/compute/vm-group-pic.svg) **Группы виртуальных машин**.
  1. Выберите группу `todo-ig`.
  1. В правом верхнем углу нажмите **Редактировать**.
  1. В блоке **Шаблон виртуальной машины** нажмите значок ![horizontal-ellipsis](../../_assets/horizontal-ellipsis.svg) и выберите **Редактировать**.
  1. В блоке **Образ загрузочного диска** перейдите на вкладку **Container Solution**.
  1. Выберите необходимый Docker-контейнер и нажмите ![image](../../_assets/options.svg) → **Редактировать**.
  1. В открывшемся окне в поле **Docker-образ** укажите образ с новой версией приложения (тег `v2`).
  1. Нажмите кнопку **Применить**.
  1. Нажмите кнопку **Сохранить**.
  1. Нажмите кнопку **Сохранить** на странице **Изменение группы виртуальных машин**.

{% endlist %}

Реакция тестового стенда:

1. Instance Groups выводит из балансировки две ВМ с устаревшей версией приложения ([статус](../concepts/instance-groups/statuses.md#vm-statuses) таких ВМ `RUNNING_OUTDATED`).
1. Удаляет выведенные ВМ, одновременно с этим создает ВМ с новой версией приложения.
1. Добавляет созданные ВМ в балансировку.
1. Действия повторяются для оставшихся двух ВМ с устаревшей версией приложения.

Обновите страницу приложения. Если сетевой балансировщик отправит ваш запрос на уже обновленную ВМ, то вы увидите версию приложения с темной цветовой схемой.

Количество одновременно создаваемых и удаляемых ВМ определяется [политикой развертывания](../concepts/instance-groups/policies/deploy-policy.md).

Во время выведения ВМ из балансировки возможно появление ошибок Connection Timeout (HTTP-код `0` на графиках **Quantities** и **HTTP codes** в мониторинге Load Testing Tool).

После выведения ВМ из балансировки пользовательская нагрузка обрабатывается корректно.

### Масштабирование конфигурации БД {#scaling-database}

Масштабирование БД может потребоваться, если:

* Производительности хостов в кластере не хватает для обработки запросов.
* Для данных требуется хранилище большего объема.

Чтобы масштабировать конфигурацию:

{% list tabs %}

- Консоль управления

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог с вашим кластером БД.
  1. Перейдите в сервис **Managed Service for&nbsp;PostgreSQL**.
  1. Выберите кластер `todo-postgresql`.
  1. Нажмите кнопку ![image](../../_assets/pencil.svg) **Редактировать**.
  1. В блоке **Класс хоста** выберите `s2.medium`.
  1. Нажмите кнопку **Сохранить изменения**.

{% endlist %}

Managed Service for PostgreSQL запустит операцию изменения кластера.

При переключении между мастером и репликой (в начале и в конце процесса изменения) возможно появление ошибок Internal Server Error (HTTP-код `500` на графиках **Quantities** и **HTTP codes** в мониторинге Load Testing Tool).

После переключения пользовательская нагрузка обрабатывается корректно.

## Удаление приложений и окружения {#clear-out}

{% note warning %}

Если создана ВМ с Load Testing Tool, необходимо сначала удалить ее, иначе удаление сети Virtual Private Cloud завершится с ошибкой.

{% endnote %}

Чтобы удалить приложение Load Testing Tool, перейдите в каталог `yandex-cloud-fault-tolerance-demo-master/terraform/tank` и выполните следующую команду:

```bash
terraform destroy -var yc_folder=$YC_FOLDER -var yc_token=$YC_TOKEN -var user=$USER -var overload_token=not-used
```

Чтобы удалить приложение TodoList, перейдите в каталог `yandex-cloud-fault-tolerance-demo-master/terraform/app` и выполните следующую команду:

```bash
terraform destroy -var yc_folder=$YC_FOLDER -var yc_token=$YC_TOKEN -var user=$USER
```