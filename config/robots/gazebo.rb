## A common pattern is to load the 'default' robot configuration
require_relative './default'

## One can require the configuration from another robot, for instance if one has
## a common robot class with minor modifications
#
# require 'config/robots/robot_class'

# Block evaluated at the very beginning of the Roby app initialization
Robot.init do
    ## You could also change the Roby search path
    # Roby.app.search_path << "separate path"
end

# Block evaluated to load the models this robot requires
Robot.requires do
end

# Block evaluated to configure the system, that is set up values in Roby's Conf
# and State
Robot.requires do
    Syskit.conf.use_gazebo_world('empty_world')

    require 'syskit_basics/models/profiles/gazebo/arm_control'
    Syskit.conf.use_deployment OroGen.cart_ctrl_wdls.CartCtrl => 'arm_pos2twist'
    Syskit.conf.use_deployment OroGen.cart_ctrl_wdls.WDLSSolver => 'arm_twist2joint'
    Syskit.conf.use_deployment OroGen.robot_frames.SingleChainPublisher => 'arm_chain_publisher'
    Syskit.conf.use_ruby_tasks SyskitBasics::Compositions::ArmCartesianConstantCommandGenerator => 'arm_constant_setpoint'
    Syskit.conf.use_ruby_tasks SyskitBasics::Compositions::JointPositionConstantCommandGenerator => 'joint_position_setpoint'
end

# Setup of the robot's main action interface
#
# Add use statements here, as e.g.
#
#   use_library SyskitBasics::Actions::MyActionInterface
#
# or, if you're using syskit
#
#   use_profile SyskitBasics::Profiles::BaseProfile
#
Robot.actions do
    use_profile SyskitBasics::Profiles::Gazebo::Base
    use_profile SyskitBasics::Profiles::Gazebo::ArmControl
end

# Block evaluated when the Roby app is fully setup, and the robot ready to
# start. This is where one usually adds permanent tasks and/or status lines
Robot.controller do
end

Robot.init do
    Roby.app.register_app '../common_models'
    require 'rock_gazebo/syskit'
    Conf.syskit.transformer_enabled = true
end
