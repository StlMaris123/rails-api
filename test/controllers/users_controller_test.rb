require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  before do
    @user = users(:one)
  end

  describe 'GET/users' do
    it 'should successfully fetch all users' do
      @expected_users = User.all
      get users_url, as: :json
      assert_response :ok

      json_response = JSON.parse(response.body)
      response_users = json_response['users']
      assert_instance_of Array, response_users

      assert_ids @expected_users.pluck(:id), response_users, 'id'

      expected_keys = %w(id email gravatar_url admin created_at updated_at links)
      assert_keys expected_keys, response_users.first
    end
  end

  describe 'GET/users/:id' do
    it 'should successfully fetch the requested user' do
      get user_url(@user)
      assert_response :ok

      response_user = json_response['user']
      expected_keys = %w(id email gravatar_url admin created_at updated_at links active_boards)
      assert_keys expected_keys, response_user
    end

    describe 'when id is unknown' do
      it 'should respond with :not_found' do
        get user_url(id: 'jim'), as: :json
        assert_response :not_found
      end
    end
  end

  describe 'POST/users' do
  end

  describe 'PATCH/users:id' do
  end

  describe 'DELETE/users/:id' do
  end
end
