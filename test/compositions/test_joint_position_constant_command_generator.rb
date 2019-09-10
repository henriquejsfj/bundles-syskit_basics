require 'models/compositions/joint_position_constant_command_generator'

module SyskitBasics
    module Compositions
        describe JointPositionConstantCommandGenerator do
            # it "propagates its name and command arguments to #values" do
            #     name = ["lets_test"]
            #     command = [Types.base.JointState.new(
            #         position: 3.14,
            #         speed: Float::NAN,
            #         effort: Float::NAN,
            #         raw: Float::NAN,
            #         acceleration: Float::NAN)] # pi
            #     task = syskit_stub_deploy_configure_and_start(
            #         JointPositionConstantCommandGenerator.
            #             with_arguments(setpoint: Hash[joint_names: name, joint_commands: command]))
            #     assert_equal name, task.values['out'].names
            #     assert_equal command, task.values['out'].elements.to_a
            # end
            # it "returns the value with an updated timestamp" do
            #     name = ["lets_test"]
            #     command = [Types.base.JointState.new(
            #         position: 3.14,
            #         speed: Float::NAN,
            #         effort: Float::NAN,
            #         raw: Float::NAN,
            #         acceleration: Float::NAN)] # pi
            #     task = syskit_stub_deploy_configure_and_start(
            #         JointPositionConstantCommandGenerator.
            #             with_arguments(setpoint: Hash[joint_names: name, joint_commands: command]))
            #     Timecop.freeze(expected_time = Time.now)
            #     sample = expect_execution.
            #         to { have_one_new_sample task.out_port }
            #     assert_in_delta expected_time, sample.time, 1e-6
            # end
            it "sets the names and positions based on the given hash" do
                task = syskit_stub_deploy_configure_and_start(
                    JointPositionConstantCommandGenerator.
                        with_arguments(setpoint: Hash['j0' => 10, 'j1' => 20]))
                assert_equal ['j0', 'j1'], task.values['out'].names
                assert_equal [10, 20], task.values['out'].elements.map(&:position)
            end

            it "returns the value with an updated timestamp" do
                task = syskit_stub_deploy_configure_and_start(
                    JointPositionConstantCommandGenerator.
                        with_arguments(setpoint: Hash['j0' => 10, 'j1' => 20]))
                Timecop.freeze(expected_time = Time.now)
                sample = expect_execution.
                    to { have_one_new_sample task.out_port }
                assert_in_delta expected_time, sample.time, 1e-6
            end
        end
    end
end
