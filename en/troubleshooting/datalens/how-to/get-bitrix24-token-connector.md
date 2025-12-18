# How to get a token to access a Bitrix24 database from {{ datalens-name }}



## Case description {#case-description}

You need to obtain a token to set up a connection to a Bitrix24 database from {{ datalens-name }}.

## Solution {#case-resolution}

You can get the connection token from your BI settings in Bitrix24. Follow [this guide](https://helpdesk.bitrix24.ru/open/17402692/) to get the data for the {{ datalens-name }} connector. 

Use the secret key value as a token.

{% note info %}

If you are running the box version of Bitrix24, BI features will only be available [for a specific license edition](https://helpdesk.bitrix24.ru/open/15702822/). To learn more about BI solutions in Bitrix24, see [this Bitrix article](https://helpdesk.bitrix24.ru/open/14888370/).

{% endnote %}

## If the issue persists {#if-nothing-worked}

If the above steps did not help you set up a connection from {{ datalens-name }}, [contact Bitrix24 support](https://helpdesk.bitrix24.ru/ticket.php) to get information and help in the connection setup.
