# Как начать работать с {{ ml-platform-name }}

{{ ml-platform-full-name }} — среда для ML-разработки, которая сочетает в себе привычный интерфейс [Jupyter® Notebook](https://jupyter.org/), технологию бессерверных вычислений и возможность бесшовного использования разных конфигураций вычислительных ресурсов. {{ ml-platform-name }} помогает значительно сократить стоимость машинного обучения по сравнению с вычислениями на собственном оборудовании или на других облачных платформах.

В этом разделе вы научитесь:
1. [Создавать проект](#create-project).
1. [Запускать проект](#start-project).
1. [Настраивать окружение](#install-dependencies).
1. [Загружать данные в проект](#download-data). 
1. [Запускать обучение](#start-ml).
1. [Делиться результатами](#share-with-community).

## Перед началом работы {#before-you-begin}

1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или зарегистрируйтесь, если вы еще не зарегистрированы.
1. [На странице биллинга]({{ link-console-billing }}) убедитесь, что у вас подключен [платежный аккаунт](../billing/concepts/billing-account.md) и он находится в статусе `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../billing/quickstart/index.md#create_billing_account).
1. Откройте [главную страницу]({{ link-datasphere-main }}) {{ ml-platform-name }}.
1. Примите пользовательское соглашение.
1. Активируйте {{ ml-platform-name }} в облаке.

## Создайте проект {#create-project}

{% include [create-project](../_includes/datasphere2/create-project.md) %}

## Запустите проект {#start-project}

{% include [start-project](../_includes/datasphere2/start-project.md) %}

## Настройте окружение {#install-dependencies}

{% include [install-dependencies-intro](../_includes/datasphere2/install-dependencies-intro.md) %}

{% include [install-dependencies-steps](../_includes/datasphere2/install-dependencies-steps.md) %}

Вы также можете настроить окружение для выполнения вашего кода, [используя Docker-образы](operations/user-images.md).

## Загрузите данные в проект {#download-data}

{% include [download-data](../_includes/datasphere2/download-data.md) %}

## Запустите обучение {#start-ml}

{% include [start-ml](../_includes/datasphere2/start-ml.md) %}

## Поделитесь результатами {#share-with-community}

{% include [share-with-community](../_includes/datasphere2/share-with-community.md) %}

## Что дальше {#what-is-next}

* [Узнайте об особенностях сервиса](concepts/index.md).
* [Посмотрите другие инструкции по работе с сервисом](operations/index.md).
* [Посмотрите практические руководства](tutorials/index.md).