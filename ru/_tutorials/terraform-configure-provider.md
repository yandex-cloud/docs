{% note info %}

Настройки применимы для Terraform `0.13` и более поздних версий.

{% endnote %}


1. Укажите источник, из которого будет устанавливаться провайдер.
   
   {% list tabs %}

   - Linux и MacOS
     
     Откройте файл конфигурации Terraform CLI: 

     ```
     nano ~/.terraformrc
     ```

   - Windows

     Откройте файл конфигурации Terraform CLI `terraform.rc` в папке `%APPDATA%` вашего пользователя.

   {% endlist %} 

   Добавьте в него следующий блок:


   ```
   provider_installation {
     network_mirror {
       url = "https://terraform-mirror.yandexcloud.net/"
       include = ["registry.terraform.io/*/*"]
     }
     direct {
       exclude = ["registry.terraform.io/*/*"]
     }
   }
   ```

   Подробнее о настройках зеркал см. в [документации](https://www.terraform.io/cli/config/config-file#explicit-installation-method-configuration).

1. В начале конфигурационного файла `.tf` добавьте следующие блоки:

   ```hcl
   terraform {
     required_providers {
       yandex = {
         source = "yandex-cloud/yandex"
       }
     }
     required_version = ">= 0.13"
   }

   provider "yandex" {
     token     = "<OAuth>"
     cloud_id  = "<идентификатор облака>"
     folder_id = "<идентификатор каталога>"
     zone      = "<зона доступности по умолчанию>"
   }
   ```

   * `source` — глобальный [адрес источника](https://www.terraform.io/docs/language/providers/requirements.html#source-addresses) провайдера.
   * `version` — минимальная версия провайдера, с которой совместим модуль. Номер версии можно посмотреть на [странице провайдера]({{ tf-provider-link }}) (кнопка **USE PROVIDER** в верхнем правом углу).
   * `provider` — название провайдера.
   * `token` — [OAuth-токен](../iam/concepts/authorization/oauth-token.md) для доступа к {{ yandex-cloud }}.
   * `cloud_id` — идентификатор облака, в котором Terraform создаст ресурсы.
   * `folder_id` — [идентификатор каталога](../resource-manager/operations/folder/get-id.md), в котором по умолчанию будут создаваться ресурсы.
   * `zone` — [зона доступности](../overview/concepts/geo-scope.md), в которой по умолчанию будут создаваться все облачные ресурсы.

2. Если раньше у вас был настроен провайдер из реестра Hashicorp, удалите его настройки:

   ```
   rm -rf .terraform*
   ```

3. Выполните команду `terraform init` в папке с конфигурационным файлом `.tf`. Эта команда инициализирует провайдеров, указанных в конфигурационных файлах, и позволяет работать с ресурсами и источниками данных провайдера.

Если провайдер не установился, создайте обращение в [поддержку](https://console.cloud.yandex.ru/support?section=contact) с именем и версией провайдера.

Если вы использовали файл `.terraform.lock.hcl`, то перед инициализацией выполните команду `terraform providers lock`, указав адрес зеркала, откуда будет загружаться провайдер, и платформы, на которых будет использоваться конфигурация:

```
terraform providers lock -net-mirror=https://terraform-mirror.yandexcloud.net -platform=linux_amd64 -platform=darwin_arm64 yandex-cloud/yandex
```

Если вы использовали модули, то сначала выполните `terraform init`, затем удалите lock-файл, а затем выполните команду `terraform providers lock`.

