# == Schema Information
#
# Table name: return_stats
#
#  id                            :integer          not null, primary key
#  nfl_matchup_id                :integer
#  nfl_player_id                 :integer
#  nfl_team_id                   :integer
#  number                        :integer
#  position                      :string
#  fantasy_position              :string
#  fantasy_points                :float
#  kick_return_long              :integer
#  kick_return_touchdowns        :integer
#  kick_return_yards             :integer
#  kick_return_yards_per_attempt :float
#  kick_returns                  :integer
#  punt_return_long              :integer
#  punt_return_touchdowns        :integer
#  punt_return_yards             :integer
#  punt_return_yards_per_attempt :float
#  punt_returns                  :integer
#  created_at                    :datetime         not null
#  updated_at                    :datetime         not null
#  week                          :integer
#  season                        :integer
#

class ReturnStat < ActiveRecord::Base
  include FantasyDataMapper

  attr_accessible :week, :season, :nfl_player_id
  
  belongs_to :nfl_matchup
  belongs_to :nfl_player
  belongs_to :nfl_team

  def total_points league
    # TODO
    0
  end

end
