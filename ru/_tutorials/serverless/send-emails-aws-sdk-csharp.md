

В этом руководстве вы научитесь отправлять электронные письма через {{ postbox-full-name }} с использованием [AWS SDK для .NET Core](https://docs.aws.amazon.com/sdk-for-net/v4/developer-guide/net-dg-sdk-features.html).

Чтобы начать отправлять электронные письма:

1. [Подготовьте облако к работе](#before-begin).
1. [Настройте директорию для аутентификационных данных](#auth).
1. [Создайте и запустите приложение](#app).
1. [Проверьте результат](#check-result).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Подготовьте облако к работе {#before-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}


### Необходимые платные ресурсы {#paid-resources}

{% include [paid-resources](../../_includes/postbox/send-emails-aws-sdk/paid-resources.md) %}


### Подготовьте ресурсы {#infrastructure}

{% include [clone-yc-postbox-examples](../../_includes/postbox/send-emails-aws-sdk/send-emails-infrastructure.md) %}


## Настройте директорию для аутентификационных данных {#auth}

{% include [sdk-auth](../../_includes/postbox/send-emails-aws-sdk/auth.md) %}


### Использование переменных окружения {#variables}

{% include [sdk-env-variables](../../_includes/postbox/send-emails-aws-sdk/env-variables.md) %}


## Создайте и запустите приложение {#app}

1. Получите код приложения:

    {% list tabs %}

    - Репозиторий

      1. {% include [clone-yc-postbox-examples](../../_includes/postbox/send-emails-aws-sdk/clone-yc-postbox-examples.md) %}
      1. Перейдите в папку в склонированном репозитории `csharp/Postbox/Postbox/`.
      1. {% include [edit-program-cs](../../_includes/postbox/send-emails-aws-sdk/edit-program-cs.md) %}

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

      1. {% include [edit-program-cs](../../_includes/postbox/send-emails-aws-sdk/edit-program-cs.md) %}
      1. Создайте файл `Postbox.csproj` и вставьте в него код:

          ```
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

* Удалите [адрес](../../postbox/operations/).
* Удалите [зону DNS](../../dns/operations/zone-delete.md), если создавали в ней ресурсную запись.