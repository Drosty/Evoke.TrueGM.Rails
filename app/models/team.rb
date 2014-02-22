class Team < ActiveRecord::Base
  attr_accessible :name, :tagline, :total_salary, :invite_code

  belongs_to :league
  belongs_to :user

  has_many :draft_picks
  has_many :power_rankings
  has_many :trades
  has_many :trade_votes

  has_and_belongs_to_many :nfl_players

  before_save :update_total_salary

  delegate :name, :to => :user, :prefix => true

  def quarterbacks
    get_players_by_position "QB"
  end

  def runningbacks
    get_players_by_position "RB"
  end

  def receivers
    get_players_by_position "WR"
  end

  def tightends
    get_players_by_position "TE"
  end

  def kickers
    get_players_by_position "K"
  end

  def defenses
    get_players_by_position "D"
  end

private

  def update_total_salary
    total_salary = nfl_players.map(&:salary).inject(0, &:+)
  end

  def get_players_by_position position
    nfl_players.select { |p| p.position == position }
  end

end
