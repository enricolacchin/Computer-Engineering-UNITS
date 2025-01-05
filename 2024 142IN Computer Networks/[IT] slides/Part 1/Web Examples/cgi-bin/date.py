#!/usr/bin/env python3

import cgi
import datetime

# Set the content type to HTML
print("Content-type: text/html\n")

# Get the current date and time
current_datetime = datetime.datetime.now()

# HTML template
html_template = f"""
<!DOCTYPE html>
<html>
<head>
    <title>CGI Script - Displaying Request Date</title>
</head>
<body>
    <h1>HTTP Request Date</h1>
    <p>The HTTP request was received on: {current_datetime}</p>
</body>
</html>
"""

# Print the HTML response
print(html_template)
