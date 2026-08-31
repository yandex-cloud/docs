# Как начать работать с {{ network-load-balancer-short-name }}

[Сетевые балансировщики](concepts/index.md) равномерно распределяют нагрузку по облачным ресурсам и отслеживают их состояние. Это позволяет повысить доступность и отказоустойчивость ваших приложений и облачной сетевой инфраструктуры. 

Создайте сетевой балансировщик с [обработчиком](concepts/listener.md), подключите к нему [группу целевых ресурсов](concepts/target-resources) и настройте [проверку их состояния](concepts/health-check.md) с помощью сервиса {{ network-load-balancer-name }}.

## Перед началом работы {#before-you-begin}

1. Войдите в [консоль управления]({{ link-console-main }}) или зарегистрируйтесь. Если вы еще не зарегистрированы, перейдите в консоль управления и следуйте инструкциям.
1. На странице [**{{ ui-key.yacloud.component.navigation-menu.label_billing }}**]({{ link-console-billing }}) убедитесь, что у вас подключен [платежный аккаунт](../billing/concepts/billing-account.md) и он находится в статусе `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../billing/quickstart/index.md#create_billing_account).
1. Если у вас еще нет каталога, [создайте его](../resource-manager/operations/folder/create.md).
1. Заранее [создайте](../compute/quickstart/quick-create-linux.md) несколько виртуальных машин, которые войдут в целевую группу, подключенную к сетевому балансировщику. Для тестирования можно использовать недорогие [прерываемые ВМ](../compute/concepts/preemptible-vm.md).

## Создайте целевую группу {#create-target-group}

[Целевая группа](concepts/target-resources.md) объединяет облачные ресурсы, по которым сетевой балансировщик будет распределять трафик. 

Чтобы создать целевую группу:

1. В [консоли управления]({{ link-console-main }}) выберите каталог, где требуется создать целевую группу.
1. [Перейдите]({{ link-console-main }}/link/network-load-balancer/) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}**.
1. На панели слева выберите ![image](../_assets/console-icons/target.svg) **{{ ui-key.yacloud.load-balancer.target-group.label_list }}**.
1. Нажмите **{{ ui-key.yacloud.load-balancer.target-group.button_create }}**.
1. Введите имя целевой группы `test-target-group`.
1. Выберите виртуальные машины, которые нужно добавить в целевую группу.
1. Нажмите **{{ ui-key.yacloud.common.create }}**.


## Создайте сетевой балансировщик {#create-load-balancer}

При создании сетевого балансировщика нужно создать обработчик, на котором балансировщик будет принимать трафик, а также настроить проверку состояния ресурсов в подключенной целевой группе.

Чтобы создать сетевой балансировщик:
  
1. В [консоли управления]({{ link-console-main }}) выберите каталог, где требуется создать балансировщик.
1. [Перейдите]({{ link-console-main }}/link/network-load-balancer/) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}**.
1. Нажмите **{{ ui-key.yacloud.load-balancer.network-load-balancer.button_create }}**.
1. Задайте имя балансировщика, например `test-load-balancer`.
1. Выберите **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.field_network-load-balancer-type }}** балансировщика — `{{ ui-key.yacloud.load-balancer.network-load-balancer.form.label_external }}`.
1. {% include [select-external-ip](../_includes/network-load-balancer/select-external-ip.md) %}
1. {% include [add-listener](../_includes/network-load-balancer/add-listener.md) %}
1. В блоке **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.section_target-groups }}** выберите созданную [ранее](#create-target-group) целевую группу.
1. {% include [configure-health-check](../_includes/network-load-balancer/configure-health-check.md) %}
1. Нажмите **{{ ui-key.yacloud.common.create }}**.


## Проверьте состояния ресурсов {#health-check}

Чтобы проверить [состояние сетевого балансировщика](concepts/index.md#lb-statuses) и ресурсов в подключенной целевой группе:

1. В [консоли управления]({{ link-console-main }}) выберите каталог, где требуется создать балансировщик.
1. [Перейдите]({{ link-console-main }}/link/network-load-balancer/) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}**.
1. Найдите в списке созданный балансировщик.
1. Убедитесь, что он находится в состоянии `Active` — это означает, что балансировщик готов передавать трафик целевым ресурсам.
1. Нажмите на имя балансировщика.
1. Посмотрите на блок **{{ ui-key.yacloud.load-balancer.network-load-balancer.section_attached-target-groups }}**. Если виртуальные машины запущены и готовы принимать трафик, у них должно быть состояние `HEALTHY`.
1. Откройте страницу сервиса {{ compute-name }} и [остановите](../compute/operations/vm-control/vm-stop-and-start.md#stop) одну из ВМ, входящих в целевую группу.
1. Вернитесь на страницу балансировщика и убедитесь, что остановленная ВМ перешла в состояние `UNHEALTHY`. Это означает, что целевой ресурс из группы не прошел проверку состояния и не готов принимать трафик.


## Удалите сетевой балансировщик и созданные ресурсы {#delete-resources}

Если вам больше не нужен балансировщик, [удалите его](operations/load-balancer-delete.md).

Затем [удалите целевую группу](operations/target-group-delete.md) и [виртуальные машины](../compute/operations/vm-control/vm-delete.md).


## Что дальше {#what-is-next}

* Узнайте больше о работе [сетевых балансировщиков](concepts/index.md).
* Ознакомьтесь с [рекомендациями](concepts/best-practices.md) по развертыванию сетевого балансировщика.
