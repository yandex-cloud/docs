# Integration with version and data control systems

{{ ml-platform-short-name }} is integrated with the [DVC](https://dvc.org/) version control system and [Git](https://git-scm.com/) version control system.

## Integration with the DVC data version control system {#dvc}

To work with the DVC system, use the following commands:

* **%dvc_init**: Initialize a DVC project in the current directory.

   {% cut "Command parameter descriptions" %}

   * `-f`, `--force`: Deletes an existing internal DVC directory. This clears the entire local cache.
   * `--subdir`: Initializes a DVC project in the working directory even if it isn't the root of the Git repository. This parameter is ignored when running in the root directory of a DVC project.
   * `--no-scm`: Initializes a DVC project separately from Git. This means that DVC doesn't try to find or use Git in the target directory. Some DVC functions are not available in this mode.
   * `-h`, `--help`: Shows Help.
   * `-q`, `--quiet`: Stops writing data to standard output. 0 is output if no problems arise, otherwise 1.
   * `-v`, `--verbose`: Displays detailed tracing information.

   {% endcut %}

* **%dvc_add**: Add files or directories to track in DVC.

   {% cut "Command parameter descriptions" %}

   * `-R`, `--recursive`: Defines files to add by searching for data files in each target directory and its subdirectories. If there are no directories among the targets, this parameter is ignored.
   * `--no-commit`: Do not save files to cache. In this case, a DVC file is created and an entry is added to .dvc/state.
   * `--file <filename>`: Specifies the name of the DVC file generated. The default name is `<target>.dvc`, where `<target>` is the name of the file to add.
   * `--external`: Allows adding files and folders that are outside of the DVC repository.
   * `-h`, `--help`: Shows Help.
   * `-q`, `--quiet`: Stops writing data to standard output. 0 is output if no problems arise, otherwise 1.

   {% endcut %}

* **%dvc_remove**: Stops tracking files or directories in DVC.

   {% cut "Command parameter descriptions" %}

   * `--outs`: Additionally deletes data generated at all stages of the target operation. By default, always used for DVC files.
   * `-h`, `--help`: Shows Help.
   * `-q`, `--quiet`: Stops writing data to standard output. 0 is output if no problems arise, otherwise 1.
   * `-v`, `--verbose`: Displays detailed tracing information.

   {% endcut %}

* **%dvc_status**: Show changes in the project pipelines and file mismatches either between the cache and workspace, or between the cache and remote storage.

   {% cut "Command parameter descriptions" %}

   * `-c`, `--cloud`: Comparisons are made with remote storage.
   * `-a`, `--all-branches`: Compares cache content against all Git branches instead of just the workspace. Applies only if the `--cloud` or `-r` parameter is specified.
   * `-T`, `--all-tags`: The same as `-a`, but applies to Git tags and the workspace. Can be combined with the `-a` parameter, for example, using the `-aT` flag.
   * `-R`, `--recursive`: Defines files for status checks in each target directory and its subdirectories. A search is made in dvc.yaml and DVC files.
   * `--show-json`: Prints the output in JSON format instead of a table.
   * `--all-commits`: The same as `-a` or `-T`, but applies to all Git commits and the workspace. Used for comparing cache content for the entire existing history of the project.
   * `-d, --with-deps`: Defines files to check by tracking dependencies to the targets. If nothing is specified, this parameter is ignored.
   * `-r <name>`, `--remote <name>`: Specifies the remote repository to compare with.
   * `-j <number>`, `--jobs <number>`: Specifies the number of jobs that DVC can use to retrieve information from remote servers. Only applies if the `--cloud` parameter is used or remote access is granted.
   * `-h`, `--help`: Shows Help.
   * `-q`, `--quiet`: Stops writing data to standard output. 0 is output if data is up-to-date, otherwise 1.
   * `-v`, `--verbose`: Displays detailed tracing information.

   {% endcut %}

* **%dvc_checkout**: Update files and directories in the workspace based on current DVC files.

   {% cut "Command parameter descriptions" %}

   * `--summary`: Displays a summary of changes made by the current command in the workspace.
   * `-R`, `--recursive`: Defines files to update by searching each target directory and its subdirectories for DVC files. If there are no directories among the targets, this parameter is ignored.
   * `-d`, `--with-deps`: Defines files to update by tracking dependencies to the target DVC files. If no targets are specified, the parameter is ignored.
   * `-f`, `--force `: Deletes unsaved changes to the workspace.
   * `--relink`: Ensures that the file linking strategy (`reflink`, `hardlink`, `symlink`, or `copy`) for all data in the workspace is consistent with the project's cache.
   * `-q`, `--quiet`: Stops writing data to standard output. 0 is output if no problems arise, otherwise 1.
   * `-v`, `--verbose`: Displays detailed tracing information from executing the `dvc pull` command.

   {% endcut %}

* **%dvc_pull**: Download tracked files or directories from remote storage to the cache and workspace.

   {% cut "Command parameter descriptions" %}

   * `-a`, `--all-branches`: Defines files to download by checking dvc.yaml and .dvc files in all Git branches instead of just those present in the current workspace.
   * `-T`, `--all-tags`: The same as `-a`, but applies to Git tags and the workspace. Can be combined with the `-a` parameter, for example, using the `-aT` flag.
   * `--all-commits`: The same as `-a` or `-T`, but applies to all Git commits and the workspace. Used for downloading all the data for the entire existing history of the project.
   * `-d`, `--with-deps`: Defines files to download by tracking dependencies to the targets. If no targets are specified, the parameter is ignored.
   * `-R`, `--recursive`: Defines files to download by searching each target directory and its subdirectories for dvc.yaml and .dvc files to check. If there are no directories among the targets, this parameter is ignored.
   * `-f`, `--force `: Doesn't prompt when removing workspace files that no longer match the current stages or DVC files.
   * `-r <name>`, `--remote <name>`: Sets the name of a remote repository to pull from.
   * `--run-cache`: Downloads all available history of stage runs from the remote repository into the local run cache.
   * `-j <number>`, `--jobs <number>`: Specifies the number of parallel jobs to pull files from the remote repository.
   * `-h`, `--help`: Shows Help.
   * `-q`, `--quiet`: Stops writing data to standard output. 0 is output if data is up-to-date, otherwise 1.
   * `-v`, `--verbose`: Displays detailed tracing information.

   {% endcut %}

* **%dvc_push**: Upload tracked files or directories to remote storage.

   {% cut "Command parameter descriptions" %}

   * `-a`, `--all-branches`: Defines files to upload by checking dvc.yaml and .dvc files in all Git branches instead of just those present in the current workspace.
   * `-T`, `--all-tags`: The same as `-a`, but applies to Git tags and the workspace. Can be combined with the `-a` parameter, for example, using the `-aT` flag.
   * `--all-commits`: The same as `-a` or `-T`, but applies to all Git commits and the workspace. Used for downloading all the data for the entire existing history of the project.
   * `-d`, `--with-deps`: Defines files to upload by tracking dependencies to the targets. If no targets are specified, the parameter is ignored.
   * `-R`, `--recursive`: Defines files to upload by searching each target directory and its subdirectories for dvc.yaml and .dvc files to check. If there are no directories among the targets, this parameter is ignored.
   * `-r <name>`, `--remote <name>`: Sets the name of a remote repository to push to.
   * `--run-cache`: Uploads all available history of stage runs to the remote repository.
   * `-j <number>`, `--jobs <number>`: Specifies the number of parallel jobs to push files to the remote repository.
   * `-h`, `--help`: Shows Help.
   * `-q`, `--quiet`: Stops writing data to standard output. 0 is output if data is up-to-date, otherwise 1.
   * `-v`, `--verbose`: Displays detailed tracing information.

   {% endcut %}

## Integration with the Git version control system {#git}

To use the version control system, click **Git** in the project window. To work with the system, you can clone an existing repository or initiate a new one, and use all common methods for working with Git. For more information, see [{#T}](../operations/projects/work-with-git.md).
