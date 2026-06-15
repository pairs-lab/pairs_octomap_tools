# pairs_octomap_tools

A toolbox for working with the OctoMaps produced by the PAIRS mapping stack: visualizing
them in RViz, interactively editing them, removing a ceiling/roof layer, and saving them to
disk. It supports both plain (`OcTree`) and colored (`ColorOcTree`) maps. These tools support
offline map cleanup and inspection alongside the live `pairs_octomap_server`.

## Contents
Component libraries (each with a plain `octree` and a `color_octree` variant):
- `OctomapTools_OctomapRvizVisualizer` — converts an OctoMap into RViz markers for
  visualization.
- `OctomapTools_OctomapEditor` — interactive map editing.
- `OctomapTools_OctomapSaver` — saves an OctoMap to a file.

Also ships launch files for each tool and a tmux `editor` session that brings up the editor,
RViz and rqt_reconfigure together.

## Branches
- `ros1` — ROS 1 Noetic (catkin)
- `ros2` — ROS 2 Jazzy (ament_cmake)

## Install (ROS 2 Jazzy)
```bash
sudo apt install ros-jazzy-pairs-octomap-tools
```

## Usage
Start the full editing workspace (editor + RViz + rqt_reconfigure) via the tmux session:
```bash
cd tmux/editor && ./start.sh
```

## License
BSD 3-Clause. Derived from the CTU-MRS `pairs_octomap_tools` package; the original
copyright is retained in [LICENSE](LICENSE).
