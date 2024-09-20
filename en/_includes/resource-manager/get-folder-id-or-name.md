If you know the folder ID or name, proceed to the next step. Otherwise, use one of these methods to get them:

* Get a list of folders:
  ```bash
  yc resource-manager folder list
  ```

  Result:

  ```text
  +----------------------+--------------------+--------+--------+-------------+
  |          ID          |        NAME        | LABELS | STATUS | DESCRIPTION |
  +----------------------+--------------------+--------+--------+-------------+
  | b1gppulhhm2a******** | yet-another-folder |        | ACTIVE |             |
  | b1gvmob95yys******** | default            |        | ACTIVE |             |
  +----------------------+--------------------+--------+--------+-------------+
  ```

  * If you know the ID of the resource that belongs to the required folder, you can get the folder ID from the information about that resource:

  ```bash
  yc <service_name> <service_category> get <resource_ID>
  ```

  Where:
  * `<service_name>`: Service name, e.g., `compute`.
  * `<service_category>`: Resource category, e.g., `instance`.
  * `<resource_ID>`: Resource ID.

  For example, the `fhmp74bfis2a********` VM belongs to the `b1gpvjd9ir42********` folder:

  ```bash
  yc compute instance get fhmp74bfis2a********
  ```

  Result:

  ```text
  id: fhmp74bfis2a********
  folder_id: b1gpvjd9ia42********
  ...
  ```