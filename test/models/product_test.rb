require 'test_helper'

class ProductTest < ActiveSupport::TestCase

  fixtures :products

  test "product attirbutes mustent be empty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:image_url].any?
  end

  test "product price must be possitive" do
    product = Product.new( title: "My Book title",
                          description: "yyy",
                          image_url: "zzz.jpg")
    product.price = -1
    assert product.invalid?
    assert_equal ["must be greater or euqal to 0.01"],
      product.errors[:price]

    product.price=0
    assert product.invalid?
    assert_equal ["must be greater or equal to 0.01"],
      product.errors[:price]

    product.price = 1
    assert product.valid?

  end

  def new_product(image_url)
    Product.new(title: "My book Title",
               description: "yyy",
               price: 1 ,
               image_url: image_url)
  end

  test "image url" do
    ok = %w{fred.jpg fred.png FRED.JPG FRED.Jpg http://a.b.c/x/y/z/fred.gif fred.gif}
    bad = %w{fred.doc fred.gif/more fred.gif.more fred.exe fred.cgi fred.dll}

    ok.each do |name|
      assert new_product(name).valid?, "#{name} should be valid"
    end

    bad.each do |name|
      assert new_product(name).valid?, "#{name} shouldn't be valid!"
    end

  end

  test "product is not valid without unique title" do
    product = Product.new(title: products(:ruby).title,
          description: "yyy",
          price: 1,
          image_url: "fred.gif"
      )
      assert product.invalid?
      assert_equal ["has already been taken"], product.errors[:title]
  end



  # test "the truth" do
  #   assert true
  # end
end
