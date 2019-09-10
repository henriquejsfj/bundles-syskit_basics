require 'syskit_basics/models/compositions/arm_cartesian_constant_command_generator'
require 'syskit_basics/models/compositions/arm_cartesian_control_wdls'

module SyskitBasics
    module Compositions
        class ArmCartesianConstantControlWdls < Syskit::Composition

            argument :robot
            argument :setpoint

            add(ArmCartesianConstantCommandGenerator, as: 'command').
                with_arguments(setpoint: from(:parent_task).setpoint)
            # add ArmCartesianControlWdls, as: 'control'
            add(ArmCartesianControlWdls, as: 'control').
                with_arguments(robot: from(:parent_task).robot)

            command_child.out_port.
                connect_to control_child.command_port

        end
    end
end