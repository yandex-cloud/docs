# Создать рабочий процесс с помощью конструктора

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите создать [рабочий процесс](../../../concepts/workflows/workflow.md).
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-integrations }}**.
  1. На панели слева нажмите ![image](../../../../_assets/console-icons/graph-node.svg) **{{ ui-key.yacloud.serverless-workflows.label_service }}**.
  1. В правом верхнем углу нажмите **{{ ui-key.yacloud.serverless-workflows.button_create-workflow }}**.
  1. Выберите способ `{{ ui-key.yacloud.serverless-workflows.spec-editor-type_label_visual-editor }}`.
  1. Добавьте необходимые шаги в рабочий процесс. Подробнее о настройке шагов с помощью конструктора см. раздел [{#T}](../constructor/index.md).
  1. Раскройте блок **{{ ui-key.yacloud.serverless-workflows.label_additional-parameters }}**:
     
     1. Введите имя и описание рабочего процесса. Требования к имени:
     
         * длина — от 3 до 63 символов;
         * может содержать строчные буквы латинского алфавита, цифры и дефисы;
         * первый символ — буква, последний — не дефис.
     
     1. (Опционально) [Добавьте](label-add.md) метки.
     1. (Опционально) [Укажите](network-add.md) облачную сеть.
     1. Выберите [сервисный аккаунт](../../../../iam/concepts/users/service-accounts.md) или [создайте](../../../../iam/operations/sa/create.md) новый.
     
         Сервисному аккаунту должны быть назначены роли для доступа к закрытым ресурсам, которые используются в шагах рабочего процесса.
     
     1. (Опционально) [Настройте](logs-write.md) запись логов.
  1. Нажмите **{{ ui-key.yacloud.common.create }}**.

{% endlist %}