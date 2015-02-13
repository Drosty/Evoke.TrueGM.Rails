require 'spec_helper'

describe NflPlayer do
  before(:each) do
    @player = build(:nfl_player)
  end

  describe "basic methods on Player" do
    it "Factory Generates Valid Model" do
      @player.should be_valid
    end

    it "will return field if it is available" do
      p = build(:nfl_player, full_name: "test fullname")
      p.full_name.should eq("test fullname")
    end

    it "will return true to free agent when player is" do
      @player.free_agent?(1).should eq(true)
    end

    it "will return false to free agent when player is on team" do
      team = create(:team)
      team.nfl_players << @player
      @player.free_agent?(team.league_id).should eq(false)
    end

    it "will return FA to fantasy_team_name when player is FA" do
      @player.fantasy_team_name(1).should eq("FA")
    end

    it "will return Team Name when player is on a team in the league" do
      team = create(:team)
      team.nfl_players << @player
      @player.fantasy_team_name(team.league_id).should eq(team.name)
    end
  end

  describe "creating hashes of the players" do
    it "will create same hash with same string except whitespace" do
      first = NflPlayer.generate_hash(" Henry Smith ", "WR ", "ARI ")
      second = NflPlayer.generate_hash("Henry Smith", " WR", " ARI")
      assert_equal first, second
    end

    it "will create same hash with same string except Special chars" do
      first = NflPlayer.generate_hash(" Henry.Smith$!", "WR**", ".,:ARI;")
      second = NflPlayer.generate_hash("+{|`~Henry Smith#", " WR()", "!@ARI-_'")
      assert_equal first, second
    end

    it "will create same hash with same string except case" do
      first = NflPlayer.generate_hash(" Henry SMITH ", "WR ", "ARI ")
      second = NflPlayer.generate_hash("Henry Smith", " Wr", " Ari")
      assert_equal first, second
    end
  end

  describe "position scope" do
    before(:each) do
      create(:nfl_player, :qb)
      create(:nfl_player, :rb)
      create(:nfl_player, :rb)
      create(:nfl_player, :wr)
      create(:nfl_player, :wr)
      create(:nfl_player, :wr)
      create(:nfl_player, :te)
      create(:nfl_player, :te)
      create(:nfl_player, :te)
      create(:nfl_player, :te)
    end

    it "returns all for all" do
      NflPlayer.positions(Position::ALL_STRING).count.should == 10
    end

    it "return only qbs" do
      NflPlayer.positions(Position::QUARTERBACK).count.should == 1
    end

    it "return only rbs" do
      NflPlayer.positions(Position::RUNNINGBACK).count.should == 2
    end

    it "return only wrs" do
      NflPlayer.positions(Position::WIDERECEIVER).count.should == 3
    end

    it "return only tes" do
      NflPlayer.positions(Position::TIGHTEND).count.should == 4
    end

    it "return flex players" do
      NflPlayer.positions("flex").count.should == 9
      NflPlayer.positions("rb/wr/te").count.should == 9
    end
  end

end
