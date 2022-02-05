#!/bin/zsh

function clock_emoji() {
  local hour=$1
  local mod_hour=$(($hour % 12))
  if [ $mod_hour -eq 0 ]; then
    local time="1f55B"
  else
    local hex_hour=$(printf '%x\n' $(echo $((mod_hour - 1))))
    local time=$(echo $((16#1f550+16#$hex_hour)) | xargs printf '%x\n')
  fi
  local minute=$2
  if [ $minute -gt 30 ]; then
    local time=$(echo $((16#$time+16#c)) | xargs printf '%x\n')
  fi
  echo "\U$time"
}

if (type toggl > /dev/null); then
  local current_task=$(toggl now)

  if [ "$current_task" = "There is no time entry running!" ]; then
    echo ""
  else
    local duration=$(echo $current_task | grep Duration | cut -d ' ' -f 2)
    local project=$(echo $current_task | grep Project | cut -d ' ' -f 2)
    local hour=$(echo $duration | cut -d ":" -f 1)
    local minute=$(echo $duration | cut -d ":" -f 2)
    local emoji=$(clock_emoji $hour $minute)
    echo -e "$emoji $project $duration"
  fi
else
  echo ""
fi

