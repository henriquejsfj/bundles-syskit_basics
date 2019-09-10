
module SyskitBasics
    module Profiles
        module Gazebo
            profile "Base" do
                use_gazebo_model 'model://ur10',
                    prefix_device_with_name: true
                use_sdf_world
            end
        end
    end
end
