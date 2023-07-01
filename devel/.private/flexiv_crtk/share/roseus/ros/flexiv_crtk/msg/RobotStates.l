;; Auto-generated. Do not edit!


(when (boundp 'flexiv_crtk::RobotStates)
  (if (not (find-package "FLEXIV_CRTK"))
    (make-package "FLEXIV_CRTK"))
  (shadow 'RobotStates (find-package "FLEXIV_CRTK")))
(unless (find-package "FLEXIV_CRTK::ROBOTSTATES")
  (make-package "FLEXIV_CRTK::ROBOTSTATES"))

(in-package "ROS")
;;//! \htmlinclude RobotStates.msg.html
(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))


(defclass flexiv_crtk::RobotStates
  :super ros::object
  :slots (_measured_jp _measrued_cp _goal_cp _measured_cv _measured_cf ))

(defmethod flexiv_crtk::RobotStates
  (:init
   (&key
    ((:measured_jp __measured_jp) (make-array 7 :initial-element 0.0 :element-type :float))
    ((:measrued_cp __measrued_cp) (instance geometry_msgs::Pose :init))
    ((:goal_cp __goal_cp) (instance geometry_msgs::Pose :init))
    ((:measured_cv __measured_cv) (instance geometry_msgs::Twist :init))
    ((:measured_cf __measured_cf) (instance geometry_msgs::Wrench :init))
    )
   (send-super :init)
   (setq _measured_jp __measured_jp)
   (setq _measrued_cp __measrued_cp)
   (setq _goal_cp __goal_cp)
   (setq _measured_cv __measured_cv)
   (setq _measured_cf __measured_cf)
   self)
  (:measured_jp
   (&optional __measured_jp)
   (if __measured_jp (setq _measured_jp __measured_jp)) _measured_jp)
  (:measrued_cp
   (&rest __measrued_cp)
   (if (keywordp (car __measrued_cp))
       (send* _measrued_cp __measrued_cp)
     (progn
       (if __measrued_cp (setq _measrued_cp (car __measrued_cp)))
       _measrued_cp)))
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
    ;; float64[7] _measured_jp
    (* 8    7)
    ;; geometry_msgs/Pose _measrued_cp
    (send _measrued_cp :serialization-length)
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
     ;; float64[7] _measured_jp
     (dotimes (i 7)
       (sys::poke (elt _measured_jp i) (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
       )
     ;; geometry_msgs/Pose _measrued_cp
       (send _measrued_cp :serialize s)
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
   ;; float64[7] _measured_jp
   (dotimes (i (length _measured_jp))
     (setf (elt _measured_jp i) (sys::peek buf ptr- :double)) (incf ptr- 8)
     )
   ;; geometry_msgs/Pose _measrued_cp
     (send _measrued_cp :deserialize buf ptr-) (incf ptr- (send _measrued_cp :serialization-length))
   ;; geometry_msgs/Pose _goal_cp
     (send _goal_cp :deserialize buf ptr-) (incf ptr- (send _goal_cp :serialization-length))
   ;; geometry_msgs/Twist _measured_cv
     (send _measured_cv :deserialize buf ptr-) (incf ptr- (send _measured_cv :serialization-length))
   ;; geometry_msgs/Wrench _measured_cf
     (send _measured_cf :deserialize buf ptr-) (incf ptr- (send _measured_cf :serialization-length))
   ;;
   self)
  )

(setf (get flexiv_crtk::RobotStates :md5sum-) "9ca6fd6ae4c4a0b14dbb192201e94af1")
(setf (get flexiv_crtk::RobotStates :datatype-) "flexiv_crtk/RobotStates")
(setf (get flexiv_crtk::RobotStates :definition-)
      "float64[7] measured_jp
geometry_msgs/Pose measrued_cp
geometry_msgs/Pose goal_cp
geometry_msgs/Twist measured_cv
geometry_msgs/Wrench measured_cf

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



(provide :flexiv_crtk/RobotStates "9ca6fd6ae4c4a0b14dbb192201e94af1")


