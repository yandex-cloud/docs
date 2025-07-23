

In this tutorial, you will learn how to send emails via {{ postbox-full-name }} using the [AWS SDK for .Net Core](https://docs.aws.amazon.com/sdk-for-net/v4/developer-guide/net-dg-sdk-features.html).

To start sending emails:

1. [Get your cloud ready](#before-begin).
1. [Configure a directory for authentication data](#auth).
1. [Create and run the application](#app).
1. [Check the result](#check-result).

If you no longer need the resources you created, [delete them](#clear-out).


## Get your cloud ready {#before-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

{% include [paid-resources](../../_includes/postbox/send-emails-aws-sdk/paid-resources.md) %}


### Set up resources {#infrastructure}

{% include [clone-yc-postbox-examples](../../_includes/postbox/send-emails-aws-sdk/send-emails-infrastructure.md) %}


## Configure a directory for authentication data {#auth}

{% include [sdk-auth](../../_includes/postbox/send-emails-aws-sdk/auth.md) %}


### Using environment variables {#variables}

{% include [sdk-env-variables](../../_includes/postbox/send-emails-aws-sdk/env-variables.md) %}


## Create and run the application {#app}

1. Get the application code:

    {% list tabs %}

    - Repository

      1. {% include [clone-yc-postbox-examples](../../_includes/postbox/send-emails-aws-sdk/clone-yc-postbox-examples.md) %}
      1. Navigate to the folder in the cloned `csharp/Postbox/Postbox/` repository.
      1. {% include [edit-program-cs](../../_includes/postbox/send-emails-aws-sdk/edit-program-cs.md) %}

    - Manually

      1. Create a directory named `postbox-csharp` and open it.
      1. Create a file named `Program.cs` and paste this code into it:

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
                          ToAddresses = ["<recipient_address>"]
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
                      FromEmailAddress = "<sender_address>"
                  });

              Console.Write(response.MessageId);
          }
          catch (Exception ex)
          {
              // Logging exceptions in JSON format
              Console.WriteLine(ex);
          }
          ```

      1. {% include [edit-program-cs](../../_includes/postbox/send-emails-aws-sdk/edit-program-cs.md) %}
      1. Create a file named `Postbox.csproj` and paste this code into it:

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

      1. Create a file named `Postbox.sln` and paste this code into it:

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

  1. Run the application:

      ```bash
      dotnet run
      ```

      Result:

      ```text
      DB42OLB6KLNJ.7VDE********@ingress2-klg
      ```


## Check the result {#check-result}

Make sure the recipient specified in the file named `Program.cs` in the `ToAddresses` field has received an email with the specified parameters.


## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:

* Delete the [address](../../postbox/operations/).
* Delete the [DNS zone](../../dns/operations/zone-delete.md) if you had created a resource record in it.