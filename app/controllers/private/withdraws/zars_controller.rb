module Private::Withdraws
  class ZarsController < ::Private::Withdraws::BaseController
    include ::Withdraws::Withdrawable
  end
end
