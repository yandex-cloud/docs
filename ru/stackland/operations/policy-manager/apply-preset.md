# Активировать пресет политик

{{ stackland-name }} позволяет активировать пресеты политик и применять их к ресурсам кластера. Чтобы активировать пресет, создайте ресурс `ClusterPolicySet`.

{% note info %}

По умолчанию к кластеру применен пресет [baseline](https://kubernetes.io/docs/concepts/security/pod-security-standards/#baseline).

{% endnote %}


## Через CLI {#cli}

1. Создайте файл ресурса `ClusterPolicySet`. Например, с помощью команды `touch clusterpolicyset.yaml`.
1. Откройте файл и вставьте конфигурацию ниже:

    {% list tabs %}

    - Baseline

        {% include notitle [YAML-файл](../../_includes/yamls/operations/policy-manager/apply-preset-baseline.md) %}

    - Restricted

        {% include notitle [YAML-файл](../../_includes/yamls/operations/policy-manager/apply-preset-restricted.md) %}

    - Restricted и Baseline

        {% include notitle [YAML-файл](../../_includes/yamls/operations/policy-manager/apply-preset-both.md) %}

    {% endlist %}

1. Примените манифест: `kubectl apply -f clusterpolicyset.yaml`.

## Через консоль управления {#console}

1. В левом меню выберите **Политики безопасности**.
1. Перейдите на вкладку **Настройки**.
1. Включите переключатель **Проверка политик**.
1. В разделе **Kyverno** выберите нужные пресеты политик:

    * **Baseline** — базовая защита от неправильной конфигурации.
    * **Restricted** — строгое соблюдение принципа минимальных привилегий.

    Вы можете выбрать один или оба пресета одновременно.

Нажмите **Открыть YAML редактор**, чтобы просмотреть или изменить конфигурацию ресурса `ClusterPolicySet`.

Готово, Policy Manager начнет отправлять уведомления о нарушениях политик.
