require 'test_helper'
require 'support/serialization'

class UserSerializerTest < ActiveSupport::TestCase
  include Rails.application.routes_url_helpers
  include Serialization::Assertions

  setup do
    @user = users(:admin)
  end

  test 'serializes all visible attributes for a User' do
    serializer = UserSerializer.new(@user)
    serialized_user = serializer.as_json

    %i(id email gravatar_url admin created_at updated_at).each do |attribute|
      assert_equal @user.send(attribute), serialized_user[attribute]
    end
  end

  test 'includes links for the users' do
    serialized_links = serialized_user[:links]
    assert_equal 2, serialized_links.count

    self_url = serialized_links.find { |url| url[:rel] == :self }
    refute_nil self_url
    assert_equal user_url(@user), self_url[:href]

    boards_url = serialized_links.find { |url| url[:rel] == :boards }
    refute_nil boards_url

    assert_equal user_boards_url(@user), boards_url[:href]
  end

  test 'includes currently active Boards created by the user' do
    active_boards = serialized_user[:active_boards]

    assert_equal 1, active_boards.count

    expected_ids = @user.boards.where(archived: false).pluck(:id)

    assert_ids expected_ids, active_boards

    assert_keys %i(id title link), active_boards.first
  end

  private

  def serialized_user(user = nil)
    user ||= @user
    UserSerializer.new(user).as_json
  end
end
