# health_check.py

import requests
from datetime import datetime

url = "http://20.235.76.124"

try:
    response = requests.get(url, timeout=5)

    if response.status_code == 200:
        print(f"{datetime.now()} - HEALTHY")
    else:
        print(f"{datetime.now()} - UNHEALTHY")

except Exception as e:
    print(f"{datetime.now()} - FAILED : {e}")