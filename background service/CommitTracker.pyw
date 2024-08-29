import os
import requests
import datetime 
import winsound
from dotenv import load_dotenv

load_dotenv()

def main(): 
    api_response = call_api(10)
    loop_events(api_response)


def call_api(return_limit):
    username = os.environ.get('GIT_USERNAME')
    url = f"https://api.github.com/users/{username}/events?per_page={return_limit}"
    response = requests.get(url)
    return response.json()

def loop_events(events):
    for event in events:
        today = is_today(event)
        if event["type"] == "PushEvent" and not today:
            winsound.Beep(1000, 1000)
            exit()

def is_today(event): 
    event_date = event['created_at']

    today = datetime.date.today()
    date = datetime.datetime.strptime(event_date, "%Y-%m-%dT%H:%M:%SZ").date()

    if date == today:
        return True
    else:
        return False

main()