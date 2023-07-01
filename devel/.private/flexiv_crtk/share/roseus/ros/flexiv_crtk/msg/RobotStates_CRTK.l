;; Auto-generated. Do not edit!


(when (boundp 'flexiv_crtk::RobotStates_CRTK)
  (if (not (find-package "FLEXIV_CRTK"))
    (make-package "FLEXIV_CRTK"))
  (shadow 'RobotStates_CRTK (find-package "FLEXIV_CRTK")))
(unless (find-package "FLEXIV_CRTK::ROBOTSTATES_CRTK")
  (make-package "FLEXIV_CRTK::ROBOTSTATES_CRTK"))

(in-package "ROS")
;;//! \htmlinclude RobotStates_CRTK.msg.html
(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass flexiv_crtk::RobotStates_CRTK
  :super ros::object
  :slots (_header _measured_jp _measured_cp _goal_cp _measured_cv _measured_cf ))

(defmethod flexiv_crtk::RobotStates_CRTK
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:measured_jp __measured_jp) (make-array 7 :initial-element 0.0 :element-type :float))
    ((:measured_cp __measured_cp) (instance geometry_msgs::Pose :init))
    ((:goal_cp __goal_cp) (instance geometry_msgs::Pose :init))
    ((:measured_cv __measured_cv) (instance geometry_msgs::Twist :init))
    ((:measured_cf __measured_cf) (instance geometry_msgs::Wrench :init))
    )
   (send-super :init)
   (setq _header __header)
   (setq _measured_jp __measured_jp)
   (setq _measured_cp __measured_cp)
   (setq _goal_cp __goal_cp)
   (setq _measured_cv __measured_cv)
   (setq _measured_cf __measured_cf)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:measured_jp
   (&optional __measured_jp)
   (if __measured_jp (setq _measured_jp __measured_jp)) _measured_jp)
  (:measured_cp
   (&rest __measured_cp)
   (if (keywordp (car __measured_cp))
       (send* _measured_cp __measured_cp)
     (progn
       (if __measured_cp (setq _measured_cp (car __measured_cp)))
       _measured_cp)))
  (:goal_cp
   (&rest __goal_cp)
   (if (keywordp (car __goal_cp))
       (send* _goal_cp __goal_cp)
     (progn
       (if __goal_cp (setq _goal_cp (car __goal_cp)))
       _goal_cp)))
  (:measured_cv
   (&rest __measured_cv)
   (if (keywordp (car __measured_cv))
       (send* _measured_cv __measured_cv)
     (progn
       (if __measured_cv (setq _measured_cv (car __measured_cv)))
       _measured_cv)))
  (:measured_cf
   (&rest __measured_cf)
   (if (keywordp (car __measured_cf))
       (send* _measured_cf __measured_cf)
     (progn
       (if __measured_cf (setq _measured_cf (car __measured_cf)))
       _measured_cf)))
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; float64[7] _measured_jp
    (* 8    7)
    ;; geometry_msgs/Pose _measured_cp
    (send _measured_cp :serialization-length)
    ;; geometry_msgs/Pose _goal_cp
    (send _goal_cp :serialization-length)
    ;; geometry_msgs/Twist _measured_cv
    (send _measured_cv :serialization-length)
    ;; geometry_msgs/Wrench _measured_cf
    (send _measured_cf :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; float64[7] _measured_jp
     (dotimes (i 7)
       (sys::poke (elt _measured_jp i) (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
       )
     ;; geometry_msgs/Pose _measured_cp
       (send _measured_cp :serialize s)
     ;; geometry_msgs/Pose _goal_cp
       (send _goal_cp :serialize s)
     ;; geometry_msgs/Twist _measured_cv
       (send _measured_cv :serialize s)
     ;; geometry_msgs/Wrench _measured_cf
       (send _measured_cf :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; float64[7] _measured_jp
   (dotimes (i (length _measured_jp))
     (setf (elt _measured_jp i) (sys::peek buf ptr- :double)) (incf ptr- 8)
     )
   ;; geometry_msgs/Pose _measured_cp
     (send _measured_cp :deserialize buf ptr-) (incf ptr- (send _measured_cp :serialization-length))
   ;; geometry_msgs/Pose _goal_cp
     (send _goal_cp :deserialize buf ptr-) (incf ptr- (send _goal_cp :serialization-length))
   ;; geometry_msgs/Twist _measured_cv
     (send _measured_cv :deserialize buf ptr-) (incf ptr- (send _measured_cv :serialization-length))
   ;; geometry_msgs/Wrench _measured_cf
     (send _measured_cf :deserialize buf ptr-) (incf ptr- (send _measured_cf :serialization-length))
   ;;
   self)
  )

(setf (get flexiv_crtk::RobotStates_CRTK :md5sum-) "57c0e118106470de81cca4c527be64f9")
(setf (get flexiv_crtk::RobotStates_CRTK :datatype-) "flexiv_crtk/RobotStates_CRTK")
(setf (get flexiv_crtk::RobotStates_CRTK :definition-)
      "Header header
float64[7] measured_jp
geometry_msgs/Pose measured_cp
geometry_msgs/Pose goal_cp
geometry_msgs/Twist measured_cv
geometry_msgs/Wrench measured_cf

================================================================================
MSG: std_msgs/Header
# Standard metadata for higher-level stamped data types.
# This is generally used to communicate timestamped data 
# in a particular coordinate frame.
# 
# sequence ID: consecutively increasing ID 
uint32 seq
#Two-integer timestamp that is expressed as:
# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')
# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')
# time-handling sugar is provided by the client library
time stamp
#Frame this data is associated with
string frame_id

================================================================================
MSG: geometry_msgs/Pose
# A representation of pose in free space, composed of position and orientation. 
Point position
Quaternion orientation

================================================================================
MSG: geometry_msgs/Point
# This contains the position of a point in free space
float64 x
float64 y
float64 z

================================================================================
MSG: geometry_msgs/Quaternion
# This represents an orientation in free space in quaternion form.

float64 x
float64 y
float64 z
float64 w

================================================================================
MSG: geometry_msgs/Twist
# This expresses velocity in free space broken into its linear and angular parts.
Vector3  linear
Vector3  angular

================================================================================
MSG: geometry_msgs/Vector3
# This represents a vector in free space. 
# It is only meant to represent a direction. Therefore, it does not
# make sense to apply a translation to it (e.g., when applying a 
# generic rigid transformation to a Vector3, tf2 will only apply the
# rotation). If you want your data to be translatable too, use the
# geometry_msgs/Point message instead.

float64 x
float64 y
float64 z
================================================================================
MSG: geometry_msgs/Wrench
# This represents force in free space, separated into
# its linear and angular parts.
Vector3  force
Vector3  torque

")



(provide :flexiv_crtk/RobotStates_CRTK "57c0e118106470de81cca4c527be64f9")


