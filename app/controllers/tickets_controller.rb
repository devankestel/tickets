class TicketsController < ApplicationController
  before_action :set_ticket, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  def index
    @tickets = Ticket.all
  end
  def show
  end
  def new
    @user = current_user
    @ticket = @user.tickets.new
  end
  def create
    @user = current_user
    @ticket = @user.tickets.create(ticket_params)
    redirect_to @ticket
  end
  def edit
    @user = current_user
    @editing = true
    render :new  
  end
  def update
    @ticket.update(ticket_params)
    redirect_to @ticket
  end
  def destroy
    @ticket.destroy
    redirect_to tickets_path
  end

  private
  def ticket_params
    params.require(:ticket).permit(:id, :title, :body, :severity, :assignee_id)
  end
  def set_ticket
    @ticket = Ticket.find(params[:id])
  end
end
