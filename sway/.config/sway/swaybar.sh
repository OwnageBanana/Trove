#!/bin/bash
# Change this according to your device
################
# Variables
################

# Keyboard input name

# Date and time
date_and_week=$(date "+%Y/%m/%d (w%-V)")
current_time=$(date "+%H:%M:%S")

#############
# Commands
#############

# Battery or charger
battery_charge=$(upower --show-info $(upower --enumerate | grep 'BAT') | egrep "percentage" | awk '{print $2}')
battery_status=$(upower --show-info $(upower --enumerate | grep 'BAT') | egrep "state" | awk '{print $2}')

# Audio and multimedia
#audio_volume=$(pamixer --sink `pactl list sinks short | grep RUNNING | awk '{print $1}'` --get-volume)
#audio_is_muted=$(pamixer --sink `pactl list sinks short | grep RUNNING | awk '{print $1}'` --get-mute)
audio_volume=$(pamixer --get-volume)
audio_is_muted=$(pamixer --get-mute)
media_artist=$(playerctl metadata artist)
media_song=$(playerctl metadata title)
player_status=$(playerctl status)

# Network
network=$(ip route get 1.1.1.1 | grep -Po '(?<=dev\s)\w+' | cut -f1 -d ' ')
local_ip=$(ip route get 1.1.1.1 | grep -Po '(?<=src\s)\d+\.\d+\.\d+\.\d+')
wifi_quality=$(nmcli -t -f IN-USE,SIGNAL dev wifi | grep '^\*' | cut -d: -f2)
wifi_bitrate=$(nmcli -t -f IN-USE,RATE dev wifi | grep '^\*' | cut -d: -f2)

# Network traffic (KB/s)
rx_file="/tmp/swaybar_rx"
tx_file="/tmp/swaybar_tx"
rx_now=$(cat /sys/class/net/$network/statistics/rx_bytes)
tx_now=$(cat /sys/class/net/$network/statistics/tx_bytes)
rx_old=$(cat $rx_file 2>/dev/null || echo $rx_now)
tx_old=$(cat $tx_file 2>/dev/null || echo $tx_now)
echo $rx_now > $rx_file
echo $tx_now > $tx_file
rx_rate=$(printf "%3s" $(( ($rx_now - $rx_old) / 1024 )))
tx_rate=$(printf "%3s" $(( ($tx_now - $tx_old) / 1024 )))

# Others
loadavg_5min=$(cat /proc/loadavg | awk -F ' ' '{print $2}')

# RAM usage
ram_used=$(free -h | awk '/^Mem:/ {print $3}')
ram_total=$(free -h | awk '/^Mem:/ {print $2}')

# Removed weather because we are requesting it too many times to have a proper
# refresh on the bar
#weather=$(curl -Ss 'https://wttr.in/Pontevedra?0&T&Q&format=1')

battery_time=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep "time to" | awk '{print $4, $5}')
if [ "$battery_status" = "discharging" ]; then
    battery_pluggedin="🔋 $battery_time"
else
    battery_pluggedin='⚡'
fi

network_active="⇆"

if [ "$player_status" = "Playing" ]; then
    song_status=$media_artist-$media_song' ▶'
elif [ "$player_status" = "Paused" ]; then
    song_status='⏸'
else
    song_status='⏹'
fi

if [ "$audio_is_muted" = "true" ]; then
    audio_active='🔇'
    audio_volume='muted'
else
    audio_active='🔊'
    audio_volume=$audio_volume'%'
fi
#$media_artist - $media_song 
echo "!CAT ZONE! ฅ^._.^ฅ   ᓚ₍ ^- -^₎   ≽^• ˕ • ྀི≼   =^.^= !CAT ZONE! | $network $network_active $local_ip ($wifi_quality% $wifi_bitrate) ↓${rx_rate}KB/s ↑${tx_rate}KB/s | $loadavg_5min | 🐏 $ram_used/$ram_total | 🎧 $song_status | $audio_active $audio_volume | $battery_pluggedin $battery_charge | 🕘 $current_time - $date_and_week |"
