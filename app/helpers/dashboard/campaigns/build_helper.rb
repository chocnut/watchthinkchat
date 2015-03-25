module Dashboard
  module Campaigns
    module BuildHelper
      def step_class(step)
        return 'active' if wizard_path == wizard_path(step)
        return 'success' if past_step?(step)
        'disabled'
      end
    end
  end
end
