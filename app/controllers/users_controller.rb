class UsersController < ApplicationController
  def new
    binding.pry
    @user = User.new
  end

  def create
    binding.pry
    @user = User.new
    @user.save
  end
end
