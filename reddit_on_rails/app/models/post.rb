# == Schema Information
#
# Table name: posts
#
#  id         :bigint(8)        not null, primary key
#  title      :string           not null
#  url        :string
#  content    :string
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Post < ApplicationRecord
  validates :title, presence: true
  validates :subs, length: { minimum: 1 }

  belongs_to :user

  has_many :postsubs,
    dependent: :destroy,
    inverse_of: :post

  has_many :subs,
    through: :postsubs

end
