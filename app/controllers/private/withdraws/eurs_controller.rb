module Private::Withdraws
  class EursController < ::Private::Withdraws::BaseController
    include ::Withdraws::Withdrawable
  end
end
