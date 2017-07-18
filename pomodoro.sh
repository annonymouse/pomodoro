#!/bin/bash
# POMODORO in YA TerMINAL ;)

function pomo {
    RED='\033[0;31m'
    NC='\033[0m' # No Color
    ORANGE='\033[0;33m'
    printf "${ORANGE}POMODORO in YA TERMINAL${NC}\n"

    if [[ "$1" == "-h" ]] || [[ "$1" == "--help" ]]; then
        echo "usage: pomo       25 minute cycle"
        echo -e "   or: pomo [break]['_message_']  see options below\n"
        echo "Options:"
        echo "  d: timer duration in minutes"
        echo "  s: 05 minute break"
        echo "  l:  15 minute break"
        echo "  message: Your message to display"
        return
    fi

    if [[ "$1" == "-v" ]] || [[ "$1" == "--version" ]]; then
        echo -e "${ORANGE}POMODORO TIMER BY RUKY"
        echo "  v: 1"
        echo "  twitter: @justruky"
        echo "  blog: rukshn.github.io"
        echo -e "  email: arkruka[@]gmail.com"
        return
    fi

    TITLE="POMODORO TIMER"
    MESSAGE=""
    ICON="face-cool"
    TIMER=25

    while :
    do
        case "$1" in
        -d | --duration)
            TIMER=$2
            shift 2
            ;;
        -l | --long-break)
            MESSAGE="Long break over, back to work"
            TIMER=15
            shift
            ;;
        -s | --short-break)
            MESSAGE="Short break over, back to work"
            TIMER=5
            shift
            ;;
        -*)
          echo "Error: Unknown option: $1" >&2
          return 1
          ;;
        *)  # No more options
          break
          ;;
        esac
    done

    if [ -n "$1" ]; then
        MESSAGE="$1"
    elif [ -z "$MESSAGE" ]; then
        MESSAGE="Time to take a break"
    fi

    echo -e "${RED}TIMER SET FOR $TIMER MINUTES $(date) -> $(date -v +${TIMER}M) ${NC}"

    # LINUX users
    if [[ "$(uname)" == "Linux" ]]; then
        sleep $((TIMER *60)) && notify-send "$TITLE" "$MESSAGE" --icon=$ICON
    # MAC users
    elif [[ "$(uname)" == "Darwin" ]]; then
        sleep $((TIMER * 60)) && terminal-notifier -message "$MESSAGE" -title 'Pomodoro' --subtitle "$TITLE" -sound
    else
        echo "Sorry! Only Linux or Mac";
    fi
}

