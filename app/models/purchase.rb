class Purchase < ActiveRecord::Base
  belongs_to :medium
  belongs_to :wallet

  validates_presence_of :medium, :wallet

  monetize :amount_centavos, presence: true, numericality: {
    greater_than_or_equal_to: 0
  }

  monetize :author_amount_centavos, presence: true, numericality: {
    greater_than_or_equal_to: 0
  }

  monetize :admin_amount_centavos, presence: true, numericality: {
    greater_than_or_equal_to: 0
  }

  validate :shares_sum_up

  private

  def shares_sum
    author_amount + admin_amount
  end

  def shares_sum_up
    unless shares_sum == amount
      errors.add(:amount, 'individual shares do not sum up to total amount')
    end
  end
end
