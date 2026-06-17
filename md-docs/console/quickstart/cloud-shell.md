# Как начать работать с Yandex Cloud Shell

С помощью Cloud Shell вы можете пользоваться [CLI Yandex Cloud](../../cli/index.md) и другими терминальными инструментами без предварительной настройки прямо в браузере. Среда окружения Cloud Shell содержит основные инструменты для работы с облаком и популярные SDK для языков программирования.

Чтобы начать работать с Cloud Shell:

1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь, если вы еще не зарегистрированы.

1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

1. В [консоли управления](https://console.yandex.cloud) на панели слева выберите ![Cloud Shell](../../_assets/console-icons/cloud-shell.svg) **Cloud Shell**.

    Откроется окно терминала — дождитесь, когда сессия запустится и будет создана среда разработки.

1. Воспользуйтесь командами CLI Yandex Cloud, чтобы управлять облачными ресурсами через терминал. Например, чтобы посмотреть список ВМ в облаке, выполните команду:

    ```bash
    yc compute instance list
    ```

   ![screen01](../../_assets/console/cloud-shell-01.png)

    Примеры других команд см. в разделе [Начало работы с CLI](../../cli/quickstart.md#example). Чтобы посмотреть полный список доступных команд, выполните команду `yc --help` или откройте [справочник CLI](../../cli/cli-ref/index.md).

    {% note info %}

    Вы можете запустить до 4 параллельных сессий в терминале. Чтобы запустить новую сессию, нажмите кнопку ![plus-sign](../../_assets/console-icons/plus.svg). После запуска сессия может быть активна в течение 12 часов. Неактивные сессии автоматически прерываются после 30 минут бездействия. Подробнее об ограничениях в Cloud Shell см. в разделе [Лимиты](../concepts/cloud-shell/limits.md).

    {% endnote %}
   
1. Установите необходимые приложения с помощью инструмента `apt`. Например, чтобы установить `postgresql-client` для [подключения к кластеру Yandex Managed Service for PostgreSQL](../../managed-postgresql/operations/connect/index.md), выполните команду:

    ```bash
    sudo apt update && sudo apt install --yes postgresql-client
    ```

    {% note info %}

    Виртуальная машина Cloud Shell будет автоматически остановлена и удалена по прошествии 15 минут после завершения последней активной сессии. Любые системные изменения, включая установленные приложения и пакеты, будут сброшены.

    {% endnote %}


## Полезные ссылки {#see-also}

* [Управление Cloud Shell](../operations/cloud-shell-options.md)
* [Лимиты Cloud Shell](../concepts/cloud-shell/limits.md)
* [Справочник CLI](../../cli/cli-ref/index.md)