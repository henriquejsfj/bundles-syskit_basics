require 'models/compositions/arm_cartesian_constant_command_generator'

module SyskitBasics
    module Compositions
        describe ArmCartesianConstantCommandGenerator do
            attr_reader :task, :p, :q
            before do
                @p = Eigen::Vector3.new(1, 2, 3)
                @q = Eigen::Quaternion.from_angle_axis(0.2, Eigen::Vector3.UnitX)
                @task = syskit_stub_deploy_configure_and_start(
                ArmCartesianConstantCommandGenerator.
                    with_arguments(setpoint: Hash[position: p, orientation: q]))
            end
        
            it "propagates its position and orientation arguments to #values" do
                assert_equal p, task.values['out'].position
                assert_equal q, task.values['out'].orientation
            end
        
            it "returns the value with an updated timestamp" do
                Timecop.freeze(expected_time = Time.now)
                sample = expect_execution.
                    to { have_one_new_sample task.out_port }
                assert_in_delta expected_time, sample.time, 1e-6
            end
        end
    end
end
