### При работе Container Optimized Image используется шифрование секретов {#secrets-coi}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | high | crypto.secrets-coi ||
|#

#### Описание

{% note tip "**Автоматическая проверка**" %}

Данный контроль автоматически проверяет шифрование секретов в конфигурациях Container Optimized Image.

{% endnote %}

KMS предоставляет возможность шифрования секретов, используемых в конфигурации Terraform, в частности, для передачи секретов на виртуальную машину в зашифрованном виде. См. инструкцию в разделе [Шифрование секретов в HashiCorp Terraform](https://yandex.cloud/ru/docs/kms/tutorials/terraform-secret) документации KMS. Передача секретов через переменные окружения в открытом виде небезопасна, поскольку они отображаются в свойствах ВМ.

#### Инструкции и решения по выполнению

* Шифрование секретов в Terraform для передачи на ВМ с Container Optimized Image: https://github.com/yandex-cloud-examples/yc-encrypt-coi-secrets
* Другие рекомендации по безопасному использованию Terraform см. в статье Безопасная конфигурация: Terraform: https://yandex.cloud/ru/docs/security/standard/virtualenv-safe-config#tf-using