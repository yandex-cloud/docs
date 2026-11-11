---
title: Как изменить политику аутентификации в {{ org-full-name }}
description: Следуя этой инструкции, вы сможете изменить политику аутентификации в {{ org-full-name }}.
---

# Изменить политику аутентификации

{% include [auth-policy-intro](../../../_includes/organization/auth-policy-intro.md) %}

{% include [auth-policy-role](../../../_includes/organization/auth-policy-role.md) %}

Чтобы изменить политику аутентификации:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. На панели слева выберите ![shield](../../../_assets/console-icons/shield.svg) **{{ ui-key.yacloud_org.pages.securitySettings }}** и перейдите на вкладку **{{ ui-key.yacloud_org.organization.security-settings.SecuritySettingsPageLayout.tab_auth_policies }}**.
  1. В строке с нужной политикой аутентификации нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
  1. (Опционально) В поле **{{ ui-key.yacloud.common.name }}** измените [имя](*policy_name) политики.
  1. (Опционально) В поле **{{ ui-key.yacloud.common.description }}** измените описание политики.
  1. (Опционально) В поле **{{ ui-key.yacloud.common.labels }}** задайте [метки](*labels) для политики.
  1. (Опционально) Отключите или включите опцию **{{ ui-key.yacloud_org.form.auth-policy.caption.active }}**, чтобы соответственно деактивировать или активировать политику.
  1. (Опционально) Настройте **{{ ui-key.yacloud_org.organization.security-settings.AuthPolicyForm.section_title_scope_b9vbe }}** политики:

      {% include [auth-policy-and-logic-notice](../../../_includes/organization/auth-policy-and-logic-notice.md) %}

      1. {% include [auth-policy-create-users](../../../_includes/organization/auth-policy-create-users.md) %}
      1. {% include [auth-policy-create-apps](../../../_includes/organization/auth-policy-create-apps.md) %}
      1. {% include [auth-policy-create-ntwrks](../../../_includes/organization/auth-policy-create-ntwrks.md) %}
      1. {% include [auth-policy-create-action](../../../_includes/organization/auth-policy-create-action.md) %}
      1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  1. Посмотрите описание команды CLI для изменения политики аутентификации:

      ```bash
      yc organization-manager authentication-policy-rule update --help
      ```
  1. {% include [auth-policy-list-cli](../../../_includes/organization/auth-policy-list-cli.md) %}
  1. Получите подробную информацию о параметрах политики аутентификации, указав ее идентификатор:

      ```bash
      yc organization-manager authentication-policy-rule get <идентификатор_политики>
      ```

      Результат:

      ```text
      id: bpf03arsgnjr********
      name: new-auth-policy
      organization_id: bpf2c65rqcl8********
      effect: ALLOW_WITH_OBLIGATIONS
      obligations:
        - skip_mfa:
            require_once: true
      created_at: "2026-11-09T16:33:54.162563Z"
      updated_at: "2026-11-09T16:37:10.960698Z"
      subjects_include:
        - ajeld88hdama********
        - aje0j5mts02t********
        - aje57o51v47n********
      subjects_exclude:
        - aje7r6bn6p22********
      networks_include:
        - 192.168.2.0/31
        - 192.168.1.0/24
      applications_include:
        - ek0oai8597m7********
        - ek0q6h6uel9i********
      status: ACTIVE
      ```
  1. Измените политику аутентификации, указав в команде ее идентификатор:

      ```bash
      yc organization-manager authentication-policy-rule update <идентификатор_политики> \
        --new-name <новое_имя_политики> \
        --description <описание_политики> \
        --labels <список_меток> \
        --subjects-include <идентификатор_субъекта_1>,<идентификатор_субъекта_2>,...,<идентификатор_субъекта_n> \
        --subjects-exclude <идентификатор_субъекта_1>,<идентификатор_субъекта_2>,...,<идентификатор_субъекта_m> \
        --applications-include <идентификатор_приложения_1>,<идентификатор_приложения_2>,...,<идентификатор_приложения_k> \
        --applications-exclude <идентификатор_приложения_1>,<идентификатор_приложения_2>,...,<идентификатор_приложения_i> \
        --networks-include <подсеть_1>,<подсеть_2>,...,<подсеть_h> \
        --networks-exclude <подсеть_1>,<подсеть_2>,...,<подсеть_g> \
        --effect <действие> \
        --obligations <список_требований>
      ```

      Где:

      * Основные параметры:

          * `--new-name` — новое имя политики. Необязательный параметр.
          * `--description` — описание политики. Необязательный параметр.
          * `--labels` — список [меток](*labels) политики в формате `ключ=значение`. Необязательный параметр.

      * Группа параметров, задающих условия для пользователей, в отношении которых будет действовать политика:

          {% note warning %}

          Условия, которые задаются в политике для пользователей, приложений и IP-адресов, при проверке возможности аутентификации применяются с логикой `И`.

          {% endnote %}

          * `--subjects-include` — один или несколько идентификаторов [пользователей](../users-get.md) и [групп пользователей](../group-get-id.md), которые будут включены в [область применения](../../concepts/authentication-policy.md#conditions) политики.

              Необязательный параметр. Если параметр не задан, в политике сохранится его текущее значение. Если задан, текущее значение будет полностью перезаписано новым значением.

              Чтобы обнулить текущее значение поля в настройках политики, передайте в команде параметр `--subjects-include ""`. В этом случае политика будет применяться ко всем пользователям в организации.
          * `--subjects-exclude` — один или несколько идентификаторов пользователей и групп пользователей, которые будут исключены из области применения политики.
          
              Необязательный параметр. Если параметр не задан, в политике сохранится его текущее значение. Если задан, текущее значение будет полностью перезаписано новым значением.
              
              Чтобы обнулить текущее значение поля в настройках политики, передайте в команде параметр `--subjects-exclude ""`.

              {% include [auth-policy-incl-excl-same-usr-ids-notice](../../../_includes/organization/auth-policy-incl-excl-same-usr-ids-notice.md) %}

      * Группа параметров, задающих условия для [приложений](*applications), аутентификацией в которых будет управлять политика:

          * `--applications-include` — один или несколько идентификаторов [SAML](../applications/saml-get.md)- и [OIDC](../applications/oidc-get.md)-приложений, которые будут включены в область применения политики.
          
              Необязательный параметр. Если параметр не задан, в политике сохранится его текущее значение. Если задан, текущее значение будет полностью перезаписано новым значением.

              Чтобы обнулить текущее значение поля в настройках политики, передайте в команде параметр `--applications-include ""`. В этом случае политика будет управлять аутентификацией во всех SAML- и OIDC-приложениях, созданных в организации.
          * `--applications-exclude` — один или несколько идентификаторов SAML- и OIDC-приложений, которые будут исключены из области применения политики.

              Необязательный параметр. Если параметр не задан, в политике сохранится его текущее значение. Если задан, текущее значение будет полностью перезаписано новым значением.
              
              Чтобы обнулить текущее значение поля в настройках политики, передайте в команде параметр `--applications-exclude ""`.

              {% include [auth-policy-incl-excl-same-app-ids-notice](../../../_includes/organization/auth-policy-incl-excl-same-app-ids-notice.md) %}

      * Группа параметров, задающих условия для IP-адресов, с которых политика будет разрешать или запрещать аутентификацию пользователей:

          * `--networks-include` — один или несколько диапазонов IPv4- или IPv6-адресов в нотации [CIDR](https://ru.wikipedia.org/wiki/Бесклассовая_адресация), которые будут включены в область применения политики.

              Необязательный параметр. Если параметр не задан, в политике сохранится его текущее значение. Если задан, текущее значение будет полностью перезаписано новым значением.
              
              Чтобы обнулить текущее значение поля в настройках политики, передайте в команде параметр `--networks-include ""`. В этом случае политика будет управлять аутентификацией пользователей с любых IP-адресов.
          * `--networks-exclude` — один или несколько диапазонов IPv4- или IPv6-адресов в нотации CIDR, которые будут исключены из области применения политики.

              Необязательный параметр. Если параметр не задан, в политике сохранится его текущее значение. Если задан, текущее значение будет полностью перезаписано новым значением.
              
              Чтобы обнулить текущее значение поля в настройках политики, передайте в команде параметр `--networks-exclude ""`.

              {% include [auth-policy-incl-excl-same-ips-notice](../../../_includes/organization/auth-policy-incl-excl-same-ips-notice.md) %}

      * Группа параметров, задающих действие, которое будет выполнять политика в отношении событий аутентификации:

          * `--effect` — действие, которое будет применяться к событиям аутентификации, относящимся к заданной области применения политики.

              Необязательный параметр. Если параметр не задан, в политике сохранится его текущее значение.

              Возможные значения:

              * `deny` — запрет аутентификации.
              * `allow-with-obligations` — разрешение аутентификации с учетом дополнительных требований, которые заданы в параметре `--obligations`.
          * `--obligations` — список дополнительных требований, которые будут предъявляться к событиям аутентификации, относящимся к области применения политики. Может быть задан, если для политики выбрано действие, разрешающее аутентификацию.

              Необязательный параметр. Если не задан, в политике сохранится текущее значение этого параметра. Если задан, текущее значение будет полностью перезаписано новым значением.

              Задается в формате строки, содержащей JSON-объект:

              ```json
              [{"stepUpRequired":{"acrId":"<стандарты_MFA>","ttl":"<время_жизни>"}},{"reauthenticationRequired":{"ttl":"<время_жизни>"}},{"skipMfa":{"requireOnce":true}}]
              ```

              Где:

              * `stepUpRequired` — требование запрашивать дополнительный фактор аутентификации, даже если вход уже был подтвержден ранее. В качестве значения принимает JSON-объект со следующими полями:

                  * `acrId` — допустимые к применению стандарты [факторов MFA](../../concepts/mfa.md#mfa-factors). Возможные значения:

                      * `any-mfa` — допускается использование дополнительных факторов аутентификации по стандартам [WebAuthn](https://en.wikipedia.org/wiki/WebAuthn) ([FIDO2](https://en.wikipedia.org/wiki/FIDO_Alliance#FIDO2)), [TOTP](https://ru.wikipedia.org/wiki/TOTP) или [SMS](https://ru.wikipedia.org/wiki/SMS).
                      * `any-except-sms` — допускается использование дополнительных факторов аутентификации только по стандартам WebAuthn или TOTP.
                      * `phr` — допускается использование дополнительных факторов аутентификации только по наиболее безопасному стандарту WebAuthn.
                  * `ttl` — время жизни дополнительного фактора аутентификации в секундах. По истечении заданного времени пользователям потребуется выполнить повторную проверку. Например, чтобы установить время жизни в один час, укажите значение `"ttl":"3600s"`.
              * `reauthenticationRequired` — требование запрашивать полный повторный вход пользователя: ввод пароля и фактора MFA.

                  В качестве значения принимает JSON-объект, содержащий поле `ttl` с периодичностью запроса повторного входа. Например, чтобы установить периодичность в один час, укажите значение `"ttl":"3600s"`.
              * `skipMfa` — параметр, позволяющий полностью отключить требование второго фактора MFA или запрашивать его только при первом входе.

                  В качестве значения принимает JSON-объект `{"skipMfa":{"requireOnce":<true_или_false>}}`, где значение поля `requireOnce`:

                  * `false` — чтобы полностью отключить требование второго фактора MFA.
                  * `true` — чтобы запрашивать второй фактор MFA только при первом входе.

              {% include [auth-policy-obligations-cli-notice](../../../_includes/organization/auth-policy-obligations-cli-notice.md) %}
- {{ TF }} {#tf}

  {% note info %}

  Активировать или деактивировать политику с помощью {{ TF }} нельзя.

  {% endnote %}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Откройте конфигурационный файл {{ TF }} и измените параметры ресурса `yandex_organizationmanager_policy_authentication_policy_rule` нужной политики. Политика должна управляться с помощью {{ TF }}.

     Подробнее о параметрах ресурса читайте в [документации провайдера]({{ tf-provider-resources-link }}/organizationmanager_policy_authentication_policy_rule).

  1. Примените изменения:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

- API {#api}

  Воспользуйтесь методом REST API [update](../../policy/api-ref/AuthenticationPolicyRule/update.md) для ресурса [AuthenticationPolicyRule](../../policy/api-ref/AuthenticationPolicyRule/index.md) или вызовом gRPC API [AuthenticationPolicyRuleService/Update](../../policy/api-ref/grpc/AuthenticationPolicyRule/update.md).

{% endlist %}

#### Полезные ссылки {#see-also}

* [{#T}](../../concepts/applications/index.md)
* [{#T}](../../concepts/authentication-policy.md)
* [{#T}](./create.md)
* [{#T}](./activate-deactivate.md)
* [{#T}](./delete.md)

[*policy_name]: Требования к имени:
* длина — от 3 до 63 символов;
* может содержать строчные буквы латинского алфавита, цифры и дефисы;
* первый символ — буква, последний — не дефис.

[*labels]: Метки — это пары `ключ:значение`, которые можно использовать для разделения ресурсов на логические группы. Подробнее читайте в разделе [{#T}](../../../resource-manager/concepts/labels.md).

[*mfa]: {% include notitle [hostname](../../../_popups/identity-hub/mfa.md) %}
