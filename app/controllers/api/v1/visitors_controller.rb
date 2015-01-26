module Api
  module V1
    class VisitorsController < Api::V1Controller
      def show
        load_visitor
      end

      def update
        load_visitor
        build_visitor
        save_visitor
        subscribe_visitor if params[:subscribe]
        render 'show', status: :ok
      end

      protected

      def load_visitor
        @visitor ||= visitor_scope
        @visitor
      end

      def build_visitor
        @visitor ||= visitor_scope.build
        @visitor.attributes = visitor_params
      end

      def subscribe_visitor
        @visitor.decorate.subscribe(@campaign)
      end

      def save_visitor
        @visitor.save!
      end

      def visitor_scope
        current_visitor
      end

      def visitor_params
        VisitorParams.permit(params)
      end

      class VisitorParams
        def self.permit(params)
          params.require(:visitor).permit(:first_name, :last_name, :email, :notify_me_on_share)
        end
      end
    end
  end
end
