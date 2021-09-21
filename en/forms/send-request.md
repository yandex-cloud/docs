# Send an HTTP request

To send data from your form to a web service via the API, use HTTP requests:

{% if audience == "internal" %}

1. Before setting up requests, [request access](https://puncher.yandex-team.ru/) to your server from the {{ forms-name }} subnet: `_FORMS_BACK_PROD_NETS_` for production, `_FORMS_BACK_TEST_NETS_` for testing.

{% endif %}

1. Select a form and go to **Integration**.

1. Select the [group of actions](notifications.md#add-integration) to add an HTTP request to and click the button with the request type at the bottom of the group:
    - **JSON-RPC.POST**: Send a request using the JSON-RPC protocol.

    {% if audience == "internal" %}

    - **HTTP.POST**: Send the user's responses in JSON or XML format using an HTTP request with the POST method.

    - **HTTP.PUT**: Send the user's responses in JSON or XML format using an HTTP request with the PUT method.

    {% endif %}
    - **HTTP.Request to endpoint**: Send any available form data with the option to set the request format and select the HTTP method.

    {% note info %}

    All requests are executed asynchronously.

    {% endnote %}

1. Specify the URL of the service.

{% if audience == "internal" %}

1. If necessary, turn on and set up authentication using [TVM2](https://wiki.yandex-team.ru/passport/tvm2/):

    1. In the **Client ID** field, specify the ID of your TVM application.

    1. Set up permission to accept TVM tickets from {{ forms-name }} in your service. You can lean more about TVM applications {{ forms-name }} in the [ABC service](https://abc.yandex-team.ru/services/forms/resources/?supplier=14&type=47&state=requested&state=approved&state=granted&view=consuming): the forms application is for production, and the forms-testing application is for testing.

{% endif %}

1. Set parameters that depend on your selected request type:

    - JSON-RPC.POST

        - Specify the service method to which the request is sent.

        - Set the request parameters. Specify a name and value for each parameter.

        - You can use [variables](vars.md) as parameter values. In this case, enable **Only when the value is received**.

    {% if audience == "internal" %}

    - HTTP.POST/PUT

        - Select the questions for which responses should be sent in the request.

        - Choose the request format: JSON or XML.

        - If necessary, add headers to the request. Specify a name and value for each header.

        - You can use [variables](vars.md) as header values. In this case, enable **Only when the value is received**.

    {% endif %}

    - HTTP.Request to endpoint

        - Select the HTTP method.

        - Set the request body. To add form data to the request body, use [variables](vars.md).

        {% if audience == "internal" %}

        - If necessary, add headers to the request. Specify a name and value for each header.

        - You can use [variables](vars.md) as header values. In this case, enable **Only when the value is received**.

        {% endif %}

1. Click **Save**.

{% if audience == "external" %}

{% note warning %}

For HTTP requests to work correctly, you need to allow your service to accept packets from the `2a02:6b8:c00::/40` form network over the `ipv6` protocol. Otherwise, your service firewall may block data that's sent by the form.

{% endnote %}

{% endif %}

## Processing responses to HTTP requests.{% if audience == "internal" %}POST/PUT/{% endif %}Request to endpoint{#http-response}

**Successful request**

The request is considered successful if the response received has the code `200`, `201`, or `202`.

**Error processing**

If the following errors occur, the request is sent again (up to seven attempts in 30 minutes):

- Timeout expires in 5 seconds.

- Network error.

- Response with the `5XX` code.

- Response with the `404` code.

All other errors cause the integration to fail.

**Redirect**

If the received response has the `307` code, the request is redirected to the URL that's specified in the `Location` header.

## Processing responses to a JSON-RPC.POST request {#json-response}

**Successful request**

The request is considered successful if there are no errors from the list below.

**Redirect**

If the received response has the `307` code, the request is redirected to the URL that's specified in the `Location` header.

**Error processing**

Errors are processed in the following way:

1. If there's no response because of a network error or because timeout expired, the request is sent again.

1. The response body is checked. If there's an error in the response body, the request is sent again after any error code except:

    - `-32700` Parse error

    - `-32600` Invalid request

    - `-32602` Invalid params

1. If the response body has no errors, the HTTP status code is checked. The request is sent again after responses with `5XX` and `404` status codes.

All other errors cause the integration to fail.

## Troubleshooting {#filters}

### Two HTTP requests are sent per one response in the form

In some cases, the HTTP request module doesn't wait for the external service to respond that the request is accepted. Then the request is sent again, and the service receives a duplicate request with the same data. If you want to track the uniqueness of HTTP requests, use the `x-delivery-id` header value.

{% if audience == "internal" %}

### Variable data is inserted in the wrong format

If you add data from the form to the request using [variables](vars.md), invalid characters may get into the request body and cause an integration error. To remove invalid characters from the response or convert the response format, configure filters for variables in the old admin panel {{ forms-name }}.

For example, you need to add a variable containing the response to the <q>Long text</q> question to the request body. If the response text contains line breaks, it will cause an integration error. To avoid this error, you need to convert the variable value to the JSON format.

To set up filters for variables:

1. Set up integration using variables in the form.

1. Go to the old admin panel. To do this, click **Go to the old version** on the top panel.

1. In the old admin panel, click **Settings** at the top of the page, and then select **Integrations** in the left panel.

1. In the integration settings, find the list of added variables and click the one you want to convert.

![](../_assets/forms/var-old-admin.png)

1. In the variable settings window, select the filter for data conversion and click **Add**.

![](../_assets/forms/var-filters.png)

1. Save the integration settings.

### I can't attach a file to the issue in {{ tracker-full-name }}

If you need to attach a file from the response to a question in the form to the issue in {{ tracker-short-name }}, the easiest way is to add the file to the comment. To do this, create a **HTTP.Request to endpoint** request with the following parameters:

- URL: `https://st-api.yandex-team.ru/v2/issues/<issue_key>/comments`

- Request method: **POST**

- Request body: Add a <q>Response to prompt</q> variable to the request body and select the <q>File</q> question type.

    ```
    {
        "text":"<response_to_prompt>"
    }
    ```

- Headings: `Authorization: OAuth <token>`

    ![](../_assets/forms/http-add-file.png)

### I can't create an issue with a {#resolve-problems-checklist}  checklist in {{ tracker-full-name }}

To create an issue with a checklist in {{ tracker-short-name }}, use the **HTTP.Request to endpoint** integration with the following parameters:

- URL: `https://st-api.yandex-team.ru/v2/issues`

- Request method: **POST**

- Request body: Specify the parameters of the issue in JSON format. Examples:

    ```
    {"queue":"<Queue_key>",
    "summary":"issue heading",     
    "checklistItems":[                     
        {"text":"Item 1"},
        {"text":"Item 2"},
        {"text":"Item 3"}]
    }
    ```

    To add form data to the request body, use [variables](vars.md). For example, to make the user who filled out the form the owner of the issue, add a variable as the `createdBy` parameter value

    {% note info %}

    The `queue` and `summary` issue parameters are required. To learn more about the request structure [go to {{ wiki-name }}](https://wiki.yandex-team.ru/tracker/api/issues/create/).

    {% endnote %}

    ![](../_assets/forms/http-checklist.png)

    {% endif %}

