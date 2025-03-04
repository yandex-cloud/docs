# How to get started with the AWS SDK for C++ in {{ cns-full-name }}

{% include [preview-stage](../../_includes/notifications/preview-stage.md) %}

To get started with the AWS SDK for C++:

1. [Get your cloud ready](#before-you-begin).
1. [Get a static access key](#static-key).
1. [Configure the AWS SDK](#aws-sdk).
1. [Create a notification channel](#create-channel).
1. [Get a list of channels](#list-channel).
1. [Create an endpoint](#create-endpoint).
1. [Send a notification](#publish).


## Get your cloud ready {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}


## Get a static access key {#static-key}

{% include [sa-role-static-key](../../_includes/notifications/sa-role-static-key.md) %}


## Configure the AWS SDK {#aws-sdk}

To get the AWS SDK for C++, [compile and build](https://docs.aws.amazon.com/sdk-for-cpp/v1/developer-guide/sdk-from-source.html) the source code or [install](https://docs.aws.amazon.com/sdk-for-cpp/v1/developer-guide/sdk-from-pm.html) the package using your package manager.

Below is a guide on how to build and install the source files on Linux and macOS.

For Windows, see the relevant [AWS documentation](https://docs.aws.amazon.com/sdk-for-cpp/v1/developer-guide/setup-windows.html).

You can also find the prerequisites and a guide in the [AWS documentation](https://docs.aws.amazon.com/sdk-for-cpp/v1/developer-guide/welcome.html).

### Get your OS ready {#prepare-os}

To use the AWS SDK for C++ you will need:

* [GCC](https://gcc.gnu.org/gcc-4.9/) 4.9 or higher
* [Clang](https://releases.llvm.org/3.3/tools/clang/docs/ReleaseNotes.html) 3.3 or higher
* [CMake](https://cmake.org/) 3.13 or higher

For Linux, additionally install dev packages for the `libcurl`, `libopenssl`, `libuuid`, and `zlib` libraries:

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


### Install AWS SDK for C++ {#install-sdk}

1. Create a directory to store the source files in and navigate to it:

    ```bash
    mkdir -p ~/dev/aws-sdk-cpp
    cd ~/dev/aws-sdk-cpp
    ```

1. Get the source files:

    ```bash
    git clone --recurse-submodules https://github.com/aws/aws-sdk-cpp
    ```

1. Create a directory for your build and navigate to it:

    ```bash
    mkdir ~/aws-sdk-build
    cd ~/aws-sdk-build
    ```

1. Generate files for the build:

    ```bash
    cmake ~/dev/aws-sdk-cpp/aws-sdk-cpp -DCMAKE_BUILD_TYPE=Debug -DCMAKE_PREFIX_PATH=/usr/local/ -DCMAKE_INSTALL_PREFIX=/usr/local/ -DBUILD_ONLY="sns"
    ```

1. Build and install the SDK:

    ```bash
    make
    make install
    ```


### Create an app {#create-app}

1. Create a project:

   ```bash
   mkdir -p ~/example-app
   cd ~/example-app
   ```

1. Create a file named `CMakeLists.txt` and add the following contents to it:

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

1. Create a project file named `example_app.cpp` and add the following contents to it:

    ```cpp
    #include <aws/core/Aws.h>
    #include <aws/core/auth/AWSCredentials.h>
    #include <aws/sns/SNSClient.h>
    #include <iostream>
    
    int main(int argc, char **argv) {
        std::string endpoint = "https://{{ cns-host }}/";
        std::string accessKeyId = "<static_key_ID>";
        std::string secretKey = "<secret_key>";
        std::string region = "{{ region-id }}";

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

    Where:

    * `accessKeyId`: Static key ID
    * `secretKey`: Secret key

1. Create a directory for the build:

    ```bash
    cd ~/example-app
    mkdir build
    cd build
    ```

1. Configure `cmake` and build the project:

    ```bash
    cmake ..
    cmake --build .
    ```

See also the [official Hello SNS example](https://github.com/awsdocs/aws-doc-sdk-examples/tree/main/cpp/example_code/sns/hello_sns).


## Create a notification channel {#create-channel}

```cpp
try {
    Aws::SNS::Model::CreatePlatformApplicationRequest request;
    request.SetName("<channel_name>");
    request.SetPlatform("<platform_type>");

    Aws::Map<Aws::String, Aws::String> attributes;
    attributes["<authentication_type>"] = "<key>";
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

Where:

* `SetName`: Notification channel name, user-defined. The name must be unique within the [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud). It may contain lowercase and uppercase Latin letters, numbers, underscores, hyphens, and periods. It may be from 1 to 256 characters long. For APNs channels, we recommend specifying the bundle ID in the name, and for FCM and HMS, the full package name.
* `SetPlatform`: Mobile platform type:

    {% include [platform-types](../../_includes/notifications/platform-types.md) %}

* `attributes`: Mobile platform authentication parameters in `key=value` format. The values depend on platform:

    {% include [auth-attributes](../../_includes/notifications/auth-attributes.md) %}

As a result, you will get a notification channel ID (ARN).


## Get a list of notification channels {#list-channel}

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

You will get the list of notification channels located in the same folder as the service account.


## Create an endpoint {#create-endpoint}

```cpp
try {
    std::string appArn = "<notification_channel_ARN>";
    std::string token = "<push_token>";

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

Where:

* `appArn`: Notification channel ID (ARN).
* `token`: Unique push token for the application on the user’s device.

As a result, you will get a mobile endpoint ID (ARN).


## Send a notification {#publish}

### Explicit notifications (Bright Push) {#bright-push}

{% list tabs %}

- Apple iOS (APNs)

  ```cpp
  try {
      std::string targetArn = "<endpoint_ARN>";
      std::string message = R"({
          "default": "<notification_text>",
          "APNS": "{\"aps\": {\"alert\": \"<notification_text>\"}}"
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
      std::string targetArn = "<endpoint_ARN>";
      std::string message = R"({
          "default": "<notification_text>",
          "GCM": "{\"notification\": {\"body\": \"<notification_text>\"}}"
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

Where:

* `targetArn`: Mobile endpoint ID (ARN)
* `message`: Message
* `messageStructure`: Message format


### Silent notifications (Silent Push) {#silent-push}

{% list tabs %}

- Apple iOS (APNs)

  ```cpp
  try {
      std::string targetArn = "<endpoint_ARN>";
      std::string silentMessage = R"({
          "default": "<notification_text>",
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
      std::string targetArn = "<endpoint_ARN>";
      std::string message = R"({
          "default": "<notification_text>",
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

Where:

* `targetArn`: Mobile endpoint ID (ARN)
* `message`: Message
* `messageStructure`: Message format

### Text message {#sms-messages}

```cpp
  try {
      std::string phoneNumber = "<phone_number>";
      std::string message = "<notification_text>";

      Aws::SNS::Model::PublishRequest request;
      request.SetPhoneNumber(phoneNumber);
      request.SetMessage(message);

      Aws::Map<Aws::String, Aws::SNS::Model::MessageAttributeValue> messageAttributes;
      Aws::SNS::Model::MessageAttributeValue senderIdAttribute;
      senderIdAttribute.SetDataType("String");
      senderIdAttribute.SetStringValue("<sender's_text_name>");
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

Where:

* `phoneNumber`: Recipient's phone number
* `message`: Notification text
* `senderIdAttribute.SetStringValue`: Sender's text name


## See also {#see-also}

* [Getting started](../quickstart.md)
* [AWS CLI](aws-cli.md)
* [Concepts](../concepts/index.md)