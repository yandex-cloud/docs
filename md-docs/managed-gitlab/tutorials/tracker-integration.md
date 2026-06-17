# Интеграция с Яндекс Трекер

# Интеграция GitLab с Яндекс Трекер


В [задачах Трекер](https://yandex.ru/support/tracker/ru/about-tracker#zadacha) можно автоматически добавлять ссылки на [мерж-реквесты](https://docs.gitlab.com/ee/user/project/merge_requests/) из GitLab, указывая [ключ](https://yandex.ru/support/tracker/ru/glossary#key) нужной задачи в названии или описании нового мерж-реквеста. Ссылки будут размещаться в разделе [Связи с внешними приложениями](https://yandex.ru/support/tracker/ru/external-links).

Дополнительно можно включить автоматическое создание комментариев в задаче с информацией о мерж-реквестах. Автоматическое комментирование доступно только для [Managed Service for GitLab](../index.md).

Чтобы настроить интеграцию с GitLab в Трекер:

1. [Подключите Яндекс Трекер](#enable-tracker).
1. [Создайте инстанс GitLab](#create-gitlab).
1. [(Опционально) Создайте проект GitLab](#create-project).
1. [Создайте хук для интеграции](#create-hook).
1. [Протестируйте хук](#test-hook).
1. [Проверьте результат](#check-result).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входит:

* Плата за [диск](../../compute/concepts/disk.md) и постоянно запущенную ВМ ([тарифы Yandex Compute Cloud](../../compute/pricing.md)).
* Плата за количество пользователей Трекер с полным доступом, если их более 5 ([тарифы Трекер](https://yandex.ru/support/tracker/ru/cloud/pricing)).
* Плата за использование [публичного IP-адреса](../../vpc/concepts/address.md#public-addresses) ([тарифы Yandex Virtual Private Cloud](../../vpc/pricing.md)).

## Подключите Яндекс Трекер {#enable-tracker}

[Подключите Трекер](https://yandex.ru/support/tracker/ru/enable-tracker) к вашей [организации Yandex Cloud](../../organization/index.md).

## Создайте инстанс GitLab {#create-gitlab}

Создайте [инстанс Managed Service for GitLab](../concepts/index.md#instance) или [виртуальную машину](../../compute/concepts/vm.md) с [образом](../../compute/concepts/image.md) GitLab.

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

## (Опционально) Создайте проект GitLab {#create-project}

Чтобы настроить интеграцию для отдельного проекта GitLab, создайте его.

{% list tabs group=gl_installation %}

- Инстанс Managed Service for GitLab {#instance-mgl}

    1. Авторизуйтесь в веб-интерфейсе [инстанса Managed Service for GitLab](../concepts/index.md#instance).
    1. Нажмите кнопку **Create a project**.
    1. Нажмите кнопку **Create blank project**.
    1. Заполните поля:
        * **Project name** — укажите имя проекта.
        * **Project URL** — выберите пользователя-администратора в поле рядом с FQDN инстанса Managed Service for GitLab.

        Остальные поля оставьте без изменений.
    1. Нажмите кнопку **Create project**.

- ВМ с образом GitLab {#gl-image-vm}

    1. Перейдите в сервис Yandex Compute Cloud.
    1. Выберите созданную [ВМ](../../compute/concepts/vm.md) и скопируйте ее [публичный IP-адрес](../../vpc/concepts/address.md#public-addresses).
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

        Если вы не можете войти, [сбросьте пароль учетной записи администратора](https://docs.gitlab.com/ee/security/reset_user_password.html#reset-your-root-password).
    1. [Смените пароль учетной записи администратора](https://docs.gitlab.com/ee/user/profile/user_passwords.html#change-your-password).
    1. Повторно войдите в систему с учетной записью администратора, используя новый пароль.
    1. Выберите **Create a project**.
    1. Укажите имя проекта.
    1. Нажмите кнопку **Create project**.

{% endlist %}

## Создайте хук для интеграции {#create-hook}

### Создайте хук для интеграции {#create-hook}

Чтобы привязывать мерж-реквесты из GitLab к задачам в Трекер, создайте хук:

1. Если у вас еще нет OAuth-токена для работы с Трекер API, [получите его](https://yandex.ru/support/tracker/ru/concepts/access#section_about_OAuth).

    {% note warning %}

    Для работы с Трекер API у пользователей должны быть соответствующие права в Трекере. Чтобы настроить интеграцию, убедитесь, что у вас есть права на изменение настроек очереди. Подробнее о правах доступа читайте в разделе [Роли и права доступа](https://yandex.ru/support/tracker/ru/role-model).

    {% endnote %}

1. Проверьте наличие доступа к API с помощью [запроса информации о текущем пользователе](https://yandex.ru/support/tracker/ru/get-user-info).
1. Откройте инстанс GitLab и перейдите к настройкам хука:
    * Для включения интеграции на весь [инстанс GitLab](../concepts/index.md) (требуются права администратора GitLab):
        1. В панели слева нажмите на раскрывающийся список **Your work** и выберите пункт **Admin Area**.
        1. Перейдите в раздел **System Hooks**.
    * Для включения интеграции на отдельный проект:
        1. Перейдите в необходимый проект.
        1. В панели слева нажмите кнопку **Settings** и выберите пункт **Webhooks**.
1. Укажите параметры хука:
    * **URL** — `https://api.tracker.yandex.net/v2/system/gitlab/receive?comments=true&<тип_организации>=<идентификатор_организации>`.

        Где:

        * `comments=true` — включает автоматическое создание комментариев в задаче со ссылкой и информацией о мерж-реквестах. Отключите, если комментирование не нужно. Параметр доступен только для Managed Service for GitLab.
        * `<тип_организации>` — может принимать следующие значения:

            * `x_cloud_org_id` — если тип вашей организации Yandex Identity Hub.
            * `x_org_id` — если тип вашей организации или Яндекс 360 для бизнеса, или одновременно Яндекс 360 для бизнеса и Yandex Identity Hub.

        * `<идентификатор_организации>` — идентификатор организации на [странице организаций Трекер](https://tracker.yandex.ru/admin/orgs).

    * **Secret token** — OAuth-токен робота, от имени которого будут добавляться связи, в формате `OAuth <содержимое_токена>`.
      Например: `OAuth y1_AQAD-qJScAAAEKEQbBNnChvfBIqR_yEQl_HMO0********`.
    * В блоке **Trigger** выключите все опции, кроме **Merge request events**.
    * В блоке **SSL verification** включите опцию **Enable SSL verification**.
1. Нажмите кнопку **Add system hook** (**Add webhook** для отдельного проекта).

На странице появится блок **System Hooks** (**Project Hooks** для отдельного проекта), в котором отобразится созданный хук и его параметры.

## Протестируйте хук {#test-hook}

### Протестируйте хук {#test-hook}

1. В блоке **System Hooks** (**Project Hooks** для отдельного проекта) нажмите кнопку **Test**.
1. В раскрывающемся списке выберите пункт **Merge request events**.

Тестовый запрос должен вернуть ответ `Hook executed successfully: HTTP 204`. Если тестовый запрос возвращает ошибку, значит параметры хука указаны неверно.

## Проверьте результат {#check-result}

1. [Создайте задачу](https://yandex.ru/support/tracker/ru/user/create-ticket#create-task) в Трекер.
1. [Создайте мерж-реквест](https://docs.gitlab.com/ee/user/project/merge_requests/creating_merge_requests.html) в GitLab и укажите в его названии или описании [ключ задачи](https://yandex.ru/support/tracker/ru/glossary#key).
1. Убедитесь, что в задаче Трекер в разделе [Связи с внешними приложениями](https://yandex.ru/support/tracker/ru/external-links) появилась ссылка на мерж-реквест из GitLab.

    Если вы использовали Managed Service for GitLab и включили автоматическое комментирование при [создании хука](#create-hook), то в задаче появится комментарий со ссылкой на мерж-реквест и информацией о нем.

## Удалите созданные ресурсы {#clear-out}

Удалите ресурсы, которые вы больше не будете использовать, чтобы за них не списывалась плата:

1. [Удалите инстанс Managed Service for GitLab](../operations/instance/instance-delete.md) или [созданную ВМ с образом GitLab](../../compute/operations/vm-control/vm-delete.md).
1. Если вы зарезервировали публичный статический IP-адрес для ВМ, освободите и [удалите его](../../vpc/operations/address-delete.md).