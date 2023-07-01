// Auto-generated. Do not edit!

// (in-package flexiv_crtk.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let geometry_msgs = _finder('geometry_msgs');

//-----------------------------------------------------------

class RobotStates {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.measured_jp = null;
      this.measrued_cp = null;
      this.goal_cp = null;
      this.measured_cv = null;
      this.measured_cf = null;
    }
    else {
      if (initObj.hasOwnProperty('measured_jp')) {
        this.measured_jp = initObj.measured_jp
      }
      else {
        this.measured_jp = new Array(7).fill(0);
      }
      if (initObj.hasOwnProperty('measrued_cp')) {
        this.measrued_cp = initObj.measrued_cp
      }
      else {
        this.measrued_cp = new geometry_msgs.msg.Pose();
      }
      if (initObj.hasOwnProperty('goal_cp')) {
        this.goal_cp = initObj.goal_cp
      }
      else {
        this.goal_cp = new geometry_msgs.msg.Pose();
      }
      if (initObj.hasOwnProperty('measured_cv')) {
        this.measured_cv = initObj.measured_cv
      }
      else {
        this.measured_cv = new geometry_msgs.msg.Twist();
      }
      if (initObj.hasOwnProperty('measured_cf')) {
        this.measured_cf = initObj.measured_cf
      }
      else {
        this.measured_cf = new geometry_msgs.msg.Wrench();
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type RobotStates
    // Check that the constant length array field [measured_jp] has the right length
    if (obj.measured_jp.length !== 7) {
      throw new Error('Unable to serialize array field measured_jp - length must be 7')
    }
    // Serialize message field [measured_jp]
    bufferOffset = _arraySerializer.float64(obj.measured_jp, buffer, bufferOffset, 7);
    // Serialize message field [measrued_cp]
    bufferOffset = geometry_msgs.msg.Pose.serialize(obj.measrued_cp, buffer, bufferOffset);
    // Serialize message field [goal_cp]
    bufferOffset = geometry_msgs.msg.Pose.serialize(obj.goal_cp, buffer, bufferOffset);
    // Serialize message field [measured_cv]
    bufferOffset = geometry_msgs.msg.Twist.serialize(obj.measured_cv, buffer, bufferOffset);
    // Serialize message field [measured_cf]
    bufferOffset = geometry_msgs.msg.Wrench.serialize(obj.measured_cf, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type RobotStates
    let len;
    let data = new RobotStates(null);
    // Deserialize message field [measured_jp]
    data.measured_jp = _arrayDeserializer.float64(buffer, bufferOffset, 7)
    // Deserialize message field [measrued_cp]
    data.measrued_cp = geometry_msgs.msg.Pose.deserialize(buffer, bufferOffset);
    // Deserialize message field [goal_cp]
    data.goal_cp = geometry_msgs.msg.Pose.deserialize(buffer, bufferOffset);
    // Deserialize message field [measured_cv]
    data.measured_cv = geometry_msgs.msg.Twist.deserialize(buffer, bufferOffset);
    // Deserialize message field [measured_cf]
    data.measured_cf = geometry_msgs.msg.Wrench.deserialize(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 264;
  }

  static datatype() {
    // Returns string type for a message object
    return 'flexiv_crtk/RobotStates';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '9ca6fd6ae4c4a0b14dbb192201e94af1';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    float64[7] measured_jp
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
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new RobotStates(null);
    if (msg.measured_jp !== undefined) {
      resolved.measured_jp = msg.measured_jp;
    }
    else {
      resolved.measured_jp = new Array(7).fill(0)
    }

    if (msg.measrued_cp !== undefined) {
      resolved.measrued_cp = geometry_msgs.msg.Pose.Resolve(msg.measrued_cp)
    }
    else {
      resolved.measrued_cp = new geometry_msgs.msg.Pose()
    }

    if (msg.goal_cp !== undefined) {
      resolved.goal_cp = geometry_msgs.msg.Pose.Resolve(msg.goal_cp)
    }
    else {
      resolved.goal_cp = new geometry_msgs.msg.Pose()
    }

    if (msg.measured_cv !== undefined) {
      resolved.measured_cv = geometry_msgs.msg.Twist.Resolve(msg.measured_cv)
    }
    else {
      resolved.measured_cv = new geometry_msgs.msg.Twist()
    }

    if (msg.measured_cf !== undefined) {
      resolved.measured_cf = geometry_msgs.msg.Wrench.Resolve(msg.measured_cf)
    }
    else {
      resolved.measured_cf = new geometry_msgs.msg.Wrench()
    }

    return resolved;
    }
};

module.exports = RobotStates;
