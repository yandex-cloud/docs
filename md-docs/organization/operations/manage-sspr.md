[Документация Yandex Cloud](../../index.md) > [Yandex Identity Hub](../index.md) > [Пошаговые инструкции](index.md) > Аутентификация > Настроить самостоятельный сброс пароля пользователями (SSPR)

# Настроить самостоятельный сброс пароля пользователями в Yandex Identity Hub

С помощью [политик MFA](../concepts/mfa.md) вы можете разрешить самостоятельный сброс пароля (SSPR — [self-service password reset](https://en.wikipedia.org/wiki/Self-service_password_reset)) для [локальных](../../iam/concepts/users/accounts.md#local) пользователей Yandex Identity Hub.

Чтобы настроить для пользователей возможность самостоятельного сброса пароля:

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

  1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization).
  1. На панели слева выберите ![shield](../../_assets/console-icons/shield.svg) **Настройки безопасности**.
  1. Перейдите на вкладку **Политики MFA**.
  1. В списке политик MFA в строке с нужной политикой нажмите значок ![ellipsis](../../_assets/console-icons/ellipsis.svg) и выберите ![pencil](../../_assets/console-icons/pencil.svg) **Редактировать**. Если у вас нет политики MFA, [создайте](mfa/create-policy.md) новую политику. В открывшемся окне:

      1. Чтобы включить возможность [самостоятельного сброса пароля](../concepts/sspr.md) для пользователей, добавленных в целевую группу политики MFA, в блоке **Самостоятельный сброс пароля**:

          1. Включите опцию **Разрешить сброс пароля**.
          1. В поле **Способ сброса** выберите как минимум один способ верификации пользователя при сбросе пароля:

          * `Последовательный ввод двух любых аутентификаторов` — способ сброса, при котором пользователь может подтвердить личность поочередно с помощью двух любых способов верификации (например, TOTP и код из SMS).
          
              Чтобы пользователь мог воспользоваться этим способом сброса пароля, для его аккаунта должны быть заданы как минимум два любых [фактора MFA](../concepts/mfa.md#mfa-factors). В противном случае сбросить пароль пользователя сможет только администратор [пула пользователей](../concepts/user-pools.md).
          * `FIDO2 с обязательным подтверждением личности пользователя (User Verification)` — способ сброса, при котором пользователь может подтвердить личность с помощью [FIDO2](https://en.wikipedia.org/wiki/FIDO_Alliance#FIDO2)-ключа или [Passkey](https://www.passkeys.com/), но только если при этом пользователь проходит процедуру локальной проверки с помощью PIN-кода, биометрии или аналогичного механизма.
          
              Чтобы пользователь мог воспользоваться этим способом сброса пароля, для его аккаунта должен быть задан фактор MFA типа [WebAuthn](https://en.wikipedia.org/wiki/WebAuthn). В противном случае сбросить пароль пользователя сможет только администратор пула пользователей.

      {% note info %}

      Чтобы отключить для пользователей возможность самостоятельного сброса пароля, в блоке **Самостоятельный сброс пароля** отключите опцию **Разрешить сброс пароля**.

      {% endnote %}

  1. Нажмите кнопку **Сохранить**.

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  Для настройки SSPR используйте провайдер Yandex Cloud версии 0.239.0 или выше.

  1. Откройте конфигурационный файл Terraform и добавьте параметр `sspr_policies` в описание нужной политики MFA — ресурса `yandex_organizationmanager_mfa_enforcement`:

     ```hcl
     resource "yandex_organizationmanager_mfa_enforcement" "example_mfa_policy" {
       name            = "<имя_политики>"
       organization_id = "<идентификатор_организации>"
       acr_id          = "<тип_фактора_аутентификации>"
       ttl             = "<время_жизни>"
       enroll_window   = "<срок_создания>"
       sspr_policies   = ["two-any", "mfa"]
     }
     ```

     `sspr_policies` — список разрешенных [способов сброса пароля](../concepts/sspr.md#reset-methods). Укажите одно или оба значения:

     * `two-any` — подтверждение личности с помощью двух любых факторов MFA.
     * `mfa` — подтверждение личности с помощью FIDO2-ключа или Passkey с обязательной локальной проверкой пользователя (User Verification), например с помощью PIN-кода или биометрии.

     Чтобы отключить самостоятельный сброс пароля, задайте пустой список: `sspr_policies = []`.

     Сохраните остальные параметры политики без изменений. Подробнее о параметрах ресурса `yandex_organizationmanager_mfa_enforcement` читайте в [документации провайдера](../../terraform/resources/organizationmanager_mfa_enforcement.md).

     Если политика создана не в Terraform, сначала добавьте ее описание в конфигурационный файл с текущими значениями параметров и импортируйте ее в состояние Terraform:

     ```bash
     terraform init
     terraform import yandex_organizationmanager_mfa_enforcement.example_mfa_policy <идентификатор_политики>
     ```

     Если политики MFA еще нет, [создайте](mfa/create-policy.md) ее и [добавьте пользователей в целевую группу](mfa/add-users.md).

  1. Примените изменения:

     1. В терминале перейдите в директорию с конфигурационным файлом.
     1. Проверьте корректность конфигурации с помощью команды:
     
        ```bash
        terraform validate
        ```
     
        Если конфигурация является корректной, появится сообщение:
     
        ```bash
        Success! The configuration is valid.
        ```
     
     1. Выполните команду:
     
        ```bash
        terraform plan
        ```
     
        В терминале будет выведен список планируемых изменений: ресурсы и/или выходные переменные. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
     1. Примените изменения конфигурации:
     
        ```bash
        terraform apply
        ```
     
     1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

- API {#api}

    Воспользуйтесь методом REST API [update](../api-ref/MfaEnforcement/update.md) для ресурса [MfaEnforcement](../api-ref/MfaEnforcement/index.md) или вызовом gRPC API [MfaEnforcementService/Update](../api-ref/grpc/MfaEnforcement/update.md).

{% endlist %}

#### Полезные ссылки {#see-also}

* [Самостоятельный сброс пароля пользователем в Yandex Identity Hub](../concepts/sspr.md)
* [Многофакторная аутентификация в Yandex Identity Hub](../concepts/mfa.md)
* [Сбросить пароль для входа в консоль управления Yandex Cloud](user-account/reset-password.md)