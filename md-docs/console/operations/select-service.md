[Документация Yandex Cloud](../../index.md) > [Yandex Cloud Console](../index.md) > Пошаговые инструкции > Переход в сервис и создание ресурсов Yandex Cloud

# Как начать работу с сервисами и создавать ресурсы

В консоли управления Yandex Cloud можно перейти к нужному сервису и создавать ресурсы через дашборд или панель слева.

{% note info %}

Если у вас нет кнопки перехода на дашборд, активируйте новый интерфейс. Для этого в настройках [консоли управления](https://console.yandex.cloud) в секции **Оформление** включите опцию **Новый дашборд**.

{% endnote %}

## Как открыть страницу сервиса {#select-service}

### Перейти в сервис с панели слева {#select-service-panel}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог.
  1. На панели слева нажмите ![image](../../_assets/console-icons/dots-9.svg) **Все сервисы**.
  1. В строке **Поиск по сервисам** введите название сервиса.
  1. Выберите нужный сервис.

  ![image](../../_assets/console/select-service-panel.png)

### Перейти в сервис с дашборда {#select-service-dashboard}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог.
  1. На панели слева нажмите ![image](../../_assets/console-icons/house.svg) **Дашборд**.
  1. В строке **Поиск сервисов** введите название сервиса.
  1. В разделе **Ресурсы** выберите нужный сервис.

  ![image](../../_assets/console/select-service-dashboard.png)

## Как создать ресурс {#create-resource}

### Создать ресурс на панели слева {#create-resource-panel}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог.
  1. На панели слева нажмите ![image](../../_assets/console-icons/plus.svg) **Создать ресурс**.
  1. Выберите нужный ресурс.

  ![image](../../_assets/console/create-resource-panel.png)

### Создать ресурс на дашборде {#create-resource-dashboard}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог.
  1. На панели слева нажмите ![image](../../_assets/console-icons/house.svg) **Дашборд**.
  1. Справа нажмите ![image](../../_assets/console-icons/plus.svg) **Создать ресурс**.
  1. Выберите нужный ресурс.

  ![image](../../_assets/console/create-resource-dashboard.png)

### Генерация кода для создания ресурса {#generate-resource-code}

При создании ресурса через консоль управления вы можете сгенерировать код для Terraform, CLI или API. Код генерируется автоматически на основе параметров, выбранных в консоли управления. Ручной ввод параметров не потребуется.

Чтобы сгенерировать код для создания ресурса:

1. В [консоли управления](https://console.yandex.cloud) перейдите к [созданию ресурса](#create-resource).
1. Заполните необходимые поля и нажмите кнопку ![image](../../_assets/console-icons/code.svg) **Генерация кода**.
1. В открывшемся окне выберите одну из доступных вкладок:

    {% note info %}

    Набор вкладок зависит от возможности создания данного типа ресурса в соответствующем инструменте.

    {% endnote %}

   {% list tabs %}

   - Terraform {#tf}

        Выберите `Код Terraform` и скопируйте команду для создания ресурса.

        Для получения информации о ресурсе провайдера [Terraform](../../tutorials/infrastructure-management/terraform-quickstart.md) нажмите `Документация Terraform`.

   - Yandex Cloud CLI {#cli}

        Выберите `Код CLI` и скопируйте команду для создания ресурса.

        Для получения информации о команде [CLI](../../cli/quickstart.md) нажмите `Документация CLI`.

        Чтобы перейти в Cloud Shell нажмите ![image](../../_assets/console-icons/terminal.svg) **Открыть Cloud Shell**.

   - API(gRPC) {#api}

        Выберите `Код API` и скопируйте запрос на создание ресурса.

        Для получения информации о запросе к [API](../../api-design-guide/concepts/general.md) Yandex Cloud нажмите `Документация API`.

        Чтобы перейти в Cloud Shell нажмите ![image](../../_assets/console-icons/terminal.svg) **Открыть Cloud Shell**.

   {% endlist %}

#### Полезные ссылки {#see-also}

* [Поиск в консоли управления](search.md)
* [Управление ресурсами Yandex Cloud с помощью AI-ассистента](ai-assistant.md)
* [Управление Cloud Shell](cloud-shell-options.md)