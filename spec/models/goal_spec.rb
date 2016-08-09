# == Schema Information
#
# Table name: goals
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  title      :string           not null
#  details    :text             not null
#  private    :boolean          default(FALSE), not null
#  completed  :boolean          default(FALSE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Goal, type: :model do

  describe "validates goal" do
    before(:each) do
      User.create!(name: "Grace", password: "asdfasdf")
      goal = Goal.create!(user_id: 1, title: "finish assessment", details: "and rocking it!!!!")
    end

    it {should validate_presence_of(:user)}
    it {should validate_presence_of(:title)}
    it {should validate_presence_of(:details)}
    it {should belong_to(:user)}
  end
end
