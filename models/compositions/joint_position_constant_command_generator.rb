import_types_from 'base'
require 'common_models/models/compositions/constant_generator'

module SyskitBasics
    module Compositions
        class JointPositionConstantCommandGenerator < 
            CommonModels::Compositions::ConstantGenerator.
                for('/base/commands/Joints')

            argument :setpoint
            
            def setpoint=(setpoint)
                joint_names    = setpoint.keys
                joint_commands = setpoint.each_value.map do |position|
                    Types.base.JointState.new(
                        position: position,
                        speed: Float::NAN,
                        effort: Float::NAN,
                        raw: Float::NAN,
                        acceleration: Float::NAN)
                end
                self.values = Hash['out' =>
                    Types.base.commands.Joints.new(
                        time: Time.at(0),
                        names: joint_names,
                        elements: joint_commands)]
            end

            # def setpoint=(setpoint)
            #     joint = Types.base.commands.Joints.new(
            #         time: Time.at(0),
            #         names: setpoint.fetch(:joint_names),
            #         elements: setpoint.fetch(:joint_commands))
                
            #     self.values = Hash['out' => joint]
            # end
            def values
                if v = super
                    # Do not change the argument "under the hood"
                    sample = v['out'].dup
                    sample.time = Time.now
                    Hash['out' => sample]
                end
            end
        end
    end
end
