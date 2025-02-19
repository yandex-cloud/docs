Сейчас запросить изменение квот можно через [консоль управления]({{ link-console-main }}). Позднее появится возможность изменить квоты через CLI и API.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Убедитесь, что ваша [учетная запись]({{ link-console-iam-users }}) имеет [роль](../../iam/roles-reference.md#quota-manager-requestoperator) `quota-manager.requestOperator` или выше (`{{ roles-editor }}` или `{{ roles-admin }}`).
  1. Запросите изменение квоты одним из способов:
     * На [странице квот]({{ link-console-quotas }}) выберите ресурсы и нажмите **{{ ui-key.yacloud.iam.cloud.quotas.button_action-request }}**.
     * Обратитесь в [техническую поддержку]({{ link-console-support }}) и опишите, какие потребляемые квоты нужно увеличить и на сколько.

{% endlist %}