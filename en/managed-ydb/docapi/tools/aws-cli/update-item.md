---
sourcePath: overlay/quickstart/document-api/aws-cli/update-item.md
---
# Updating data

To update the data in the `series` table:

{% list tabs %}

- AWS CLI

   Run the command by replacing `https://your-database-endpoint` [the previously prepared Document API endpoint](index.md#before-you-begin) your DB:

   {% note warning %}

   To work with the AWS CLI from Windows, we recommend using the [WSL](https://docs.microsoft.com/en-us/windows/wsl/).

   {% endnote %}

   ```bash
   endpoint="https://your-database-endpoint"
   aws dynamodb update-item \
       --table-name series \
       --key '{"series_id": {"N": "2"}, "title": {"S": "Silicon Valley"}}' \
       --update-expression "SET series_info = :newval" \
       --expression-attribute-values '{":newval":{"S":"Silicon Valley is an American comedy television series created by Mike Judge, John Altschuler and Dave Krinsky. The series focuses on five young men who founded a startup company in Silicon Valley."}}' \
       --return-values ALL_NEW \
       --endpoint $endpoint
   ```

   Output:

   ```text
   {
       "Attributes": {
           "series_id": {
               "N": ".2e1"
           },
           "title": {
               "S": "Silicon Valley"
           },
           "release_date": {
               "S": "2014-04-06"
           },
           "series_info": {
               "S": "Silicon Valley is an American comedy television series created by Mike Judge, John Altschuler and Dave Krinsky. The series focuses on five young men who founded a startup company in Silicon Valley."
           }
       }
   }
   ```

{% endlist %}
