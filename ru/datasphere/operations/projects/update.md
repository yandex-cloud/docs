# Изменить настройки проекта

На странице редактирования проекта вы можете изменить его имя и описание, задать ограничения потребления и настроить интеграцию с другими сервисами {{ yandex-cloud }}:

1. {% include [include](../../../_includes/datasphere/ui-find-project.md) %}
1. Перейдите на вкладку **Настройки** и нажмите кнопку **![pencil](../../../_assets/pencil.svg) Редактировать**.
1. Если необходимо, в соответствующих полях добавьте или измените:

   * **Имя** и **Описание** проекта.
   * **Время бездействия** — как скоро перестанут выполняться ячейки с загрузкой CPU или GPU меньше 1% (по умолчанию — `Никогда`).
   * [Каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder) по умолчанию для хранения логов работы [нод](../../concepts/deploy/index.md).
   * [Сервисный аккаунт](../../../iam/concepts/users/service-accounts.md), от имени которого будут создаваться подключения S3 или кластеры Data Proc. Сервисный аккаунт должен иметь необходимые [роли](../../../iam/concepts/access-control/roles).
   * [Подсеть](../../../vpc/concepts/network#subnet), если она нужна для связи с другими сервисами {{ yandex-cloud }}.
   * [Группу безопасности](../../../vpc/concepts/security-groups.md), если они используются в вашей организации.
   * [Кластер Data Proc](../../../data-proc/concepts/#resursy), если вы собираетесь использовать [заранее созданный](../../../data-proc/operations/cluster-create.md) кластер {{ dataproc-full-name }}.

1. Нажмите кнопку **Сохранить**.

В настройках проекта вы также можете включить [автоматическое сохранение состояния](../../concepts/save-state.md#auto-save) и [режим раннего доступа](../../concepts/early-access.md).


#### См. также {#see-also}

* [{#T}](restrictions.md)
* [{#T}](install-dependencies.md)
* [{#T}](control-compute-resources.md)

