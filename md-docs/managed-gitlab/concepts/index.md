# Взаимосвязь ресурсов в {{ mgl-name }}

[{{ GL }}](https://about.gitlab.com/) — это веб-инструмент жизненного цикла [DevOps](https://yandex.cloud/ru/blog/posts/2022/03/what-is-devops) с открытым исходным кодом. Он представляет собой систему управления репозиториями кода для [Git](https://git-scm.com/) с системой отслеживания ошибок, [CI/CD](https://yandex.cloud/ru/blog/posts/2022/10/ci-cd) пайплайном, собственной Wiki и другими функциями.

{{ mgl-name }} позволяет настроить развертывание приложений на [виртуальных машинах](../../compute/concepts/vm.md) [{{ compute-full-name }}](../../compute/index.md), а также поддерживает интеграцию с [{{ container-registry-full-name }}](../../container-registry/index.md) и [{{ managed-k8s-full-name }}](../../managed-kubernetes/index.md).

Схема работы {{ mgl-name }}:

![image](../../_assets/managed-gitlab/gitlab_schema_ru.svg)

## Инстанс {{ GL }} {#instance}

_Инстанс_ {{ GL }} — основная сущность, которой оперирует сервис. Это ВМ, размещенная в {{ yandex-cloud }}. {{ mgl-name }} берет на себя рутинные операции по техническому обслуживанию этой ВМ, например, обеспечение отказоустойчивости хранилища, установку обновлений безопасности, автоматизированное обновление до новых версий {{ GL }} и т. д.

Пользователь может управлять инстансами с помощью [консоли управления {{ yandex-cloud }}]({{ link-console-main }}), [CLI](../cli-ref/index.md) и [API](../api-ref/authentication.md).

## Конфигурация инстанса {#config}

При создании инстанса указываются:
* Тип инстанса — [количество ядер (vCPU) и объем памяти (RAM)](../../compute/concepts/vm-platforms.md). Доступные типы инстансов:

  | Тип            | Вычислительные ресурсы |
  |----------------|------------------------|
  | s2.micro       | 2 vCPU, 8 ГБ RAM       |
  | s2.small       | 4 vCPU, 16 ГБ RAM      |
  | s2.medium      | 8 vCPU, 32 ГБ RAM      |
  | s2.large       | 16 vCPU, 64 ГБ RAM     |

  После создания инстанса можно [изменить его тип](../operations/instance/instance-update.md) на более производительный.
* [Подсеть](../../vpc/concepts/network.md#subnet).

  {% note warning %}
  
  Технические ограничения {{ yandex-cloud }} временно не позволяют выбрать подсеть с диапазоном адресов `192.168.0.0/24`.
  
  {% endnote %}

* Размер диска. После создания инстанса размер его диска [можно увеличить](../operations/instance/instance-update.md).
* Имя в домене `.gitlab.yandexcloud.net` — адрес вашего экземпляра {{ GL }} в интернете.
* Данные администратора:
  * Электронная почта.
  * Логин.

{% note info %}

В {{ mgl-name }} при создании инстанса автоматически генерируется SSL-сертификат. Дополнительная настройка для работы по протоколу HTTPS не требуется.

{% endnote %}

## {{ GLR }} {#runners}

[{{ GLR }}](https://docs.gitlab.com/runner/) — приложение с открытым исходным кодом, которое выполняет задания конвейерной обработки {{ GL }} [CI/CD](https://yandex.cloud/ru/blog/posts/2022/10/ci-cd) по инструкциям из специального файла `.gitlab-ci.yml`. Оно позволяет запускать автоматизированные сборки внутри [кластеров {{ managed-k8s-name }}](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) и на [виртуальных машинах {{ compute-name }}](../../compute/concepts/vm.md).

Начать работу с {{ GLR }} можно следующими способами:

* [Установить {{ GLR }} в кластер {{ managed-k8s-name }}](../../managed-kubernetes/operations/applications/gitlab-runner.md).
* Создать виртуальную машину {{ compute-name }} и [вручную установить на нее {{ GLR }}](../tutorials/install-gitlab-runner.md#install).
* [Создать раннер, управляемый {{ yandex-cloud }}](#managed-runners).

### Управляемые раннеры {#managed-runners}

{% note info %}

Функциональность создания и управления раннерами с помощью консоли управления находится на стадии [Preview](../../overview/concepts/launch-stages.md). Чтобы запросить доступ, обратитесь в [техническую поддержку]({{ link-console-support }}) или к вашему аккаунт-менеджеру.

{% endnote %}

В сервисе {{ mgl-name }} вы можете создать управляемый раннер, который автоматически разворачивает указанное число [виртуальных машин](../../compute/concepts/vm.md) {{ compute-name }} с установленными воркерами {{ GL }}. Также управляемый раннер обеспечивает горизонтальное масштабирование ВМ с воркерами в зависимости от нагрузки.

{% note warning %}

За использование виртуальных машин (воркеров) взимается плата (см. [тарифы {{ compute-name }}](../../compute/pricing.md)).

{% endnote %}

Вы можете задать следующие параметры управляемого раннера:
* Настройки масштабирования:

    * **{{ ui-key.yacloud.gitlab.field_task-minInstances }}** — число воркеров, которые всегда запущены и готовы выполнять задачи. Значение по умолчанию — `1`, минимальное — `0`, максимальное — `10`.
    * **{{ ui-key.yacloud.gitlab.field_max-workers }}** — максимальное число воркеров, которые могут быть созданы для выполнения задач. Значение по умолчанию — `3`, минимальное — `1`, максимальное — `30`. Максимальное количество воркеров не может быть меньше минимального.
    * **{{ ui-key.yacloud.gitlab.field_idle-time-minutes }}** — максимальное время простоя, по истечении которого дополнительно созданный воркер будет удален. Значение по умолчанию — `10`, минимальное — `0`.
    * **{{ ui-key.yacloud.gitlab.field_max-use-count }}** — максимальное количество задач, после выполнения которых воркер будет удален. Значение по умолчанию — `100`, минимальное — `0`.
    * **{{ ui-key.yacloud.gitlab.field_capacity-per-instance }}** — количество задач, которые выполняются на одном воркере одновременно. Значение по умолчанию — `1`, минимальное — `0`.

* Параметры ВМ с воркером:
  * Конфигурация вычислительных ресурсов воркера:
    * 2 vCPU, 4 ГБ RAM.
    * 2 vCPU, 8 ГБ RAM.
    * 4 vCPU, 16 ГБ RAM.
    * 8 vCPU, 64 ГБ RAM.
    * 16 vCPU, 128 ГБ RAM.
  * Тип (HDD или SSD) и объем диска. Подробнее см. в разделе [{#T}](../../compute/concepts/disk.md#disks-types).
  * [Сервисный аккаунт](../../iam/concepts/users/service-accounts.md).

    {% note info %}
    
    Этот сервисный аккаунт будет привязан к ВМ с воркером. С помощью него воркер сможет аутентифицироваться в API {{ yandex-cloud }} и взаимодействовать с облачными ресурсами.
    
    [Назначьте](../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту роль на ресурс, с которым вы хотите работать.
    
    {% endnote %}

  * [Группа безопасности](../../vpc/concepts/security-groups.md).

Подробнее о работе с управляемыми раннерами см. на страницах:
* [{#T}](../operations/runner.md)
* [{#T}](../tutorials/install-gitlab-runner.md)

### Сетевое взаимодействие между {{ GL }} и управляемыми раннерами {#networking-gl-mr}

Подсеть инстанса, к которому подключен управляемый раннер, должна иметь доступ в интернет (через [NAT-шлюз](../../vpc/concepts/gateways.md) или [NAT-инстанс](../../vpc/tutorials/nat-instance/index.md)).

Настройка сетевого взаимодействия между {{ GL }} и управляемыми раннерами включает обязательные, рекомендуемые и опциональные настройки групп безопасности.

![image](../../_assets/managed-gitlab/networking.svg)

#### Правила для входящего трафика {#ingress-rules-runner}

#|
|| **Зачем нужно правило** | **Настройки правила** ||
|| Для управления раннером с инстанса {{ GL }} по протоколу SSH.
Обязательное правило. |
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} — `22`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} — `{{ ui-key.yacloud.common.label_tcp }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} — CIDR всех подсетей, где могут запускаться раннеры.
Вместо CIDR вы можете указать группу безопасности, созданную для раннеров.
||
|#

#### Правила для исходящего трафика {#egress-rules-runner}

#|
|| **Зачем нужно правило** | **Настройки правила** ||
|| Для взаимодействия с публичным адресом инстанса {{ GL }} по протоколу HTTPS (например, для клонирования репозиториев, загрузки артефактов).
Обязательное правило. |
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} — `443`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} — `{{ ui-key.yacloud.common.label_tcp }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} — публичный адрес {{ GL }}.
||
|| Для доступа к реестру артефактов (например, Cloud Registry, dockerhub.io).
Рекомендуемое правило. |
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} — `443`, `5000` или другой.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} — `{{ ui-key.yacloud.common.label_tcp }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} — CIDR реестров, к которым предоставляется доступ. Чтобы разрешить трафик на любые IP-адреса, укажите `0.0.0.0/0`.
||
|| Для доступа к объектным хранилищам (например, LFS, Container Registry).
Рекомендуемое правило. |
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} — `443`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} — `{{ ui-key.yacloud.common.label_tcp }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} — CIDR объектных хранилищ, к которым предоставляется доступ. Чтобы разрешить трафик на любые IP-адреса, укажите `0.0.0.0/0`.
||
|| Для доступа к внешним ресурсам.
Опциональное правило. |
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} — `443`, `80` или другой.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} — `{{ ui-key.yacloud.common.label_tcp }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} — CIDR внешних ресурсов.
Если список ресурсов не определен, можно разрешить исходящий трафик к любым адресам (CIDR — `0.0.0.0/0`) через все порты. В этом случае можно пропустить настройку рекомендуемых правил и настройку доступа из управляемого раннера к публичному адресу инстанса {{ GL }}.
||
|#

## {{ GL }} Pages {#pages}

{{ GL }} Pages — инструмент для публикации статических сайтов на основе файлов, расположенных в репозитории {{ GL }}. Сайты разворачиваются по заданиям {{ GL }} CI/CD. {{ GL }} Pages работает с генераторами статических сайтов и обычными файлами HTML, CSS и JavaScript.

{{ GL }} Pages позволяет использовать собственные домены и сертификаты SSL/TLS, а также настраивать доступ к сайтам.

[Подробнее в официальной документации {{ GL }}](https://docs.gitlab.com/user/project/pages/).

{% note info %}

Функциональность находится на стадии [Preview](../../overview/concepts/launch-stages.md). Чтобы получить доступ, обратитесь в [техническую поддержку]({{ link-console-support }}) или к вашему аккаунт-менеджеру.

{% endnote %}

## Примеры использования {#examples}

* [{#T}](../tutorials/gitlab-lockbox-integration.md)
* [{#T}](../tutorials/ci-cd-serverless.md)
* [{#T}](../tutorials/install-gitlab-runner.md)
* [{#T}](../tutorials/gitlab-containers.md)