require 'rails_helper'
require 'support/factory_girl'

describe User do

  let(:user){build(:user)}

  it "is valid" do
    expect(user).to be_valid
  end

  it "saves without error" do
    expect{user.save!}.to_not raise_error
  end

  it "will fail without email" do
    new_user = build(:user, name: 13, email: nil,
                password: "foobar", password_confirmation: "foobar")

    expect(new_user).to_not be_valid
  end

  it "will fail without a unique email" do
    user = build(:user, email: "foo@bar.com")
    user.save

    new_user = build(:user, name: "foobar", email: "foo@bar.com",
                password: "foobar", password_confirmation: "foobar")

    expect(new_user).to_not be_valid

  end

  it "will fail without name" do
    new_user = build(:user, name: nil, email: "foobar@bar.com",
                password: "foobar", password_confirmation: "foobar")
    expect(new_user).to_not be_valid
  end

  it "name should be betweeen 3 and 20 characters" do
    user =build(:user, :name => "f")
    expect(user).to_not be_valid

    user = build(:user, :name => "kkkkkkkkkkkkkkkkkkkkkkkkk")
    expect(user).to_not be_valid

  end

  it "password length should be between 6 and 16 characters" do
    user = build(:user, password: "32", password_confirmation: "32")
    expect(user).to_not be_valid

    user = build(:user, password: "111111111111111111", password_confirmation: "111111111111111111")
    expect(user).to_not be_valid

  end

  it "should have matching password and password confirmation" do
    user = build(:user, password: "password", password_confirmation: "password1")

    expect(user).to_not be_valid
  end

  it "should respond to secrets method" do
    expect{user.secrets}.to_not raise_error
  end





end