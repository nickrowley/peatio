module Withdraws
  class Gbp < ::Withdraw
    include ::AasmAbsolutely
    include ::Withdraws::Bankable
    include ::FundSourceable
  end
end
