module Private::Withdraws
  class UsdsController < ::Private::Withdraws::BaseController
    include ::Withdraws::Withdrawable
  end
end
