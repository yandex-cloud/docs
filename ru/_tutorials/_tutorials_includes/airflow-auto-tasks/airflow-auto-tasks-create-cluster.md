{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно [создать кластер](../../../managed-airflow/operations/cluster-create.md).
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-airflow }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.airflow.button_create-cluster }}**.
  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_base }}** укажите имя кластера. Имя должно быть уникальным в рамках каталога.
  1. В блоке **{{ ui-key.yacloud.airflow.section_accesses }}** задайте пароль пользователя-администратора. Пароль должен иметь длину не менее 8 символов и содержать как минимум:

        * одну заглавную букву;
        * одну строчную букву;
        * одну цифру;
        * один специальный символ.

     {% note info %}

     Сохраните пароль локально или запомните его. Сервис не показывает пароли после создания.

     {% endnote %}

  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_network-settings }}** выберите:

      * [зону доступности](../../../overview/concepts/geo-scope) `{{ region-id }}-a`;
      * облачную сеть `yq-network`;
      * подсеть `yq-network-{{ region-id }}-a`;
      * [группу безопасности](../../../vpc/concepts/security-groups.md) по умолчанию.

        {% include [sg-ui-access](../../../_includes/mdb/maf/note-sg-ui-access.md) %}

  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_dependencies }}** укажите название pip-пакета и ограничение на его версии:

      ```text
      apache-airflow-providers-yandex>=3.10
      ```

  1. В блоке **{{ ui-key.yacloud.airflow.section_storage }}** выберите созданный ранее бакет.

  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

{% endlist %}
