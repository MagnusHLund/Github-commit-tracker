function Main {
    if (Get-OldScheduledTasks) {
        Remove-Old-ScheduledTasks;
    }

    if (Test-ScriptInAppData == $false) {
        Move-ScriptTo-AppData;
    }

    New-ScheduledTask;
}

$appDataDirectory = "\MagnusHLund"
$pythonScript = "\CommitTracker.pyw"
$pythonAppDataLocation = "$appDataDirectory$pythonScript"

function Test-ScriptInAppData {
    # Checks if the background service python script is already located within app data.
    $scriptPath = "$env:APPDATA$pythonAppDataLocation"
    $isInPath = Test-Path $scriptPath
    return [bool]$isInPath
}

function Move-ScriptTo-AppData {
    # Moves the background service script to a standardized app data location
    $sourcePath = ".\..\background service$pythonScript"
    $destinationPath = "$env:APPDATA$pythonAppDataLocation"
    if (-not (Test-Path "$env:APPDATA$appDataDirectory")) {
        New-Item -ItemType Directory -Path "$env:APPDATA$appDataDirectory"
    }
    Move-Item -Path $sourcePath -Destination $destinationPath
}

function Remove-Old-ScheduledTasks {
    # Removes pre-existing scheduled tasks, based on names
    $taskName = "GitCommitTracker"
    if (Get-ScheduledTask -TaskName $taskName -ErrorAction SilentlyContinue) {
        Unregister-ScheduledTask -TaskName $taskName -Confirm:$false
    }
}

function New-ScheduledTask {
    # Creates a new scheduled task
    $action = New-ScheduledTaskAction -Execute "python.exe" -Argument "$env:APPDATA$pythonAppDataLocation"
    $trigger = New-ScheduledTaskTrigger -Daily -At 9am
    $principal = New-ScheduledTaskPrincipal -UserId "SYSTEM" -LogonType ServiceAccount -RunLevel Highest
    Register-ScheduledTask -Action $action -Trigger $trigger -Principal $principal -TaskName "GitCommitTracker" -Description "Runs the background service script daily at 9 AM"
}

function Get-OldScheduledTasks {
    # Returns a boolean indicating if there are preexisting scheduled tasks from this project, based on scheduled task names
    $taskName = "GitCommitTracker"
    return 1
}

Main