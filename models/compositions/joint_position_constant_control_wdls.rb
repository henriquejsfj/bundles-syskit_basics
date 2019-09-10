require 'syskit_basics/models/compositions/joint_position_constant_command_generator'
require 'common_models/models/devices/gazebo/model'

module SyskitBasics
    module Compositions
        class JointPositionConstantControlWdls < Syskit::Composition
            
            argument :setpoint

            add CommonModels::Devices::Gazebo::Model, as: 'arm'
            add(JointPositionConstantCommandGenerator, as: 'command').
                with_arguments(setpoint: from(:parent_task).setpoint)
            
            command_child.out_port.connect_to \
                arm_child.joints_cmd_port
        end
    end
end
