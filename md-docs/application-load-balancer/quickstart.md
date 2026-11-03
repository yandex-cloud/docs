[Документация Yandex Cloud](../index.md) > [Yandex Application Load Balancer](index.md) > Начало работы

# Как начать работать с Yandex Application Load Balancer


Yandex Application Load Balancer позволяет предоставить пользователям единый адрес веб-приложения и распределять запросы между его бэкендами. Вы можете направлять запросы к разным приложениям по доменному имени или пути и настроить HTTPS на балансировщике.

В этом учебном примере вы создадите балансировщик и проверите передачу HTTP-запросов на тестовый веб-сервер. Для простоты используются одна ВМ и одна зона доступности. Такая конфигурация помогает освоить компоненты сервиса, но не обеспечивает отказоустойчивость приложения.

В инфраструктуру сервиса входят компоненты:

* [Целевая группа](concepts/target-group.md).
* [Группа бэкендов](concepts/backend-group.md).
* [HTTP-роутер](concepts/http-router.md).
* [L7-балансировщик](concepts/application-load-balancer.md).

Ниже описано, как создать каждый компонент по отдельности. Также вы можете [воспользоваться визардом](quickstart-wizard.md), чтобы создавать все компоненты на одной странице.

## Перед началом работы {#before-begin}

1. Войдите в [консоль управления](https://console.yandex.cloud) или зарегистрируйтесь. Если вы еще не зарегистрированы, перейдите в консоль управления и следуйте инструкциям.
1. На странице [**Yandex Cloud Billing**](https://center.yandex.cloud/billing/accounts) убедитесь, что у вас подключен [платежный аккаунт](../billing/concepts/billing-account.md) и он находится в статусе `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../billing/quickstart/index.md).
1. Если у вас еще нет каталога, [создайте его](../resource-manager/operations/folder/create.md). Во время создания каталога вы можете создать виртуальную сеть по умолчанию с подсетями во всех зонах доступности.
1. Убедитесь, что вашей учетной записи [назначены](../iam/operations/roles/grant.md) роли на каталог с создаваемыми ресурсами:

    * [alb.editor](security/index.md#alb-editor) — для управления балансировщиком, целевой группой, группой бэкендов и HTTP-роутером.
    * [compute.editor](../compute/security/index.md#compute-editor) — для создания и удаления тестовой ВМ.
    * [vpc.publicAdmin](../vpc/security/index.md#vpc-public-admin) — для подключения публичных IP-адресов.

    Если нужно создать сеть или подсети, дополнительно потребуется роль [vpc.privateAdmin](../vpc/security/index.md#vpc-private-admin).

## Создайте ВМ и запустите на ней тестовый веб-сервер {#create-vm}

1. [Создайте](../compute/operations/vm-create/create-linux-vm.md) виртуальную машину `test-vm1` из публичного образа [Ubuntu 24.04](https://yandex.cloud/ru/marketplace/products/yc/ubuntu-2404-lts-oslogin) в зоне доступности `ru-central1-a`.
   
1. [Подключитесь к ВМ по SSH](../compute/operations/vm-connect/ssh.md).
   
    Если у вас установлен [интерфейс командной строки Yandex Cloud](../cli/quickstart.md), вы можете подключиться к ВМ по [OS Login](../compute/operations/vm-connect/os-login.md):

    ```bash
    yc compute ssh --name test-vm1
    ```
    

1. Запустите тестовый веб-сервер, который будет отвечать на запросы на порте `8080`:

    ```bash
    mkdir test-server; echo 'HELLO' > test-server/hello.txt; python3 -m http.server -d test-server 8080
    ```

1. Убедитесь, что веб-сервер возвращает HTML-страницу со списком файлов каталога `test-server`, включая `hello.txt`. В терминале вашего компьютера выполните:

    ```bash
    curl --verbose <публичный_IP-адрес_ВМ>:8080
    ```

## Создайте целевую группу {#create-target-group}

На ВМ из [целевой группы](concepts/target-group.md) развертываются бэкенды вашего приложения. Целевая группа будет подключена к балансировщику, чтобы на эндпоинты бэкендов вашего приложения можно было направлять запросы.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором будет создаваться целевая группа.
  1. [Перейдите](https://console.yandex.cloud/link/application-load-balancer) в сервис **Application Load Balancer**.
  1. В меню слева выберите **Целевые группы**.
  1. Нажмите кнопку **Создать целевую группу**.
  1. Введите имя целевой группы: `test-target-group`.
  1. Выберите ВМ `test-vm1`.
  1. Нажмите кнопку **Создать**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../cli/quickstart.md#install).

  Выполните команду:

  ```bash
  yc alb target-group create test-target-group \
    --target subnet-name=<имя_подсети_ВМ>,ip-address=<внутренний_IP-адрес_ВМ>
  ```

{% endlist %}

## Создайте группу бэкендов {#create-backend-group}

[Группы бэкендов](concepts/backend-group.md) содержат настройки балансировки трафика и проверок состояния целевых ресурсов. Создайте группу и добавьте в нее один бэкенд.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В меню слева выберите **Группы бэкендов**.
  1. Нажмите кнопку **Создать группу бэкендов**.
  1. Введите имя группы бэкендов: `test-backend-group`.
  1. В блоке **Бэкенды** нажмите кнопку **Добавить**. Задайте настройки бэкенда:

      1. Введите имя бэкенда: `backend-1`.
      1. В списке **Целевая группа** выберите `test-target-group`.
      1. Укажите порт: `8080`.

  1. Разверните поле **Настройки протокола** и задайте их параметры:

      1. Выберите тип `HTTP`.

  1. Нажмите кнопку **Добавить проверку состояния** и задайте настройки проверки:

      1. **Таймаут, с**: `1`.
      1. **Интервал**: `3`.
      1. **Порог работоспособности**: `2`.
      1. **Порог неработоспособности**: `2`.
      1. **Порт**: `8080`.
      1. **Тип**: `HTTP`.
      1. **Путь**: `/`.

  1. Нажмите кнопку **Создать**.

- CLI {#cli}

  1. Создайте группу бэкендов:

      ```bash
      yc alb backend-group create test-backend-group
      ```

  1. Создайте бэкенд и проверку состояния:

      ```bash
      yc alb backend-group add-http-backend \
        --backend-group-name test-backend-group \
        --name backend-1 \
        --port 8080 \
        --target-group-name test-target-group \
        --target-group-id <идентификатор_целевой_группы> \
        --http-healthcheck healthy-threshold=2,unhealthy-threshold=2,timeout=1s,interval=3s,path=/
      ```

{% endlist %}

## Создайте HTTP-роутер {#create-http-router}

[HTTP-роутеры](concepts/http-router.md) определяют правила маршрутизации запросов к бэкендам и позволяют модифицировать запросы прямо на балансировщике.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В меню слева выберите **HTTP-роутеры**.
  1. Нажмите кнопку **Создать HTTP-роутер**.
  1. Введите имя роутера: `test-http-router`.
  1. В блоке **Виртуальные хосты** нажмите кнопку **Добавить виртуальный хост**.
  1. Введите имя хоста: `test-virtual-host`.
  1. Нажмите кнопку **Добавить маршрут**.
  1. Введите **Имя**: `test-route`.
  1. В поле **Путь** выберите `Начинается с` и укажите путь `/`.
  1. В поле **Действие** оставьте `Маршрутизация`.
  1. В списке **Группа бэкендов** выберите `test-backend-group`.
  1. Остальные настройки оставьте без изменений и нажмите кнопку **Создать**.

- CLI {#cli}

  1. Создайте HTTP-роутер:

      ```bash
      yc alb http-router create test-http-router
      ```

  1. Создайте виртуальный хост:

      ```bash
      yc alb virtual-host create test-virtual-host --http-router-name test-http-router
      ```

  1. Добавьте маршрут:

      ```bash
      yc alb virtual-host append-http-route test-route \
        --http-router-name test-http-router \
        --prefix-path-match / \
        --backend-group-name test-backend-group \
        --virtual-host-name test-virtual-host
      ```

{% endlist %}

## Создайте L7-балансировщик {#create-load-balancer}

[Балансировщик](concepts/application-load-balancer.md) принимает запросы и распределяет их по ВМ из целевой группы по правилам, указанным в HTTP-роутере. Для приема трафика балансировщик использует [обработчики](concepts/application-load-balancer.md#listener).

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В меню слева выберите **Балансировщики**.
  1. Нажмите кнопку **Создать L7-балансировщик**.
  1. Введите имя балансировщика: `test-load-balancer`.
  1. В блоке **Сетевые настройки** выберите сеть, в подсети которой будет размещаться узел балансировщика.
  1. В блоке **Размещение** выберите подсеть в одной [зоне доступности](../overview/concepts/geo-scope.md) и включите прием трафика в этой подсети.

      Остальные зоны доступности удалите, нажав ![xmark](../_assets/console-icons/xmark.svg) в соответствующей строке.

  1. В блоке **Обработчики** нажмите кнопку **Добавить обработчик**. Задайте настройки обработчика:

      1. Введите имя обработчика: `test-listener`.
      1. В блоке **Публичный IP-адрес** включите передачу трафика.
      1. Укажите порт `80`.
      1. Выберите тип **Автоматически**.
      
  1. В поле **HTTP-роутер** выберите `test-http-router`.
  1. Нажмите кнопку **Создать**.

- CLI {#cli}

  1. Создайте балансировщик с узлом в одной подсети:

      ```bash
      yc alb load-balancer create test-load-balancer \
        --network-name <имя_сети> \
        --location subnet-name=<имя_подсети_в_зоне_ru-central1-a>,zone=ru-central1-a
      ```

  1. Добавьте обработчик:

      ```bash
      yc alb load-balancer add-listener test-load-balancer \
        --listener-name test-listener \
        --http-router-id <идентификатор_HTTP-роутера> \
        --external-ipv4-endpoint port=80
      ```

{% endlist %}

## Протестируйте работу балансировщика {#test}

В терминале выполните следующую команду:

```bash
curl --verbose <публичный_IP-адрес_балансировщика>:80
```

В ответ должен вернуться HTTP-код `200` и HTML-страница со списком файлов каталога `test-server`, включая `hello.txt`.

После этого вы можете добавить другие виртуальные машины в целевую группу, создать новые бэкенды для вашего приложения и построить маршруты до их эндпоинтов.

Чтобы оценить обработку запросов, [посмотрите статистику](operations/application-load-balancer-get-stats.md) и [настройте алерт](operations/application-load-balancer-manage-alerts.md). Для разбора ошибок используйте [логи балансировщика](operations/application-load-balancer-get-logs.md).

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы, удалите их в указанном порядке:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Удалите](operations/application-load-balancer-delete.md) L7-балансировщик `test-load-balancer`.
  1. [Удалите](operations/http-router-delete.md) HTTP-роутер `test-http-router`.
  1. [Удалите](operations/backend-group-delete.md) группу бэкендов `test-backend-group`.
  1. [Удалите](operations/target-group-delete.md) целевую группу `test-target-group`.
  1. [Удалите](../compute/operations/vm-control/vm-delete.md) ВМ `test-vm1`. Если ее загрузочный диск не удалился автоматически, [удалите его](../compute/operations/disk-control/delete.md).
   
{% endlist %}

## Практические сценарии {#use-cases}

Чтобы применить балансировщик в своей инфраструктуре, воспользуйтесь руководствами:

* [Виртуальный хостинг](tutorials/virtual-hosting.md) — размещение нескольких сайтов с разными доменными именами по одному IP-адресу.
* [Терминирование TLS-соединений](tutorials/tls-termination/index.md) — настройка HTTPS и перенаправления HTTP-запросов на HTTPS.
* [Сине-зеленое и канареечное развертывание](tutorials/blue-green-canary-deployment.md) — переключение трафика между версиями приложения.