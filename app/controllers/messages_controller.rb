class MessagesController < ApplicationController
  def create
    message = current_user.messages.build(message_params)
    broadcast(message) if message.save
  end

  private

  def message_params
    params.require(:message).permit(:body)
  end

  def broadcast(message)
    ActionCable.server.broadcast "chatroom_channel", new_message: render_message(message)
  end

  def render_message(msg_source)
    render(partial: 'message', locals: {message: msg_source})
  end
end
