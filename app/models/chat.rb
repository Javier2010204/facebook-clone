# == Schema Information
#
# Table name: chats
#
#  id         :integer          not null, primary key
#  status     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Chat < ApplicationRecord
    has_many :chat_rooms
    has_many :messages
end
