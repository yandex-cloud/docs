# Как начать работать с {{ ml-platform-name }}

{{ ml-platform-name }} — сервис, который упрощает использование среды разработки JupyterLab на вычислительных мощностях Яндекс.Облака. Это позволит вам производить сложные вычисления, например обучение нейронных сетей или анализ больших данных, используя привычный интерфейс Jupyter Notebook.

В этом разделе вы научитесь:

1. [Создавать проекты](#create-project), в которых вы будете работать в среде JupyterLab.
1. [Устанавливать пакеты](#install-dependencies), которые нужны для работы.
1. [Управлять вычислительными ресурсами](#control-compute-resources), переключаясь на более мощные виртуальные машины.
1. [Загружать файлы](#upload-resources), чтобы использовать их изнутри проектов.

## Перед началом работы {#before-you-begin}

1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в Яндекс.Облако или зарегистрируйтесь, если вы еще не зарегистрированы.
1. [На странице биллинга]({{ link-console-billing }}) убедитесь, что у вас подключен [платежный аккаунт](../billing/concepts/billing-account.md) и он находится в статусе `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../billing/quickstart/index.md#create_billing_account).
1. На странице [Управление доступом]({{ link-console-access-management }}) убедитесь, что у вас есть роль `editor` или выше. Роль должна быть назначена на каталог, в котором вы будете работать, или на облако, которому принадлежит этот каталог.

## Создайте проект {#create-project}

{% include [include](../_includes/datasphere/create-project.md) %}

## Установите зависимости {#install-dependencies}

{% include [include](../_includes/datasphere/install-dependencies-intro.md) %}

{% include [include](../_includes/datasphere/install-dependencies-steps.md) %}

## Увеличьте используемые вычислительные ресурсы {#control-compute-resources}

{% include [include](../_includes/datasphere/control-compute-resources-intro.md) %}

{% include [include](../_includes/datasphere/control-compute-resources-steps.md) %}

## Загрузите свои файлы {#upload-resources}

{% include [include](../_includes/datasphere/resources-upload.md) %}

{% include [include](../_includes/datasphere/update-files.md) %}

## Что дальше {what-is-next}

- [Узнайте об особенностях сервиса](concepts/index.md).
- [Поделитесь ссылкой на ноутбук со всеми результатами](operations/projects/share.md).
- [Посмотрите другие инструкции по работе с сервисом](operations/index.md).