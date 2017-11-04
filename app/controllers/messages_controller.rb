class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_message, only: [:show, :edit, :update, :destroy]

  # GET /messages
  # GET /messages.json
  def index
    @messages = Message.all
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
  end

  # GET /messages/new
  def new
    @message = Message.new
    #user1 = User.where(:email => params[:email]).first
    puts params.inspect
    if !params[:controller]
      redirect_to root_url, :flash => {:error => "#{params[:message]}"}
      return
      session[:email] = params["message"]["email"]
    end  

  end

  # GET /messages/1/edit
  def edit
  end

  # POST /messages
  # POST /messages.json
  def create
    @message = Message.new(message_params)
    @message.user_id = current_user.id
    user1 = User.where(:email => params[:message][:email]).first
    # if user1
    # else
    #   redirect_to root_url, :flash => {:error => "No user with the email #{session[:email]} exists."}
    #   return
    # end    
    convo = Conversation.where(:sender_id => current_user.id)
    if convo
      convo = convo.where(:recipient_id => user1.id).first
    end  
    if convo
      @message.conversation_id = convo.id
    else
      convo2 = Conversation.new
      convo2.sender_id = current_user.id
      convo2.recipient_id = user1.id
      convo2.save
      @message.conversation_id = convo2.id
    end
    @message.save
    redirect_to "/conversations"    
  end

  # PATCH/PUT /messages/1
  # PATCH/PUT /messages/1.json
  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to @message, notice: 'Message was successfully updated.' }
        format.json { render :show, status: :ok, location: @message }
      else
        format.html { render :edit }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message.destroy
    respond_to do |format|
      format.html { redirect_to messages_url, notice: 'Message was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def add
    @messages = {}
    @temp = []
    @user = User.find(params[:recipient_id])
    c1 = Conversation.where(:sender_id => current_user.id).where(:recipient_id => params[:recipient_id]).first
    c2 = Conversation.where(:recipient_id => current_user.id).where(:sender_id => params[:recipient_id]).first
    m1 = Message.where(:conversation_id => c1.id)
    m2 = Message.where(:conversation_id => c2.id)
    m1.each do |m|
      h1 = {}
      h1["body"] = m.body
      h1["type"] = 0
      @messages[m.created_at] = h1
      @temp.push(m.created_at)
    end
    m2.each do |m|
      h1={}
      h1["body"] = m.body
      h1["type"] = 1
      @messages[m.created_at] = h1
      @temp.push(m.created_at)
    end
    @temp = @temp.sort
    if params[:body]
      @message1 = Message.new
      @message1.conversation_id = c1.id
      @message1.body = params[:body]
      @message1.user_id = current_user.id
      @message1.save
      redirect_to send_message_path(params[:recipient_id])
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:body, :conversation_id, :user_id, :email, :recipient_id)
    end
end
