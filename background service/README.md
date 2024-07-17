# Background service

## How it works

This script gets executed by the windows scheduled tasks.

It checks the github API, if the user specified in the .env file has made a commit today. If not, then it makes a beep sound, then it ends the script.
