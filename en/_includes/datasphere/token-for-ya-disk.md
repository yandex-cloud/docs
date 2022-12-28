1. Go to the [app's login page]({{ ya-client-app }}) in Yandex ID and log in.
1. Name the issued token in the **App name** field.
1. Under **Platforms**, select **Web services**.
1. In the **Callback URI** field that appeared, enter the `{{ ya-oauth }}` URL.
1. Under **Access**, expand **Yandex Disk REST API (cloud_api)** and select all the access permissions offered.
1. Click **Create app**.

Save the app ID (`ClientID`) and the secret key (`Client secret`): you will need them to connect to Yandex Disk.