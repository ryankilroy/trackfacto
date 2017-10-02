# TrackFacto
A tool to migrate Postfacto's action items into PivotalTracker

## Setup
There are a few environment variables you'll need to setup:

| Environment Variable | Description |
|----------------------|-------------|
| `PF_RETRO_NAME` | The name of your Postfacto retro. (i.e., https://postfacto.io/retros/$PF_RETRO_NAME) |
| `PF_BEARER_TOKEN` | This one reveals how much of a hack this is. You'll need to grab this from a logged in browser.<br><br>In Chrome, you can get this by right-clicking and selecting `Inspect`. Then navigate to the `Application` tab and in the sidebar, select `Storage > Local Storage > https://postfacto.io`. Then copy `apiToken` for your retro.<br><br>Make sure when you provide this, you wrap it in _'single quotes'_ otherwise the `$`s will mess it up |
| `TRACKER_PROJECT_ID` | The Project ID for your PivotalTracker project. (i.e., https://www.pivotaltracker.com/n/projects/$TRACKER_PROJECT_ID) |
| `TRACKER_API_TOKEN`| The API token for your PivotalTracker account. You can find it at the bottom of your [profile page](https://www.pivotaltracker.com/profile) in PivotalTracker |

## Concourse
If you decide to use the provided `concourse.yml`, it's designed to work with credentials that are provided via [Credential Management](http://concourse.ci/creds.html). Please keep in mind that if you decide to hardcode the variables, anyone with access to your pipeline can retrieve them using `$fly get-pipeline`.
