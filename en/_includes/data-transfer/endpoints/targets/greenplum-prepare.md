{% list tabs %}

- {{ mgp-name }}
    
    1. Disable the following settings on the target:
        
        * Integrity checks for foreign keys
        * Triggers
        * Other constraints

       {% note warning %}

       Do not reactivate these settings before the transfer is complete. This will ensure data integrity with respect to foreign keys.

       {% endnote %}
    
    1. Create a user:
    
        ```sql
        CREATE ROLE <username> LOGIN ENCRYPTED PASSWORD '<password>';
        ```
    
    1. Grant the user all privileges for the database, schemas, and tables to be transferred:
    
        ```sql
        GRANT ALL PRIVILEGES ON DATABASE <database_name> TO <username>;
        ```
    
       {% include [databese-owner](database-owner-role.md) %}
    
       Once the transfer starts, it will connect to the target as this user.

- {{ GP }}/{{ CB }}
    
    1. {% include notitle [White IP list](../../configure-white-ip.md) %}
    
    1. Disable the following settings on the target:
        
        * Integrity checks for foreign keys
        * Triggers
        * Other constraints

       {% note warning %}

       Do not reactivate these settings before the transfer is complete. This will ensure data integrity with respect to foreign keys.

       {% endnote %}
    
    1. Create a user:
    
        ```sql
        CREATE ROLE <username> LOGIN ENCRYPTED PASSWORD '<password>';
        ```
    
    1. Grant the user all privileges for the database, schemas, and tables to be transferred:
    
        ```sql
        GRANT ALL PRIVILEGES ON DATABASE <database_name> TO <username>;
        ```
    
       {% include [databese-owner](database-owner-role.md) %}
    
       Once the transfer starts, it will connect to the target as this user.

{% endlist %}