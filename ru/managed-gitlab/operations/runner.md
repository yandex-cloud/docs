# Работа с управляемым раннером

{% include [gl-runners-preview](../../_includes/managed-gitlab/gl-runners-preview.md) %}

{% include [gl-runners-intro](../../_includes/managed-gitlab/gl-runners-intro.md) %}

{% include [note-payment](../../_includes/managed-gitlab/note-payment.md) %}

## Получить токен GitLab Runner {#gitlab-token}

Токен можно получить при создании {{ GLR }} в {{ GL }}. Этот токен указывается при [создании раннера](#create) в инстансе {{ mgl-name }} и используется для аутентификации раннера в {{ GL }}.

{% include [get-token](../../_includes/managed-gitlab/get-token.md) %}

## Создать раннер {#create}

{% include [runner-create](../../_includes/managed-gitlab/runner-create-console.md) %}

## Изменить раннер {#update}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-gitlab }}**.
  1. Выберите инстанс {{ mgl-name }}, в котором нужно изменить раннер.
  1. Выберите вкладку **{{ ui-key.yacloud.gitlab.title_runners }}**.
  1. Нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) для нужного раннера и выберите пункт **{{ ui-key.yacloud.common.edit }}**.
  1. Задайте новые имя и описание раннера.
  1. Выберите или создайте [сервисный аккаунт](../../iam/concepts/users/service-accounts.md) для раннера.

      {% include [sa-runner-info](../../_includes/managed-gitlab/sa-runner-info.md) %}

  1. Добавьте [метки](../../resource-manager/concepts/labels.md) для разделения раннеров на логические группы.
  1. Измените настройки масштабирования:

      {% include [runner-workers](../../_includes/managed-gitlab/runner-workers.md) %}

  1. Добавьте метки для воркера.
  1. Выберите новую конфигурацию вычислительных ресурсов воркера.
  1. Измените [тип](../../compute/concepts/disk.md#disks_types) и размер загрузочного диска.
  1. Выберите или создайте сервисный аккаунт для воркера.

      {% include [sa-worker-info](../../_includes/managed-gitlab/sa-worker-info.md) %}

  1. Выберите [группу безопасности](../../vpc/concepts/security-groups.md).
  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

## Удалить раннер {#delete}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-gitlab }}**.
  1. Выберите инстанс {{ mgl-name }}, из которого нужно удалить раннер.
  1. Выберите вкладку **{{ ui-key.yacloud.gitlab.title_runners }}**.
  1. В строке раннера, который вы хотите удалить, нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) и выберите пункт **{{ ui-key.yacloud.common.delete }}**.
  1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.gitlab.runners_popup-confirm_button_delete }}**.

{% endlist %}

### См. также {#see-also}

* [{#T}](../concepts/index.md#managed-runners)
* [{#T}](../tutorials/install-gitlab-runner.md)