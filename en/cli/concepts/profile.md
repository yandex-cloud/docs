# Profiles

_The profile_ is a set of CLI configuration parameters that is stored on your computer and used when running commands.

- Obtain information about a profile.

    - Get a list of profiles.

        ```
        yc config profile list
        ```

    - Get a list of parameters stored in a profile.

        ```
        yc config profile get <profile name>
        ```

- Create a new profile or manage an existing profile.

    - Create a new profile.

        - Using the `yc init` command:

            In this case, the CLI will gradually suggest setting all the available parameters.  You can also use this command to redefine the parameters of an existing profile.

        - Using the `yc config profile create <profile name>` command:

            In this case, an empty profile is created and activated while all necessary parameters must be set separately using the `yc config set` command.

    - Change the active profile.

        ```
        yc config profile activate <profile name>
        ```

    - Delete a profile.

        ```
        yc config profile delete <profile name>
        ```

- Change the parameter values of the active profile.

    - Set a new parameter value.

        ```
        yc config set <parameter> <value>
        ```

    - Delete a parameter value.

        ```
        yc config unset <parameter> 
        ```

    - Re-initialize the profile with new settings by selecting the `Re-initialize this profile <profile name> with new settings` option.

        ```
        yc init
        Welcome! This command will take you through the configuration process.
        Pick desired action:
         [1] Re-initialize this profile 'prod' with new settings
         [2] Create a new profile
        ```

