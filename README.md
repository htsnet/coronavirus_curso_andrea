# coronavirus_tracker

A Flutter app based on "Flutter REST API Crash Course" from Andrea Bizzotto

## Getting Started

You need to create a file called settings.json inside a folder .vscode with, at least, this content:

{
    "rest-client.environmentVariables": {
        "sandbox": {
            "baseUrl": "https://apigw.nubentos.com:443",
            "authorization": "<your authkey>",
            "accessToken": "<your access token>",
        },
        "production": {
        }
    }
}