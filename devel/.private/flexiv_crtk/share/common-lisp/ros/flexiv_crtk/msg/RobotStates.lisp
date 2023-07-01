; Auto-generated. Do not edit!


(cl:in-package flexiv_crtk-msg)


;//! \htmlinclude RobotStates.msg.html

(cl:defclass <RobotStates> (roslisp-msg-protocol:ros-message)
  ((measured_jp
    :reader measured_jp
    :initarg :measured_jp
    :type (cl:vector cl:float)
   :initform (cl:make-array 7 :element-type 'cl:float :initial-element 0.0))
   (measrued_cp
    :reader measrued_cp
    :initarg :measrued_cp
    :type geometry_msgs-msg:Pose
    :initform (cl:make-instance 'geometry_msgs-msg:Pose))
   (goal_cp
    :reader goal_cp
    :initarg :goal_cp
    :type geometry_msgs-msg:Pose
    :initform (cl:make-instance 'geometry_msgs-msg:Pose))
   (measured_cv
    :reader measured_cv
    :initarg :measured_cv
    :type geometry_msgs-msg:Twist
    :initform (cl:make-instance 'geometry_msgs-msg:Twist))
   (measured_cf
    :reader measured_cf
    :initarg :measured_cf
    :type geometry_msgs-msg:Wrench
    :initform (cl:make-instance 'geometry_msgs-msg:Wrench)))
)

(cl:defclass RobotStates (<RobotStates>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <RobotStates>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'RobotStates)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name flexiv_crtk-msg:<RobotStates> is deprecated: use flexiv_crtk-msg:RobotStates instead.")))

(cl:ensure-generic-function 'measured_jp-val :lambda-list '(m))
(cl:defmethod measured_jp-val ((m <RobotStates>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader flexiv_crtk-msg:measured_jp-val is deprecated.  Use flexiv_crtk-msg:measured_jp instead.")
  (measured_jp m))

(cl:ensure-generic-function 'measrued_cp-val :lambda-list '(m))
(cl:defmethod measrued_cp-val ((m <RobotStates>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader flexiv_crtk-msg:measrued_cp-val is deprecated.  Use flexiv_crtk-msg:measrued_cp instead.")
  (measrued_cp m))

(cl:ensure-generic-function 'goal_cp-val :lambda-list '(m))
(cl:defmethod goal_cp-val ((m <RobotStates>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader flexiv_crtk-msg:goal_cp-val is deprecated.  Use flexiv_crtk-msg:goal_cp instead.")
  (goal_cp m))

(cl:ensure-generic-function 'measured_cv-val :lambda-list '(m))
(cl:defmethod measured_cv-val ((m <RobotStates>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader flexiv_crtk-msg:measured_cv-val is deprecated.  Use flexiv_crtk-msg:measured_cv instead.")
  (measured_cv m))

(cl:ensure-generic-function 'measured_cf-val :lambda-list '(m))
(cl:defmethod measured_cf-val ((m <RobotStates>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader flexiv_crtk-msg:measured_cf-val is deprecated.  Use flexiv_crtk-msg:measured_cf instead.")
  (measured_cf m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <RobotStates>) ostream)
  "Serializes a message object of type '<RobotStates>"
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-double-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream)))
   (cl:slot-value msg 'measured_jp))
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'measrued_cp) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'goal_cp) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'measured_cv) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'measured_cf) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <RobotStates>) istream)
  "Deserializes a message object of type '<RobotStates>"
  (cl:setf (cl:slot-value msg 'measured_jp) (cl:make-array 7))
  (cl:let ((vals (cl:slot-value msg 'measured_jp)))
    (cl:dotimes (i 7)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:aref vals i) (roslisp-utils:decode-double-float-bits bits)))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'measrued_cp) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'goal_cp) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'measured_cv) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'measured_cf) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<RobotStates>)))
  "Returns string type for a message object of type '<RobotStates>"
  "flexiv_crtk/RobotStates")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'RobotStates)))
  "Returns string type for a message object of type 'RobotStates"
  "flexiv_crtk/RobotStates")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<RobotStates>)))
  "Returns md5sum for a message object of type '<RobotStates>"
  "9ca6fd6ae4c4a0b14dbb192201e94af1")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'RobotStates)))
  "Returns md5sum for a message object of type 'RobotStates"
  "9ca6fd6ae4c4a0b14dbb192201e94af1")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<RobotStates>)))
  "Returns full string definition for message of type '<RobotStates>"
  (cl:format cl:nil "float64[7] measured_jp~%geometry_msgs/Pose measrued_cp~%geometry_msgs/Pose goal_cp~%geometry_msgs/Twist measured_cv~%geometry_msgs/Wrench measured_cf~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%================================================================================~%MSG: geometry_msgs/Twist~%# This expresses velocity in free space broken into its linear and angular parts.~%Vector3  linear~%Vector3  angular~%~%================================================================================~%MSG: geometry_msgs/Vector3~%# This represents a vector in free space. ~%# It is only meant to represent a direction. Therefore, it does not~%# make sense to apply a translation to it (e.g., when applying a ~%# generic rigid transformation to a Vector3, tf2 will only apply the~%# rotation). If you want your data to be translatable too, use the~%# geometry_msgs/Point message instead.~%~%float64 x~%float64 y~%float64 z~%================================================================================~%MSG: geometry_msgs/Wrench~%# This represents force in free space, separated into~%# its linear and angular parts.~%Vector3  force~%Vector3  torque~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'RobotStates)))
  "Returns full string definition for message of type 'RobotStates"
  (cl:format cl:nil "float64[7] measured_jp~%geometry_msgs/Pose measrued_cp~%geometry_msgs/Pose goal_cp~%geometry_msgs/Twist measured_cv~%geometry_msgs/Wrench measured_cf~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%================================================================================~%MSG: geometry_msgs/Twist~%# This expresses velocity in free space broken into its linear and angular parts.~%Vector3  linear~%Vector3  angular~%~%================================================================================~%MSG: geometry_msgs/Vector3~%# This represents a vector in free space. ~%# It is only meant to represent a direction. Therefore, it does not~%# make sense to apply a translation to it (e.g., when applying a ~%# generic rigid transformation to a Vector3, tf2 will only apply the~%# rotation). If you want your data to be translatable too, use the~%# geometry_msgs/Point message instead.~%~%float64 x~%float64 y~%float64 z~%================================================================================~%MSG: geometry_msgs/Wrench~%# This represents force in free space, separated into~%# its linear and angular parts.~%Vector3  force~%Vector3  torque~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <RobotStates>))
  (cl:+ 0
     0 (cl:reduce #'cl:+ (cl:slot-value msg 'measured_jp) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 8)))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'measrued_cp))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'goal_cp))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'measured_cv))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'measured_cf))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <RobotStates>))
  "Converts a ROS message object to a list"
  (cl:list 'RobotStates
    (cl:cons ':measured_jp (measured_jp msg))
    (cl:cons ':measrued_cp (measrued_cp msg))
    (cl:cons ':goal_cp (goal_cp msg))
    (cl:cons ':measured_cv (measured_cv msg))
    (cl:cons ':measured_cf (measured_cf msg))
))
