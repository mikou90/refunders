class Purchase < ActiveRecord::Base
  belongs_to :user
  belongs_to :announce

  monetize :amount_cents
end
