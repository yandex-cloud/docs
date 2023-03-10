# Limit responses

When publishing a form, you can limit the period for submitting responses and the total number of  responses. You can also restrict access by only allowing responses from employees in your organization in {{ org-full-name }}.

## Limit the date range for responses {#sec_period}

To limit the period during which users can fill out the form:

1. Select the form and open the **Settings** → **Additional** tab.

1. In the **Timeframe for accepting responses** block, enable the **Limited time** option.

1. Set the date and time range for when you want the form to be active. The specified restrictions apply to Moscow time (UTC+3).

1. Click **Save**.

## Limit the number of respondents {#sec_number}

To limit the total number of respondents that can fill out the form:

1. Select the form and open the **Settings** → **Additional** tab.

1. Turn on **Limit the number of respondents** and set a number. When the limit is reached, access to the form is closed.

1. Click **Save**.

{% note tip %}

To disable form resubmission, [generate unique keys](publish.md#personal-link). If a user follows a unique link key, they can only fill out the form once.

{% endnote %}


## Only allow responses from employees {#sec_access}

By default, any user can fill out the form. If you're using [{{ forms-full-name }} for business](forms-for-org.md), you can restrict access to only allow employees in your organization to fill out the form:

1. Select a form and open the **Settings** → **Access** tab.

1. In **Who can fill out the form**, select **Only employees of the organization**.

1. Click **Save**.
