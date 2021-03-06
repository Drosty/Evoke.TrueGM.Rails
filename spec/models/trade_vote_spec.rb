# == Schema Information
#
# Table name: trade_votes
#
#  id         :integer          not null, primary key
#  trade_id   :integer
#  team_id    :integer
#  vote       :string
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe TradeVote do
  before(:each) do
    @trade_vote_obj = build(:trade_vote)
  end

  it "Factory Generates Valid Model" do
    @trade_vote_obj.should be_valid
  end

  describe "Has valid relations" do
    it "Needs to have a trade" do
      @trade_vote_obj.trade = nil
      @trade_vote_obj.should_not be_valid
    end

    it "Needs to have a team" do
      @trade_vote_obj.team = nil
      @trade_vote_obj.should_not be_valid
    end
  end

end
