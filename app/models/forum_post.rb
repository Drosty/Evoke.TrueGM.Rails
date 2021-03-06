# == Schema Information
#
# Table name: forum_posts
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  forum_topic_id :integer
#  post_body      :text
#  created_at     :datetime
#  updated_at     :datetime
#

class ForumPost < ActiveRecord::Base
  attr_accessible :post_body, :user_id, :forum_topic_id, :id, :created_at, :updated_at

  # These are here for updating the Topic's updated date
  before_create :update_topic
  before_update :update_topic

  belongs_to :user
  belongs_to :forum_topic, :counter_cache => :forumposts_count

  delegate :league, :to => :forum_topic, :allow_nil => false

  validates_presence_of :post_body
  validates_presence_of :forum_topic

  private
  
  # This was weird, looks like when I create a post the Topic doesn't have the update
  # date being changed.  So going to manually do it like this.
  def update_topic
    forum_topic.updated_at = Time.now
    forum_topic.save!
  end

end
