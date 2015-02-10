require 'test_helper'

class ProductTest < ActiveSupport::TestCase

  test "product attirbutes mustent be empty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:image_url].any?
  end

  # test "the truth" do
  #   assert true
  # end
end
