# This is in bundles/common_models
require 'common_models/models/devices/gazebo/model'
# Load the oroGen projects
using_task_library 'cart_ctrl_wdls'
using_task_library 'robot_frames'

module SyskitBasics
    module Compositions
        class ArmCartesianControlWdls < Syskit::Composition
            argument :robot

            # add OroGen.cart_ctrl_wdls.WDLSSolver, as: 'twist2joint_velocity'
            add OroGen.cart_ctrl_wdls.CartCtrl, as: 'position2twist'
            add CommonModels::Devices::Gazebo::Model, as: 'arm'
            # add OroGen.robot_frames.SingleChainPublisher, as: 'joint2pose'
            add(OroGen.cart_ctrl_wdls.WDLSSolver, as: 'twist2joint_velocity').
                with_arguments(robot: from(:parent_task).robot)
            add(OroGen.robot_frames.SingleChainPublisher, as: 'joint2pose').
                with_arguments(robot: from(:parent_task).robot)

            position2twist_child.ctrl_out_port.
                connect_to twist2joint_velocity_child.desired_twist_port
            twist2joint_velocity_child.solver_output_port.
                connect_to arm_child.joints_cmd_port
            arm_child.joints_status_port.
                connect_to twist2joint_velocity_child.joint_status_port
            arm_child.joints_status_port.
                connect_to joint2pose_child.joints_samples_port
            joint2pose_child.tip_pose_port.
                connect_to position2twist_child.cartesian_status_port
            export position2twist_child.command_port
        end
    end
end
