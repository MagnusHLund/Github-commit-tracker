function Main {
    if (Get-OldScheduledTasks) {
        Remove-Old-ScheduledTasks;
    }

    if(Test-ScriptInAppData) {
        Move-ScriptTo-AppData;
    }

    New-ScheduledTask;
}

function Test-ScriptInAppData {
    # Checks if the background service python script is already located within app data.
}

function Move-ScriptTo-AppData {
    # Moves the background service script to a standardized app data location
}

function Remove-Old-ScheduledTasks {
    # Removes pre-existing scheduled tasks, based on names
}

function New-ScheduledTask {
    # Creates a new scheduled task
}

function Get-OldScheduledTasks {
    # Returns a boolean indicating if there are preexisting scheduled tasks from this project, based on scheduled task names
    return false;
}
