# Python client

To help you get started using the [{{ tracker-name }} API](../about-api.md), we created {% if audience == "external" %}[yandex_tracker_client](https://github.com/yandex/yandex_tracker_client){% else %}[startrek_client](https://pypi.yandex-team.ru/dashboard/repositories/default/packages/startrek_client/){% endif %}, a dedicated package that lets you easily add API calls to programs written in Python.

To start using the client:

1. Download and install the latest Python version from [https://www.python.org/downloads/](https://www.python.org/downloads/).

1. Run the following command in your OS command line:

    {% if audience == "external" %}

    ```
    pip install yandex_tracker_client
    ```

    {% else %}

    ```
    pip install -i https://pypi.yandex-team.ru/simple/ startrek_client
    ```

    or

    ```
    pip install git+git://github.yandex-team.ru/tools/startrek-python-client.git
    ```

    {% endif %}

{% if audience == "external" %}

1. Receive your OAuth token and organization ID to access the API. For more information about how to do this, see the [API reference](../concepts/access.md).

1. Initialize the client in your program's code:

    ```
    from yandex_tracker_client import TrackerClient
    client = TrackerClient(token='<token>', org_id='<org_id>')
    ```

    Here `<token>` is your OAuth token, and `<org_id>` is your organization ID.

In the client, use the same data format as in the [{{ tracker-name }} API](../concepts/access.md).

For more information about how the client works and its terms of use, see its page on GitHub: [https://github.com/yandex/yandex_tracker_client](https://github.com/yandex/yandex_tracker_client).

{% else %}

1. Get an OAuth token. To do this, follow the link and log in: [https://oauth.yandex-team.ru/authorize?response_type=token&client_id=5f671d781aca402ab7460fde4050267b](https://oauth.yandex-team.ru/authorize?response_type=token&client_id=5f671d781aca402ab7460fde4050267b).

1. Initialize the client in your program's code:

    ```
    from startrek_client import Startrek
    client = Startrek(token=<token>)
    ```

    Here, `<token>` is your OAuth token.

In the client, use the same data format as in the [{{ tracker-name }} API](../concepts/access.md).

Additional information:

- [https://a.yandex-team.ru/arc/trunk/arcadia/library/python/startrek_python_client](https://a.yandex-team.ru/arc/trunk/arcadia/library/python/startrek_python_client)

- [https://pypi.yandex-team.ru/dashboard/repositories/default/packages/startrek_client/](https://pypi.yandex-team.ru/dashboard/repositories/default/packages/startrek_client/)

{% endif %}

