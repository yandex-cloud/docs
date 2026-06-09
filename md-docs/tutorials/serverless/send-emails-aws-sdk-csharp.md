# Отправка писем с помощью AWS SDK для платформы .NET Core

В этом руководстве вы научитесь отправлять электронные письма через {{ postbox-full-name }} с использованием [AWS SDK для .NET Core](https://docs.aws.amazon.com/sdk-for-net/v4/developer-guide/net-dg-sdk-features.html).

Чтобы начать отправлять электронные письма:

1. [Подготовьте облако к работе](#before-begin).
1. [Настройте директорию для аутентификационных данных](#auth).
1. [Создайте и запустите приложение](#app).
1. [Проверьте результат](#check-result).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Подготовьте облако к работе {#before-begin}

Зарегистрируйтесь в {{ yandex-cloud }} и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или зарегистрируйтесь.
1. На странице **[{{ ui-key.yacloud_billing.billing.label_service }}]({{ link-console-billing }})** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака]({{ link-console-cloud }}).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).


### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входят:

* плата за использование {{ postbox-full-name }} (см. [тарифы {{ postbox-name }}](../../postbox/pricing.md));
* плата за публичные [DNS-запросы](../../glossary/dns.md) и [зоны DNS](../../dns/concepts/dns-zone.md), если вы создаете ресурсную запись в {{ dns-name }} (см. [тарифы {{ dns-name }}](../../dns/pricing.md)).


### Подготовьте ресурсы {#infrastructure}

1. [Создайте](../../iam/operations/sa/create.md) сервисный аккаунт.
1. [Назначьте](../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту [роль](../../postbox/security/index.md#postbox-sender) `postbox.sender`.
1. [Создайте](../../iam/operations/authentication/manage-access-keys.md) статический ключ доступа для сервисного аккаунта. Сохраните идентификатор и секретный ключ.
1. [Создайте](../../postbox/operations/create-address.md) адрес.
1. [Пройдите](../../postbox/operations/check-domain.md) проверку владения доменом.


## Настройте директорию для аутентификационных данных {#auth}

1. Создайте директорию для хранения аутентификационных данных и перейдите в нее: 

    Для macOS и Linux:

    ```bash
    mkdir ~/.aws/
    ```

    Для Windows:

    ```bash
    mkdir C:\Users\<имя_пользователя>\.aws\
    ```

1. В директории `.aws` создайте файл `credentials` и скопируйте в него аутентификационные данные, полученные при [создании статического ключа доступа](#infrastructure):

    ```text
    [default]
    aws_access_key_id = <идентификатор_статического_ключа>
    aws_secret_access_key = <секретный_ключ>
    ```

1. Создайте файл `config` с параметрами региона по умолчанию и скопируйте в него следующую информацию:

    ```text
    [default]
    region = {{ region-id }}
    endpoint_url = https://{{ postbox-host }}
    ```


### Использование переменных окружения {#variables}

AWS SDK по умолчанию использует аутентификационные данные из переменных окружения, если они заданы. Эти переменные имеют приоритет над аутентификационными данными, которые указаны в файле `.aws/credentials`.

Поддерживаются следующие переменные окружения:

* `AWS_ACCESS_KEY_ID` — идентификатор статического ключа;
* `AWS_SECRET_ACCESS_KEY` — секретный ключ.

Чтобы задать переменные окружения, выполните следующие действия в зависимости от вашей операционной системы:

{% list tabs group=operating_system %}

- Linux/macOS

    В терминале выполните команду:

    ```bash
    export AWS_ACCESS_KEY_ID=<идентификатор_статического_ключа>
    export AWS_SECRET_ACCESS_KEY=<секретный_ключ>
    ```

- Windows

    В PowerShell выполните команду:

    ```powershell
    $Env:AWS_ACCESS_KEY_ID=<идентификатор_статического_ключа>
    $Env:AWS_SECRET_ACCESS_KEY=<секретный_ключ>
    ```

{% endlist %}


## Создайте и запустите приложение {#app}

1. Получите код приложения:

    {% list tabs %}

    - Репозиторий

      1. Склонируйте репозиторий:
         
         ```bash
         git clone https://github.com/yandex-cloud-examples/yc-postbox-examples
         ```
      1. Перейдите в папку в склонированном репозитории `csharp/Postbox/Postbox/`.
      1. В файле `Program.cs` укажите данные:
         
         * В поле `ToAddresses` — электронную почту получателя. Например: `receiver@yourdomain.com`. Далее для проверки вам потребуется доступ к этой электронной почте.
         * В поле `FromEmailAddress` — электронную почту отправителя.
         
             Домен электронной почты отправителя должен совпадать с указанным в адресе {{ postbox-short-name }}, созданном при [подготовке к работе](#infrastructure). Например, если домен, на который вы подтвердили владение, — `yourdomain.com`, можно указать электронную почту `noreply@yourdomain.com` или `admin@yourdomain.com`, а `user@mail.yourdomain.com` — нельзя.

    - Вручную

      1. Создайте папку `postbox-csharp` и перейдите в нее.
      1. Создайте файл `Program.cs` и вставьте в него код:

          ```csharp
          using Amazon.Runtime;
          using Amazon.SimpleEmailV2;
          using Amazon.SimpleEmailV2.Model;

          var client = new AmazonSimpleEmailServiceV2Client(
              new AmazonSimpleEmailServiceV2Config
              {
                  ServiceURL = "{{ postbox-endpoint }}",
                  SignatureMethod = SigningAlgorithm.HmacSHA256,
                  SignatureVersion = "4",
                  AuthenticationRegion = "{{ region-id }}",
              }
          );

          try
          {
              var response = await client.SendEmailAsync(
                  new SendEmailRequest
                  {
                      Destination = new Destination
                      {
                          ToAddresses = ["<адрес_получателя>"]
                      },
                      Content = new EmailContent
                      {
                          Simple = new Message
                          {
                              Body = new Body
                              {
                                  Text = new Content
                                  {
                                      Charset = "UTF-8",
                                      Data = "Hello, world!"
                                  }
                              },
                              Subject = new Content
                              {
                                  Charset = "UTF-8",
                                  Data = "Test email"
                              }
                          }
                      },
                      FromEmailAddress = "<адрес_отправителя>"
                  });

              Console.Write(response.MessageId);
          }
          catch (Exception ex)
          {
              // Логирование исключений в формате JSON
              Console.WriteLine(ex);
          }
          ```

      1. В файле `Program.cs` укажите данные:
         
         * В поле `ToAddresses` — электронную почту получателя. Например: `receiver@yourdomain.com`. Далее для проверки вам потребуется доступ к этой электронной почте.
         * В поле `FromEmailAddress` — электронную почту отправителя.
         
             Домен электронной почты отправителя должен совпадать с указанным в адресе {{ postbox-short-name }}, созданном при [подготовке к работе](#infrastructure). Например, если домен, на который вы подтвердили владение, — `yourdomain.com`, можно указать электронную почту `noreply@yourdomain.com` или `admin@yourdomain.com`, а `user@mail.yourdomain.com` — нельзя.
      1. Создайте файл `Postbox.csproj` и вставьте в него код:

          ```xml
          <Project Sdk="Microsoft.NET.Sdk">

              <PropertyGroup>
                  <OutputType>Exe</OutputType>
                  <TargetFramework>net8.0</TargetFramework>
                  <ImplicitUsings>enable</ImplicitUsings>
                  <Nullable>enable</Nullable>
              </PropertyGroup>

              <ItemGroup>
                <PackageReference Include="AWSSDK.SimpleEmailV2" Version="3.7.408.17" />
              </ItemGroup>

          </Project>
          ```

      1. Создайте файл `Postbox.sln` и вставьте в него код:

          ```text
          Microsoft Visual Studio Solution File, Format Version 12.00
          Project("{FAE04EC0-301F-11D3-BF4B-00C04F79EFBC}") = "Postbox", "Postbox\Postbox.csproj", "{51272D55-8BA2-4072-9445-889E627E605D}"
          EndProject
          Global
            GlobalSection(SolutionConfigurationPlatforms) = preSolution
              Debug|Any CPU = Debug|Any CPU
              Release|Any CPU = Release|Any CPU
            EndGlobalSection
            GlobalSection(ProjectConfigurationPlatforms) = postSolution
              {51272D55-8BA2-4072-9445-889E627E605D}.Debug|Any CPU.ActiveCfg = Debug|Any CPU
              {51272D55-8BA2-4072-9445-889E627E605D}.Debug|Any CPU.Build.0 = Debug|Any CPU
              {51272D55-8BA2-4072-9445-889E627E605D}.Release|Any CPU.ActiveCfg = Release|Any CPU
              {51272D55-8BA2-4072-9445-889E627E605D}.Release|Any CPU.Build.0 = Release|Any CPU
            EndGlobalSection
          EndGlobal
          ```

    {% endlist %}

  1. Запустите приложение:

      ```bash
      dotnet run
      ```

      Результат:

      ```text
      DB42OLB6KLNJ.7VDE********@ingress2-klg
      ```


## Проверьте результат {#check-result}

Убедитесь, что на адрес получателя, заданный в файле `Program.cs` в поле `ToAddresses`, пришло письмо с указанными параметрами.


## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

1. Удалите [адрес](../../postbox/concepts/glossary.md#adress).
1. [Удалите](../../dns/operations/zone-delete.md) зону DNS, если создавали в ней ресурсную запись.