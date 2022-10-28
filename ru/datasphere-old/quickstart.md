# Как начать работать с {{ ml-platform-name }}

{% include [link-on-new-ui-datasphere-in-old-ui](../_includes/datasphere/datasphere-old-note.md) %}

{{ ml-platform-name }} — сервис, который упрощает использование среды разработки {{ jlab }}Lab на вычислительных мощностях {{ yandex-cloud }}. Это позволит вам производить сложные вычисления, например обучение нейронных сетей или анализ больших данных, используя привычный интерфейс Jupyter Notebook.

В этом разделе вы научитесь:

1. [Создавать проекты](#create-project), в которых вы будете работать в среде {{ jlab }}Lab.
1. [Устанавливать пакеты](#install-dependencies), которые нужны для работы.
1. [Управлять вычислительными ресурсами](#control-compute-resources), изменяя конфигурацию вычислительных ресурсов.

## Перед началом работы {#before-you-begin}

1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или зарегистрируйтесь, если вы еще не зарегистрированы.
{% if product == "yandex-cloud" %}
1. [На странице биллинга]({{ link-console-billing }}) убедитесь, что у вас подключен [платежный аккаунт](../billing/concepts/billing-account.md) и он находится в статусе `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../billing/quickstart/index.md#create_billing_account).
{% endif %}

## Назначьте роли для работы с DataSphere {#roles}

В консоли управления на странице [Управление доступом]({{ link-console-access-management }}) убедитесь, что у вас есть необходимые роли:

* Чтобы работать с уже существующими проектами, вам нужна роль `datasphere.user` или выше.

* Чтобы создавать, редактировать и удалять проекты, необходима роль `datasphere.admin` или выше.

Подробнее об [управлении доступом](security/index.md).

## Создайте проект {#create-project}

{% include [include](../_includes/datasphere/create-project.md) %}

## Установите зависимости {#install-dependencies}

Популярные пакеты для анализа данных и машинного обучения уже предустановлены и готовы к использованию, см. [список](concepts/preinstalled-packages.md).

Вы можете установить недостающие пакеты с помощью пакетного менеджера pip.

{% include [include](../_includes/datasphere/install-dependencies-steps.md) %}

## Увеличьте вычислительные ресурсы для ячейки {#control-compute-resources}

{% include [include](../_includes/datasphere/control-compute-resources-intro.md) %}

{% include [include](../_includes/datasphere/control-compute-resources-steps.md) %}

## Обратитесь в поддержку из сервиса {#support}

{% include [include](../_includes/datasphere/notebook-support.md) %}

## Что дальше {#what-is-next}

- [Узнайте об особенностях сервиса](concepts/index.md).
- [Поделитесь ссылкой на ноутбук со всеми результатами](operations/projects/publication.md).
- [Посмотрите другие инструкции по работе с сервисом](operations/index.md).
