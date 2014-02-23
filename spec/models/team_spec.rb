require 'spec_helper'

describe Team do
  before(:each) do
    @team = build(:team)
  end

  it "Factory generates valid Team" do
    @team.should be_valid
  end

  describe "Adding players to Team" do
    it "will add player to team" do
      @team.add_player build(:nfl_player)
      @team.save
      @team.nfl_players.count.should eq(1)
    end

    it "will remove from other team if in same league when adding" do
      league = @team.league
      player = create(:nfl_player)
      second_team = create(:team)

      league.teams << second_team

      second_team.add_player player
      @team.add_player player
      second_team.save
      @team.save

      second_team.nfl_players.count.should eq(0)
      @team.nfl_players.count.should eq(1)
    end

  end

  describe "NFL Players on Team" do
    before(:each) do
      # create a valid team
      @team.nfl_players << build(:nfl_player, :qb)
      @team.nfl_players << build(:nfl_player, :rb)
      @team.nfl_players << build(:nfl_player, :rb)
      @team.nfl_players << build(:nfl_player, :wr)
      @team.nfl_players << build(:nfl_player, :wr)
      @team.nfl_players << build(:nfl_player, :te)
      @team.nfl_players << build(:nfl_player, :pk)
      @team.nfl_players << build(:nfl_player, :def)
    end

    it "should return the correct num of QBs" do
      @team.quarterbacks.size.should == 1
    end

    it "should return the correct num of RBs" do
      @team.runningbacks.size.should == 2
    end

    it "should return the correct num of WRs" do
      @team.receivers.size.should == 2
    end

    it "should return the correct num of TEs" do
      @team.tightends.size.should == 1
    end

    it "should return the correct num of Kickers" do
      @team.kickers.size.should == 1
    end

    it "should return the correct num of Defenses" do
      @team.defenses.size.should == 1
    end
  end

  describe "salary updates on cache column" do
    before(:each) do
      @team.nfl_players << build(:nfl_player, :qb, :salary => 100000)
      @team.nfl_players << build(:nfl_player, :rb, :salary => 200000)
    end

    it "should update salary on save" do
      @team.send(:update_total_salary).should == 300000
    end

    it "Add player and the salary changes" do
      @team.nfl_players << build(:nfl_player, :salary => 300000)
      @team.send(:update_total_salary).should == 600000
    end
  end

  describe "Team must be valid based on League Settings" do
    before(:each) do
      league = build(:league)
      league.teams << @team
    end
  end
end
