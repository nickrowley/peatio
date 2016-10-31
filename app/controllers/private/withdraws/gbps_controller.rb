module Private::Withdraws
  class GbpsController < ::Private::Withdraws::BaseController
    include ::Withdraws::Withdrawable
  end
end
