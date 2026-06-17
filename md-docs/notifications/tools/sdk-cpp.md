# Как начать работать с AWS SDK для С++ в Yandex Cloud Notification Service

{% note info %}

Сервис находится на [стадии Preview](../../overview/concepts/launch-stages.md).

{% endnote %}

Чтобы начать работу с AWS SDK для С++:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Получите статический ключ доступа](#static-key).
1. [Настройте AWS SDK](#aws-sdk).
1. [Создайте канал уведомлений](#create-channel).
1. [Получите список каналов](#list-channel).
1. [Создайте эндпоинт](#create-endpoint).
1. [Отправьте уведомление](#publish).


## Подготовьте облако к работе {#before-you-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).


## Получите статический ключ доступа {#static-key}

Для аутентификации в Cloud Notification Service используется [статический ключ доступа](../../iam/concepts/authorization/access-key.md). Этот ключ выпускается на [сервисный аккаунт](../../iam/concepts/users/service-accounts.md), и все действия выполняются от имени этого сервисного аккаунта.

Чтобы получить статический ключ доступа:
1. [Создайте](../../iam/operations/sa/create.md) сервисный аккаунт.
1. [Назначьте](../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту [роль](../../iam/roles-reference.md#editor) `editor` на каталог.
1. Для сервисного аккаунта [создайте](../../iam/operations/authentication/manage-access-keys.md#create-access-key) статический ключ доступа.

    Сохраните идентификатор и секретный ключ.


## Настройте AWS SDK {#aws-sdk}

Чтобы получить AWS SDK для C++, [скомпилируйте и соберите](https://docs.aws.amazon.com/sdk-for-cpp/v1/developer-guide/sdk-from-source.html) исходный код или [установите](https://docs.aws.amazon.com/sdk-for-cpp/v1/developer-guide/sdk-from-pm.html) пакет с помощью пакетного менеджера.

Ниже приведена инструкция по сборке и установке исходных файлов на Linux и macOS.

Для Windows см. [документацию AWS](https://docs.aws.amazon.com/sdk-for-cpp/v1/developer-guide/setup-windows.html).

Пререквизиты и инструкция также описаны в [документации AWS](https://docs.aws.amazon.com/sdk-for-cpp/v1/developer-guide/welcome.html).

### Подготовьте ОС к работе {#prepare-os}

Для работы с AWS SDK для С++ потребуется:

* [GCC](https://gcc.gnu.org/gcc-4.9/) 4.9 или выше;
* [Clang](https://releases.llvm.org/3.3/tools/clang/docs/ReleaseNotes.html) 3.3 или выше;
* [CMake](https://cmake.org/) версии 3.13 или выше.

Для Linux дополнительно установите dev-пакеты для библиотек `libcurl`, `libopenssl`, `libuuid` и `zlib`:

{% list tabs group=operating_system %}

- Debian/Ubuntu {#ubuntu}

  ```bash
  sudo apt-get install libcurl4-openssl-dev libssl-dev uuid-dev zlib1g-dev
  ```

- CentOS/Fedora/Red Hat {#centos}

  ```bash
  sudo yum install libcurl-devel openssl-devel libuuid-devel
  ```

{% endlist %}


### Установите AWS SDK для С++ {#install-sdk}

1. Создайте директорию для хранения исходных файлов и перейдите в нее:

    ```bash
    mkdir -p ~/dev/aws-sdk-cpp
    cd ~/dev/aws-sdk-cpp
    ```

1. Получите исходные файлы:

    ```bash
    git clone --recurse-submodules https://github.com/aws/aws-sdk-cpp
    ```

1. Создайте директорию для сборки и перейдите в нее:

    ```bash
    mkdir ~/aws-sdk-build
    cd ~/aws-sdk-build
    ```

1. Сгенерируйте файлы для сборки:

    ```bash
    cmake ~/dev/aws-sdk-cpp/aws-sdk-cpp -DCMAKE_BUILD_TYPE=Debug -DCMAKE_PREFIX_PATH=/usr/local/ -DCMAKE_INSTALL_PREFIX=/usr/local/ -DBUILD_ONLY="sns"
    ```

1. Соберите и установите SDK:

    ```bash
    make
    make install
    ```


### Создайте приложение {#create-app}

1. Создайте проект:

   ```bash
   mkdir -p ~/example-app
   cd ~/example-app
   ```

1. Создайте файл cmake `CMakeLists.txt` и добавьте в него следующее содержимое:

    ```text
    cmake_minimum_required(VERSION 3.13)

    # Set the AWS service components used by this project.
    set(SERVICE_COMPONENTS sns)
    
    # Set this project's name.
    project("example_app")
    
    # Set the C++ standard to use to build this target.
    # At least C++ 11 is required for the AWS SDK for C++.
    set(CMAKE_CXX_STANDARD 11)
    
    # Use the MSVC variable to determine if this is a Windows build.
    set(WINDOWS_BUILD ${MSVC})
    
    if (WINDOWS_BUILD) # Set the location where CMake can find the installed libraries for the AWS SDK.
        string(REPLACE ";" "/aws-cpp-sdk-all;" SYSTEM_MODULE_PATH "${CMAKE_SYSTEM_PREFIX_PATH}/aws-cpp-sdk-all")
        list(APPEND CMAKE_PREFIX_PATH ${SYSTEM_MODULE_PATH})
    endif ()
    
    # Find the AWS SDK for C++ package.
    find_package(AWSSDK REQUIRED COMPONENTS ${SERVICE_COMPONENTS})
    
    if (WINDOWS_BUILD AND AWSSDK_INSTALL_AS_SHARED_LIBS)
        # Copy relevant AWS SDK for C++ libraries into the current binary directory for running and debugging.
    
        # set(BIN_SUB_DIR "/Debug") # If you are building from the command line you may need to uncomment this
        # and set the proper subdirectory to the executables' location.
    
        AWSSDK_CPY_DYN_LIBS(SERVICE_COMPONENTS "" ${CMAKE_CURRENT_BINARY_DIR}${BIN_SUB_DIR})
    endif ()
    
    add_executable(${PROJECT_NAME}
            example_app.cpp)
    
    target_link_libraries(${PROJECT_NAME}
            ${AWSSDK_LINK_LIBRARIES})
    ```

1. Создайте файл проекта `example_app.cpp` и добавьте в него следующее содержимое:

    ```cpp
    #include <aws/core/Aws.h>
    #include <aws/core/auth/AWSCredentials.h>
    #include <aws/sns/SNSClient.h>
    #include <iostream>
    
    int main(int argc, char **argv) {
        std::string endpoint = "https://notifications.yandexcloud.net/";
        std::string accessKeyId = "<идентификатор_статического_ключа>";
        std::string secretKey = "<секретный_ключ>";
        std::string region = "ru-central1";

        Aws::SDKOptions options;
        Aws::InitAPI(options); // Should only be called once.
        {
            Aws::Auth::AWSCredentials credentials(accessKeyId, secretKey);

            Aws::Client::ClientConfiguration clientConfig;
            clientConfig.endpointOverride = endpoint;
            clientConfig.region = region;

            Aws::SNS::SNSClient snsClient(credentials, clientConfig);
        }

        Aws::ShutdownAPI(options); // Should only be called once.
        return 0;
    }
    ```

    Где:

    * `accessKeyId` — идентификатор статического ключа.
    * `secretKey` — секретный ключ.

1. Создайте директорию для сборки:

    ```bash
    cd ~/example-app
    mkdir build
    cd build
    ```

1. Сконфигурируйте `cmake` и соберите проект:

    ```bash
    cmake ..
    cmake --build .
    ```

Смотрите также [официальный пример Hello SNS](https://github.com/awsdocs/aws-doc-sdk-examples/tree/main/cpp/example_code/sns/hello_sns).


## Создайте канал уведомлений {#create-channel}

```cpp
try {
    Aws::SNS::Model::CreatePlatformApplicationRequest request;
    request.SetName("<имя_канала>");
    request.SetPlatform("<тип_платформы>");

    Aws::Map<Aws::String, Aws::String> attributes;
    attributes["<тип_аутентификации>"] = "<ключ>";
    request.SetAttributes(attributes);

    auto outcome = snsClient.CreatePlatformApplication(request);

    if (outcome.IsSuccess()) {
        std::cout << "Platform application ARN: " << outcome.GetResult().GetPlatformApplicationArn() << std::endl;
    } else {
        std::cerr << "Error creating platform application: " << outcome.GetError().GetMessage() << std::endl;
    }
} catch (std::exception &ex) {
    std::cerr << "Exception occurred: " << ex.what() << std::endl;
}
```

Где:

* `SetName` — имя канала уведомлений, задается пользователем.

    Имя должно быть уникальным для всего CNS. После создания канала изменить имя нельзя. Имя может содержать строчные и заглавные буквы латинского алфавита, цифры, подчеркивания, дефисы и точки. Длина — от 1 до 256 символов. Рекомендуется для каналов APNs указывать в имени идентификатор приложения (Bundle ID), для FCM и HMS — полное название пакета приложения (Package name), для RuStore — значение `packageName`.

* `SetPlatform` — тип мобильной платформы:

    * `APNS` и `APNS_SANDBOX` — Apple Push Notification service (APNs). Для тестирования приложения используйте `APNS_SANDBOX`.
    * `GCM` — Firebase Cloud Messaging (FCM).
    * `HMS` — Huawei Mobile Services (HMS).
    * `RUSTORE` — RuStore Android.

* `attributes` — параметры аутентификации на мобильной платформе в формате `ключ=значение`. Значения зависят от типа платформы:

    * APNs:
    
        * Аутентификация с токеном:
    
            * `PlatformPrincipal` — путь к файлу с ключом подписи токена, полученный в Apple.
            * `PlatformCredential` — идентификатор ключа подписи (Key ID).
            * `ApplePlatformTeamID` — идентификатор разработчика (Team ID).
            * `ApplePlatformBundleID` — идентификатор приложения (Bundle ID).
    
        * Аутентификация с сертификатом:
    
            * `PlatformPrincipal` — SSL-сертификат в формате `.pem`.
            * `PlatformCredential` — закрытый ключ сертификата в формате `.pem`.
    
                Чтобы сохранить сертификат и закрытый ключ в отдельных файлах формата `.pem`, вы можете воспользоваться утилитой [openssl](https://docs.openssl.org/1.1.1/man1/pkcs12) в Linux:
                
                ```bash
                openssl pkcs12 -in Certificates.p12 -nokeys -nodes -out certificate.pem
                openssl pkcs12 -in Certificates.p12 -nocerts -nodes -out privatekey.pem
                ```
    
        Аутентификация с токеном — более современный и безопасный метод.
    
    * FCM: `PlatformCredential` — ключ сервисного аккаунта Google Cloud в формате JSON для аутентификации с помощью HTTP v1 API или API-ключ (server key) для аутентификации с помощью Legacy API.
    
        Используйте HTTP v1 API, так как с июля 2024 года [FCM legacy API не поддерживается](https://firebase.google.com/docs/cloud-messaging/migrate-v1).
    
    * HMS:
    
        * `PlatformPrincipal` — идентификатор ключа.
        * `PlatformCredential` — API-ключ.

В результате вы получите идентификатор (ARN) канала уведомлений.


## Получите список каналов уведомлений {#list-channel}

```cpp
Aws::SNS::Model::ListPlatformApplicationsRequest request;
Aws::SNS::Model::ListPlatformApplicationsOutcome outcome = snsClient.ListPlatformApplications(request);

if (outcome.IsSuccess()) {
    Aws::Vector<Aws::SNS::Model::PlatformApplication> &applications =
        outcome.GetResult().GetPlatformApplications();

    std::cout << "You have " << applications.size() << " platform application"
            << (applications.size() == 1 ? "" : "s") << " in your account." << std::endl;

    if (!applications.empty()) {
        std::cout << "Here are your platform application ARNs:" << std::endl;
        for (const Aws::SNS::Model::PlatformApplication &app : applications) {
            std::cout << "  * " << app.GetPlatformApplicationArn() << std::endl;
        }
    }
} else {
    std::cerr << "Error listing platform applications: " << outcome.GetError().GetMessage() << std::endl;
}
```

В результате будет выведен список каналов уведомлений, размещенных в том же каталоге, в котором находится сервисный аккаунт.


## Создайте эндпоинт {#create-endpoint}

```cpp
try {
    std::string appArn = "<ARN_канала_уведомлений>";
    std::string token = "<Push-токен>";

    Aws::SNS::Model::CreatePlatformEndpointRequest request;
    request.SetPlatformApplicationArn(appArn);
    request.SetToken(token);

    auto outcome = snsClient.CreatePlatformEndpoint(request);

    if (outcome.IsSuccess()) {
        std::cout << "Endpoint ARN: " << outcome.GetResult().GetEndpointArn() << std::endl;
    } else {
        std::cerr << "Error creating platform endpoint: " << outcome.GetError().GetMessage() << std::endl;
    }
} catch (std::exception &ex) {
    std::cerr << "Exception occurred: " << ex.what() << std::endl;
}
```

Где:

* `appArn` — идентификатор (ARN) канала уведомлений.
* `token` — уникальный Push-токен приложения на устройстве пользователя.

В результате вы получите идентификатор (ARN) мобильного эндпоинта.


## Отправьте уведомление {#publish}

### Явные уведомления (Bright Push) {#bright-push}

{% list tabs %}

- Apple iOS (APNs)

  ```cpp
  try {
      std::string targetArn = "<ARN_эндпоинта>";
      std::string message = R"({
          "default": "<текст_уведомления>",
          "APNS": "{\"aps\": {\"alert\": \"<текст_уведомления>\"}}"
      })";
      std::string messageStructure = "json";

      Aws::SNS::Model::PublishRequest request;
      request.SetTargetArn(targetArn);
      request.SetMessage(message);
      request.SetMessageStructure(messageStructure);

      auto outcome = snsClient.Publish(request);

      if (outcome.IsSuccess()) {
          std::cout << "Message ID: " << outcome.GetResult().GetMessageId() << std::endl;
      } else {
          std::cerr << "Error publishing message: " << outcome.GetError().GetMessage() << std::endl;
      }
  } catch (std::exception &ex) {
      std::cerr << "Exception occurred: " << ex.what() << std::endl;
  }
  ```

- Google Android (GCM)

  ```cpp
  try {
      std::string targetArn = "<ARN_эндпоинта>";
      std::string message = R"({
          "default": "<текст_уведомления>",
          "GCM": "{\"notification\": {\"body\": \"<текст_уведомления>\"}}"
      })";
      std::string messageStructure = "json";

      Aws::SNS::Model::PublishRequest request;
      request.SetTargetArn(targetArn);
      request.SetMessage(message);
      request.SetMessageStructure(messageStructure);

      auto outcome = snsClient.Publish(request);

      if (outcome.IsSuccess()) {
          std::cout << "Message ID: " << outcome.GetResult().GetMessageId() << std::endl;
      } else {
          std::cerr << "Error publishing message: " << outcome.GetError().GetMessage() << std::endl;
      }
  } catch (std::exception &ex) {
      std::cerr << "Exception occurred: " << ex.what() << std::endl;
  }
  ```

{% endlist %}

Где:

* `targetArn` — идентификатор (ARN) мобильного эндпоинта.
* `message` — сообщение.
* `messageStructure` — формат сообщения.


### Тихие уведомления (Silent Push) {#silent-push}

{% list tabs %}

- Apple iOS (APNs)

  ```cpp
  try {
      std::string targetArn = "<ARN_эндпоинта>";
      std::string silentMessage = R"({
          "default": "<текст_уведомления>",
          "APNS": "{\"key\": \"value\"}"
      })";
      std::string messageStructure = "json";

      Aws::SNS::Model::PublishRequest request;
      request.SetTargetArn(targetArn);
      request.SetMessage(message);
      request.SetMessageStructure(messageStructure);

      auto outcome = snsClient.Publish(request);

      if (outcome.IsSuccess()) {
          std::cout << "Message ID: " << outcome.GetResult().GetMessageId() << std::endl;
      } else {
          std::cerr << "Error publishing message: " << outcome.GetError().GetMessage() << std::endl;
      }
  } catch (std::exception &ex) {
      std::cerr << "Exception occurred: " << ex.what() << std::endl;
  }
  ```

- Google Android (GCM)

  ```cpp
  try {
      std::string targetArn = "<ARN_эндпоинта>";
      std::string message = R"({
          "default": "<текст_уведомления>",
          "GCM": "{\"data\": {\"key\": \"value\"}}"
      })";
      std::string messageStructure = "json";

      Aws::SNS::Model::PublishRequest request;
      request.SetTargetArn(targetArn);
      request.SetMessage(message);
      request.SetMessageStructure(messageStructure);
      
      auto outcome = snsClient.Publish(request);

      if (outcome.IsSuccess()) {
          std::cout << "Message ID: " << outcome.GetResult().GetMessageId() << std::endl;
      } else {
          std::cerr << "Error publishing message: " << outcome.GetError().GetMessage() << std::endl;
      }
  } catch (std::exception &ex) {
      std::cerr << "Exception occurred: " << ex.what() << std::endl;
  }
  ```

{% endlist %}

Где:

* `targetArn` — идентификатор (ARN) мобильного эндпоинта.
* `message` — сообщение.
* `messageStructure` — формат сообщения.

### SMS-сообщения {#sms-messages}

```cpp
  try {
      std::string phoneNumber = "<номер_телефона>";
      std::string message = "<текст_уведомления>";

      Aws::SNS::Model::PublishRequest request;
      request.SetPhoneNumber(phoneNumber);
      request.SetMessage(message);

      Aws::Map<Aws::String, Aws::SNS::Model::MessageAttributeValue> messageAttributes;
      Aws::SNS::Model::MessageAttributeValue senderIdAttribute;
      senderIdAttribute.SetDataType("String");
      senderIdAttribute.SetStringValue("<текстовое_имя_отправителя>");
      messageAttributes["AWS.SNS.SMS.SenderID"] = senderIdAttribute;
      request.SetMessageAttributes(messageAttributes);

      auto outcome = snsClient.Publish(request);

      if (outcome.IsSuccess()) {
          std::cout << "Message ID: " << outcome.GetResult().GetMessageId() << std::endl;
      } else {
          std::cerr << "Error sending SMS: " << outcome.GetError().GetMessage() << std::endl;
      }
  } catch (std::exception &ex) {
      std::cerr << "Exception occurred: " << ex.what() << std::endl;
  }
  ```

Где:

* `phoneNumber` — номер телефона получателя.
* `message` — текст уведомления.
* `senderIdAttribute.SetStringValue` — текстовое имя отправителя.


## Полезные ссылки {#see-also}

* [Начало работы](../quickstart.md)
* [AWS CLI](aws-cli.md)
* [Концепции](../concepts/index.md)