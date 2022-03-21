# frozen_string_literal: true

module Mutations
  module BillableMetrics
    class Create < BaseMutation
      include AuthenticableApiUser

      graphql_name 'CreateBillableMetric'

      argument :organization_id, String, required: true
      argument :name, String, required: true
      argument :code, String, required: true
      argument :description, String
      argument :billable_period, Types::BillableMetrics::BillablePeriodEnum, required: true
      argument :aggregation_type, Types::BillableMetrics::AggregationTypeEnum, required: true
      argument :properties, GraphQL::Types::JSON

      type Types::BillableMetrics::Object

      def resolve(**args)
        result = BillableMetricsService.new(context[:current_user]).create(**args)

        result.success? ? result.billable_metric : execution_error(code: result.error_code, message: result.error)
      end
    end
  end
end
