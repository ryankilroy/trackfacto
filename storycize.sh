#!/usr/bin/env bash

set -e

[ -z "$PF_RETRO_NAME" ] && echo 'Please set the retro name ($PF_RETRO_NAME)' && exit 1
[ -z "$PF_BEARER_TOKEN" ] && echo 'Please set the retro bearer token ($PF_BEARER_TOKEN)' && exit 1
[ -z "$TRACKER_PROJECT_ID" ] && echo 'Please set the tracker project id ($TRACKER_PROJECT_ID)' && exit 1
[ -z "$TRACKER_API_TOKEN" ] && echo 'Please set the retro name ($TRACKER_API_TOKEN)' && exit 1

items=$(curl "https://felicity-api.cfapps.io/retros/$PF_RETRO_NAME" -H "authorization: Bearer $PF_BEARER_TOKEN" | jq -r '.retro.action_items' | jq -r 'map(select(.done == false))' | jq -r 'map({id,description})| .[] | @base64')

for item in $(echo ${items}); do
  story=$(echo ${item} | base64 --decode | jq -r '.description')
  echo "Adding story '$story' to tracker"
  curl -X POST -H "X-TrackerToken: $TRACKER_API_TOKEN" -H "Content-Type: application/json" -d "{\"name\":\"$story\", \"story_type\":\"chore\", \"labels\":[\"action-item\"]}" "https://www.pivotaltracker.com/services/v5/projects/$TRACKER_PROJECT_ID/stories"

  story_id=$(echo ${item} | base64 --decode | jq -r '.id')
  echo "Finishing action item '$story' in Postfacto"
  curl "https://felicity-api.cfapps.io/retros/$PF_RETRO_NAME/action_items/$story_id" -X PATCH -H "authorization: Bearer $PF_BEARER_TOKEN" -H 'Content-Type: application/json' -H 'accept: application/json' --data-binary '{"done":true}' --compressed
done
