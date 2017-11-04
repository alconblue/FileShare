class ConversationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_conversation, only: [:show, :edit, :update, :destroy]
  # GET /conversations
  # GET /conversations.json
  def index
    @h = {}
    @user = []
    convo1 = Conversation.where(:sender_id => current_user.id)
    convo2 = Conversation.where(:recipient_id => current_user.id)
    convo1.each do |u|
      h1 = {}
      h1["id"] = u.recipient_id
      messages = Message.where(:conversation_id => u.id).order(:created_at).last
      h1["time"] = messages.created_at
      h1["message"] = messages.body
      @user.push(u.recipient.username)
      @h[u.recipient.username] = h1
    end
    convo2.each do |u|
      if @h.key?(u.sender.username)
        messages = Message.where(:conversation_id => u.id).order(:created_at).last
        if messages.created_at > @h[u.sender.username]["time"]
          @h[u.sender.username]["message"] = messages.body
        end
      else
        h1={}
        h1["id"] = u.sender_id
        messages = Message.where(:conversation_id => u.id).order(:created_at).last
        h1["time"] = messages.created_at
        h1["message"] = messages.body
        @user.push(u.sender.username)
        @h[u.sender.username] = h1
      end
    end
    @conversations = Conversation.all
  end

  # GET /conversations/1
  # GET /conversations/1.json
  def show
  end

  # GET /conversations/new
  def new
    @conversation = Conversation.new
  end

  # GET /conversations/1/edit
  def edit
  end

  # POST /conversations
  # POST /conversations.json
  def create
    @conversation = Conversation.new(conversation_params)

    respond_to do |format|
      if @conversation.save
        format.html { redirect_to @conversation, notice: 'Conversation was successfully created.' }
        format.json { render :show, status: :created, location: @conversation }
      else
        format.html { render :new }
        format.json { render json: @conversation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /conversations/1
  # PATCH/PUT /conversations/1.json
  def update
    respond_to do |format|
      if @conversation.update(conversation_params)
        format.html { redirect_to @conversation, notice: 'Conversation was successfully updated.' }
        format.json { render :show, status: :ok, location: @conversation }
      else
        format.html { render :edit }
        format.json { render json: @conversation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /conversations/1
  # DELETE /conversations/1.json
  def destroy
    @conversation.destroy
    respond_to do |format|
      format.html { redirect_to conversations_url, notice: 'Conversation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_conversation
      @conversation = Conversation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def conversation_params
      params.require(:conversation).permit(:recipient_id, :sender_id)
    end
end
