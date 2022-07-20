{% note info %}

Настройки применимы для {{ TF }} `0.13` и более поздних версий.

{% endnote %}

{% if product == "yandex-cloud" %}
1. Если раньше у вас был настроен провайдер из реестра Hashicorp, сохраните его настройки:

   {% list tabs %}
   
   - Linux и macOS
   
     ```bash
     mv ~/.terraformrc ~/.terraformrc.old
     ```
     
   - Windows
   
     ```powershell
     mv $env:APPDATA/terraform.rc $env:APPDATA/terraform.rc.old
     ```
     
   {% endlist %}
   
1. Укажите источник, из которого будет устанавливаться провайдер.
   
   {% list tabs %}

   - Linux и macOS
     
     Откройте файл конфигурации {{ TF }} CLI: 

     ```
     nano ~/.terraformrc
     ```

   - Windows

     Откройте файл конфигурации {{ TF }} CLI `terraform.rc` в папке `%APPDATA%` вашего пользователя.

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
{% endif %}

1. В начале конфигурационного файла `.tf` добавьте следующие блоки:
   
   {% if product == "yandex-cloud" %}
   
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
   
   {% endif %}

   {% if product == "cloud-il" %}

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
     endpoint  = "{{ api-host }}:443"
     token     = "<статический ключ сервисного аккаунта>"
     cloud_id  = "<идентификатор облака>"
     folder_id = "<идентификатор каталога>"
     zone      = "<зона доступности по умолчанию>"
   }
   ```

   {% endif %}

   Где:

   * `source` — глобальный [адрес источника](https://www.terraform.io/docs/language/providers/requirements.html#source-addresses) провайдера.
   * `version` — минимальная версия провайдера, с которой совместим модуль. Номер версии можно посмотреть на [странице провайдера]({{ tf-provider-link }}) (кнопка **USE PROVIDER** в верхнем правом углу).
   * `provider` — название провайдера.
   {% if product == "cloud-il" %}* `endpoint` — доменное имя и порт для запросов к API {{ yandex-cloud }}: `{{ api-host }}:443`.{% endif %}
   * `token` — {% if product == "yandex-cloud" %}[OAuth-токен](../iam/concepts/authorization/oauth-token.md){% endif %}{% if product == "cloud-il" %}статический ключ (`secret`) сервисного аккаунта{% endif %} для доступа к {{ yandex-cloud }}.
   * `cloud_id` — идентификатор облака, в котором {{ TF }} создаст ресурсы.
   * `folder_id` — [идентификатор каталога](../resource-manager/operations/folder/get-id.md), в котором по умолчанию будут создаваться ресурсы.
   * `zone` — [зона доступности](../overview/concepts/geo-scope.md), в которой по умолчанию будут создаваться все облачные ресурсы.

1. Выполните команду `terraform init` в папке с конфигурационным файлом `.tf`. Эта команда инициализирует провайдеров, указанных в конфигурационных файлах, и позволяет работать с ресурсами и источниками данных провайдера.

Если провайдер не установился, создайте обращение в [поддержку]({{ link-console-support }}?section=contact) с именем и версией провайдера.

{% if product == "yandex-cloud" %}

Если вы использовали файл `.terraform.lock.hcl`, то перед инициализацией выполните команду `terraform providers lock`, указав адрес зеркала, откуда будет загружаться провайдер, и платформы, на которых будет использоваться конфигурация:

```
terraform providers lock -net-mirror=https://terraform-mirror.yandexcloud.net -platform=linux_amd64 -platform=darwin_arm64 yandex-cloud/yandex
```

Если вы использовали модули, то сначала выполните `terraform init`, затем удалите lock-файл, а затем выполните команду `terraform providers lock`.

{% endif %}
