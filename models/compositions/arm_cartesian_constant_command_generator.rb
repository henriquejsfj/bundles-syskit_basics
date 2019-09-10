
import_types_from 'base'
require 'common_models/models/compositions/constant_generator'

module SyskitBasics
    module Compositions
        class ArmCartesianConstantCommandGenerator <
            CommonModels::Compositions::ConstantGenerator.
                for('/base/samples/RigidBodyState')
            # The setpoint as a { position: p, orientation: q } hash
            argument :setpoint
        
            def setpoint=(setpoint)
                rbs = Types.base.samples.RigidBodyState.Invalid
                # Use 'fetch' to generate an error if the key is not present
                # in the hash
                rbs.position = setpoint.fetch(:position)
                rbs.orientation = setpoint.fetch(:orientation)
                self.values = Hash['out' => rbs]
            end
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
