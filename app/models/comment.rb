# == Schema Information
#
# Table name: comments
#
#  id             :uuid             not null, primary key
#  body           :text
#  reported_at    :datetime
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  activity_id    :uuid             not null
#  author_id      :uuid             not null
#  reported_by_id :uuid
#
# Indexes
#
#  index_comments_on_activity_id     (activity_id)
#  index_comments_on_author_id       (author_id)
#  index_comments_on_reported_by_id  (reported_by_id)
#
# Foreign Keys
#
#  fk_rails_...  (activity_id => activities.id)
#  fk_rails_...  (author_id => users.id)
#  fk_rails_...  (reported_by_id => users.id)
#
class Comment < ApplicationRecord
  belongs_to :activity
  belongs_to :author, class_name: "User"
  belongs_to :reported_by, class_name: "User", optional: true

  validates :body, presence: true

  scope :reported, -> { where.not(reported_at: nil) }
end
