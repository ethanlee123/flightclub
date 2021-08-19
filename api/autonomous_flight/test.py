from dotenv import load_dotenv

load_dotenv

import os

token = os.environ.get('MAPS_API_KEY')
print(token)