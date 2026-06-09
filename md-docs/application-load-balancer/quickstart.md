# Как начать работать с Yandex Application Load Balancer


Yandex Application Load Balancer служит для распределения запросов по бэкендам ваших сетевых приложений и терминирования TLS-шифрования. Application Load Balancer работает на 7-м уровне [модели OSI](https://ru.wikipedia.org/wiki/OSI_model) с протоколами HTTP и HTTPS.

С помощью этой инструкции вы развернете инфраструктуру сервиса Application Load Balancer и настроите передачу трафика на бэкенд тестового приложения.

В инфраструктуру сервиса входят компоненты:

* [Целевая группа](concepts/target-group.md).
* [Группа бэкендов](concepts/backend-group.md).
* [HTTP-роутер](concepts/http-router.md).
* [L7-балансировщик](concepts/application-load-balancer.md).

Ниже описано как создать каждый компонент по отдельности. Также вы можете [воспользоваться визардом](quickstart-wizard.md), чтобы создавать все компоненты на одной странице.

## Перед началом работы {#before-begin}

1. Войдите в [консоль управления](https://console.yandex.cloud) или зарегистрируйтесь. Если вы еще не зарегистрированы, перейдите в консоль управления и следуйте инструкциям.
1. На странице [**Yandex Cloud Billing**](https://center.yandex.cloud/billing/accounts) убедитесь, что у вас подключен [платежный аккаунт](../billing/concepts/billing-account.md) и он находится в статусе `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../billing/quickstart/index.md#create_billing_account).
1. Если у вас еще нет каталога, [создайте его](../resource-manager/operations/folder/create.md). Во время создания каталога вы можете создать виртуальную сеть по умолчанию с подсетями во всех зонах доступности.

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

1. Убедитесь, что веб-сервер возвращает список папок из каталога `test-server`. В терминале вашего компьютера выполните:

    ```bash
    curl --verbose <публичный_IP-адрес_ВМ>:8080
    ```

## Создайте целевую группу {#create-target-group}

На ВМ из [целевой группы](concepts/target-group.md) развертываются бэкенды вашего приложения. Целевая группа будет подключена к балансировщику, чтобы на эндпоинты бэкендов вашего приложения можно было направлять запросы.

Для примера в целевой группе будет находиться только одна виртуальная машина.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором будет создаваться целевая группа.
  1. Перейдите в сервис **Application Load Balancer**.
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

Для примера будет создан балансировщик с узлом в одной подсети в одной зоне доступности.

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

В ответ должен вернуться HTTP-ответ с кодом `200` и список папок из каталога тестовой ВМ в HTML-разметке.

После этого вы можете добавить другие виртуальные машины в целевую группу, создать новые бэкенды для вашего приложения и построить маршруты до их эндпоинтов.

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы, удалите их в указанном порядке:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Удалите](operations/application-load-balancer-delete.md) L7-балансировщик `test-load-balancer`.
  1. [Удалите](operations/http-router-delete.md) HTTP-роутер `test-http-router`.
  1. [Удалите](operations/backend-group-delete.md) группу бэкендов `test-backend-group`.
  1. [Удалите](operations/target-group-delete.md) целевую группу `test-target-group`.
   
{% endlist %}