class NflPlayer < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :position, :salary, :nfl_data_id

  belongs_to :nfl_team
  has_and_belongs_to_many :teams
  has_many :stats

  delegate :mascot, :to  => :nfl_team, :prefix => true

  def self.available_positions_for_filter
    ['all', 'qb', 'rb', 'wr', 'te', 'd', 'pk', 'flex']
  end

  # This is for pagination
  self.per_page = 15

  # Named_Scopes
  scope :positions, ->(pos) {
                              case pos.downcase
                              when 'all'
                                where(nil)
                              when 'flex'
                                where(:position => ['rb', 'wr'])
                              else
                                where(:position => pos.downcase)
                              end
                            }

  def full_name
    return read_attribute(:full_name) unless read_attribute(:full_name).nil?
    return "#{first_name} #{last_name}"
  end

  def free_agent? league_id
    fantasy_team(league_id).nil?
  end

  def fantasy_team_name league_id
    ft = fantasy_team league_id
    return "FA" if ft.nil?
    return ft.name
  end

  def fantasy_team league_id
    self.teams.where(:league_id => league_id).first
  end

  def self.generate_hash name, pos, team_abbreviation
    name = name.gsub(/[^0-9A-Za-z]/, '').downcase
    pos = pos.gsub(/[^0-9A-Za-z]/, '').downcase
    team_abbreviation = team_abbreviation.gsub(/[^0-9A-Za-z]/, '').downcase
    Zlib.crc32 "#{name}#{pos}#{team_abbreviation}"
  end

end
