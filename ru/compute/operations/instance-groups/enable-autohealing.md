# Настроить проверку состояния приложения на ВМ

Чтобы повысить доступность приложения и убедиться в том, что оно отвечает, можно настроить проверку состояния приложения на виртуальной машине. {{ ig-name }} будет выполнять проверку и автоматически восстанавливать виртуальную машину, если она не прошла проверку. Не путайте с [проверкой состояния](../../../network-load-balancer/concepts/health-check.md) в сетевом балансировщике. [Подробнее](../../concepts/instance-groups/autohealing.md) про автоматическое восстановление и типы проверок.

В этом разделе описывается, как настроить проверку состояния приложения для уже созданной группы.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) откройте каталог, в котором находится нужная группа ВМ.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.compute.switch_groups }}**.
  1. Выберите группу, которую хотите изменить.
  1. В правом верхнем углу страницы нажмите **{{ ui-key.yacloud.common.edit }}**.
  1. В блоке **{{ ui-key.yacloud.compute.groups.create.section_health-check }}** включите опцию **{{ ui-key.yacloud.compute.groups.create.field_enable-health-check }}**.
  1. Задайте настройки проверок состояния:
     * **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-protocol }}** — `{{ ui-key.yacloud.common.label_http }}` или `{{ ui-key.yacloud.common.label_tcp }}`.
     * **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-path }}** (для HTTP) — URL‐путь запроса, на который {{ ig-name }} будет отправлять запросы проверки для HTTP.
     * **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-port }}** — порт из диапазона 1-32767, на который {{ ig-name }} будет отправлять запросы проверки.

       {% note alert %}

       Поддерживается только HTTP/1.1 и ниже.

       {% endnote %}
     * **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-timeout }}** — время ожидания ответа в секундах.  
       Если вы [подключили группу к сетевому балансировщику](create-with-balancer.md), рекомендуем здесь выставить значение _больше_, чем в балансировщике.
     * **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-interval }}** — интервал проверок в секундах.С этим интервалом {{ ig-name }} будет проверять состояние приложения.
     * **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-healthy-threshold }}** — количество успешных проверок, после которого виртуальная машина будет считаться работающей нормально.  
        Если вы подключили группу к сетевому балансировщику, рекомендуем здесь выставить значение _меньше_, чем в балансировщике.
     * **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-unhealthy-threshold }}** — количество неудачных проверок, после которого виртуальная машина будет считаться неработающей.
       Если вы подключили группу к сетевому балансировщику, рекомендуем здесь выставить значение _больше_, чем в балансировщике.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install.md](../../../_includes/cli-install.md) %}

  {% include [default-catalogue.md](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для изменения группы:

     ```
     {{ yc-compute-ig }} update --help
     ```
  
  1. Получите список групп виртуальных машин в каталоге по умолчанию:

      {% include [instance-group-list.md](../../../_includes/instance-groups/instance-group-list.md) %}
  1. Выберите идентификатор (`ID`) или имя (`NAME`) нужной группы, например `first-instance-group`.
  1. [Получите информацию](get-info.md) о группе виртуальных машин.
  1. Создайте YAML-файл с произвольным именем, например `group.yaml` и, исходя из полученной информации, опишите:

      * [шаблон](../../concepts/instance-groups/instance-template.md) виртуальной машины;
      * [политики](../../concepts/instance-groups/policies/index.md);
      * идентификатор сервисного аккаунта;
      * спецификацию сетевого балансировщика нагрузки, если необходимо.

  1. Добавьте в файл спецификацию проверок состояния, например для проверок по протоколу HTTP:

     ```yaml
     ...
     health_checks_spec:
       health_check_specs:
         - http_options:
             port: 80
             path: /
           interval: 30s
           timeout: 10s
           unhealthy_threshold: 5
           healthy_threshold: 3
     ...
     ```

      Где:

      Ключ | Значение
      ----- | -----
      `health_check_specs` | Спецификация проверки состояния.
      `http_options` | Настройки проверок по протоколу HTTP. Поддерживается только HTTP/1.1 и ниже.<br>Если вы хотите использовать протокол TCP, используйте свойство `tcp_options` и укажите в нем только порт.
      `port` | Порт из диапазона 1-32767, на который {{ ig-name }} будет отправлять запросы проверки.
      `path` | URL‐путь запроса, на который {{ ig-name }} будет отправлять запросы проверки для HTTP.
      `interval` | Интервал проверок в секундах — с этим интервалом {{ ig-name }} будет проверять состояние приложения.
      `timeout` | Время ожидания ответа в секундах.<br>Если вы [подключили группу к сетевому балансировщику](create-with-balancer.md), рекомендуем здесь выставить значение _больше_, чем в балансировщике.
      `unhealthy_threshold` | Порог неработоспособности — количество неудачных проверок, после которого виртуальная машина будет считаться неработающей.<br>Если вы подключили группу к сетевому балансировщику, рекомендуем здесь выставить значение _больше_, чем в балансировщике.
      `healthy_threshold` | Порог работоспособности — количество успешных проверок, после которого виртуальная машина будет считаться работающей нормально.<br>Если вы подключили группу к сетевому балансировщику, рекомендуем здесь выставить значение _меньше_, чем в балансировщике.

  1. Обновите группу виртуальных машин в каталоге по умолчанию:

      ```
      {{ yc-compute-ig }} update --name first-group --file group.yaml
      ```

     {{ ig-name }} запустит операцию изменения группы виртуальных машин.

{% endlist %}