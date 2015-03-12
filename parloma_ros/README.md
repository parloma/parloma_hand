Compiling
===

- Copy (or link) this folder in <ros workspace>/src
- Compile using catkin_make


Usage
===
```bash
rosrun parloma_ros move_hand <parameters>
```

Parameters are the motors commands (position form 0 to 179) in the following order
thumb, index, middle, ring, pinky, wrist_roll, wrist_pitch, wrist_yaw


