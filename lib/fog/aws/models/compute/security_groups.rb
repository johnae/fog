require 'fog/core/collection'
require 'fog/aws/models/compute/security_group'

module Fog
  module AWS
    class Compute

      class SecurityGroups < Fog::Collection

        attribute :filters

        model Fog::AWS::Compute::SecurityGroup

        def initialize(attributes)
          @filters ||= {}
          super
        end

        def all(filters = @filters)
          @filters = filters
          data = connection.describe_security_groups(@filters).body
          load(data['securityGroupInfo'])
        end

        def get(group_name)
          if group_name
            self.class.new(:connection => connection).all('group-name' => group_name).first
          end
        end

      end

    end
  end
end
