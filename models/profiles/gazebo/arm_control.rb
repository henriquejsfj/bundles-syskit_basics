require 'syskit_basics/models/profiles/gazebo/base'
require 'syskit_basics/models/compositions/arm_cartesian_constant_control_wdls'
require 'syskit_basics/models/compositions/joint_position_constant_control_wdls'

module SyskitBasics
    module Profiles
        module Gazebo
            UR10_SAFE_POSITION = Hash[
                'ur10::shoulder_pan'  => 0,
                'ur10::shoulder_lift' => -Math::PI/2,
                'ur10::elbow'         => Math::PI/2,
                'ur10::wrist_1'       => 0,
                'ur10::wrist_2'       => 0,
                'ur10::wrist_3'       => 0]

            profile 'ArmControl' do
                define 'arm_cartesian_constant_control',
                    Compositions::ArmCartesianConstantControlWdls.
                        use(Base.ur10_dev).
                        with_arguments(robot: Base)
                define 'arm_joint_position_constant_control',
                    Compositions::JointPositionConstantControlWdls.
                        use(Base.ur10_dev)
                define 'arm_safe_position',
                    arm_joint_position_constant_control_def.
                        with_arguments(setpoint: UR10_SAFE_POSITION)
            end
        end
    end
end