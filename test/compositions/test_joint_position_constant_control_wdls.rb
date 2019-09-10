require 'models/compositions/joint_position_constant_control_wdls'

module SyskitBasics
    module Compositions
        describe JointPositionConstantControlWdls do
            it "forwards its setpoint argument to the constant generator" do
                cmp_task = syskit_stub_deploy_configure_and_start(
                    JointPositionConstantControlWdls.
                        with_arguments(setpoint: Hash['j0' => 10]))
                assert_equal Hash['j0' => 10], cmp_task.command_child.setpoint
            end
        end
    end
end
