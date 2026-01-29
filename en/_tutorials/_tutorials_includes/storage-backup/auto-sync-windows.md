For auto sync, set up a task in the **Task scheduler**:

1. Open the Windows **Task Scheduler**:

    * **Start Menu** → **Task Scheduler**.
    * Or start it in **Run** → `taskschd.msc`.

1. Click **Create task...**.
1. In the **Actions** tab, add a new action by specifying the absolute path to the executable script, e.g., a BAT file, under **Program or script**.
1. In the **Triggers** tab, add a schedule.
1. Click **OK**.