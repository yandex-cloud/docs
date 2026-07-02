[Документация Yandex Cloud](../../../../index.md) > [Безопасность в Yandex Cloud](../../../index.md) > [Практические руководства](../../index.md) > Защита приложений > [Создание L7-балансировщика Application Load Balancer с профилем безопасности Smart Web Security](index.md) > Консоль управления

# Создание L7-балансировщика Application Load Balancer с профилем безопасности Smart Web Security с помощью консоли управления

Чтобы создать [L7-балансировщик с профилем безопасности Smart Web Security](index.md) с помощью консоли управления Yandex Cloud:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Подготовьте инфраструктуру](#infrastructure-prepare).
1. [Создайте профиль безопасности](#profile-create).
1. [Подключите профиль безопасности к виртуальному хосту](#profile-connect).
1. [Протестируйте работу профиля безопасности](#test).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-you-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../../../billing/quickstart/index.md) и [привяжите](../../../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../../../resource-manager/concepts/resources-hierarchy.md).

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры для L7-балансировщика с профилем безопасности Smart Web Security входят:
* плата за постоянно запущенные [ВМ](../../../../compute/concepts/vm.md) ([тарифы Yandex Compute Cloud](../../../../compute/pricing.md));
* плата за использование вычислительных ресурсов [L7-балансировщика](../../../../application-load-balancer/concepts/index.md) ([тарифы Application Load Balancer](../../../../application-load-balancer/pricing.md));
* плата за запросы, обработанные правилами [профиля безопасности](../../../../smartwebsecurity/concepts/profiles.md) ([тарифы Yandex Smart Web Security](../../../../smartwebsecurity/pricing.md)).


## Подготовьте инфраструктуру {#infrastructure-prepare}

[Разверните](../../../../application-load-balancer/quickstart.md) инфраструктуру Application Load Balancer, а также ВМ с тестовым веб-сервером.

Будут созданы следующие ресурсы:
* [ВМ](../../../../compute/concepts/vm.md) `test-vm1` с тестовым веб-сервером.
* [целевая группа](../../../../application-load-balancer/concepts/target-group.md) `test-target-group`.
* [группа бэкендов](../../../../application-load-balancer/concepts/backend-group.md) `test-backend-group`.
* [HTTP-роутер](../../../../application-load-balancer/concepts/http-router.md) `test-http-router` с [виртуальным хостом](../../../../application-load-balancer/concepts/http-router.md#virtual-host) `test-virtual-host`.
* [L7-балансировщик](../../../../application-load-balancer/concepts/application-load-balancer.md) `test-load-balancer`.

Сохраните публичный IP-адрес L7-балансировщика, он понадобится для проверки профиля безопасности.

{% note tip %}

Чтобы обеспечить доступность вашего сервиса при высоких нагрузках, рекомендуем настроить [автомасштабирование](../../../../application-load-balancer/concepts/application-load-balancer.md#lcu-scaling) L7-балансировщика. 

{% endnote %}

## Создайте профиль безопасности {#profile-create}

Профиль безопасности является основным элементом сервиса Smart Web Security и состоит из набора правил, каждое из которых содержит условия для фильтрации входящих пользовательских запросов к защищаемому ресурсу.

Чтобы создать профиль безопасности:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы хотите создать профиль.
  1. Перейдите в сервис **Smart Web Security**.
  1. На панели слева выберите ![shield-check](../../../../_assets/console-icons/shield-check.svg) **Профили безопасности**.
  1. Нажмите кнопку **Создать профиль** и выберите **По преднастроенному шаблону**.

      Преднастроенный профиль содержит:
      
      * [базовое правило](../../../../smartwebsecurity/concepts/rules.md#base-rules) по умолчанию, включенное для всего трафика с [типом действия](../../../../smartwebsecurity/concepts/rules.md#rule-action) `Разрешить`;
      * [правило Smart Protection](../../../../smartwebsecurity/concepts/rules.md#smart-protection-rules) `sp-rule-1`, включенное для всего трафика, с типом действия `Полная защита`.

      {% note tip %}
      
      Создание преднастроенного профиля с полной защитой Smart Protection является предпочтительным. Рекомендуем использовать его, чтобы обеспечить наибольшую безопасность защищаемого ресурса.
      
      {% endnote %}

  1. Введите имя профиля, например `test-sp1`.
  1. В поле **Действие для базового правила по умолчанию** выберите `Запретить`. Таким образом, если не будет задано других правил, весь трафик к защищаемому ресурсу будет запрещен.
  1. Нажмите кнопку ![plus-sign](../../../../_assets/console-icons/plus.svg) **Добавить правило**.
  1. В окне создания правила:
      1. Введите имя правила, например `test-rule1`.
      1. Задайте приоритет правила, например `999800`. Правило будет иметь больший приоритет, чем преднастроенные правила.

          {% note info %}
          
          Чем меньше значение параметра, тем больший приоритет у правила. Приоритеты преднастроенных правил:
          * базовое правило по умолчанию — `1000000`;
          * правило Smart Protection с полной защитой — `999900`.
          
          {% endnote %}

      1. Выберите тип правила — `Базовое`.
      1. Выберите действие — `Разрешить`.

          В правиле будут описаны условия, при которых запросы будут направлены к бэкенду тестового приложения.
      1. В поле **Условия** выберите IP.
      1. В появившемся поле **Условия на IP** выберите опцию `Совпадает или принадлежит диапазону` и задайте публичный IP-адрес устройства, с которого вы будете отправлять запросы L7-балансировщику, например `158.160.100.200`.
      1. Нажмите кнопку **Добавить**.
        
          В блоке **Правила безопасности** в таблице появится созданное вами правило.
  1. Нажмите кнопку **Создать**.

{% endlist %}

## Подключите профиль безопасности к виртуальному хосту {#profile-connect}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится нужный [профиль безопасности](../../../../smartwebsecurity/concepts/profiles.md).
    1. Перейдите в сервис **Smart Web Security**.
    1. На панели слева выберите ![shield-check](../../../../_assets/console-icons/shield-check.svg) **Профили безопасности**.
    1. Выберите профиль безопасности, который вы хотите подключить к [виртуальному хосту](../../../../application-load-balancer/concepts/http-router.md#virtual-host) сервиса [Yandex Application Load Balancer](../../../../application-load-balancer/index.md).
    1. Нажмите кнопку ![plug](../../../../_assets/console-icons/plug-connection.svg) **Подключить к хосту**.
    1. В открывшемся окне нажмите **Добавить ресурс** и выберите **Виртуальный хост**.
    1. Последовательно установите значения в полях [**Балансировщик**](../../../../application-load-balancer/concepts/application-load-balancer.md), [**HTTP-роутер**](../../../../application-load-balancer/concepts/http-router.md) и [**Виртуальный хост**](../../../../application-load-balancer/concepts/http-router.md#virtual-host). Вы можете подключить профиль безопасности сразу к нескольким хостам.
  
        Чтобы подключить профиль к еще одному L7-балансировщику, нажмите кнопку **Добавить ресурс** и выберите **Виртуальный хост**.
      
    1. Нажмите кнопку **Подключить**. Если выбранные хосты уже подключены к другому профилю безопасности, подтвердите подключение.
  
        В разделе ![cubes-3-overlap](../../../../_assets/console-icons/cubes-3-overlap.svg) **Подключенные ресурсы** появятся подключенные виртуальные хосты.

{% endlist %}

## Протестируйте работу профиля безопасности {#test}

1. Откройте терминал устройства, IP-адрес которого вы указали в разрешающем правиле.
1. Отправьте запрос на бэкенд тестового приложения:

    ```bash
    curl --verbose <публичный_IP-адрес_L7-балансировщика>
    ```

    В результате должно быть выведено содержимое директории с тестовым веб-сервером.

1. Повторите запрос с другого IP-адреса. В результате должно быть выведено сообщение о невозможности установить соединение с сервером.

{% note info %}

Проверка правил Smart Protection не проводится. При такой проверке параметры подозрительных запросов, в том числе IP-адреса, заносятся в черный список.

{% endnote %}

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:
1. [Удалите](../../../../smartwebsecurity/operations/profile-delete.md) профиль безопасности.
1. [Удалите](../../../../application-load-balancer/operations/application-load-balancer-delete.md) L7-балансировщик.
1. [Удалите](../../../../application-load-balancer/operations/http-router-delete.md) HTTP-роутер.
1. [Удалите](../../../../application-load-balancer/operations/backend-group-delete.md) группу бэкендов.
1. [Удалите](../../../../application-load-balancer/operations/target-group-delete.md) целевую группу.
1. [Удалите](../../../../compute/operations/vm-control/vm-delete.md) ВМ.

#### Полезные ссылки {#see-also}

* [Создание L7-балансировщика Application Load Balancer с профилем безопасности Smart Web Security с помощью Terraform](terraform.md)