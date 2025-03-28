# == Schema Information
#
# Table name: chat_rooms
#
#  id         :integer          not null, primary key
#  status     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  chat_id    :integer          not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_chat_rooms_on_chat_id  (chat_id)
#  index_chat_rooms_on_user_id  (user_id)
#
# Foreign Keys
#
#  chat_id  (chat_id => chats.id)
#  user_id  (user_id => users.id)
#
class ChatRoom < ApplicationRecord
  belongs_to :user
  belongs_to :chat
end
