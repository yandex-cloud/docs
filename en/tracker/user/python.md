# Python client

To help you get started using the [{{ tracker-name }} API](../about.md), we created [yandex_tracker_client](https://github.com/yandex/yandex_tracker_client), a dedicated package that lets you easily add API calls to programs written in Python.

To start using the client:

1. Download and install the newest version of Python from [https://www.python.org/downloads/](https://www.python.org/downloads/).

1. Run the following command in your OS command line:

    ```
    pip install yandex_tracker_client
    ```

1. Receive your OAuth token and organization ID to access the API. To learn more, see the [API reference](../concepts/access.md).

1. Initialize the client in your program's code:

    ```
    from yandex_tracker_client import TrackerClient
    client = TrackerClient(token=<token>, org_id=<org_id>)
    ```

    Here `<token>` is your OAuth token, and `<org_id>` is your organization ID.

In the client, use the same data format as in the [{{ tracker-name }} API](../concepts/access.md).

To learn more about the client and its terms of use, visit the GitHub page: [https://github.com/yandex/yandex_tracker_client](https://github.com/yandex/yandex_tracker_client).

