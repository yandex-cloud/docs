# Как начать работать с {{ sws-full-name }}

{{ sws-name }} позволяет защитить вашу инфраструктуру от [DDoS-атак](../glossary/ddos.md) и ботов на уровне приложений (L7).

Сервис находится на [стадии Preview](../overview/concepts/launch-stages.md).

{% include [ask-for-turning-on](../_includes/smartwebsecurity/ask-for-turning-on.md) %}

Создайте первый [профиль безопасности](./concepts/profiles.md), подключите его к [L7-балансировщику](../application-load-balancer/concepts/application-load-balancer.md) {{ alb-full-name }} и протестируйте работу настроенных правил безопасности.

Чтобы начать работу с сервисом:
1. [Подготовьте облако к работе](#before-you-begin).
1. [Подготовьте инфраструктуру](#infrastructure-prepare).
1. [Создайте профиль безопасности](#profile-create).
1. [Подключите профиль безопасности к виртуальному хосту](#profile-connect).
1. [Протестируйте работу профиля безопасности](#test).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../_tutorials/_tutorials_includes/before-you-begin.md) %}

## Подготовьте инфраструктуру {#infrastructure-prepare}

[Разверните](../application-load-balancer/quickstart.md) инфраструктуру {{ alb-name }}, а также ВМ с тестовым веб-сервером.

Будут созданы следующие ресурсы:
* [ВМ](../compute/concepts/vm.md) `test-vm1` с тестовым веб-сервером.
* [целевая группа](../application-load-balancer/concepts/target-group.md) `test-target-group`.
* [группа бэкендов](../application-load-balancer/concepts/backend-group.md) `test-backend-group`.
* [HTTP-роутер](../application-load-balancer/concepts/http-router.md) `test-http-router` с [виртуальным хостом](../application-load-balancer/concepts/http-router.md#virtual-host) `test-virtual-host`.
* [L7-балансировщик](../application-load-balancer/concepts/application-load-balancer.md) `test-load-balancer`.

Сохраните публичный IP-адрес L7-балансировщика, он понадобится для проверки профиля безопасности.

{% include [auto-scaling-tip](../_includes/smartwebsecurity/auto-scaling-tip.md) %}

## Создайте профиль безопасности {#profile-create}

Профиль безопасности является основным элементом сервиса {{ sws-name }} и состоит из набора правил, каждое из которых содержит условия для фильтрации входящих пользовательских запросов к защищаемому ресурсу.

Чтобы создать профиль безопасности:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите создать профиль.
  1. В списке сервисов выберите **{{ sws-name }}**.
  1. Нажмите кнопку **Создать профиль безопасности** и выберите **По шаблону с преднастроенным профилем**.

      Преднастроенный профиль содержит:
      * [базовое правило](./concepts/rules.md#base-rules) по умолчанию, включенное для всего трафика с [типом действия](./concepts/rules.md#rule-action) — **Запретить**;
      * [правило Smart Protection](./concepts/rules.md#smart-protection-rules), включенное для всего трафика, с типом действия — **Полная защита**.

      {% include [smart-protection-tip](../_includes/smartwebsecurity/smart-protection-tip.md) %}

  1. Введите имя профиля, например `test-sp1`.
  1. В поле **Действие базового правила по умолчанию** выберите **Запретить**. Таким образом, если не будет задано других правил, весь трафик к защищаемому ресурсу будет запрещен.
  1. Нажмите кнопку ![plus-sign](../_assets/plus-sign.svg) **Добавить правило**.
  1. В окне создания правила:
      1. Введите имя правила, например `test-rule1`.
      1. Задайте приоритет правила, например `999800`. Правило будет иметь больший приоритет, чем преднастроенные.

          {% include [preconfigured-rules-priority](../_includes/smartwebsecurity/preconfigured-rules-priority.md) %}

      1. Выберите тип правила — **Базовое**.
      1. Выберите действие — **Разрешить**.

          В правиле будут описаны условия, при которых запросы будут направлены к бэкенду тестового приложения.
      1. Раскройте поле **Условия**.
      1. В поле **IP** выберите опцию **совпадает с** и задайте публичный IP-адрес устройства, с которого вы будете отправлять запросы L7-балансировщику, например `158.160.100.200`.
      1. Нажмите кнопку **Сохранить правило**.
        
          На вкладке **Правила безопасности** в таблице появится созданное вами правило.
  1. Нажмите кнопку **Создать**.

{% endlist %}

## Подключите профиль безопасности к виртуальному хосту {#profile-connect}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите подключить профиль безопасности к виртуальному хосту сервиса {{ alb-name }}.
  1. В списке сервисов выберите **{{ sws-name }}**.
  1. Напротив профиля `test-sp1` нажмите ![options](../_assets/options.svg) и выберите ![pencil](../_assets/pencil.svg) **Редактировать**.
  1. Нажмите кнопку ![plug](../_assets/smartwebsecurity/plug.svg) **Подключить профиль к хосту**.
  1. В открывшемся окне выберите:
      * **Балансировщик** `test-load-balancer`.
      * **HTTP-роутер** `test-http-router`.
      * **Виртуальный хост** `test-virtual-host`. 
  1. Нажмите кнопку **Подключить**.

      На вкладке **Подключённые хосты** появится подключенный виртуальный хост.
  1. Нажмите кнопку **Сохранить**. 

{% endlist %}

## Протестируйте работу профиля безопасности {#test}

1. Откройте терминал устройства, IP-адрес которого вы указали в разрешающем правиле.
1. Отправьте запрос на бэкенд тестового приложения:

    ```bash
    curl -v <публичный_IP-адрес_L7-балансировщика>
    ```

    В результате должно быть выведено содержимое директории с тестовым веб-сервером.

1. Повторите запрос с другого IP-адреса. В результате должно быть выведено сообщение о невозможности установить соединение с сервером.

{% note info %}

Проверка правил Smart Protection не проводится. При такой проверке параметры подозрительных запросов, в том числе IP-адреса, заносятся в черный список.

{% endnote %}

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:
1. [Удалите](operations/profile-delete.md) профиль безопасности.
1. [Удалите](../application-load-balancer/operations/application-load-balancer-delete.md) L7-балансировщик.
1. [Удалите](../application-load-balancer/operations/http-router-delete.md) HTTP-роутер.
1. [Удалите](../application-load-balancer/operations/backend-group-delete.md) группу бэкендов.
1. [Удалите](../application-load-balancer/operations/target-group-delete.md) целевую группу.
1. [Удалите](../compute/operations/vm-control/vm-delete.md) ВМ.
