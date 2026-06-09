# Интеграция {{ GL }} с {{ tracker-full-name }}

# Интеграция {{ GL }} с {{ tracker-full-name }}


В [задачах {{ tracker-name }}]({{ link-tracker-cloudless }}about-tracker#zadacha) можно автоматически добавлять ссылки на [мерж-реквесты]({{ gl.docs }}/ee/user/project/merge_requests/) из {{ GL }}, указывая [ключ]({{ link-tracker-cloudless }}glossary#key) нужной задачи в названии или описании нового мерж-реквеста. Ссылки будут размещаться в разделе [Связи с внешними приложениями]({{ link-tracker-cloudless }}external-links).

Дополнительно можно включить автоматическое создание комментариев в задаче с информацией о мерж-реквестах. Автоматическое комментирование доступно только для [{{ mgl-name }}](../../managed-gitlab/index.md).

Чтобы настроить интеграцию с {{ GL }} в {{ tracker-name }}:

1. [Подключите {{ tracker-full-name }}](#enable-tracker).
1. [Создайте инстанс {{ GL }}](#create-gitlab).
1. [(Опционально) Создайте проект {{ GL }}](#create-project).
1. [Создайте хук для интеграции](#create-hook).
1. [Протестируйте хук](#test-hook).
1. [Проверьте результат](#check-result).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

Зарегистрируйтесь в {{ yandex-cloud }} и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или зарегистрируйтесь.
1. На странице **[{{ ui-key.yacloud_billing.billing.label_service }}]({{ link-console-billing }})** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака]({{ link-console-cloud }}).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входит:

* Плата за [диск](../../compute/concepts/disk.md) и постоянно запущенную ВМ (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md)).
* Плата за количество пользователей {{ tracker-name }} с полным доступом, если их более 5 (см. [тарифы {{ tracker-name }}]({{ link-tracker-cloudless }}cloud/pricing)).
* Плата за использование [публичного IP-адреса](../../vpc/concepts/address.md#public-addresses) (см. [тарифы {{ vpc-full-name }}](../../vpc/pricing.md)).

## Подключите {{ tracker-full-name }} {#enable-tracker}

[Подключите {{ tracker-name }}]({{ link-tracker-cloudless }}enable-tracker) к вашей [организации {{ yandex-cloud }}](../../organization/index.md).

## Создайте инстанс {{ GL }} {#create-gitlab}

Создайте [инстанс {{ mgl-name }}](../../managed-gitlab/concepts/index.md#instance) или [виртуальную машину](../../compute/concepts/vm.md) с [образом](../../compute/concepts/image.md) {{ GL }}.

{% list tabs group=gl_installation %}

- Инстанс {{ mgl-name }} {#instance-mgl}

    Создайте инстанс {{ mgl-name }} [согласно инструкции](../../managed-gitlab/quickstart.md#instance-create).

- ВМ с образом {{ GL }} {#gl-image-vm}

    Запустите {{ GL }} на ВМ с [публичным IP-адресом](../../vpc/concepts/address.md#public-addresses).

    1. На странице [каталога](../../resource-manager/concepts/resources-hierarchy.md#folder) в [консоли управления]({{ link-console-main }}) нажмите кнопку **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** и выберите `{{ ui-key.yacloud.iam.folder.dashboard.value_compute }}`.
    1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** в поле **{{ ui-key.yacloud.compute.instances.create.placeholder_search_marketplace-product }}** введите `Gitlab` и выберите публичный образ [{{ GL }}](https://yandex.cloud/ru/marketplace/products/yc/gitlab).
    1. В блоке **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}** выберите [зону доступности](../../overview/concepts/geo-scope.md), в которой будет находиться ВМ. Если вы не знаете, какая зона доступности вам нужна, оставьте выбранную по умолчанию.
    1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_platform }}** перейдите на вкладку `{{ ui-key.yacloud.component.compute.resources.label_tab-custom }}` и укажите необходимую [платформу](../../compute/concepts/vm-platforms.md), количество vCPU и объем RAM:
    
        * **{{ ui-key.yacloud.component.compute.resources.field_platform }}** — `Intel Ice Lake`.
        * **{{ ui-key.yacloud.component.compute.resources.field_cores }}** — `4`.
        * **{{ ui-key.yacloud.component.compute.resources.field_core-fraction }}** — `100%`.
        * **{{ ui-key.yacloud.component.compute.resources.field_memory }}** — `8 {{ ui-key.yacloud.common.units.label_gigabyte }}`.
    
    1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_network }}**:
        
        * В поле **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** выберите сеть и подсеть, к которым нужно подключить ВМ. Если нужной [сети](../../vpc/concepts/network.md#network) или [подсети](../../vpc/concepts/network.md#subnet) еще нет, [создайте их](../../vpc/operations/subnet-create.md).
        * В поле **{{ ui-key.yacloud.component.compute.network-select.field_external }}** оставьте значение `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}`, чтобы назначить ВМ случайный внешний IP-адрес из пула {{ yandex-cloud }}, или выберите статический адрес из списка, если вы зарезервировали его заранее.
    
    1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}** выберите вариант **{{ ui-key.yacloud.compute.instance.access-method.label_oslogin-control-ssh-option-title }}** и укажите данные для доступа на ВМ:
    
        * В поле **{{ ui-key.yacloud.compute.instances.create.field_user }}** введите имя пользователя. Не используйте имя `root` или другие имена, зарезервированные ОС. Для выполнения операций, требующих прав суперпользователя, используйте команду `sudo`.
        * В поле **{{ ui-key.yacloud.compute.instances.create.field_key }}** выберите SSH-ключ, сохраненный в вашем профиле [пользователя организации](../../organization/concepts/membership.md).
          
          Если в вашем профиле нет сохраненных SSH-ключей или вы хотите добавить новый ключ:
          
          1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_add-ssh-key }}**.
          1. Задайте имя SSH-ключа.
          1. Выберите вариант:
          
              * `{{ ui-key.yacloud_components.ssh-key-add-dialog.value_radio-manual }}` — вставьте содержимое открытого [SSH](../../glossary/ssh-keygen.md)-ключа. Пару SSH-ключей необходимо [создать](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) самостоятельно.
              * `{{ ui-key.yacloud_components.ssh-key-add-dialog.value_radio-upload }}` — загрузите открытую часть SSH-ключа. Пару SSH-ключей необходимо создать самостоятельно.
              * `{{ ui-key.yacloud_components.ssh-key-add-dialog.value_radio-generate }}` — автоматическое создание пары SSH-ключей.
              
                При добавлении сгенерированного SSH-ключа будет создан и загружен архив с парой ключей. В ОС на базе Linux или macOS распакуйте архив в папку `/home/<имя_пользователя>/.ssh`. В ОС Windows распакуйте архив в папку `C:\Users\<имя_пользователя>/.ssh`. Дополнительно вводить открытый ключ в консоли управления не требуется.
          
          1. Нажмите кнопку **{{ ui-key.yacloud.common.add }}**.
          
          SSH-ключ будет добавлен в ваш профиль пользователя организации. Если в организации [отключена](../../organization/operations/os-login-access.md) возможность добавления пользователями SSH-ключей в свои профили, добавленный открытый SSH-ключ будет сохранен только в профиле пользователя внутри создаваемого ресурса.
    
    1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_base }}** задайте имя ВМ: `ci-tutorial-gitlab`.
    1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_create }}**.
    
    Создание ВМ может занять несколько минут. Когда ВМ перейдет в статус `RUNNING` и запустится {{ GL }}, настройте его.

{% endlist %}

## (Опционально) Создайте проект {{ GL }} {#create-project}

Чтобы настроить интеграцию для отдельного проекта {{ GL }}, создайте его.

{% list tabs group=gl_installation %}

- Инстанс {{ mgl-name }} {#instance-mgl}

    1. Авторизуйтесь в веб-интерфейсе [инстанса {{ mgl-name }}](../../managed-gitlab/concepts/index.md#instance).
    1. Нажмите кнопку **Create a project**.
    1. Нажмите кнопку **Create blank project**.
    1. Заполните поля:
        * **Project name** — укажите имя проекта.
        * **Project URL** — выберите пользователя-администратора в поле рядом с FQDN инстанса {{ mgl-name }}.

        Остальные поля оставьте без изменений.
    1. Нажмите кнопку **Create project**.

- ВМ с образом {{ GL }} {#gl-image-vm}

    1. Перейдите в сервис {{ compute-full-name }}.
    1. Выберите созданную [ВМ](../../compute/concepts/vm.md) и скопируйте ее [публичный IP-адрес](../../vpc/concepts/address.md#public-addresses).
    1. [Подключитесь](../../compute/operations/vm-connect/ssh.md) к ВМ по протоколу SSH.
    1. Получите пароль администратора {{ GL }} с помощью команды ВМ:

        ```bash
        sudo cat /etc/gitlab/initial_root_password
        ```

    1. Скопируйте пароль из строки `Password` (исключая пробелы) в буфер обмена или отдельный файл.
    1. Откройте в браузере ссылку `http://<публичный_IP-адрес_ВМ>`. Откроется веб-интерфейс {{ GL }}.
    1. Войдите в систему с учетной записью администратора:
        * **Username or email** — `root`.
        * **Password** — пароль, скопированный ранее.

        Если вы не можете войти, [сбросьте пароль учетной записи администратора]({{ gl.docs }}/ee/security/reset_user_password.html#reset-your-root-password).
    1. [Смените пароль учетной записи администратора]({{ gl.docs }}/ee/user/profile/user_passwords.html#change-your-password).
    1. Повторно войдите в систему с учетной записью администратора, используя новый пароль.
    1. Выберите **Create a project**.
    1. Укажите имя проекта.
    1. Нажмите кнопку **Create project**.

{% endlist %}

## Создайте хук для интеграции {#create-hook}

### Создайте хук для интеграции {#create-hook}

Чтобы привязывать мерж-реквесты из {{ GL }} к задачам в {{ tracker-name }}, создайте хук:

1. Если у вас еще нет OAuth-токена для работы с {{ tracker-name }} API, [получите его]({{ link-tracker-cloudless }}concepts/access#section_about_OAuth).

    {% note warning %}

    Для работы с {{ tracker-name }} API у пользователей должны быть соответствующие права в Трекере. Чтобы настроить интеграцию, убедитесь, что у вас есть права на изменение настроек очереди. Подробнее о правах доступа читайте в разделе [Роли и права доступа]({{ link-tracker-cloudless }}role-model).

    {% endnote %}

1. Проверьте наличие доступа к API с помощью [запроса информации о текущем пользователе]({{ link-tracker-cloudless }}get-user-info).
1. Откройте инстанс {{ GL }} и перейдите к настройкам хука:
    * Для включения интеграции на весь [инстанс {{ GL }}](../../managed-gitlab/concepts/index.md) (требуются права администратора {{ GL }}):
        1. В панели слева нажмите на раскрывающийся список **Your work** и выберите пункт **Admin Area**.
        1. Перейдите в раздел **System Hooks**.
    * Для включения интеграции на отдельный проект:
        1. Перейдите в необходимый проект.
        1. В панели слева нажмите кнопку **Settings** и выберите пункт **Webhooks**.
1. Укажите параметры хука:
    * **URL** — `https://api.tracker.yandex.net/v2/system/gitlab/receive?comments=true&<тип_организации>=<идентификатор_организации>`.

        Где:

        * `comments=true` — включает автоматическое создание комментариев в задаче со ссылкой и информацией о мерж-реквестах. Отключите, если комментирование не нужно. Параметр доступен только для {{ mgl-name }}.
        * `<тип_организации>` — может принимать следующие значения:

            * `x_cloud_org_id` — если тип вашей организации {{ org-full-name }}.
            * `x_org_id` — если тип вашей организации или {{ ya-360 }}, или одновременно {{ ya-360 }} и {{ org-full-name }}.

        * `<идентификатор_организации>` — идентификатор организации на [странице организаций {{ tracker-name }}]({{ link-tracker }}admin/orgs).

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

1. [Создайте задачу]({{ link-tracker-cloudless }}user/create-ticket#create-task) в {{ tracker-name }}.
1. [Создайте мерж-реквест]({{ gl.docs }}/ee/user/project/merge_requests/creating_merge_requests.html) в {{ GL }} и укажите в его названии или описании [ключ задачи]({{ link-tracker-cloudless }}glossary#key).
1. Убедитесь, что в задаче {{ tracker-name }} в разделе [Связи с внешними приложениями]({{ link-tracker-cloudless }}external-links) появилась ссылка на мерж-реквест из {{ GL }}.

    Если вы использовали {{ mgl-name }} и включили автоматическое комментирование при [создании хука](#create-hook), то в задаче появится комментарий со ссылкой на мерж-реквест и информацией о нем.

## Удалите созданные ресурсы {#clear-out}

Удалите ресурсы, которые вы больше не будете использовать, чтобы за них не списывалась плата:

1. [Удалите инстанс {{ mgl-name }}](../../managed-gitlab/operations/instance/instance-delete.md) или [созданную ВМ с образом {{ GL }}](../../compute/operations/vm-control/vm-delete.md).
1. Если вы зарезервировали публичный статический IP-адрес для ВМ, освободите и [удалите его](../../vpc/operations/address-delete.md).