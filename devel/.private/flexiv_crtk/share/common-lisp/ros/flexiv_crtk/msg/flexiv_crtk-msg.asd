
(cl:in-package :asdf)

(defsystem "flexiv_crtk-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :geometry_msgs-msg
               :std_msgs-msg
)
  :components ((:file "_package")
    (:file "RobotStates_CRTK" :depends-on ("_package_RobotStates_CRTK"))
    (:file "_package_RobotStates_CRTK" :depends-on ("_package"))
  ))