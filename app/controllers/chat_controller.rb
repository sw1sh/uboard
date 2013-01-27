class ChatController < ApplicationController
  
  def index
    
  end
  
  def send_msg
    Pusher['test_channel'].trigger('message', {
      :message => params[:message]
    })
    render :partial => 'blank'
  end
 
  
end
