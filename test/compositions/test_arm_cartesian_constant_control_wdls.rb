require 'models/compositions/arm_cartesian_constant_control_wdls'

module SyskitBasics
    module Compositions
        describe ArmCartesianConstantControlWdls do
            it "forwards its setpoint argument to the generator child" do
                setpoint = Hash[
                    position: Eigen::Vector3.new(1, 2, 3),
                    orientation: Eigen::Quaternion.from_angle_axis(0.4, Eigen::Vector3.UnitZ)]
                cmp = syskit_stub_deploy_configure_and_start(
                    ArmCartesianConstantControlWdls.with_arguments(setpoint: setpoint))
                assert_equal setpoint, cmp.command_child.setpoint
            end
        end
    end
end
