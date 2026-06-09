# Создание инфраструктуры {{ alb-name }} с помощью визарда


{{ alb-full-name }} служит для распределения запросов по бэкендам ваших сетевых приложений и терминирования TLS-шифрования. {{ alb-name }} работает на 7-м уровне [модели OSI](https://ru.wikipedia.org/wiki/OSI_model) с протоколами HTTP и HTTPS.

С помощью этой инструкции вы развернете инфраструктуру сервиса {{ alb-name }} и настроите передачу трафика на бэкенд тестового приложения.

Ниже описано как создать инфраструктуру с помощью [визарда](concepts/index.md#alb-wizard). Также вы можете [создавать каждый компонент по отдельности](quickstart.md).

## Перед началом работы {#before-begin}

1. Войдите в [консоль управления]({{ link-console-main }}) или зарегистрируйтесь. Если вы еще не зарегистрированы, перейдите в консоль управления и следуйте инструкциям.
1. На странице [**{{ ui-key.yacloud.component.navigation-menu.label_billing }}**]({{ link-console-billing }}) убедитесь, что у вас подключен [платежный аккаунт](../billing/concepts/billing-account.md) и он находится в статусе `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../billing/quickstart/index.md#create_billing_account).
1. Если у вас еще нет каталога, [создайте его](../resource-manager/operations/folder/create.md). Во время создания каталога вы можете создать виртуальную сеть по умолчанию с подсетями во всех зонах доступности.

## Создайте ВМ и запустите на ней тестовый веб-сервер {#create-vm}

1. [Создайте](../compute/operations/vm-create/create-linux-vm.md) виртуальную машину `test-vm1` из публичного образа [Ubuntu 24.04](https://yandex.cloud/ru/marketplace/products/yc/ubuntu-2404-lts-oslogin) в зоне доступности `{{ region-id }}-a`.
   
1. [Подключитесь к ВМ по SSH](../compute/operations/vm-connect/ssh.md).
   
    Если у вас установлен [интерфейс командной строки {{ yandex-cloud }}](../cli/quickstart.md), вы можете подключиться к ВМ по [{{ oslogin }}](../compute/operations/vm-connect/os-login.md):

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

## Создайте инфраструктуру {{ alb-name }} {#create-alb-infrastructure}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет создан балансировщик.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.alb.button_load-balancer-create }}** и выберите **{{ ui-key.yacloud.alb.label_alb-create-wizard }}**.

{% endlist %}

### Настройки целевой группы {#settings-target-group}

На ВМ из [целевой группы](concepts/target-group.md) развертываются бэкенды вашего приложения. Целевая группа будет подключена к балансировщику, чтобы на эндпоинты бэкендов вашего приложения можно было направлять запросы.

Для примера в целевой группе будет находиться только одна виртуальная машина.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Введите имя целевой группы: `test-target-group`.
  1. Выберите ВМ `test-vm1`.
  1. Остальные настройки оставьте без изменений и нажмите кнопку **{{ ui-key.yacloud.alb.button_wizard-create-tg }}**.

{% endlist %}

### Настройки группы бэкендов {#settings-backend-group}

[Группы бэкендов](concepts/backend-group.md) содержат настройки балансировки трафика и проверок состояния целевых ресурсов. Визард автоматически создает один бэкенд и одну группу проверки состояния. В качестве целевой группы будет выбрана группа, созданная на предыдущем шаге.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Введите имя группы бэкендов: `test-backend-group`.
   
  1. Чтобы открыть настройки бэкенда и группы проверки состояния, включите переключатель **{{ ui-key.yacloud.alb.label_detailed-settings }}**.

  1. Введите имя бэкенда: `backend-1`.

  1. Укажите порт: `8080`.

  1. Задайте настройки проверки состояния:
      1. **{{ ui-key.yacloud.alb.label_interval }}**: `3`.
      1. **{{ ui-key.yacloud.alb.label_healthy }}**: `2`.
      1. **{{ ui-key.yacloud.alb.label_port }}**: `8080`.
  
  1. Остальные настройки оставьте без изменений и нажмите кнопку **{{ ui-key.yacloud.alb.button_wizard-create-tg }}**.

{% endlist %}

### Настройки HTTP-роутера {#settings-http-router}

[HTTP-роутеры](concepts/http-router.md) определяют правила маршрутизации запросов к бэкендам и позволяют модифицировать запросы прямо на балансировщике. Визард автоматически создает виртуальный хост и правило маршрутизации. В качестве группы бэкендов будет выбрана группа, созданная на предыдущем шаге.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Введите имя роутера: `test-http-router`.
  1. Включите переключатель **{{ ui-key.yacloud.alb.label_detailed-settings }}**.
  1. В блоке **{{ ui-key.yacloud.alb.label_virtual-hosts }}** введите:
     1. Имя хоста: `test-virtual-host`.
     1. Имя маршрута: `test-route`.
  1. Остальные настройки оставьте без изменений и нажмите кнопку **{{ ui-key.yacloud.alb.button_wizard-create-tg }}**.

{% endlist %}

### Настройки L7-балансировщика {#create-load-balancer}

[Балансировщик](concepts/application-load-balancer.md) принимает запросы и распределяет их по ВМ из целевой группы по правилам, указанным в HTTP-роутере. Для приема трафика балансировщик использует [обработчики](concepts/application-load-balancer.md#listener). Визард создает обработчик автоматически. В качестве HTTP-роутера будет выбран роутер, созданный на предыдущем шаге.

Для примера будет создан балансировщик с узлом в одной подсети в одной зоне доступности.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Введите имя балансировщика: `test-load-balancer`.
  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_network-settings }}** выберите сеть, в подсети которой будет размещаться узел балансировщика.
  1. Включите переключатель **{{ ui-key.yacloud.alb.label_detailed-settings }}**.
  1. В блоке **{{ ui-key.yacloud.alb.section_allocation-settings }}** выберите подсеть в одной [зоне доступности](../overview/concepts/geo-scope.md) и включите прием трафика в этой подсети.

      Остальные зоны доступности удалите, нажав ![xmark](../_assets/console-icons/xmark.svg) в соответствующей строке.

  1. В блоке **{{ ui-key.yacloud.alb.label_listeners }}** введите имя обработчика: `test-listener`.
   
  1. Остальные настройки оставьте без изменений и нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

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