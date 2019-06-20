class Private::ConversationsController < ApplicationController
  def show
    if user_signed_in?
      @message_has_been_sent = conversation_exist?
    end
  end

  def create
    recipient_id = Post.find(params[:post_id]).user.id
    @conversation = Private::Conversation.new(sender_id: current_user.id,
                                             recipient_id: recipient_id)
    if @conversation.save
      add_to_conversations unless already_added?
      Private::Message.create(user_id: recipient_id,
                              conversation_id: @conversation.id,
                              body: params[:message_body])
      respond_to do |format|
        format.js {render partial: 'posts/show/contact_user/message_form/success'}
      end
    else
      respond_to do |format|
        format.js {render partial: 'posts/show/contact_user/message_form/fail'}
      end
    end
  end

  def close
    @conversation_id = params[:id].to_i
    session[:private_conversations].delete(@conversation_id)

    respond_to do |format|
      format.js
    end
  end

  private

  def add_to_conversations
    session[:private_conversations] ||= []
    session[:private_conversations] << @conversation.id
  end

  def already_added?
    session[:private_conversations].include?(@conversation.id)
  end

  def conversation_exist?
    Private::Conversation.between_users(current_user.id, @post.user.id).present?
  end
end
