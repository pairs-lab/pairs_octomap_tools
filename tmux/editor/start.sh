#!/bin/bash
# Plain-tmux session script (one window per section below; panes are split and
# their commands typed via send-keys). Edit the send-keys lines to change what
# runs in each pane; ./kill.sh stops everything.

SESSION_NAME=editor

# absolute path to this script's directory; every pane starts here
SCRIPT=$(readlink -f "$0")
SCRIPTPATH=$(dirname "$SCRIPT")

# commands executed first in every pane
PRE_WINDOW='export ROS_MASTER_URI=http://localhost:11311; export ROS_IP=127.0.0.1; export UAV_NAME=uav1'
SETUP="cd $SCRIPTPATH; $PRE_WINDOW"

if [ -n "$TMUX" ]; then
  echo "Already inside tmux, detach first."
  exit 1
fi

if tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
  echo "Session $SESSION_NAME already exists; attach with 'tmux a -t $SESSION_NAME' or stop it with ./kill.sh."
  exit 1
fi

# ---------------- window: editor ----------------
read W_editor P <<< "$(tmux new-session -d -s "$SESSION_NAME" -n "editor" -x 250 -y 50 -P -F '#{window_id} #{pane_id}')"
tmux send-keys -t "$P" "$SETUP; "'waitForRos; roslaunch pairs_octomap_tools octomap_editor.launch' Enter
tmux select-layout -t "$W_editor" tiled

# ---------------- window: reconfigure ----------------
read W_reconfigure P <<< "$(tmux new-window -t "$SESSION_NAME" -n "reconfigure" -P -F '#{window_id} #{pane_id}')"
tmux send-keys -t "$P" "$SETUP; "'waitForRos; rosrun rqt_reconfigure rqt_reconfigure' Enter
tmux select-layout -t "$W_reconfigure" tiled

# ---------------- window: rviz ----------------
read W_rviz P <<< "$(tmux new-window -t "$SESSION_NAME" -n "rviz" -P -F '#{window_id} #{pane_id}')"
tmux send-keys -t "$P" "$SETUP; "'waitForRos; rosrun rviz rviz -d ./octomap_editor.rviz' Enter
tmux select-layout -t "$W_rviz" tiled

# ---------------- window: roscore ----------------
read W_roscore P <<< "$(tmux new-window -t "$SESSION_NAME" -n "roscore" -P -F '#{window_id} #{pane_id}')"
tmux send-keys -t "$P" "$SETUP; "'roscore' Enter
tmux select-layout -t "$W_roscore" tiled

# ---------------- window: layout ----------------
read W_layout P <<< "$(tmux new-window -t "$SESSION_NAME" -n "layout" -P -F '#{window_id} #{pane_id}')"
tmux send-keys -t "$P" "$SETUP; "'waitForRos; sleep 3; ~/.i3/layout_manager.sh ./layout.json' Enter
tmux select-layout -t "$W_layout" tiled

# ---------------- window: kill (press enter inside to stop the session) ----------------
read W_kill P <<< "$(tmux new-window -t "$SESSION_NAME" -n "kill" -P -F '#{window_id} #{pane_id}')"
tmux send-keys -t "$P" "$SCRIPTPATH/kill.sh"

# mouse support (select panes / scroll with the mouse)
tmux set-option -t "$SESSION_NAME" mouse on

tmux select-window -t "$W_editor"
tmux -2 attach-session -t "$SESSION_NAME"
